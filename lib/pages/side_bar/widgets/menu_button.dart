import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key, required this.onTap, required this.onInit});
  final VoidCallback onTap;
  final ValueChanged<Artboard> onInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 4,
              )
            ],
          ),
          child: RiveAnimation.asset(
            'assets/RiveAssets/menu_button.riv',
            onInit: onInit,
          ),
        ),
      ),
    );
  }
}
