import 'package:flutter/material.dart';
import 'package:tdmubook/shared/constants/colors.dart';
import 'package:tdmubook/shared/constants/styles.dart';

import '../../../shared/constants/app_constants.dart';

class ButtonLoginWidget extends StatelessWidget {
  const ButtonLoginWidget(
      {super.key, required this.title, required this.onPressed});
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context) * 0.06,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        onPressed: () {
          onPressed();
        },
        child: Text(
          title,
          style: styleS16W5(Colors.white),
        ),
      ),
    );
  }
}
