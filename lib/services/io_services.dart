import 'dart:io';
import 'package:path/path.dart' as path;

const String writerSeparator = ' | ';

class AppIOServices {
  AppIOServices({
    required this.dir,
    required this.fileStem,
    required this.ext,
  });

  final String dir;
  final String fileStem;
  final String ext;

  File getFilename() {
    String fileName = '$fileStem.$ext';
    // Check if file exists
    File file = _createSavePath(fileName);
    if (file.existsSync()) {
      int i = 1;
      while (file.existsSync()) {
        fileName = '$fileStem($i).$ext';
        file = _createSavePath(fileName);
        i++;
      }
    }
    return file;
  }

  File _createSavePath(String fileName) {
    String finalPath = path.join(dir, fileName);
    return File(finalPath);
  }
}
