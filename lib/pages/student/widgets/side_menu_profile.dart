import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/auth/models/student.dart';
import 'package:tdmubook/pages/student/widgets/info_card.dart';
import 'package:tdmubook/pages/student/widgets/side_menu_tile.dart';
import '../../../shared/interface/menu_item.dart';

class SideMenuProfile extends StatefulWidget {
  const SideMenuProfile({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  State<SideMenuProfile> createState() => _SideMenuProfileState();
}

class _SideMenuProfileState extends State<SideMenuProfile> {
  final UserController _userController = Get.find<UserController>();
  late Student student;


  List<MenuItem> sideMenus = [
    MenuItem(title: "Thông tin tài khoản", icon: Icon(Icons.account_circle_outlined, color: Colors.white)),
    MenuItem(title: 'Đổi mã đăng nhập', icon: Icon(Icons.vpn_key_outlined, color: Colors.white)),
    MenuItem(title: 'Đăng xuất', icon: Icon(Icons.logout, color: Colors.white)),

  ];

  late MenuItem selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    student = _userController.student;
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoCard(
                    name: student.name!, profession: student.classes!.name!),
                SizedBox(height: 8),
                Center(
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(student.photoUrl ??
                        "https://img.freepik.com/premium-vector/bronze-membership-icon-default-avatar-profile-icon-membership-icon-social-media-user-image-vector-illustration_561158-4231.jpg?size=626&ext=jpg&ga=GA1.1.1973436602.1725011771&semt=ais_hybrid"),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 24, top: 16, bottom: 16),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
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
