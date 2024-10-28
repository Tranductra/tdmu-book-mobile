import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import 'package:tdmubook/pages/student/views/entry_point_layout_student.dart';
import 'package:tdmubook/shared/constants/styles.dart';
import '../../home/views/live_page.dart';
import '../controller/livestream_controller.dart';

class LivestreamRoomsPage extends StatefulWidget {
  const LivestreamRoomsPage({super.key});

  @override
  LivestreamRoomsPageState createState() => LivestreamRoomsPageState();
}

class LivestreamRoomsPageState extends State<LivestreamRoomsPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserController userController = Get.find<UserController>();
  LivestreamController livestreamController = Get.put<LivestreamController>(LivestreamController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Phòng phát trực tiếp'),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('room_live').snapshots(), // Theo dõi thay đổi trong Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Có lỗi xảy ra: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Không có phòng nào'));
          }

          // Lấy danh sách phòng từ snapshot
          final rooms = snapshot.data!.docs.map((doc) => {
            'roomId': doc.id,
            ...doc.data() as Map<String, dynamic>,
          }).toList();

          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return Card(
                color: Colors.red.shade500,
                child: ListTile(
                  title: Text('${room['description']}', style: styleS16W5(Colors.white)),
                  subtitle: Text('Live của ${room['hostName']}', style: styleS12W5(Colors.white)),
                  trailing: const Icon(Icons.live_tv_outlined, color: Colors.white),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LivePage(liveID: room['roomId'], isHost: false, userCurrent: userController.userCurrent),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}