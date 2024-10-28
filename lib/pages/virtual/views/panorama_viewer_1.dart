import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class PanoramaViewer1 extends StatefulWidget {
  const PanoramaViewer1({super.key});

  @override
  _PanoramaViewer1State createState() => _PanoramaViewer1State();
}

class _PanoramaViewer1State extends State<PanoramaViewer1> {
  // Hàm để hiển thị thông tin khi nhấn vào hotspot
  void _showInfo(String info, {Function? onTap}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green[100],
          title: Align(alignment: Alignment.center, child: Text('Thông tin')),
          content: Wrap(
            children: [
              Divider(),
              Text(info),
              Divider(),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            onTap != null
                ? TextButton(
                    child: Text('Đi đến đây'),
                    onPressed: () => onTap(),
                  )
                : SizedBox.shrink(),
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PanoramaViewer(
            animSpeed: 0,
            child: Image.asset(
                'assets/images/guest/virtual/img_virtual_cong_1.jpg'),
            hotspots: [
              Hotspot(
                latitude: 15, // Vị trí theo trục ngang (độ)
                longitude: 81, // Vị trí theo trục dọc (độ)
                width: 50,
                height: 50,
                widget: GestureDetector(
                  onTap: () {
                    _showInfo('Dãy A1 - Phòng hành chính');
                  },
                  child: Icon(
                    Icons.info_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
              Hotspot(
                latitude: 15, // Vị trí theo trục ngang (độ)
                longitude: 148, // Vị trí theo trục dọc (độ)
                width: 50,
                height: 50,
                widget: GestureDetector(
                  onTap: () {
                    _showInfo('Cổng 1 Đại học Thủ Dầu Một');
                  },
                  child: Icon(
                    Icons.info_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
              Hotspot(
                latitude: 15, // Vị trí theo trục ngang (độ)
                longitude: 265, // Vị trí theo trục dọc (độ)
                width: 50,
                height: 50,
                widget: GestureDetector(
                  onTap: () {
                    _showInfo('Dãy E1');
                  },
                  child: Icon(
                    Icons.info_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
              Hotspot(
                latitude: 10, // Vị trí theo trục ngang (độ)
                longitude: 305, // Vị trí theo trục dọc (độ)
                width: 50,
                height: 50,
                widget: GestureDetector(
                  onTap: () {
                    _showInfo('Vườn hoa', onTap: () {
                      Navigator.pop(context);
                    });
                  },
                  child: Icon(
                    Icons.arrow_circle_up_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
              Hotspot(
                latitude: 10, // Vị trí theo trục ngang (độ)
                longitude: 360, // Vị trí theo trục dọc (độ)
                width: 50,
                height: 50,
                widget: GestureDetector(
                  onTap: () {
                    _showInfo('Dãy B1');
                  },
                  child: Icon(
                    Icons.info_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
              Hotspot(
                latitude: 5, // Vị trí theo trục ngang (độ)
                longitude: 395, // Vị trí theo trục dọc (độ)
                width: 50,
                height: 50,
                widget: GestureDetector(
                  onTap: () {
                    _showInfo('Sân cờ', onTap: () {
                      Navigator.pop(context);
                    });
                  },
                  child: Icon(
                    Icons.arrow_circle_up_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
          // Các nút Zoom In và Zoom Out đè lên panorama
        ],
      ),
    );
  }
}
