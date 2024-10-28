import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tdmubook/pages/admin/widgets/info_card.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/auth/models/admin.dart';
import 'package:tdmubook/pages/student/widgets/side_menu_tile.dart';
import '../../../shared/interface/menu_item.dart';

class SideMenuProfileAdmin extends StatefulWidget {
  const SideMenuProfileAdmin({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  State<SideMenuProfileAdmin> createState() => _SideMenuProfileAdminState();
}

class _SideMenuProfileAdminState extends State<SideMenuProfileAdmin> {
  final UserController _userController = Get.find<UserController>();
  late Admin admin;

  List<MenuItem> sideMenus = [
    MenuItem(title: "Thông tin tài khoản", icon: const Icon(Icons.account_circle_outlined, color: Colors.white)),
    MenuItem(title: 'Đổi mã đăng nhập', icon: const Icon(Icons.vpn_key_outlined, color: Colors.white)),
    MenuItem(title: 'Đăng xuất', icon: const Icon(Icons.logout, color: Colors.white)),

  ];
  late MenuItem selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    admin = _userController.admin;
    selected = sideMenus[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xff17203a),
        body: SafeArea(
            child: Container(
          height: double.infinity,
          width: 288,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoCard(
                    name: admin.name!, profession: 'Tài khoản quản trị viên'),
                const SizedBox(height: 8),
                Center(
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(admin.photoUrl!),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 24, top: 16, bottom: 16),
                    child: Text("Trang cá nhân".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white70))),
                _buildSideMenu(),


                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: widget.onPressed.call,
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }


  _goToPageNav(String selected) {
    switch (selected) {
      case "Thông tin tài khoản":
        break;
      case "Đổi mã đăng nhập":
        break;
      case "Đăng xuất":
        _userController.signOut();
        GoRouter.of(context).go('/');
        break;
      default:
        print("Not found");
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
