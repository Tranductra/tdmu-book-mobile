import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdmubook/data/guest/general_information/general_information_data.dart';
import 'package:tdmubook/data/guest/general_information/training_program/training_program_data.dart';
import 'package:tdmubook/data/guest/trainning_programs/trainning_programs_data.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import 'package:tdmubook/shared/constants/styles.dart';

class TrainingProgramsPage extends StatefulWidget {
  const TrainingProgramsPage({super.key});

  @override
  _TrainingProgramsPageState createState() => _TrainingProgramsPageState();
}

class _TrainingProgramsPageState extends State<TrainingProgramsPage> {
  @override
  Widget build(BuildContext context) {
    var menuItems = TrainingProgramsData.listTrainingPrograms;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Chương trình đào tạo",
        onBackPressed: () {
          context.pop();
        },
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          if (item.subMenu == null) {
            return Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                  onTap: () {},
                ),
              ),
            );
          }
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 4.0,
            child: Container(
              alignment: Alignment.center,
              child: ExpansionTile(
                childrenPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                title: ListTile(
                  title: Text(
                    item.title,
                    style: styleS18W6(null),
                  ),
                ),
                children: item.subMenu == null
                    ? [] // Không có submenu thì ExpansionTile không mở rộng
                    : item.subMenu!.map<Widget>((subItem) {
                        return ListTile(
                          title: Text(
                            subItem.title,
                            style: styleS16W4(null),
                          ),
                          onTap: () {},
                        );
                      }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
