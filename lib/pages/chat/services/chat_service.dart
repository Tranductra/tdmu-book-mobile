import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';

import '../../../shared/resources/storage_methods.dart';
import '../models/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserController userController = Get.put(UserController());

  Future<void> sendMessage(
      String receiverId, String message, File? file) async {
    //get current user info
    final String currentUserId = userController.userCurrent.currentId!;
    final Timestamp timestamp = Timestamp.now();
    String? photoUrl;
    if (file != null) {
      photoUrl =
          await StorageMethods().upLoadImageToStorage('messages', file, true);
    } else {
      photoUrl = null;
    }

    Message newMessage = Message(
        senderId: currentUserId,
        receiverId: receiverId,
        message: message.isNotEmpty ? message : null,
        imageUrl: photoUrl,
        timestamp: timestamp);

    // construct chat room Id for the two users
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    // Add chat room ID field to the chat_rooms data
    Map<String, dynamic> chatRoomData = {
      'chattingUsers': [currentUserId, receiverId]
    };

    // Add the chat room data to the chat_rooms collection
    await _firestore.collection('chat_rooms').doc(chatRoomId).set(chatRoomData);

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userId, ortherUserId) {
    List<String> ids = [userId, ortherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<DocumentSnapshot?> getLastMessage(
      String userId, String otherUserId) async {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    QuerySnapshot querySnapshot = await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1) // Chỉ lấy một tin nhắn cuối cùng
        .get();
    // print(querySnapshot.docs.length);
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null;
    }
  }

  Future<List<String>> getChattingUsers(String userId) async {
    List<String> chattingUsers = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('chat_rooms')
          .where('chattingUsers', arrayContains: userId)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        List<dynamic> users = doc['chattingUsers'];
        for (dynamic user in users) {
          if (user != userId) {
            chattingUsers.add(user.toString());
          }
        }
      }

      // Loại bỏ các UID trùng lặp và trả về danh sách người dùng khác đang nhắn tin với người dùng này
      chattingUsers = chattingUsers.toSet().toList();
      return chattingUsers;
    } catch (error) {
      print('Error getting chatting users: $error');
      return [];
    }
  }
}
