import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<List<File>?> pickMultipleImages() async {
  try {
    final List<XFile> listXFile = await ImagePicker().pickMultiImage();

    final List<File> listFile = listXFile.map((e) => File(e.path)).toList();

    return listFile;
  } catch (e) {
    return null;
  }
}
