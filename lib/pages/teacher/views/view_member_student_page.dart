import 'package:flutter/material.dart';
import 'package:tdmubook/pages/admin/views/profile_student_page.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/auth/models/student.dart';

import '../../../shared/constants/styles.dart';
import '../controller/view_member_controller.dart';

class ViewMemberStudentPage extends StatefulWidget {
  const ViewMemberStudentPage({super.key});

  @override
  _ViewMemberStudentPageState createState() => _ViewMemberStudentPageState();
}

class _ViewMemberStudentPageState extends State<ViewMemberStudentPage> {
  ViewMemberController viewMemberController = Get.put(ViewMemberController());
  UserController userController = Get.find();
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    viewMemberController
        .fetchStudents(userController.teacher.classes![0].classId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách lớp ${userController.teacher.classes![0].name}'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Thanh tìm kiếm
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Tìm sinh viên',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  viewMemberController.filterStudents(value);
                },
              ),
              const SizedBox(height: 10),
              // Hiển thị danh sách sinh viên
              Expanded(
                child: Obx(() {
                  if (viewMemberController.isLoading.value) {
                    return Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ));
                  } else {
                    return ListView.builder(
                      itemCount: viewMemberController.listMember.length,
                      itemBuilder: (context, index) {
                        Student student =
                            viewMemberController.listMember[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: _buildInfoCard(student),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          )),
    );
  }

  _buildInfoCard(Student student) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProfileStudentPage(studentId: student.studentId!),
          ),
        );
      },
      child: SizedBox(
        height: 80,
        child: ListTile(
          tileColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(student
                  .photoUrl!)), // Replace with an actual placeholder image URL

          title: Text(
            '${student.name}',
            style: styleS16W6(Colors.white),
          ),
          subtitle: Text(
            '${student.email}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
