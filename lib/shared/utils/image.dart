import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(ImageSource source) async {
  File? image;
  final picker = ImagePicker();
  final file = await picker.pickImage(
    source: source,
    maxHeight: 720,
    maxWidth: 720,
  );

  if (file != null) {
    image = File(file.path);
  }

  return image;
}

Future<File?> pickVideo(ImageSource source) async {
  File? video;
  final picker = ImagePicker();
  final file = await picker.pickVideo(
    source: source,
    maxDuration: const Duration(minutes: 5),
  );

  if (file != null) {
    video = File(file.path);
  }

  return video;
}
