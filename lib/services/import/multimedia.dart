import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/utility_services.dart';

class ImageServices {
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
    return result.map((e) => e.path).toList();
  }

  Future<List<String>> pickFromFiles() async {
    List<File> files = await FilePickerServices()
        .pickMultiFiles(['jpg', 'png', 'jpeg', 'heic']);
    return files.map((e) => e.path).toList();
  }

  Future<String?> accessCamera() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.camera);
    return result?.path;
  }
}
