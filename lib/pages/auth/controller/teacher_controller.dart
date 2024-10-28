import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tdmubook/pages/auth/models/student.dart';
import 'package:http/http.dart' as http;
import 'package:tdmubook/pages/auth/models/teacher.dart';

import '../../../config/token_manager.dart';

class TeacherController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(hostedDomain: 'tdmu.edu.vn');
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var message = ''.obs;
  // Student student = Student();
  Teacher teacher = Teacher();

  @override
  void onInit() {
    super.onInit();
    // user.bindStream(_firebaseAuth.authStateChanges());
    // ever(user, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) {
    if (user != null) {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }

  Future<bool> signInWithGoogle() async {
    isLoading.value = true;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        // Kiểm tra xem tài khoản có tồn tại trong Firebase không
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final userInfo = userCredential.user;
        // Kiểm tra email domain
        if (userInfo != null) {
          final email = userInfo.email;

          if (email != null && email.endsWith('@gmail.com')) {
            // if (email != null) {
            message.value = 'Đăng nhập thành công';

            /// Lấy dữ liệu từ bảng students tương ứng cập nhật vào biến student

            QueryDocumentSnapshot<Map<String, dynamic>> userSnapshot =
                await FirebaseFirestore.instance
                    .collection('teachers')
                    .where('email', isEqualTo: email)
                    .get()
                    .then((value) => value.docs.first);

            teacher = Teacher.fromJson(userSnapshot.data());

            return true;
          } else {
            // Email không hợp lệ, yêu cầu người dùng đăng nhập lại
            await signOut(); // Đăng xuất nếu cần
            message.value = 'Vui lòng đăng nhập bằng email TDMU';
            return false;
          }
        }
        if (userCredential.user != null) {
          return true;
        }
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> signInWithPhoneAndCode(
      String phoneNumber, String codePhone) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Truy vấn Firestore để lấy thông tin người dùng
      DocumentSnapshot userSnapshot = await firestore
          .collection('teachers')
          .where('phone', isEqualTo: phoneNumber)
          .get()
          .then((value) => value.docs.first);

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        // Kiểm tra xem mã codePhone có khớp không
        if (userData['codePhone'] == codePhone) {
          teacher = Teacher.fromJson(userData);
          return true; // Đăng nhập thành công
        } else {
          print('Sai mã codePhone.');
          return false; // Đăng nhập thất bại
        }
      } else {
        message.value = 'Tên tài khoản hoặc mật khẩu không đúng.';
        return false; // Người dùng không tồn tại
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi đăng nhập: $e');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      isLoading.value = true;
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      isLoading.value = false;
      return true;
      // Get.offAllNamed('/guestPage'); // Redirect to guest page after sign-out
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    }
    return false;
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<bool> saveInfoUser(Teacher teacher) async {
    isLoading.value = true;
    try {
      const url = '$uRL/teacher'; // API URL for updating student info
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          // Use jsonEncode to serialize the map
          'phone': teacher.phone,
          'name': teacher.name,
          'codePhone': teacher.codePhone,
          'email': teacher.email,
          // 'classId': teacher.classes!.classId,
          'photoUrl': teacher.photoUrl,
        }),
      );

      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        return true;
      } else {
        message.value = 'Có lỗi xảy ra: ${response.body}';
        return false;
      }
    } catch (e) {
      print('Error updating user info: ${e.toString()}');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
