import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  String title;
  String content;
  String teacherId;
  String classId;
  String? photoUrl;
  Timestamp timestamp;

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.teacherId,
    required this.classId,
    this.photoUrl,
    required this.timestamp,
  });

  factory NotificationModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    return NotificationModel(
      id: documentId,
      title: data['title'],
      content: data['content'],
      teacherId: data['teacherId'],
      classId: data['classId'],
      photoUrl: data['photoUrl'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'teacherId': teacherId,
      'classId': classId,
      'photoUrl': photoUrl,
      'timestamp': timestamp,
    };
  }
}
