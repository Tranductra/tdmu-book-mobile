import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdmubook/data/guest/guest_data.dart';
import 'package:tdmubook/pages/animation/animation_text.dart';
import 'package:tdmubook/pages/guest/widgets/grid_item_widget.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import '../../shared/constants/app_constants.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    var listDataGridItem = GuestData.gridItems;
    return Scaffold(
      appBar: CustomAppBar(
        title: "TDMU Book",
        onBackPressed: () {
          context.pop();
        },
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Số cột trong GridView
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                children: [
                  for (var item in listDataGridItem)
                    GridItemWidget(
                      icon: item.image!,
                      title: item.title,
                      route: item.route,
                    )
                ],
              ),
            ),
            _buildHeader(context, "Thu Dau Mot University"),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String nameSchool) {
    return Container(
      width: getWidth(context) * 0.8,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade600.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: AnimatedText(
        text: nameSchool,
        style: GoogleFonts.lora(
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
