import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdmubook/pages/guest/education/controller/industry_controller.dart';
import 'package:tdmubook/shared/constants/styles.dart';

import '../../../../shared/constants/app_constants.dart';
import '../../../animation/animation_text.dart';
import '../../widgets/card_animation_widget.dart';

class MenuEducationPage extends StatefulWidget {
  const MenuEducationPage({super.key});

  @override
  State<MenuEducationPage> createState() => _MenuEducationPageState();
}

class _MenuEducationPageState extends State<MenuEducationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 24),
              CardAnimationWidget(title: "CHƯƠNG TRÌNH ĐÀO TẠO"),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // Số cột trong GridView
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildItem(
                        title: 'ĐẠI HỌC CHÍNH QUY',
                        img: 'assets/images/guest/education/dhchinhquy.png',
                        onTap: () {
                          context.go('/guest/education/undergraduate');
                        }),
                    _buildItem(
                        title: 'THẠC SĨ / TIẾN SĨ',
                        img: 'assets/images/guest/education/thacsi.png',
                        onTap: () {
                          context.go('/guest/education/master-training');
                        }),
                    _buildItem(
                        title: 'HỆ THƯỜNG XUYÊN',
                        img: 'assets/images/guest/education/hethuongxuyen.png',
                        onTap: () {
                          context.go('/guest/education/continuing-education');
                        }),
                    _buildItem(
                        title: 'CÁC KHÓA NGẮN HẠN',
                        img:
                            'assets/images/guest/education/cackhoadaotaonganhan.png')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildItem({
    required String title,
    required String img,
    Function()? onTap,
  }) {
    return Container(
      height: 200,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                img,
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.lora(
                textStyle: styleS16W6(Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
