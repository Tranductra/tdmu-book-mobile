import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/guest/education/models/industry_model.dart';
import 'package:tdmubook/pages/guest/education/models/master_training_model.dart';
import 'package:tdmubook/pages/guest/education/views/master_training_detail_page.dart';

import '../../widgets/card_animation_widget.dart';
import '../controller/industry_controller.dart';
import '../controller/master_training_controller.dart';
import 'menu_list_major_by_industry_page.dart';

class MenuListMasterTrainingPage extends StatefulWidget {
  const MenuListMasterTrainingPage({super.key});

  @override
  State<MenuListMasterTrainingPage> createState() =>
      _MenuListMasterTrainingPageState();
}

class _MenuListMasterTrainingPageState
    extends State<MenuListMasterTrainingPage> {
  MasterTrainingController masterTrainingController =
      Get.put(MasterTrainingController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    masterTrainingController.getMasterTrainingList();
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
                  title: "CHƯƠNG TRÌNH ĐÀO TẠO THẠC SĨ / TIẾN SĨ"),
              SizedBox(height: 24),
              Expanded(
                child: Obx(
                  () {
                    if (masterTrainingController.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount:
                            masterTrainingController.masterTrainingList.length,
                        itemBuilder: (context, index) {
                          MasterTraining masterTraining =
                              masterTrainingController
                                  .masterTrainingList[index];
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
        color: Colors.white,
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
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
