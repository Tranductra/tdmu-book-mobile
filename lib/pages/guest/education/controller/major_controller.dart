import 'dart:convert';

import 'package:get/get.dart';
import 'package:tdmubook/config/token_manager.dart';
import 'package:http/http.dart' as http;
import 'package:tdmubook/pages/guest/education/models/major_model.dart';

class MajorController extends GetxController {
  var isLoading = false.obs;
  var majorList = [].obs;
  var majorByIndustryList = [].obs;

  Future<void> getMajorList() async {
    try {
      isLoading(true);
      const url = '$uRL/majors';

      final response = await http.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)['data'];

        majorList.value =
            jsonResponse.map((json) => Major.fromJson(json)).toList();
      } else {
        print('Failed to load major list');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getMajorByIndustryList(String industryId) async {
    try {
      isLoading(true);
      final url = '$uRL/majors/industry/$industryId';

      final response = await http.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${tokenManager.bearToken}',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)['data'];

        majorByIndustryList.value =
            jsonResponse.map((json) => Major.fromJson(json)).toList();
      } else {
        print('Failed to load major list');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
