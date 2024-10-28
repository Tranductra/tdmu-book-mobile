import 'dart:convert';

import 'package:get/get.dart';
import 'package:tdmubook/config/token_manager.dart';
import 'package:http/http.dart' as http;
import 'package:tdmubook/pages/guest/education/models/master_training_model.dart';

class TuitionController extends GetxController {
  var isLoading = false.obs;
  var tuitionList = [].obs;

  Future<void> getTuitionList() async {
    try {
      isLoading(true);
      const url = '$uRL/tuition';

      final response = await http.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)['data'];

        tuitionList.value =
            jsonResponse.map((json) => MasterTraining.fromJson(json)).toList();
      } else {
        print('Failed to load industry list');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
