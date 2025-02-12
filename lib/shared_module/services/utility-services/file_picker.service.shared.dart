import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

Future<List<File>> getPictureFromGallery(isSingle) async {
  List<File> selectedMedias = [];

  FilePickerResult? result1 = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true );

  if (result1 == null) return [];

  if (isSingle) {
    if (result1.files.length > 0) {
      selectedMedias.add(File(result1.files[0].path!));
    } else {
      return [];
    }
  } else {
    for (var i = 0; i < result1.files.length; i++) {
      selectedMedias.add(File(result1.files[i].path!));
    }
  }

  return selectedMedias;
}

Future<List<File>> getPictureFromCamera() async {

  List<File> selectedMedias = [];

  final _picker = ImagePicker();
  final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    if (pickedFile.path != null && pickedFile.path != "") {
      selectedMedias.add(File(pickedFile.path));
    }
  } else {
    return [];
  }
  return selectedMedias;

}

Future<List<File>> getVideFromGallery(isSingle) async {
  List<File> selectedMedias = [];

  FilePickerResult? result1 = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true);

  if (result1 == null) return [];

  if (isSingle) {
    if (result1.files.length > 0) {
      selectedMedias.add(File(result1.files[0].path!));
    } else {
      return [];
    }
  } else {
    for (var i = 0; i < result1.files.length; i++) {
      selectedMedias.add(File(result1.files[i].path!));
    }
  }

  return selectedMedias;
}

Future<List<File>> getVideoFromCamera() async {

  List<File> selectedMedias = [];

  final _picker = ImagePicker();
  final pickedFile = await _picker.pickVideo(source: ImageSource.camera,maxDuration: const Duration(seconds: 10));
  if (pickedFile != null) {
    if (pickedFile.path != null && pickedFile.path != "") {
      selectedMedias.add(File(pickedFile.path));
    }
  } else {
    return [];
  }
  return selectedMedias;

}

getMimeType(String path) {
  String? mimeType = lookupMimeType(path);
  print("mimeType is");

  if (mimeType != null) {
    if (mimeType.contains('video')) {
      return "video";
    } else if (mimeType.contains('image')) {
      return "image";
    } else {
      return "application";
    }
  } else {
    return "application";
  }
}
