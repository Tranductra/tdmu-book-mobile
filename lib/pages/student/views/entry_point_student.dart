import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tdmubook/pages/student/views/feed_student_page.dart';
import 'package:tdmubook/pages/student/views/search_student_page.dart';
import 'package:tdmubook/pages/student/widgets/menu_button.dart';
import 'package:tdmubook/pages/student/widgets/side_menu.dart';
import 'package:tdmubook/pages/student/widgets/side_menu_profile.dart';
import 'package:tdmubook/shared/utils/rive_utils.dart';
import '../../../shared/models/rive_asset.dart';
import '../models/rive_asset_student.dart';

class EntryPointStudent extends StatefulWidget {
  const EntryPointStudent({super.key});

  @override
  State<EntryPointStudent> createState() => _EntryPointStudentState();
}

class _EntryPointStudentState extends State<EntryPointStudent>
    with SingleTickerProviderStateMixin {
  RiveAsset selected = bottomNavs[0];
  late SMIBool isSideBarClosed;
  bool isSideMenuClosed = true;
  bool isProfileMenuOpen = false; // New state for Profile Menu

  late AnimationController animationController;
  late Animation animation;
  late Animation scaleAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
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

  void _buildOpenMenu() {
    setState(() {
      isProfileMenuOpen = !isProfileMenuOpen; // Toggle profile menu state
      if (isProfileMenuOpen) {
        animationController.forward(); // Open Profile Menu
      } else {
        animationController.reverse(); // Close Profile Menu
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xff17203a),
        // resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            //SideMenu
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              width: 288,
              curve: Curves.fastOutSlowIn,
              left: isSideMenuClosed ? -288 : 0,
              height: MediaQuery.of(context).size.height,
              child: SideMenu(
                onMenuClosed: () {
                  isSideBarClosed.value = !isSideBarClosed.value;
                  if (isSideMenuClosed) {
                    animationController.forward();
                  } else {
                    animationController.reverse();
                  }
                  setState(() {
                    isSideMenuClosed = isSideBarClosed.value;
                  });
                },
              ),
            ),
            // Profile Menu
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              width: 288,
              curve: Curves.fastOutSlowIn,
              right: isProfileMenuOpen ? 0 : -288, // Move menu to the right
              height: MediaQuery.of(context).size.height,
              child: isProfileMenuOpen
                  ? SideMenuProfile(onPressed: _buildOpenMenu)
                  : Container(), // Show Profile Menu
              // child: SideMenuProfile(onPressed: _buildOpenMenu),
            ),

            // FeedStudentPage
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(isProfileMenuOpen
                    ? -30 * animation.value * pi / 180
                    : animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                  offset: Offset(
                      (isProfileMenuOpen ? -animation.value : animation.value) *
                          265,
                      0),
                  child: Transform.scale(
                      scale: scaleAnimation.value,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: _goToPageNav(bottomNavs.indexOf(selected))))),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: 8,
              left: isSideMenuClosed ? 0 : 220,
              curve: Curves.fastOutSlowIn,
              child:
                  isProfileMenuOpen // Hide MenuButton if Profile Menu is open
                      ? Container()
                      : MenuButton(
                          onTap: () {
                            isSideBarClosed.value = !isSideBarClosed.value;
                            if (isSideMenuClosed) {
                              animationController.forward();
                            } else {
                              animationController.reverse();
                            }
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
                            isSideBarClosed =
                                controller.findSMI("isOpen") as SMIBool;
                            isSideBarClosed.value = true;
                          },
                        ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  _buildAnimatedContainer(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 4,
      width: selected == bottomNavs[index] ? 24 : 0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    );
  }

  _buildBottomNav() {
    return Transform.translate(
      offset: Offset(0, animation.value * 100),
      child: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 24),
        decoration: const BoxDecoration(
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
                  if (index == 3) {
                    _buildOpenMenu();
                  }
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
    );
  }

  _goToPageNav(int index) {
    switch (index) {
      case 0:
        return FeedStudentPage();
      case 1:
        return SearchStudentPage();
      case 2:
        return Container();
      default:
        return FeedStudentPage();
    }
  }
}
