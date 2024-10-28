import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tdmubook/interface/guest/grid_item.dart';
import 'package:tdmubook/pages/guest/general_information/controller/general_info_controller.dart';
import 'package:tdmubook/pages/guest/general_information/models/general_info.dart';
import 'package:tdmubook/pages/guest/widgets/information_section_widget.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key, required this.gridItem});
  final GridItem gridItem;

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final GeneralInfoController controler = Get.put(GeneralInfoController());

  @override
  void initState() {
    super.initState();
    controler.fetchByKeyType(widget.gridItem.keyword!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.gridItem.title,
        onBackPressed: () {
          context.pop();
        },
      ),
      body: Obx(() {
        if (controler.isShowLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controler.listGeneralInfo.isNotEmpty
                  ? controler.listGeneralInfo.map((item) {
                      return Column(
                        children: [
                          InformationSectionWidget(
                              title: item.title!, content: item.description!),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList()
                  : [Center(child: Text('No data available'))],
            ),
          );
        }
      }),
    );
  }
}
