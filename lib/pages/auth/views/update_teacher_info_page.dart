import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/auth/models/student.dart';
import 'package:tdmubook/pages/auth/widgets/textfield_login_widget.dart';
import 'package:tdmubook/shared/constants/app_constants.dart';
import 'package:tdmubook/shared/constants/colors.dart';
import 'package:tdmubook/shared/utils/validator.dart';
import 'package:tdmubook/shared/widgets/drop_down_class.dart';
import 'package:tdmubook/shared/widgets/drop_down_unit.dart';
import '../../../shared/constants/styles.dart';
import '../../../shared/resources/storage_methods.dart';
import '../../../shared/utils/image.dart';
import '../models/teacher.dart';
import '../widgets/button_login_widget.dart';

class UpdateTeacherInfoPage extends StatefulWidget {
  UpdateTeacherInfoPage();

  @override
  _UpdateTeacherInfoPageState createState() => _UpdateTeacherInfoPageState();
}

class _UpdateTeacherInfoPageState extends State<UpdateTeacherInfoPage> {
  final _formKey = GlobalKey<FormState>();
  UserController userController = Get.find();
  File? _image;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codePhoneController = TextEditingController();
  String unitId = '';
  String classId = '';
  late User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    emailController.text = user.email!;
    nameController.text = user.displayName!;
  }

  void selectImage() async {
    File? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void _saveUserInfo() async {
    String photoUrl = await StorageMethods()
        .upLoadImageToStorage('profilePics', _image!, false);

    Map<String, dynamic> data = {
      'email': emailController.text,
      'name': nameController.text,
      'phone': phoneController.text,
      'codePhone': codePhoneController.text,
      'classId': [classId],
      'photoUrl': photoUrl,
    };
    // print('data: $data');
    // print(classId);

    bool success = await userController.saveInfoTeacher(data);
    if (success) {
      showSnackBar(context, 'Thông tin đã được cập nhật thành công!');
      context.go('/home');
    } else {
      showSnackBar(context, 'Cập nhật thông tin thất bại');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: getWidth(context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.symmetric(horizontal: getWidth(context) * 0.05)
              .copyWith(top: getHeight(context) * 0.1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'CẬP NHẬT THÔNG TIN GIẢNG VIÊN',
                  style: styleS24W4(primaryBlue).copyWith(
                      fontFamily: 'sf_compact', fontWeight: FontWeight.w200),
                ),
                SizedBox(height: 8),
                _buildUploadAvatar(),
                // TextfieldLoginWidget(
                //   controller: emailController,
                //   lable: 'Email',
                //
                // ),
                // SizedBox(height: getHeight(context) * 0.025),
                // TextfieldLoginWidget(
                //   controller: nameController,
                //   lable: 'Họ và tên',
                // ),
                SizedBox(height: getHeight(context) * 0.025),
                TextfieldLoginWidget(
                  validator: Validator.validatePhoneNumber,
                  controller: phoneController,
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
                SizedBox(height: getHeight(context) * 0.025),
                SizedBox(
                  child: DropDownUnit(
                    onChanged: (value) {
                      unitId = value;
                      setState(() {
                        print('unitId: $unitId');
                      });
                    },
                  ),
                ),
                SizedBox(height: getHeight(context) * 0.025),
                DropDownClass(
                  unitId: unitId,
                  onChanged: (value) {
                    classId = value;
                    print('classId: $classId');
                  },
                ),
                SizedBox(height: getHeight(context) * 0.025),
                ButtonLoginWidget(
                  title: 'Lưu thông tin',
                  onPressed: () async {
                    _saveUserInfo();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildUploadAvatar() {
    return Stack(
      children: [
        _image != null
            ? CircleAvatar(
                radius: 64,
                backgroundImage: FileImage(_image!),
              )
            : const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(
                    'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg'),
              ),
        Positioned(
            bottom: -10,
            left: 80,
            child: IconButton(
              icon: const Icon(Icons.add_a_photo),
              onPressed: () {
                selectImage();
              },
            ))
      ],
    );
  }
}
