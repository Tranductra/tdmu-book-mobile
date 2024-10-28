import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/guest/education/models/master_training_model.dart';
import 'package:tdmubook/pages/guest/education/views/master_training_detail_page.dart';
import '../../widgets/card_animation_widget.dart';
import '../controller/continuing_education_controller.dart';

class MenuListContinuingEducation extends StatefulWidget {
  const MenuListContinuingEducation({super.key});

  @override
  State<MenuListContinuingEducation> createState() =>
      _MenuListContinuingEducationState();
}

class _MenuListContinuingEducationState
    extends State<MenuListContinuingEducation> {

  final ContinuingEducationController controller = Get.put(ContinuingEducationController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getContinuingEducationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 24),
              CardAnimationWidget(
                  title: "CHƯƠNG TRÌNH ĐÀO TẠO HỆ THƯỜNG XUYÊN",),
              SizedBox(height: 24),
              Expanded(
                child: Obx(
                      () {
                    if (controller.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount:
                        controller.continuingEducationList.length,
                        itemBuilder: (context, index) {
                          MasterTraining masterTraining =
                          controller
                              .continuingEducationList[index];
                          return _buildItem(
                            name: masterTraining.name!,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MasterTrainingDetailPage(
                                              pdfUrl: masterTraining.file!)));
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildItem({
    required String name,
    Function()? onTap,
  }) {
    return Container(
      height: 64,
      // padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.yellowAccent
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
