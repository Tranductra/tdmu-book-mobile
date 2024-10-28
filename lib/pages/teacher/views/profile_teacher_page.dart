import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdmubook/pages/auth/models/student.dart';
import 'package:tdmubook/pages/auth/models/teacher.dart';
import 'package:tdmubook/pages/auth/widgets/button_login_widget.dart';
import 'package:tdmubook/pages/chat/views/chat_screen.dart';
import 'package:tdmubook/shared/constants/styles.dart';

class ProfileTeacherPage extends StatelessWidget {
  final String teacherId;
  const ProfileTeacherPage({super.key, required this.teacherId});

  Future<DocumentSnapshot> getTeacherData() async {
    return FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông tin giảng viên',
          style: styleS20W6(Colors.black),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getTeacherData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          Teacher teacherData =
              Teacher.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatarImage(teacherData),
                SizedBox(height: 20),
                _buildInfo(teacherData),
                SizedBox(height: 24),
                _buildButtonOptions(context, teacherData),
              ],
            ),
          );
        },
      ),
    );
  }

  _buildAvatarImage(Teacher teacherData) {
    return Center(
      child: CircleAvatar(
        radius: 70,
        backgroundImage: NetworkImage(teacherData.photoUrl!),
      ),
    );
  }

  _buildInfo(Teacher teacherData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            teacherData.name!,
            style: styleS20W6(Colors.black87),
          ),
        ),
        SizedBox(height: 16),
        Divider(height: 1),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleAndContent('Email', teacherData.email!),
              _buildTitleAndContent('Số điện thoại', teacherData.phone!),
              _buildTitleAndContent('Cố vấn lớp',
                  teacherData.classes!.map((e) => e.name!).join(', ')),
              // _buildTitleAndContent('Khoa', teacherData.classes!.unit!.name!)
            ],
          ),
        ),
      ],
    );
  }

  _buildButtonOptions(BuildContext context, Teacher teacherData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          splashColor: Colors.greenAccent,
          onPressed: () {},
          icon: Icon(
            Icons.call_outlined,
            size: 32,
          ),
          color: Colors.blueAccent,
        ),
        IconButton(
          splashColor: Colors.greenAccent,
          onPressed: () {},
          icon: Icon(
            Icons.email_outlined,
            size: 32,
          ),
          color: Colors.blueAccent,
        ),
        IconButton(
          splashColor: Colors.greenAccent,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                        receiverUsername: teacherData.name!,
                        receiverId: teacherData.teacherId!)));
          },
          icon: Icon(
            Icons.message_outlined,
            size: 32,
          ),
          color: Colors.blueAccent,
        ),
      ],
    );
  }

  _buildTitleAndContent(String title, String name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: styleS16W6(Colors.blueAccent),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: styleS16W5(Colors.black),
          ),
        ],
      ),
    );
  }
}
