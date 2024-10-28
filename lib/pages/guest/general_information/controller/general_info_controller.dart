import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../config/token_manager.dart';
import '../models/general_info.dart';

class GeneralInfoController extends GetxController {
  var isShowLoading = false.obs;
  var listGeneralInfo = <GeneralInfo>[].obs;

  Future<void> fetchByKeyType(String keyType) async {
    try {
      isShowLoading.value = true;
      final response = await http.get(
        Uri.parse('$uRL/general-infomations/key/$keyType'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)['data'];
        listGeneralInfo.value =
            jsonResponse.map((json) => GeneralInfo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load information');
      }
    } catch (e) {
      print(e);
    } finally {
      isShowLoading.value = false;
    }
  }
}
