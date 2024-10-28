import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tdmubook/pages/home/views/feed_page.dart';
import 'package:tdmubook/pages/side_bar/widgets/menu_button.dart';
import 'package:tdmubook/pages/side_bar/widgets/side_menu.dart';
import 'package:tdmubook/shared/utils/rive_utils.dart';

import '../models/rive_asset.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  RiveAsset selected = bottomNavs[0];
  late SMIBool isSideBarClosed;
  bool isSideMenuClosed = true;

  late AnimationController animationController;
  late Animation animation;
  late Animation scaleAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Color(0xff17203a),
        // resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              width: 288,
              curve: Curves.fastOutSlowIn,
              left: isSideMenuClosed ? -288 : 0,
              height: MediaQuery.of(context).size.height,
              child: SideMenu(),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                  offset: Offset(animation.value * 265, 0),
                  child: Transform.scale(
                      scale: scaleAnimation.value,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: FeedPage()))),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              top: 8,
              left: isSideMenuClosed ? 0 : 220,
              curve: Curves.fastOutSlowIn,
              child: MenuButton(
                onTap: () {
                  isSideBarClosed.value = !isSideBarClosed.value;
                  if (isSideMenuClosed)
                    animationController.forward();
                  else
                    animationController.reverse();
                  setState(() {
                    isSideMenuClosed = isSideBarClosed.value;
                  });
                },
                onInit: (artboard) {
                  StateMachineController controller =
                      RiveUtils.getRiveController(
                    artboard,
                    stateMachineName: 'State Machine',
                  );
                  isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                  isSideBarClosed.value = true;
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Transform.translate(
          offset: Offset(0, animation.value * 100),
          child: SafeArea(
              child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  bottomNavs.length,
                  (index) => GestureDetector(
                    onTap: () {
                      bottomNavs[index].input!.change(true);
                      if (selected != bottomNavs[index]) {
                        setState(() {
                          selected = bottomNavs[index];
                        });
                      }
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          bottomNavs[index].input!.change(false);
                        },
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildAnimatedContainer(index),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: Opacity(
                            opacity: selected == bottomNavs[index] ? 1 : 0.5,
                            child: RiveAnimation.asset(
                              'assets/RiveAssets/icons.riv',
                              artboard: bottomNavs[index].artboard,
                              onInit: (artboard) {
                                StateMachineController controller =
                                    RiveUtils.getRiveController(artboard,
                                        stateMachineName:
                                            bottomNavs[index].stateMachineName);
                                bottomNavs[index].input =
                                    controller.findSMI("active") as SMIBool;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  _buildAnimatedContainer(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 4,
      width: selected == bottomNavs[index] ? 24 : 0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    );
  }
}
