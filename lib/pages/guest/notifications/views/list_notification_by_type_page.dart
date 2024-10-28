import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/guest/notifications/models/guest_notification.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import 'package:tdmubook/shared/constants/styles.dart';
import 'package:tdmubook/shared/utils/date_time.dart';

import '../controller/guest_notification_controller.dart';
import '../interface/type_notification.dart';
import 'guest_info_notification_page.dart';

class ListNotificationByTypePage extends StatefulWidget {
  const ListNotificationByTypePage({super.key, required this.typeNotification});
  final TypeNotification typeNotification;

  @override
  State<ListNotificationByTypePage> createState() => _ListNotificationByTypePageState();
}

class _ListNotificationByTypePageState extends State<ListNotificationByTypePage> {

  final GuestNotificationController controller = Get.put(GuestNotificationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getNotificationsByType(widget.typeNotification.type);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.typeNotification.title),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(controller.notifications.isEmpty) {
          return Center(
            child: Text('Không có thông báo nào'),
          );
        }
        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            GuestNotification notification = controller.notifications[index];
            return Card(
              margin: EdgeInsets.all(16),
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GuestInfoNotificationPage(notification: notification)));
                },
                title: Text(notification.name!, style: styleS16W5(Color(0xff222222)),),
                subtitle: Text(formatTimestamp(notification.dataPublished!)),
                trailing: Icon(Icons.remove_red_eye),
              ),
            );
          },
        );
      }),
    );
  }
}
