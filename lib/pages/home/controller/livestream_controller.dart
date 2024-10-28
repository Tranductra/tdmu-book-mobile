import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LivestreamController extends  GetxController {
  var isLoading = false.obs;
  var rooms = [].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchRooms() async {
    isLoading(true);
   try {
     QuerySnapshot snapshot = await firestore.collection('room_live').get();
     rooms.value = snapshot.docs.map((doc) {
       print(doc.id);
       print('data: ${doc.data()}');
       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
       data['roomId'] = doc.id; // Lưu ID phòng
       return data;
     }).toList();
    } catch (e) {
      print(e);
   }
    isLoading(false);
  }



}