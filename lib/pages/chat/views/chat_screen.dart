import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/auth/models/user_current.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../../shared/constants/video_call.dart';
import '../../../shared/utils/image.dart';
import '../services/chat_service.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUsername;
  final String receiverId;

  const ChatScreen(
      {super.key, required this.receiverUsername, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserController userController = Get.put(UserController());
  late UserCurrent user;
  // text Controller;
  final TextEditingController _messageController = TextEditingController();
  File? _file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onUserLogin();
    user = userController.userCurrent;
    print(userController.userCurrent.currentId);
    print(userController.userCurrent.name);
    print(widget.receiverId);
    print(widget.receiverUsername);
  }

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
  void onUserLogin() {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: appId /*input your AppID*/,
      appSign: appSign /*input your AppSign*/,
      userID: userController.userCurrent.currentId!,
      userName: userController.userCurrent.name!,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  //chat & auth services
  final ChatService _chatService = ChatService();
  sendMessage() async {
    if (_messageController.text.isNotEmpty || _file != null) {
      // send the message
      await _chatService.sendMessage(
          widget.receiverId, _messageController.text.trim(), _file);
      _messageController.clear();
      clearImage();
    } else {
      // show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập nội dung tin nhắn'),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Row(
      //     children: [
      //       Text(widget.receiverUsername),
      //       // const SizedBox(
      //       //   width: 10,
      //       // ),
      //       _buildButtonCallPhone(),
      //       _buildButtonCallVideo(),
      //     ],
      //   ),
      // ),

      appBar: CustomAppBar(
          title: widget.receiverUsername,
          toolbarHeight: 110,
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildButtonCallPhone(),
          _buildButtonCallVideo(),
        ],
      )),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // display all messages
          Expanded(child: _buildMessageList()),
          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = userController.userCurrent.currentId!;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverId, senderId),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return const Text('Error');
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  _buildButtonCallPhone() {
    return Expanded(
      child: ZegoSendCallInvitationButton(
        iconSize: Size(24, 24),
        icon: ButtonIcon(
          icon: Icon(
            Icons.phone_in_talk_outlined,
            size: 24,
          ),
        ),
        isVideoCall: false,
        //You need to use the resourceID that you created in the subsequent steps.
        //Please continue reading this document.
        resourceID: "zegouikit_call",
        invitees: [
          ZegoUIKitUser(
            id: widget.receiverId,
            name: widget.receiverUsername,
          ),
        ],
      ),
    );
  }
  _buildButtonCallVideo() {
    return Expanded(
      child: ZegoSendCallInvitationButton(
        icon: ButtonIcon(
          icon: Icon(
            Icons.video_call_outlined,
            size: 24,
          ),
        ),
        isVideoCall: true,
        //You need to use the resourceID that you created in the subsequent steps.
        //Please continue reading this document.
        resourceID: "zegouikit_call",
        invitees: [
          ZegoUIKitUser(
            id: widget.receiverId,
            name: widget.receiverUsername,
          ),
        ],
      ),
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser =
        data['senderId'] == userController.userCurrent.currentId!;
    // align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data['message'],
              imageUrl: data['imageUrl'],
              isCurrentUser: isCurrentUser,
            )
          ],
        ));
  }

  _buildUserInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl!),
          ),
          // icon image to upload image
          IconButton(
              onPressed: () {
                _selecteImage(context);
              },
              icon: const Icon(
                Icons.image,
                color: Colors.blue,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  if (_file != null)
                    Stack(
                      children: [
                        Image.file(
                          _file!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
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
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                        hintText: 'Nhập nội dung', border: InputBorder.none),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              sendMessage();
              setState(() {
                _messageController.text = '';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: const Text(
                'Gửi',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          )
        ],
      ),
    );
  }
}
