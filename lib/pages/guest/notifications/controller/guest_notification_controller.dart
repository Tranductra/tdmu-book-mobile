import 'dart:convert';
import 'package:get/get.dart';
import 'package:tdmubook/config/token_manager.dart';
import 'package:http/http.dart' as http;

import '../models/guest_notification.dart';
class GuestNotificationController extends GetxController{
  var notifications = [].obs;
  var isLoading = false.obs;


  Future<void> getNotificationsByType(String type) async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('$uRL/guest-notifications/type/$type'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)['data'];
        notifications.value =
            jsonResponse.map((json) => GuestNotification.fromJson(json))
                .toList();
      } else {
        throw Exception('Failed to load information');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
