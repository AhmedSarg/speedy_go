import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

File renameFile(File picture, String newName) {
  print('Original path: ${picture.path}');
  String dir = dirname(picture.path);
  String newPath = join(dir, newName);
  print('NewPath: ${newPath}');
  return picture.renameSync(newPath);
}

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