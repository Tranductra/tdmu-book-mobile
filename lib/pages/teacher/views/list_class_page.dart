import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/admin/views/profile_student_page.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import 'package:tdmubook/pages/student/controller/student_controller.dart';
import 'package:tdmubook/shared/constants/styles.dart';
import '../../auth/models/student.dart';

class ListClassPage extends StatefulWidget {
  const ListClassPage ({super.key});

  @override
  State<ListClassPage> createState() => _ListClassPageState();
}

class _ListClassPageState extends State<ListClassPage> {

  StudentController studentController = Get.put(StudentController());
  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentController.getStudentByClass(userController.teacher.classes![0].classId!);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Danh sách lớp ${userController.teacher.classes![0].name}'),
      body: Obx(() {
        if (studentController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // childAspectRatio: 0.8,
                  crossAxisCount: 2), itemBuilder: (context, index) {
                Student student = studentController.listStudents[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileStudentPage(studentId: student.studentId!)));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(student.photoUrl!),
                    ),
                    SizedBox(height: 16),
                    Text(student.name!, style: styleS16W6(Color(0xff222222)),),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     SizedBox(height: 8),
                    //     Text(student.email!, style: styleS14W4(Color(0xff222222))),
                    //     SizedBox(height: 8),
                    //     Text(student.phone!, style: styleS14W4(Color(0xff222222))),
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          },
          itemCount: studentController.listStudents.length,
          );

      }
      }),
    );
  }
}
