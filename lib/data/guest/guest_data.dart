import 'package:tdmubook/interface/guest/grid_item.dart';

class GuestData {
  static List<GridItem> gridItems = [
    GridItem(
      title: "Thông Tin Chung",
      image: "assets/icons/guest/icon_info.svg",
      route: "/guest/general-information",
    ),
    GridItem(
      title: "Chương Trình Đào Tạo",
      image: "assets/icons/guest/icon_program.svg",
      route: "/guest/training-programs",
    ),
    GridItem(
      title: "Đào tạo",
      image: "assets/icons/guest/icon_training.svg",
      route: "/guest/education",
    ),
    GridItem(
      title: "Học Phí",
      image: "assets/icons/guest/icon_money.svg",
      route: "/guest/tuition",
    ),
    GridItem(
      title: "Hỗ Trợ Học Tập",
      image: "assets/icons/guest/icon_help.svg",
    ),
    GridItem(
      title: "Thông báo",
      image: "assets/icons/guest/icon_notification.svg",
      route: "/guest/notifications",
    ),
    GridItem(
      title: "Tư vấn tuyển sinh",
      image: "assets/icons/guest/icon_message.svg",
      route: "/guest/admission-consulting",
    ),
    GridItem(
      title: "Tham quan trường học 3D",
      image: "assets/icons/guest/icon_travel.svg",
      route: "/guest/virtual",
    ),

  ];
}
