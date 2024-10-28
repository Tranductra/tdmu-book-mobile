import 'package:flutter/material.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import '../services/chat_service.dart';
import '../widgets/char_card.dart';

class ListChatUser extends StatefulWidget {
  const ListChatUser({super.key});

  @override
  _ListChatUserState createState() => _ListChatUserState();
}

class _ListChatUserState extends State<ListChatUser> {
  List<String> chattingUsers = [];
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    loadChattingUsers();
  }

  Future<void> loadChattingUsers() async {
    List<String> users = await ChatService()
        .getChattingUsers(userController.userCurrent.currentId!);
    setState(() {
      chattingUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'DS Chat'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: chattingUsers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ChatCard(
                  uid: chattingUsers[index],
                  uidCurrent: userController.userCurrent.currentId!),
            );
          },
        ),
      ),
    );
  }
}
