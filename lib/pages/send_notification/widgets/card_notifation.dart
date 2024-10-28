import 'package:flutter/material.dart';
import 'package:tdmubook/shared/constants/styles.dart';
import 'package:tdmubook/shared/utils/date_time.dart';

import '../models/notification_models.dart';

class CardNotifation extends StatelessWidget {
  const CardNotifation({super.key, required this.notification});
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              notification.photoUrl ?? 'https://plus.unsplash.com/premium_photo-1682309526815-efe5d6225117?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG5vdGlmaWNhdGlvbnxlbnwwfHwwfHx8MA%3D%3D',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: styleS16W5(Color(0xff222222)),
              ),
              const SizedBox(height: 5),
              Text(
                notification.content,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 5),
              Text(
                formatDateTimePost(notification.timestamp.toDate()),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
