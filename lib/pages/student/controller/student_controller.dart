import 'dart:convert';

import 'package:get/get.dart';
import '../../../config/token_manager.dart';
import '../../auth/models/student.dart';
import 'package:http/http.dart' as http;

class StudentController extends GetxController {
  var isLoading = false.obs;
  var listStudents = <Student>[].obs;

  Future<void> getStudentByClass(String classId) async {
    try {
      isLoading(true);
      final url = '$uRL/students/class/$classId'; // API URL for updating student info
      final response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        List<dynamic> list = data['students'];
        listStudents.clear();
        list.forEach((element) {
          listStudents.add(Student.fromJson(element));
        });
      }

    } catch (e) {
      print(e);
    }
    finally {
      isLoading(false);
    }
  }
}