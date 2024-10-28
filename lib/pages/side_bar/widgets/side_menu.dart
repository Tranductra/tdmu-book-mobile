import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tdmubook/pages/side_bar/widgets/info_card.dart';
import 'package:tdmubook/pages/side_bar/widgets/side_menu_tile.dart';

import '../../../shared/utils/rive_utils.dart';
import '../models/rive_asset.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selected = sideMenus[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Color(0xff17203a),
        body: SafeArea(
            child: Container(
          height: double.infinity,
          width: 288,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(name: "Trần Đức Trà", profession: "D20KTPM02"),
              Padding(
                  padding: EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text("Menu".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white70))),
              ...sideMenus.map((menu) => SideMenuTile(
                  riveAsset: menu,
                  onTap: () {
                    menu.input!.change(true);
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        menu.input!.change(false);
                      },
                    );
                    setState(() {
                      selected = menu;
                    });
                  },
                  onInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  isSelected: selected == menu)),
              Padding(
                  padding: EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text("Khác".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white70))),
              ...sideMenus2.map((menu) => SideMenuTile(
                  riveAsset: menu,
                  onTap: () {
                    menu.input!.change(true);
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        menu.input!.change(false);
                      },
                    );
                    setState(() {
                      selected = menu;
                    });
                  },
                  onInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  isSelected: selected == menu)),
            ],
          ),
        )));
  }
}
