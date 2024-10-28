import 'package:flutter/material.dart';
import 'package:tdmubook/pages/guest/notifications/interface/type_notification.dart';
import 'package:tdmubook/pages/guest/notifications/views/guest_info_notification_page.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import 'package:tdmubook/shared/constants/styles.dart';
import 'list_notification_by_type_page.dart';

class GuestNotificationsPage extends StatefulWidget {
  const GuestNotificationsPage({super.key});

  @override
  State<GuestNotificationsPage> createState() => _GuestNotificationsPageState();
}

class _GuestNotificationsPageState extends State<GuestNotificationsPage> {
  List<TypeNotification> notifications = [
    TypeNotification(title: 'Tổng hợp', type: 'all'),
    TypeNotification(title: 'Học bổng', type: 'scholarship'),
    TypeNotification(title: 'Tuyển sinh', type: 'admission'),
    TypeNotification(title: 'Sinh viên', type: 'student'),
    TypeNotification(title: 'Giảng viên', type: 'teacher'),
    TypeNotification(title: 'Văn bản pháp quy', type: 'legal'),
    TypeNotification(title: 'Khác', type: 'other'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Thông báo'),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: notifications.length,
            itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(notifications[index].title, style: styleS16W5(Color(0xff222222)),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListNotificationByTypePage(typeNotification: notifications[index],)));
              },

            ),
          );
        }),
      ),
    );
  }
}
