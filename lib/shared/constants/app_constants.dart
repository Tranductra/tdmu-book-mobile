import 'package:flutter/material.dart';
import 'package:tdmubook/shared/constants/styles.dart';

double getWidth(context) => MediaQuery.of(context).size.width;
double getHeight(context) => MediaQuery.of(context).size.height;

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 10),
    backgroundColor: Colors.green,
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 10, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    content: Row(
      children: [
        const Icon(
          Icons.check_box,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(
          width: getWidth(context) * 0.03,
        ),
        Expanded(
          child: Text(
            message,
            style: styleS14W6(Colors.white),
          ),
        ),
      ],
    ),
  ));
}

void showSnackBarSecond(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 10),
    backgroundColor: Colors.red,
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 10, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    content: Row(
      children: [
        const Icon(
          Icons.cancel_outlined,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(
          width: getWidth(context) * 0.03,
        ),
        Expanded(
          child: Text(
            message,
            style: styleS14W6(Colors.white),
          ),
        ),
      ],
    ),
  ));
}
