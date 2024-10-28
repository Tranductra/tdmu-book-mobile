import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/guest/education/controller/major_controller.dart';
import 'package:tdmubook/pages/guest/education/models/industry_model.dart';
import 'package:tdmubook/pages/guest/education/models/major_model.dart';
import 'package:tdmubook/shared/constants/styles.dart';

import '../../widgets/card_animation_widget.dart';
import '../controller/industry_controller.dart';
import 'major_detail_page.dart';

class MenuListMajorByIndustryPage extends StatefulWidget {
  const MenuListMajorByIndustryPage({super.key, required this.industry});
  final Industry industry;

  @override
  State<MenuListMajorByIndustryPage> createState() =>
      _MenuListMajorByIndustryPageState();
}

class _MenuListMajorByIndustryPageState
    extends State<MenuListMajorByIndustryPage> {
  // IndustryController industryController = Get.put(IndustryController());
  MajorController majorController = Get.put(MajorController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    majorController.getMajorByIndustryList(widget.industry.industryId!);
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
              CardAnimationWidget(title: widget.industry.name ?? "CÁC NGÀNH"),
              SizedBox(height: 24),
              Expanded(
                child: Obx(
                  () {
                    if (majorController.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: majorController.majorByIndustryList.length,
                        itemBuilder: (context, index) {
                          // Industry industry =
                          //     industryController.industryList[index];
                          Major major =
                              majorController.majorByIndustryList[index];
                          return _buildItem(
                            major: major,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MajorDetailPage(
                                    major: major,
                                  ),
                                ),
                              );
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
    required Major major,
    Function()? onTap,
  }) {
    return Container(
      height: 100,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64,
                // height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(major.images![0]),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    major.name ?? "Tên ngành",
                    style: styleS16W5(Colors.red),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Danh hiệu: ${major.title ?? "Chưa cập nhật"}',
                    style: styleS14W4(Colors.black),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${major.totalCalculationOnly ?? "Chưa cập nhật"} tín chỉ',
                        style: styleS14W4(Colors.black),
                      ),
                      SizedBox(width: 16),
                      Text(
                        '${major.trainingTime ?? "Chưa cập nhật"}',
                        style: styleS14W4(Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 16),
              if (major.aun_qa ==
                  true) // Use if statement for conditional rendering
                Expanded(
                  child: Image.asset(
                    'assets/images/guest/education/pass_aun_qa.png',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
