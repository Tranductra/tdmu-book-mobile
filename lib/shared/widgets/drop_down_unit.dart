import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdmubook/shared/controller/unit_controller.dart';
import 'package:tdmubook/shared/models/unit.dart';
import 'package:tdmubook/shared/widgets/drop_down_null.dart';

import '../constants/styles.dart';

class DropDownUnit extends StatefulWidget {
  const DropDownUnit({super.key, required this.onChanged});
  final Function(String) onChanged;

  @override
  State<DropDownUnit> createState() => _DropDownUnitState();
}

class _DropDownUnitState extends State<DropDownUnit> {
  UnitController unitController = Get.put(UnitController());
  late Future<List<Unit>> units;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    units = unitController.getAllData();
  }

  // Variable to store the selected value
  String? selectedTitle;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Unit>>(
      future: units,
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
              return snapshot.data!.map<Widget>((Unit item) {
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
            // decoration: InputDecoration(
            //   border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(6),
            //     borderSide: const BorderSide(color: Color(0xffE3E5E5), width: 1),
            //   ),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            //   hintStyle: styleS16W4(const Color(0xffAFAFAF)),
            // ),
            hint: Text('Chọn...', style: styleS16W4(const Color(0xffAFAFAF))),
            value: selectedTitle,
            items: [
              for (var unit in snapshot.data!)
                DropdownMenuItem(
                  value: unit.unitId,
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: selectedTitle == unit.unitId
                          ? Color(0xff00B389).withOpacity(0.1)
                          : Colors.blue.withOpacity(0.6),
                      border: Border.all(
                        color: selectedTitle == unit.unitId
                            ? Colors.blue
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      unit.name!,
                      style: styleS16W4(Colors.black),
                    ),
                  ),
                )
            ],
            onChanged: (value) {
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
