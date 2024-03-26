import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String> getImagesFromGallery() async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    return pickedImage!.path;
  }
  catch (e) {
    throw Exception(e);
  }
}
Future<void> getImagesFromCamera(BuildContext context) async {
  final picker = ImagePicker();
  List<XFile>? pickedFiles = [];

  while (true) {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) break;
    pickedFiles.add(pickedFile);
  }

  if (pickedFiles.isNotEmpty) {
    for (var pickedFile in pickedFiles) {
    }
  }
}