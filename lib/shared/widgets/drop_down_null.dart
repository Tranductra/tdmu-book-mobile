import 'package:flutter/material.dart';
import 'package:tdmubook/shared/constants/styles.dart';

class DropDownNull extends StatefulWidget {
  const DropDownNull({super.key});

  @override
  State<DropDownNull> createState() => _DropDownNullState();
}

class _DropDownNullState extends State<DropDownNull> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Variable to store the selected value
  String? selectedTitle;

  @override
  Widget build(BuildContext context) {
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
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintStyle: styleS16W4(const Color(0xffAFAFAF)),
        ),
        hint: Text('Không có dữ liệu',
            style: styleS16W4(const Color(0xffAFAFAF))),
        value: selectedTitle,
        items: [],
        onChanged: (value) {},
        isExpanded: true,
      ),
    );
  }
}
