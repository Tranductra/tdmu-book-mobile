// lib/models/region.dart

class Region {
  final String name;
  final String imagePath; // Hình ảnh hiển thị trong GridView
  final String panoramaPath; // Ảnh 360 độ hiển thị trong PanoramaViewer

  Region({
    required this.name,
    required this.imagePath,
    required this.panoramaPath,
  });
}
