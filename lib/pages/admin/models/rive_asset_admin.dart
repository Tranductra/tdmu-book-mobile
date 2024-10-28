import '../../../shared/models/rive_asset.dart';

class RiveAssetAdmin {
  static List<RiveAsset> bottomNavs = [
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Trang chủ",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "R",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Thông báo",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Trang cá nhân",
    ),
  ];

  static List<RiveAsset> sideMenus = [
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Quản lý bài viết",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Quản lý người dùng",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Quản lý lớp học",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Giấy xác nhận của sinh viên",
    ),
  ];

  static List<RiveAsset> sideMenus2 = [
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "SETTINGS",
      stateMachineName: "SETTINGS_Interactivity",
      title: "Cài đặt",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Trợ giúp",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Thông tin ứng dụng",
    ),
  ];
  static List<RiveAsset> profileMenu = [
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Chỉnh sửa thông tin",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Đổi mã đăng nhập",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Đăng xuất",
    ),
  ];

  static List<RiveAsset> profileMenu2 = [
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "SETTINGS",
      stateMachineName: "SETTINGS_Interactivity",
      title: "Cài đặt",
    ),
    RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "REFRESH/RELOAD",
      stateMachineName: "RELOAD_Interactivity",
      title: "Trợ giúp",
    ),
  ];
}
