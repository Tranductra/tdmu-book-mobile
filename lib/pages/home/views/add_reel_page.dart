import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdmubook/pages/home/services/firestore_methods_post.dart';
import 'package:tdmubook/shared/constants/app_constants.dart';
import '../../../shared/utils/image.dart';
import '../../auth/controller/user_controller.dart';
import '../../layout/widgets/custom_app_bar.dart';
import '../widgets/view_video.dart';

class AddReelPage extends StatefulWidget {
  const AddReelPage({super.key});

  @override
  State<AddReelPage> createState() => _AddReelPageState();
}

class _AddReelPageState extends State<AddReelPage> {
  File? _file;
  UserController userController = Get.put(UserController());
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  void postVideo(String uid, String username, String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      bool success = await FirestoreMethodsPost().uploadReel(
          _descriptionController.text, _file!, uid, username, profImage);

      if (success) {
        setState(() {
          _isLoading = false;
        });

        clearVideo();
        showSnackBar(context, 'Reel posted successfully');
      } else {
        showSnackBar(context, 'Failed to post reel');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _selecteVideo(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'Tạo video',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            const Divider(),
            SimpleDialogOption(
              padding: const EdgeInsets.all(10),
              child: const Text('Dùng máy ảnh'),
              onPressed: () async {
                Navigator.of(context).pop();
                File? file = await pickVideo(ImageSource.camera);
                if (file != null) {
                  setState(() {
                    _file = file;
                  });
                }
              },
            ),
            const Divider(),
            SimpleDialogOption(
              padding: const EdgeInsets.all(10),
              child: const Text('Chọn từ thư viện'),
              onPressed: () async {
                Navigator.of(context).pop();
                File? file = await pickVideo(ImageSource.gallery);
                if (file != null) {
                  setState(() {
                    _file = file;
                  });
                }
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

  void clearVideo() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Scaffold(
      appBar: CustomAppBar(title: 'Tạo video reel', marginLeft: 24),
            body: Center(
              child: IconButton(
                onPressed: () {
                  _selecteVideo(context);
                },
                icon: const Icon(Icons.upload),
              ),
            ),
          )
        : Scaffold(
      appBar: CustomAppBar(title: 'Tạo video reel', marginLeft: 24, child:
        TextButton(
                onPressed: () {
                  postVideo(
                      userController.userCurrent.currentId!,
                      userController.userCurrent.name!,
                      userController.userCurrent.photoUrl!);
                },
                child: const Text('Tải lên',
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)))),
            // appBar: AppBar(
            //   leading: IconButton(
            //     onPressed: () {
            //       clearVideo();
            //     },
            //     icon: const Icon(Icons.arrow_back),
            //   ),
            //   title: const Text('Tạo video reel'),
            //   actions: [
            //     TextButton(
            //         onPressed: () {
            //           postVideo(
            //               userController.userCurrent.currentId!,
            //               userController.userCurrent.name!,
            //               userController.userCurrent.photoUrl!);
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: VideoView(
                        video: _file!,
                        onVideoSelected: (file) {
                          clearVideo();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
