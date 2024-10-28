import 'package:tdmubook/interface/guest/grid_item.dart';

class GeneralInformationData {
  static List<GridItem> listGeneralInformation = [
    GridItem(
      title: "Tên trường",
      route: '/guest/general-information/information-school',
      subMenu: null,
      keyword: 'name_school',
    ),
    GridItem(
      title: "Chiến lược phát triển",
      subMenu: null,
      route: '/guest/general-information/development-strategy',
      keyword: 'development_strategy',
    ),
    GridItem(
      title: "Giá trị cốt lõi",
      route: "/guest/general-information/core-values",
      subMenu: null,
      keyword: 'core_values',
    ),
    GridItem(
      title: "Triết lý giáo dục",
      route: "/guest/general-information/educational-philosophy",
      subMenu: null,
      keyword: 'educational_philosophy',
    ),
    GridItem(
      title: "Khái quát lịch sử phát triển",
      route: "/guest/general-information/history-summary",
      subMenu: null,
      keyword: 'history_summary',
    ),
    GridItem(
      title: "Kiểm định chất lượng và xếp hạng đại học",
      route: "/guest/general-information/quality-assurance-ranking",
      subMenu: null,
      keyword: 'quality_assurance_ranking',
    ),
    GridItem(
      title: "Ca khúc truyền thống",
      route: "/guest/general-information/traditional-song",
      subMenu: null,
    ),
  ];
}
