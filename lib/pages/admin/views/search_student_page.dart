import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/student/views/profile_student_page.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/teacher/views/profile_teacher_page.dart';

class SearchStudentPage extends StatefulWidget {
  const SearchStudentPage({super.key});

  @override
  State<SearchStudentPage> createState() => _SearchStudentPageState();
}

class _SearchStudentPageState extends State<SearchStudentPage> {
  UserController userController = Get.put(UserController());

  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<List<Map<String, dynamic>>> searchStudentsAndTeachers(
      String searchText) async {
    // Query for students (name, email, phone)
    var studentNameQuery = FirebaseFirestore.instance
        .collection('students')
        .where('name', isGreaterThanOrEqualTo: searchText)
        .where('name', isLessThanOrEqualTo: searchText + '\uf8ff')
        .get();

    var studentEmailQuery = FirebaseFirestore.instance
        .collection('students')
        .where('email', isGreaterThanOrEqualTo: searchText)
        .where('email', isLessThanOrEqualTo: searchText + '\uf8ff')
        .get();

    var studentPhoneQuery = FirebaseFirestore.instance
        .collection('students')
        .where('phone', isGreaterThanOrEqualTo: searchText)
        .where('phone', isLessThanOrEqualTo: searchText + '\uf8ff')
        .get();

    // Query for teachers (name, email, phone)
    var teacherNameQuery = FirebaseFirestore.instance
        .collection('teachers')
        .where('name', isGreaterThanOrEqualTo: searchText)
        .where('name', isLessThanOrEqualTo: searchText + '\uf8ff')
        .get();

    var teacherEmailQuery = FirebaseFirestore.instance
        .collection('teachers')
        .where('email', isGreaterThanOrEqualTo: searchText)
        .where('email', isLessThanOrEqualTo: searchText + '\uf8ff')
        .get();

    var teacherPhoneQuery = FirebaseFirestore.instance
        .collection('teachers')
        .where('phone', isGreaterThanOrEqualTo: searchText)
        .where('phone', isLessThanOrEqualTo: searchText + '\uf8ff')
        .get();

    // Wait for all queries to complete
    var querySnapshots = await Future.wait([
      studentNameQuery,
      studentEmailQuery,
      studentPhoneQuery,
      teacherNameQuery,
      teacherEmailQuery,
      teacherPhoneQuery
    ]);

    // Combine the results with a label for student or teacher and remove duplicates
    var allDocs = <Map<String, dynamic>>{};

    for (var snapshot in querySnapshots) {
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        data['type'] = snapshot == studentNameQuery ||
                snapshot == studentEmailQuery ||
                snapshot == studentPhoneQuery
            ? 'student'
            : 'teacher';
        allDocs.add(data);
      }
    }
    // print(allDocs.toList());

    return allDocs.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.search),
            labelText: 'Tìm kiếm sinh viên hoặc giảng viên',
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: searchStudentsAndTeachers(searchController.text),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var results = snapshot.data as List<Map<String, dynamic>>;
                return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      var result = results[index];
                      return InkWell(
                        onTap: () {
                          result['email'].endsWith('@student.tdmu.edu.vn')
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileStudentPage(
                                          studentId: result['studentId'])))
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileTeacherPage(
                                          teacherId: result['teacherId'])));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                result['photoUrl'] ?? 'default_image_url'),
                          ),
                          title: Text(result['name'] ?? 'No Name'),
                          subtitle: Text(result['email'] ?? 'No Email'),
                          trailing: Text(
                              // result['email'] == userController.emailCurrent
                              result['email'] ==
                                      userController.userCurrent.email
                                  ? 'Bạn'
                                  : (result['email']
                                          .endsWith('@student.tdmu.edu.vn')
                                      ? 'Sinh viên'
                                      : 'Giảng viên')),
                        ),
                      );
                    });
              },
            )
          : const Center(
              child:
                  Text('Nhập thông tin sinh viên hoặc giảng viên để tìm kiếm'),
            ),
    );
  }
}
