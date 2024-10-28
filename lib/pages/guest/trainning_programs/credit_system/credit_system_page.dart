import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdmubook/data/guest/general_information/information_school/information_school_data.dart';
import 'package:tdmubook/data/guest/trainning_programs/credit_system/credit_system_data.dart';
import 'package:tdmubook/pages/animation/animation_text.dart';
import 'package:tdmubook/pages/guest/widgets/information_section_widget.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';

class CreditSystemPage extends StatelessWidget {
  const CreditSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    var creditSystemData = CreditSystemData();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tín chỉ",
        onBackPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var item in creditSystemData.listContent)
              Column(
                children: [
                  InformationSectionWidget(
                      title: item['title']!, content: item['content']!),
                  const SizedBox(height: 16),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
