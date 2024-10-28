import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tdmubook/pages/student/widgets/info_card.dart';
import '../../../shared/interface/menu_item.dart';
import '../../student/widgets/side_menu_tile.dart';

class SideMenuAdmin extends StatefulWidget {
  const SideMenuAdmin({super.key, required this.onMenuClosed});
  final VoidCallback onMenuClosed;


  @override
  State<SideMenuAdmin> createState() => _SideMenuAdminState();
}

class _SideMenuAdminState extends State<SideMenuAdmin> {
  List<MenuItem> sideMenus = [
    MenuItem(title: 'Trang chủ', icon: Icon(Icons.home_outlined, color: Colors.white)),
  ];

  late MenuItem selected;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = sideMenus[0];
  }
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
              InfoCard(
                  name: "Công tác trường",
                  profession: "Tài khoản quản trị viên"),
              Padding(
                  padding: EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text("Menu".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white70))),
              _buildSideMenu(),

            ],
          ),
        )));
  }
  _goToPageNav(String selected ) {
    switch (selected) {
      case 'Trang chủ':
        widget.onMenuClosed();
        GoRouter.of(context).go('/home-admin');
        break;
      default:
        Navigator.pushNamed(context, '/home-admin');
    }
  }

  _buildSideMenu() {
    return Column(
      children: [
        ...sideMenus.map((e) {
          return SideMenuTile(menuItem: e, onTap: () {
            _goToPageNav(e.title);
            setState(() {
              selected = e;
            });
          }, isSelected: selected == e);
        },)
      ],
    );
  }
}
