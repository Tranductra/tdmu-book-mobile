import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/auth/models/student.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import 'package:tdmubook/pages/send_notification/models/notification_models.dart';

import '../widgets/card_notifation.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    Student student = userController.student;

    return Scaffold(
      appBar: CustomAppBar(title: 'Thông báo'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('classId', isEqualTo: student.classes!.classId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, notifSnapshot) {
          if (notifSnapshot.hasError) {
            return Center(child: Text('Có lỗi xảy ra'));
          }

          if (notifSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (notifSnapshot.data!.docs.isEmpty) {
            return Center(child: Text('Chưa có thông báo nào'));
          }

          return ListView(
            children: notifSnapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              NotificationModel notification =
                  NotificationModel.fromMap(data, doc.id);
              return CardNotifation(notification: notification);
            }).toList(),
          );
        },
      ),
    );
  }
}
