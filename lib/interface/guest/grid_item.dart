class GridItem {
  String title;
  String? subtitle;
  String? image;
  String? route;
  List<GridItem>? subMenu;
  String? keyword;
  GridItem(
      {required this.title,
      this.subtitle,
      this.image,
      this.route,
      this.subMenu,
      this.keyword});
}
