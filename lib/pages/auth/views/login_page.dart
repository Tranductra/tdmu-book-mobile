import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tdmubook/pages/auth/controller/teacher_controller.dart';
import 'package:tdmubook/pages/auth/views/update_user_info_page.dart';
import 'package:tdmubook/shared/constants/app_constants.dart';
import 'package:tdmubook/shared/constants/colors.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/widgets/bg_login.dart';
import 'package:tdmubook/shared/constants/styles.dart';

import '../../../shared/utils/validator.dart';
import '../../../shared/widgets/button_loading.dart';
import '../widgets/button_login_widget.dart';
import '../widgets/textfield_login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController codePhoneController = TextEditingController();
  final UserController userController = Get.put(UserController());
  final TeacherController teacherController = Get.put(TeacherController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late var isLogin = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void login() async {
    isLogin.value = true;
    try {
      if (formKey.currentState!.validate()) {
        bool success = await userController.signInWithPhoneAndCode(
            phoneNumberController.text, codePhoneController.text);
        if (success) {
          phoneNumberController.clear();
          codePhoneController.clear();
          String typeEmail = userController.typeEmail;
          if (typeEmail == 'student') {
            context.go('/home-student');
          } else if (typeEmail == 'teacher') {
            context.go('/home-teacher');
          } else if (typeEmail == 'admin') {
            context.go('/home-admin');
          } else {
            showSnackBar(context, 'Vui lòng đăng nhập bằng email TDMU');
          }
        } else {
          showSnackBar(context, "Số điện thoại hoặc mã cá nhân không đúng");
        }
      }
    } catch (e) {
      showSnackBar(context, 'Đăng nhập thất bại');
    } finally {
      isLogin.value = false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    codePhoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const BgLogin(),
            _buildBgOpacity(),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBgOpacity() {
    return Container(
      color: Colors.white.withOpacity(0.7),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40),
            child: SvgPicture.asset(
              'assets/images/login/logo_tdmu.svg',
              color: primaryBlue,
            ),
          ),
          SizedBox(height: getHeight(context) * 0.03),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'TDMU BOOK',
              style: TextStyle(
                  fontFamily: 'sf_compact',
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: textSecondary),
            ),
          ),
          _buildFormLogin(context),
        ],
      ),
    );
  }

  Widget _buildFormLogin(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        width: getWidth(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.symmetric(horizontal: getWidth(context) * 0.05),
        child: Column(
          children: [
            SizedBox(height: getHeight(context) * 0.05),
            Text(
              'ĐĂNG NHẬP',
              style: styleS24W4(primaryBlue).copyWith(
                  fontFamily: 'sf_compact', fontWeight: FontWeight.w200),
            ),
            SizedBox(height: getHeight(context) * 0.03),
            TextfieldLoginWidget(
              validator: Validator.validatePhoneNumber,
              controller: phoneNumberController,
              lable: 'Số điện thoại',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: getHeight(context) * 0.025),
            TextfieldLoginWidget(
              validator: Validator.validateCodePhone,
              controller: codePhoneController,
              suffixIcon: true,
              lable: 'Mã cá nhân',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              obscure: true,
            ),
            SizedBox(height: getHeight(context) * 0.02),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Quên mã cá nhân?',
                      style: styleS12W5(textPrimary),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: getHeight(context) * 0.02),
            Obx(
              () => isLogin.value
                  ? const ButtonLoading()
                  : ButtonLoginWidget(
                      title: 'Đăng nhập',
                      onPressed: login,
                    ),
            ),
            SizedBox(height: getHeight(context) * 0.02),
            TextButton(
              onPressed: () async {
                bool success = await userController.signInWithGoogle();

                if (success) {
                  String typeEmail = userController.typeEmail;
                  if (typeEmail == 'student') {
                    await _buildTypeEmailStudent(context);
                  } else if (typeEmail == 'teacher') {
                    await _buildTypeEmailTeacher(context);
                  } else {
                    showSnackBar(context, 'Vui lòng đăng nhập bằng email TDMU');
                  }
                }
              },
              child: Obx(
                () => userController.isLoading.value
                    ? const CircularProgressIndicator()
                    : Text('Đăng nhập nhanh bằng email'),
              ),
            ),
            TextButton(
              onPressed: () {
                context.go('/guest');
              },
              child: RichText(
                text: TextSpan(
                  text: 'Bạn không có tài khoản? ',
                  style: styleS14W4(textPrimary),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Chế độ khách',
                      style: styleS14W6(primaryBlue),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: getHeight(context) * 0.01),
          ],
        ),
      ),
    );
  }

  Future<void> _buildTypeEmailStudent(BuildContext context) async {
    var user = userController.student;
    print("user: ${user.email}");
    // Kiểm tra bảng students
    QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: user.email)
        .get();

    if (studentSnapshot.docs.isNotEmpty) {
      // Nếu người dùng thuộc bảng students
      DocumentSnapshot studentDoc = studentSnapshot.docs.first;

      if (studentDoc.exists) {
        context.go('/home-student');
        return; // Ngừng xử lý thêm vì đã chuyển hướng
      }
    } else {
      context.go("/user/update-user-info");
      return;
    }
  }

  Future<void> _buildTypeEmailTeacher(BuildContext context) async {
    var teacher = userController.teacher;

    // Kiểm tra bảng teachers nếu không thuộc bảng students
    QuerySnapshot teacherSnapshot = await FirebaseFirestore.instance
        .collection('teachers')
        .where('email', isEqualTo: teacher.email)
        .get();

    if (teacherSnapshot.docs.isNotEmpty) {
      // Nếu người dùng thuộc bảng teachers
      DocumentSnapshot teacherDoc = teacherSnapshot.docs.first;

      if (teacherDoc.exists) {
        context.go('/home-teacher');
        return; // Ngừng xử lý thêm vì đã chuyển hướng
      }
    } else {
      context.go("/user/update-teacher-info");
      return;
    }
  }
}
