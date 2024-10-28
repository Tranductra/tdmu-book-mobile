import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';

class MasterTrainingDetailPage extends StatefulWidget {
  final String pdfUrl;

  MasterTrainingDetailPage({required this.pdfUrl});

  @override
  _MasterTrainingDetailPageState createState() =>
      _MasterTrainingDetailPageState();
}

class _MasterTrainingDetailPageState extends State<MasterTrainingDetailPage> {
  late String localFilePath;
  PdfController? controller; // Thay đổi để controller có thể null
  int? currentPage;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePDF(widget.pdfUrl);
  }

  Future<void> _downloadAndSavePDF(String url) async {
    final response = await http.get(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    localFilePath = '${dir.path}/document.pdf';
    final file = File(localFilePath);
    await file.writeAsBytes(response.bodyBytes);

    // Khởi tạo controller
    controller = PdfController(
      document: PdfDocument.openFile(localFilePath),
    );

    // Cập nhật trạng thái để xây dựng lại widget
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose(); // Kiểm tra nếu controller không null
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Chi tiết'),
      body: controller != null // Kiểm tra xem controller có không
          ? PdfView(
              scrollDirection: Axis.vertical,
              controller: controller!,
              backgroundDecoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
