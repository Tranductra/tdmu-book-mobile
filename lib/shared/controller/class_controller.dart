import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tdmubook/config/token_manager.dart';
import 'package:tdmubook/shared/models/class.dart';

import '../models/unit.dart';

class ClassController extends GetxController {
  var isLoading = false.obs;
  List<Class> classes = [];

  // Future<List<Class>> getAllData() async {
  //   // Get units from APIis
  //   isLoading.value = true;
  //   try {
  //     const url = '$uRL/units'; // API URL for getting all units
  //     // final token =
  //     //     tokenManager.bearToken; // Capture the token value for logging
  //     final response = await http.get(Uri.parse(url), headers: {
  //       'Content-Type': 'application/json',
  //     });
  //     // print(response.statusCode);
  //     // print(response.body);
  //     if (response.statusCode == 200) {
  //       List<dynamic> data = json.decode(response.body)['data'];
  //       units = data.map<Unit>((json) => Unit.fromJson(json)).toList();
  //       return data.map((json) => Unit.fromJson(json)).toList();
  //     } else {}
  //   } catch (e) {
  //     print('An error occurred: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  //   return [];
  // }

  Future<List<Class>> getClassByUnitId(String unitId) async {
    // Get units from APIis
    isLoading.value = true;
    try {
      final url = '$uRL/class/$unitId'; // API URL for getting all units
      // final token =
      //     tokenManager.bearToken; // Capture the token value for logging
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        classes = data.map<Class>((json) => Class.fromJson(json)).toList();
        return data.map((json) => Class.fromJson(json)).toList();
      } else {}
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
    return [];
  }
}
