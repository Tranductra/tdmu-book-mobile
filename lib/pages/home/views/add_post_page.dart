import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/home/services/firestore_methods_post.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/utils/image.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage>
    with SingleTickerProviderStateMixin {
  UserController userController = Get.put(UserController());
  File? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  // late TabController _tabController;

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      bool success = await FirestoreMethodsPost().uploadPost(
          _descriptionController.text, _file!, uid, username, profImage);

      if (success) {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, 'Đăng bài viết thành công');
        clearImage();
      } else {
        showSnackBar(context, 'Đăng bài viết thất bại');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _selecteImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'Tạo bài viết',
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

  @override
  void initState() {
    // _tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
    // _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Scaffold(
            appBar: CustomAppBar(title: 'Đăng bài viết', marginLeft: 24),
            body: Center(
              child: IconButton(
                onPressed: () {
                  _selecteImage(context);
                },
                icon: const Icon(Icons.upload),
              ),
            ),
          )
        : Scaffold(
      appBar: CustomAppBar(title: 'Đăng bài viết', marginLeft: 24, child:
        TextButton(
                onPressed: () {
                  postImage(
                      userController.admin.adminId!,
                      userController.admin.name!,
                      userController.admin.photoUrl!);
                },
                child: const Text('Tải lên',
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),),
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   leading: IconButton(
            //     onPressed: () {
            //       clearImage();
            //     },
            //     icon: const Icon(Icons.arrow_back),
            //   ),
            //   title: const Text('Đăng bài viết'),
            //   actions: [
            //     TextButton(
            //         onPressed: () {
            //           postImage(
            //               userController.admin.adminId!,
            //               userController.admin.name!,
            //               userController.admin.photoUrl!);
            //         },
            //         child: const Text('Tải lên',
            //             style: TextStyle(
            //                 color: Colors.blueAccent,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16)))
            //   ],
            // ),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _isLoading
                        ? const LinearProgressIndicator()
                        : const Padding(padding: EdgeInsets.only(top: 5)),
                    const Divider(),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(userController.admin.photoUrl!),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 80,
                      width: double.infinity,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                            hintText: 'Viết mô tả...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            )),
                        maxLines: 2,
                      ),
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                          child: Image.file(
                            _file!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                            right: 0,
                            top: -10,
                            child: IconButton(
                                onPressed: () {
                                  clearImage();
                                },
                                icon: Icon(Icons.cancel))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
