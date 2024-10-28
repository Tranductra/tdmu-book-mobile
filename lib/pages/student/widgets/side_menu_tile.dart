import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/interface/menu_item.dart';

class SideMenuTile extends StatefulWidget {
  const SideMenuTile(
      {super.key,
      required this.menuItem,
      required this.onTap,
      required this.isSelected});

  final MenuItem menuItem;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  State<SideMenuTile> createState() => _SideMenuTileState();
}

class _SideMenuTileState extends State<SideMenuTile> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
              width: widget.isSelected ? 288 : 0,
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
              onTap: widget.onTap,
              leading: SizedBox(
                width: 34,
                height: 34,
                child: widget.menuItem.icon,
              ),
              title: Text(
                widget.menuItem.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
