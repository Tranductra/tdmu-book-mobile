import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdmubook/data/guest/general_information/general_information_data.dart';
import 'package:tdmubook/pages/guest/general_information/views/display_page.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';

import '../../../shared/constants/styles.dart';

class GeneralInformationPage extends StatefulWidget {
  const GeneralInformationPage({super.key});

  @override
  _GeneralInformationPageState createState() => _GeneralInformationPageState();
}

class _GeneralInformationPageState extends State<GeneralInformationPage> {
  @override
  Widget build(BuildContext context) {
    var menuItems = GeneralInformationData.listGeneralInformation;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Thông tin chung",
        onBackPressed: () {
          context.pop();
        },
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 4.0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              height: 70.0,
              child: ListTile(
                splashColor: Colors.transparent,
                title: Text(
                  item.title,
                  style: styleS18W6(null),
                ),
                onTap: () {
                  if (item.keyword == null) {
                    context.go(item.route!);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DisplayPage(gridItem: item)));
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
