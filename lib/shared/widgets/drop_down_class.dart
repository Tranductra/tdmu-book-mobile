import 'package:flutter/material.dart';
import 'package:tdmubook/shared/controller/class_controller.dart';
import 'package:tdmubook/shared/controller/unit_controller.dart';
import 'package:tdmubook/shared/models/class.dart';
import 'package:tdmubook/shared/models/unit.dart';
import 'package:tdmubook/shared/widgets/drop_down_null.dart';

import '../constants/styles.dart';

class DropDownClass extends StatefulWidget {
  const DropDownClass(
      {super.key, required this.onChanged, required this.unitId});
  final String unitId;
  final Function(String) onChanged;

  @override
  State<DropDownClass> createState() => _DropDownClassState();
}

class _DropDownClassState extends State<DropDownClass> {
  ClassController classController = ClassController();
  late Future<List<Class>> classes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // classes = classController.getClassByUnitId(widget.unitId);
    classes = classController.getClassByUnitId(widget.unitId);
  }

  @override
  void didUpdateWidget(covariant DropDownClass oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    classes = classController.getClassByUnitId(widget.unitId);
  }

  // Variable to store the selected value
  String? selectedTitle;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Class>>(
      future: classes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return DropDownNull();
        }

        return Container(
          alignment: Alignment.centerLeft,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.black.withOpacity(0.6),
              width: 1,
            ),
          ),
          child: DropdownButtonFormField(
            selectedItemBuilder: (BuildContext context) {
              return snapshot.data!.map<Widget>((Class item) {
                return Text(
                  item.name!,
                  style: styleS16W4(
                    Colors.black,
                  ),
                );
              }).toList();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                // borderRadius: BorderRadius.circular(6),
                // borderSide:
                //     const BorderSide(color: Color(0xffE3E5E5), width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintStyle: styleS16W4(const Color(0xffAFAFAF)),
            ),
            hint: Text('Chọn...', style: styleS16W4(const Color(0xffAFAFAF))),
            value: selectedTitle,
            items: [
              for (var item in snapshot.data!)
                DropdownMenuItem(
                  value: item.classId,
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: selectedTitle == item.classId
                          ? Color(0xff00B389).withOpacity(0.1)
                          : Colors.blue.withOpacity(0.6),
                      border: Border.all(
                        color: selectedTitle == item.classId
                            ? Colors.blue
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      item.name!,
                      style: styleS16W4(Colors.black),
                    ),
                  ),
                )
            ],
            onChanged: widget.unitId == ''
                ? null
                : (value) {
                    setState(() {
                      selectedTitle = value.toString();
                      widget.onChanged(value.toString());
                    });
                  },
            isExpanded: true,
          ),
        );
      },
    );
  }
}
