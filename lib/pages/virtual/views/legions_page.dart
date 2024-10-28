// lib/pages/regions_page.dart

import 'package:flutter/material.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import 'package:tdmubook/pages/virtual/data/region_data.dart';
import 'package:tdmubook/pages/virtual/views/panorama_viewer_1.dart';
import 'package:tdmubook/pages/virtual/views/panorama_viewer_2.dart';
import '../models/region.dart';

class RegionsPage extends StatelessWidget {
  // Danh sách các khu vực
  final List<Region> regions = RegionData.regions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Tham Quan 3D'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 2,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột
            crossAxisSpacing: 10.0, // Khoảng cách ngang giữa các cột
            mainAxisSpacing: 10.0, // Khoảng cách dọc giữa các hàng
            childAspectRatio: 3 / 4, // Tỉ lệ chiều rộng / chiều cao của mỗi ô
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _goToPanoramaViewer(context, index);
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12.0)),
                        child: Image.asset(
                          regions[index].imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        regions[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _goToPanoramaViewer(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PanoramaViewer1()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PanoramaViewer2()));
        break;
      // Thêm các case khác ở đây
    }
  }
}
