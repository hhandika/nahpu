import 'dart:io';
import 'package:nahpu/providers/database.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

String get dateTimeStamp {
  DateTime now = DateTime.now();
  String date = '${now.year}-${now.month}-${now.day}';
  String time = '${now.hour}-${now.minute}-${now.second}';
  return '$date-$time';
}

class FilePickerServices {
  FilePickerServices();

  Future<Directory?> selectDir() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      if (kDebugMode) {
        print('Selected directory: $result');
      }
      return Directory(result);
    }
    return null;
  }

  Future<File?> selectFile(List<String> allowedExtension) async {
    final result = await _matchPicker(allowedExtension);

    if (result != null) {
      if (kDebugMode) {
        print('Selected file: ${result.files.single.path}');
      }
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<FilePickerResult?> _matchPicker(List<String> allowedExt) async {
    if (Platform.isIOS || Platform.isAndroid) {
      return await FilePicker.platform.pickFiles();
    } else {
      return await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db', 'sqlite', 'sqlite3'],
      );
    }
  }
}

class AppIOServices {
  AppIOServices({
    required this.dir,
    required this.fileStem,
    required this.ext,
  });

  final Directory? dir;
  final String fileStem;
  final String ext;

  Future<File> getSavePath() async {
    String fileName = '$fileStem.$ext';
    // Check if file exists
    File file = await _createSavePath(fileName);
    if (file.existsSync()) {
      int i = 1;
      while (file.existsSync()) {
        fileName = '$fileStem($i).$ext';
        file = await _createSavePath(fileName);
        i++;
      }
    }
    return file;
  }

  Future<File> _createSavePath(String fileName) async {
    Directory finalDir = await _getSaveDir();

    if (finalDir.existsSync()) {
      finalDir.createSync(recursive: true);
    }

    String finalPath = path.join(finalDir.path, fileName);
    return File(finalPath);
  }

  Future<Directory> _getSaveDir() async {
    if (dir == null) {
      return await getApplicationDocumentsDirectory();
    }
    return dir!;
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

Future<File> getDbBackUpPath() async {
  final documentDir = await nahpuDocumentDir;
  final backupDir = Directory(path.join(documentDir.path, 'nahpu/backup'));
  await backupDir.create(recursive: true);
  final backupFile =
      File(path.join(backupDir.path, 'nahpu_backup$dateTimeStamp.sqlite3'));
  return backupFile;
}

String get nahpuBackupDir => 'nahpu/backup';

Future<Directory> get nahpuDocumentDir async {
  final dbDir = await getApplicationDocumentsDirectory();
  final nahpuDir = Directory(path.join(dbDir.path, 'nahpu'));
  await nahpuDir.create(recursive: true);
  return nahpuDir;
}
