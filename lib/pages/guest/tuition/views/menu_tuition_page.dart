import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/guest/education/models/master_training_model.dart';
import 'package:tdmubook/pages/guest/education/views/master_training_detail_page.dart';

import '../../education/controller/master_training_controller.dart';
import '../../widgets/card_animation_widget.dart';
import '../controller/tuition_controller.dart';

class MenuTuitionPage extends StatefulWidget {
  const MenuTuitionPage({super.key});

  @override
  State<MenuTuitionPage> createState() =>
      _MenuTuitionPageState();
}

class _MenuTuitionPageState
    extends State<MenuTuitionPage> {

  final TuitionController tuitionController = Get.put(TuitionController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tuitionController.getTuitionList();
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
                  title: "HỌC PHÍ CÁC NGÀNH HỌC"),
              SizedBox(height: 24),
              Expanded(
                child: Obx(
                      () {
                    if (tuitionController.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount:
                        tuitionController.tuitionList.length,
                        itemBuilder: (context, index) {
                          MasterTraining masterTraining =
                          tuitionController
                              .tuitionList[index];
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
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
