import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tdmubook/shared/constants/colors.dart';

class GridItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String? subtitle;
  final String? route;

  const GridItemWidget(
      {super.key,
      required this.icon,
      required this.title,
      this.subtitle,
      this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          context.go(route!);
        }
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            SvgPicture.asset(
              icon,
              width: 40,
              height: 40,
              // color: Colors.red,
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            if (subtitle != null)
              Text(
                subtitle!,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
