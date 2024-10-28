import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tdmubook/pages/student/widgets/info_card.dart';

import '../../../shared/interface/menu_item.dart';
import '../../guest/notifications/interface/type_notification.dart';
import '../../guest/notifications/views/list_notification_by_type_page.dart';
import '../../student/widgets/side_menu_tile.dart';

class SideMenuTeacher extends StatefulWidget {
  const SideMenuTeacher({super.key, required this.onMenuClosed});
  final VoidCallback onMenuClosed;

  @override
  State<SideMenuTeacher> createState() => _SideMenuTeacherState();
}

class _SideMenuTeacherState extends State<SideMenuTeacher> {

  List<MenuItem> sideMenus = [
    MenuItem(title: 'Trang chủ', icon: Icon(Icons.home_outlined, color: Colors.white)),
    MenuItem(title: "Phòng phát trực tiếp", icon: Icon(Icons.live_tv_outlined, color: Colors.white)),
    // MenuItem(title: "Yêu cầu giấy", icon: Icon(Icons.request_page_outlined, color: Colors.white)),
    MenuItem(title: "Thông tin khoa viện", icon: Icon(Icons.school_outlined, color: Colors.white)),
    MenuItem(title: "Danh sách lớp", icon: Icon(Icons.list_alt_outlined, color: Colors.white)),
    MenuItem(title: "Gửi thông báo cho lớp", icon: Icon(Icons.send_outlined, color: Colors.white)),
    MenuItem(title: "Thông báo từ đoàn trường", icon: Icon(Icons.notification_add_outlined, color: Colors.white)),
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
              InfoCard(name: "Giảng viên", profession: "Giảng viên"),
              Padding(
                  padding: EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text("Menu".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white70))),
              _buildSideMenu(),],
          ),
        )));
  }

  _goToPageNav(String selected) {
    switch (selected) {
      case "Trang chủ":
        widget.onMenuClosed();
        GoRouter.of(context).go('/home-teacher');
        break;
      case "Phòng phát trực tiếp":
        widget.onMenuClosed();
        GoRouter.of(context).go('/home-teacher/live-stream-room');
        break;
      case "Thông tin khoa viện":
        widget.onMenuClosed();
        // GoRouter.of(context).go('/teacher/department');
        break;
      case "Danh sách lớp":
        widget.onMenuClosed();
        GoRouter.of(context).go('/home-teacher/list-class');
        break;
      case "Gửi thông báo cho lớp":
        widget.onMenuClosed();
        GoRouter.of(context).go('/home-teacher/send-notification');
        break;
      case "Thông báo từ đoàn trường":
        widget.onMenuClosed();
        Navigator.push(context, MaterialPageRoute(builder: (context) => ListNotificationByTypePage(typeNotification: TypeNotification(title: 'Giảng viên', type: 'teacher'))));
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
