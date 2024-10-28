import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tdmubook/config/token_manager.dart';
import 'package:tdmubook/pages/auth/models/student.dart';

class ViewMemberController extends GetxController {
  var isLoading = false.obs;
  var listMember = [].obs;
  var filteredStudents = [].obs; // Danh sách sinh viên sau khi lọc
  var errorMessage = ''.obs;

  // Hàm gọi API
  Future<void> fetchStudents(String classId) async {
    try {
      isLoading(true);
      errorMessage('');
      var apiUrl = '$uRL/students/class/$classId';
      // print('API URL: $apiUrl');

      final response = await http.get(Uri.parse(apiUrl));
      // print(response.body);
      // print(response.statusCode);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body)['students'];
        listMember.value = jsonData.map((e) => Student.fromJson(e)).toList();
      } else {
        errorMessage('Error: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  // Hàm lọc sinh viên theo tên
  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.value = listMember;
    } else {
      filteredStudents.value = listMember
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
