import 'package:flutter/material.dart';
import 'package:tdmubook/shared/constants/colors.dart';
import 'package:tdmubook/shared/constants/styles.dart';

import '../../../shared/constants/app_constants.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading(
      {super.key});

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
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
