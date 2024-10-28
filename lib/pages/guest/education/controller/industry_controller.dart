import 'dart:convert';

import 'package:get/get.dart';
import 'package:tdmubook/config/token_manager.dart';
import 'package:http/http.dart' as http;
import 'package:tdmubook/pages/guest/education/models/industry_model.dart';

class IndustryController extends GetxController {
  var isLoading = false.obs;
  var industryList = [].obs;

  Future<void> getIndustryList() async {
    try {
      isLoading(true);
      const url = '$uRL/industrys';

      final response = await http.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)['data'];

        industryList.value =
            jsonResponse.map((json) => Industry.fromJson(json)).toList();
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
