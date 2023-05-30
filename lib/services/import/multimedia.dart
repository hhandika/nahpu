import 'package:image_picker/image_picker.dart';

class ImageServices {
  Future<List<String>> pickImages() async {
    final picker = ImagePicker();
    final result = await picker.pickMultiImage();
    return result.map((e) => e.path).toList();
  }

  Future<String?> accessCamera() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.camera);
    return result?.path;
  }
}
