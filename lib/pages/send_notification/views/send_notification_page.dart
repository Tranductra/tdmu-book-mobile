import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/auth/models/teacher.dart';
import 'package:tdmubook/pages/auth/widgets/button_login_widget.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import 'package:tdmubook/shared/utils/validator.dart';

import '../../../shared/resources/storage_methods.dart';
import '../../../shared/utils/image.dart';
import '../../auth/widgets/textfield_login_widget.dart';

class SendNotificationPage extends StatefulWidget {
  @override
  _SendNotificationPageState createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final UserController _userController = Get.find();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  File? _file;

  _selecteImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'Chọn ảnh',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            const Divider(),
            SimpleDialogOption(
              padding: const EdgeInsets.all(10),
              child: const Text('Dùng máy ảnh'),
              onPressed: () async {
                Navigator.of(context).pop();
                File? file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            const Divider(),
            SimpleDialogOption(
              padding: const EdgeInsets.all(10),
              child: const Text('Chọn từ thư viện'),
              onPressed: () async {
                Navigator.of(context).pop();
                File? file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            const Divider(),
            SimpleDialogOption(
              padding: const EdgeInsets.all(10),
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  Future<void> _sendNotification() async {
    if (_formKey.currentState!.validate()) {
      // _formKey.currentState!.save();

      // Lấy user hiện tại (giáo viên)
      Teacher teacher = _userController.teacher;

      String classId = teacher.classes![0].classId!;
      String? photoUrl;
      if (_file != null) {
        photoUrl = await StorageMethods()
            .upLoadImageToStorage('notifications', _file!, true);
      } else {
        photoUrl = null;
      }

      // Tạo thông báo trong Firestore
      await FirebaseFirestore.instance.collection('notifications').add({
        'title': _titleController.text,
        'content': _contentController.text,
        'teacherId': teacher.teacherId,
        'classId': classId,
        'photoUrl': photoUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // (Tuỳ chọn) Gửi push notification đến học sinh thuộc lớp
      // Cần tích hợp FCM và lưu token của học sinh

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gửi thông báo thành công')),
      );
      // Reset form
      _formKey.currentState!.reset();
      clearImage();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Gửi thông báo'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextfieldLoginWidget(
                      controller: _titleController,
                      lable: 'Tiêu đề',
                      validator: Validator.validateContent,
                    ),
                    SizedBox(height: 20),
                    TextfieldLoginWidget(
                      controller: _contentController,
                      lable: 'Nội dung',
                      validator: Validator.validateContent,
                      maxLines: 5,
                    ),
                    SizedBox(height: 20),
                    _buildAttachFile(),
                    SizedBox(height: 20),
                    if (_file != null) _buildImagePreview(_file!),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ButtonLoginWidget(
                          title: 'Gửi',
                          onPressed: () {
                            _sendNotification();
                          }),
                    )
                  ],
                )),
          ),
        ));
  }

  _buildAttachFile() {
    return Row(
      children: [
        Text('Đính kèm ảnh:'),
        SizedBox(width: 10),
        IconButton(
            onPressed: () {
              _selecteImage(context);
            },
            icon: const Icon(
              Icons.image,
              color: Colors.blue,
            )),
      ],
    );
  }

  _buildImagePreview(File file) {
    return Stack(
      children: [
        Image.file(
          file,
          height: 200,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
        Positioned(
          right: -10,
          top: -10,
          child: IconButton(
            onPressed: () {
              clearImage();
            },
            icon: const Icon(
              Icons.cancel,
              size: 20,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
