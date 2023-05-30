import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/utility_services.dart';

class ImageServices extends DbAccess {
  ImageServices(super.ref);

  Future<List<String>> pickImages() async {
    switch (systemPlatform) {
      case PlatformType.mobile:
        return await pickFromGallery();
      case PlatformType.desktop:
        return await pickFromFiles();
      case PlatformType.unknown:
        throw Exception('Unsupported platform');
      default:
        return [];
    }
  }

  Future<List<String>> pickFromGallery() async {
    final picker = ImagePicker();
    final result = await picker.pickMultiImage();
    List<File> files = await _moveFiles(result.map((e) => e.path).toList());
    return files.map((e) => e.path).toList();
  }

  Future<List<String>> pickFromFiles() async {
    List<File> result = await FilePickerServices()
        .pickMultiFiles(['jpg', 'png', 'jpeg', 'heic']);
    List<File> files = await _moveFiles(result.map((e) => e.path).toList());
    return files.map((e) => e.path).toList();
  }

  Future<String?> accessCamera() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.camera);

    return result?.path;
  }

  Future<List<File>> _moveFiles(List<String> paths) async {
    List<File> files = [];
    for (String path in paths) {
      File file = File(path);
      File newPath = await FileServices(ref)
          .moveFileToProjectDir(file, Directory('media'));
      files.add(newPath);
    }
    return files;
  }
}
