import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdmubook/pages/auth/models/student.dart';
import 'package:tdmubook/pages/auth/widgets/button_login_widget.dart';
import 'package:tdmubook/pages/chat/views/chat_screen.dart';
import 'package:tdmubook/shared/constants/styles.dart';

class ProfileStudentPage extends StatelessWidget {
  final String studentId;
  const ProfileStudentPage({super.key, required this.studentId});

  Future<DocumentSnapshot> getStudentData() async {
    return FirebaseFirestore.instance
        .collection('students')
        .doc(studentId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông tin sinh viên',
          style: styleS20W6(Colors.black),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getStudentData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Student studentData =
              Student.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatarImage(studentData),
                SizedBox(height: 20),
                _buildInfo(studentData),
                SizedBox(height: 24),
                _buildButtonOptions(context, studentData),
              ],
            ),
          );
        },
      ),
    );
  }

  _buildAvatarImage(Student studentData) {
    return Center(
      child: CircleAvatar(
        radius: 70,
        backgroundImage: NetworkImage(studentData.photoUrl!),
      ),
    );
  }

  _buildInfo(Student studentData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            studentData.name!,
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
              _buildTitleAndContent('Email', studentData.email!),
              _buildTitleAndContent('Số điện thoại', studentData.phone!),
              _buildTitleAndContent('Lớp', studentData.classes!.name!),
              _buildTitleAndContent('Khoa', studentData.classes!.unit!.name!)
            ],
          ),
        ),
      ],
    );
  }

  _buildButtonOptions(BuildContext context, Student studentData) {
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
                        receiverUsername: studentData.name!,
                        receiverId: studentData.studentId!)));
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
