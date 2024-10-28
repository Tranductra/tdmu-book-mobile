import 'package:flutter/material.dart';
import 'package:tdmubook/shared/constants/app_constants.dart';

class BgLogin extends StatelessWidget {
  const BgLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/login/logo.jpg',
      width: getWidth(context),
      height: getHeight(context),
      fit: BoxFit.cover,
    );
  }
}
