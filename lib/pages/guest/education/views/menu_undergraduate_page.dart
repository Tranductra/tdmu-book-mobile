import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdmubook/pages/guest/education/models/industry_model.dart';
import 'package:tdmubook/shared/constants/styles.dart';

import '../../widgets/card_animation_widget.dart';
import '../controller/industry_controller.dart';
import 'menu_list_major_by_industry_page.dart';

class MenuUndergraduatePage extends StatefulWidget {
  const MenuUndergraduatePage({super.key});

  @override
  State<MenuUndergraduatePage> createState() => _MenuUndergraduatePageState();
}

class _MenuUndergraduatePageState extends State<MenuUndergraduatePage> {
  IndustryController industryController = Get.put(IndustryController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    industryController.getIndustryList();
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
              CardAnimationWidget(title: "KHỐI NGÀNH ĐÀO TẠO"),
              SizedBox(height: 24),
              Expanded(
                child: Obx(
                  () {
                    if (industryController.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: industryController.industryList.length,
                        itemBuilder: (context, index) {
                          Industry industry =
                              industryController.industryList[index];
                          return _buildItem(
                            img: industry.photoUrl!,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MenuListMajorByIndustryPage(
                                              industry: industry)));
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
    required String img,
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              img,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
