import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tdmubook/pages/auth/models/student.dart';
import 'package:http/http.dart' as http;
import 'package:tdmubook/pages/auth/models/user_current.dart';

import '../../../config/token_manager.dart';
import '../models/admin.dart';
import '../models/teacher.dart';

class UserController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var message = ''.obs;
  // var uidCurrent = '';
  // var emailCurrent = '';
  Student student = Student();
  Teacher teacher = Teacher();
  Admin admin = Admin();
  UserCurrent userCurrent = UserCurrent();
  String typeEmail = '';

  @override
  void onInit() {
    super.onInit();
    // user.bindStream(_firebaseAuth.authStateChanges());
    // ever(user, _handleAuthChanged);
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

        if (userInfo != null) {
          final email = userInfo.email;

          if (email != null) {
            // Gọi hàm đăng nhập dựa trên domain của email
            if (email.endsWith('@student.tdmu.edu.vn')) {
              return await signInStudent(userInfo);
            } else if (email.endsWith('@gmail.com')) {
              return await signInTeacher(userInfo);
            } else {
              // Email không hợp lệ, yêu cầu người dùng đăng nhập lại
              await signOut(); // Đăng xuất nếu cần
              message.value = 'Vui lòng đăng nhập bằng email của TDMU';
              return false;
            }
          }
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

  Future<bool> signInStudent(User userInfo) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('email', isEqualTo: userInfo.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        student = Student.fromJson(userSnapshot.data() as Map<String, dynamic>);
        message.value = 'Đăng nhập sinh viên thành công';
        userCurrent = UserCurrent(
          currentId: student.studentId!,
          email: student.email!,
          name: student.name!,
          photoUrl: student.photoUrl ?? '',
        );
        // uidCurrent = student.studentId!;
        // emailCurrent = student.email!;
        typeEmail = 'student';
        return true;
      } else {
        student.email = userInfo.email;
        typeEmail = 'student';
        message.value =
            'Tài khoản sinh viên chưa tồn tại. Vui lòng cập nhật thông tin.';
        return true; // Tiếp tục để tạo tài khoản mới
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> signInTeacher(User userInfo) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teachers')
          .where('email', isEqualTo: userInfo.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        teacher = Teacher.fromJson(userSnapshot.data() as Map<String, dynamic>);
        message.value = 'Đăng nhập giảng viên thành công';
        userCurrent = UserCurrent(
          currentId: teacher.teacherId!,
          email: teacher.email!,
          name: teacher.name!,
          photoUrl: teacher.photoUrl!,
        );
        // uidCurrent = teacher.teacherId!;
        // emailCurrent = student.email!;
        typeEmail = 'teacher';
        return true;
      } else {
        teacher.email = userInfo.email;
        typeEmail = 'teacher';
        message.value =
            'Tài khoản giảng viên chưa tồn tại. Vui lòng cập nhật thông tin.';
        return true; // Tiếp tục để tạo tài khoản mới
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> signInWithPhoneAndCode(
      String phoneNumber, String codePhone) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Truy vấn Firestore để lấy thông tin sinh viên
      QuerySnapshot studentSnapshot = await firestore
          .collection('students')
          .where('phone', isEqualTo: phoneNumber)
          .get();

      // Truy vấn Firestore để lấy thông tin giáo viên
      QuerySnapshot teacherSnapshot = await firestore
          .collection('teachers')
          .where('phone', isEqualTo: phoneNumber)
          .get();

      // Truy vấn Firestore để lấy thông tin giáo viên
      QuerySnapshot adminSnapshot = await firestore
          .collection('admins')
          .where('phone', isEqualTo: phoneNumber)
          .get();

      Map<String, dynamic>? userData;

      // Kiểm tra xem người dùng có tồn tại trong bảng sinh viên không
      if (studentSnapshot.docs.isNotEmpty) {
        userData = studentSnapshot.docs.first.data() as Map<String, dynamic>;
        student = Student.fromJson(userData);
        userCurrent = UserCurrent(
          currentId: student.studentId!,
          email: student.email!,
          name: student.name!,
          photoUrl: student.photoUrl!,
        );
        // uidCurrent = student.studentId!;
        // emailCurrent = student.email!;

        typeEmail = 'student';
        print('Đã tìm thấy sinh viên.');
      }
      // Kiểm tra xem người dùng có tồn tại trong bảng giáo viên không
      else if (teacherSnapshot.docs.isNotEmpty) {
        userData = teacherSnapshot.docs.first.data() as Map<String, dynamic>;
        teacher = Teacher.fromJson(userData);
        userCurrent = UserCurrent(
          currentId: teacher.teacherId!,
          email: teacher.email!,
          name: teacher.name!,
          photoUrl: teacher.photoUrl!,
        );
        // uidCurrent = teacher.teacherId!;
        // emailCurrent = student.email!;
        typeEmail = 'teacher';
        print('Đã tìm thấy giáo viên.');
      } else if (adminSnapshot.docs.isNotEmpty) {
        userData = adminSnapshot.docs.first.data() as Map<String, dynamic>;
        admin = Admin.fromJson(userData);
        userCurrent = UserCurrent(
          currentId: admin.adminId!,
          email: admin.email!,
          name: admin.name!,
          photoUrl: admin.photoUrl!,
        );
        // uidCurrent = userData['adminId'];
        // emailCurrent = userData['email'];
        typeEmail = 'admin';
        print('Đã tìm thấy admin.');
      } else {
        print('Người dùng không tồn tại.');
        return false; // Người dùng không tồn tại
      }

      // Nếu tìm thấy dữ liệu người dùng
      if (userData != null) {
        // Kiểm tra mã codePhone có khớp không
        if (userData['codePhone'] == codePhone) {
          return true; // Đăng nhập thành công
        } else {
          print('Sai mã codePhone.');
          return false; // Đăng nhập thất bại
        }
      } else {
        print('Người dùng không tồn tại.');
        return false; // Người dùng không tồn tại
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi đăng nhập: $e');
      return false;
    }
  }

  Future<bool> signOut() async {
    isLoading.value = true;
    try {
      await _firebaseAuth.signOut();
      student = Student();
      teacher = Teacher();
      admin = Admin();
      userCurrent = UserCurrent();
      isLoading.value = false;
      return true;
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

  Future<bool> saveInfoUser(Student student) async {
    isLoading.value = true;
    try {
      const url = '$uRL/students'; // API URL for updating student info
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          // Use jsonEncode to serialize the map
          'phone': student.phone,
          'name': student.name,
          'codePhone': student.codePhone,
          'email': student.email,
          'classId': student.classes!.classId,
          'photoUrl': student.photoUrl,
        }),
      );

      // print(response.statusCode);
      // print(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return true;
      } else {
        message.value = 'Có lỗi xảy ra: ${data['message']}';
        return false;
      }
    } catch (e) {
      print('Error updating user info: ${e.toString()}');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> saveInfoTeacher(Map<String, dynamic> teacher) async {
    isLoading.value = true;
    try {
      const url = '$uRL/teacher'; // API URL for updating student info
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone': teacher['phone'],
          'name': teacher['name'],
          'codePhone': teacher['codePhone'],
          'email': teacher['email'],
          'classId': teacher['classId'],
          'photoUrl': teacher['photoUrl'],
        }),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        return true;
      } else {
        message.value = 'Có lỗi xảy ra: ${response.body}';
        return false;
      }
    } catch (e) {
      print('Error updating teacher info: ${e.toString()}');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
