import 'package:flutter/material.dart';
import 'package:tdmubook/pages/guest/education/models/major_model.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';

class MajorDetailPage extends StatelessWidget {
  const MajorDetailPage({super.key, required this.major});
  final Major major;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: major.name ?? "Chi tiết ngành"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: major.images!.length,
          itemBuilder: (context, index) {
            return Image.network(major.images![index]);
          },
        ),
      ),
    );
  }
}
