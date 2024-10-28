import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../shared/models/rive_asset.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile(
      {super.key,
      required this.riveAsset,
      required this.onTap,
      required this.onInit,
      required this.isSelected});

  final RiveAsset riveAsset;
  final VoidCallback onTap;
  final ValueChanged<Artboard> onInit;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 200),
              height: 56,
              width: isSelected ? 288 : 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: onTap,
              leading: SizedBox(
                width: 34,
                height: 34,
                child: RiveAnimation.asset(
                  riveAsset.src,
                  artboard: riveAsset.artboard,
                  onInit: onInit,
                ),
              ),
              title: Text(
                riveAsset.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
