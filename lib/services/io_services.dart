import 'dart:io';
import 'package:nahpu/services/database/database.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';

String get dateTimeStamp {
  DateTime now = DateTime.now();
  String date = '${now.year}-${now.month}-${now.day}';
  String time = '${now.hour}-${now.minute}-${now.second}';
  return '$date-$time';
}

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

/// This class is used to access the database
/// from the service classes.
class DbAccess {
  DbAccess(this.ref);

  final WidgetRef ref;

  Database get dbAccess => ref.read(databaseProvider);
  String get projectUuid => ref.read(projectUuidProvider);
}
