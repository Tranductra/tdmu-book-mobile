import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdmubook/shared/constants/styles.dart';

import '../../../shared/utils/date_time.dart';
import '../services/chat_service.dart';
import '../views/chat_screen.dart';

class ChatCard extends StatefulWidget {
  final String uid;
  final String uidCurrent;
  const ChatCard({super.key, required this.uid, required this.uidCurrent});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late Map<String, dynamic> userData;
  bool isStudent = true;
  String lastMessage = '';
  var messageData = {};
  bool isLastMessage = false;
  bool isLoading = true; // Add a loading flag

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      // Truy vấn thông tin từ bảng students
      DocumentSnapshot studentSnap = await FirebaseFirestore.instance
          .collection('students')
          .doc(widget.uid)
          .get();

      // Truy vấn thông tin từ bảng teachers
      DocumentSnapshot teacherSnap = await FirebaseFirestore.instance
          .collection('teachers')
          .doc(widget.uid)
          .get();


      // Nếu tồn tại dữ liệu từ bảng students
      if (studentSnap.exists) {
        var data = studentSnap.data() as dynamic;
        userData = data as Map<String, dynamic>;
      }
      // Nếu tồn tại dữ liệu từ bảng teachers
      else if (teacherSnap.exists) {
        var data = teacherSnap.data() as dynamic;
        userData = data as Map<String,
            dynamic>; // Cập nhật lại nếu bạn có model cho Teacher
        isStudent = false;
      }
      else {
        print("Người dùng không tồn tại trong cả 2 bảng.");
        return;
      }

      print(userData);

      // Truy vấn tin nhắn cuối cùng
      DocumentSnapshot? lastMessageSnap = await ChatService().getLastMessage(
        widget.uidCurrent,
        widget.uid,
      );
      if (lastMessageSnap != null && lastMessageSnap.data() != null) {
        messageData = (lastMessageSnap.data()! as dynamic);
        lastMessage = messageData['message'];
        if (messageData['receiverId'] == widget.uid) {
          isLastMessage = true;
        }
      }

      setState(() {
        isLoading = false; // Dừng trạng thái loading khi dữ liệu được tải
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Dừng trạng thái loading khi có lỗi
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(10),
          ));
    }

    // if (userData != null) {
    //   // If userData is still null, display an error or placeholder
    //   return Container(
    //       height: 70,
    //       decoration: BoxDecoration(
    //         color: Colors.lightBlueAccent,
    //         borderRadius: BorderRadius.circular(10),
    //       ));
    // }

    return InkWell(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatScreen(
                receiverUsername: userData['name'],
                receiverId: isStudent
                    ? userData['studentId']
                    : userData['teacherId'])));
      },
      child: ListTile(
        tileColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(userData[
                'photoUrl'])), // Replace with an actual placeholder image URL

        title: Text(
          '${userData['name']}',
          style: styleS16W6(Colors.white),
        ),
        subtitle: isLastMessage
            ? Text(
                'Bạn: $lastMessage',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              )
            : Text(
                lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            messageData['timestamp'] != null
                ? Text(formatDateTimePost(messageData['timestamp'].toDate()))
                : const Text(''),
            const SizedBox(height: 10),
            Text(isStudent ? 'Sinh viên' : 'Giảng viên')
          ],
        ), // Show empty if timestamp is null
      ),
    );
  }
}
