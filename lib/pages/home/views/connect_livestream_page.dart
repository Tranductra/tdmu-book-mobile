import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import '../../layout/widgets/custom_app_bar.dart';
import 'live_page.dart';

class ConnectLivestreamPage extends StatefulWidget {
  ConnectLivestreamPage({super.key});

  @override
  State<ConnectLivestreamPage> createState() => _ConnectLivestreamPageState();
}

class _ConnectLivestreamPageState extends State<ConnectLivestreamPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserController userController = Get.find<UserController>();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      fixedSize: const Size(200, 60),
      backgroundColor: Colors.white,
    );

    return Scaffold(
      appBar: CustomAppBar(title: 'Phát trực tiếp', marginLeft: 24),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(height: 16,),
              ElevatedButton(
                style: buttonStyle,
                child: const Text('Bắt đầu phát trực tiếp'),
                onPressed: () {
                  String liveID = Random().nextInt(10000).toString();
                  jumpToLivePage(context, liveID, true);
                  startLive(liveID);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startLive(String liveID) async {
    await FirebaseFirestore.instance.collection('room_live').doc(liveID).set({
      "hostId": userController.userCurrent.currentId, // Thay thế với ID thực tế
      "hostName": userController.userCurrent.name, // Thay thế với tên thực tế
      "description": _descriptionController.text,
      "isLive": true,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  void jumpToLivePage(BuildContext context, String liveID, bool isHost) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(liveID: liveID, isHost: isHost, userCurrent: userController.userCurrent),
      ),
    );
  }
}