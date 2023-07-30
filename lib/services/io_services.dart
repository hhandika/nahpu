import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/providers/database.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

String get dateTimeStamp {
  DateTime now = DateTime.now();
  String date = '${now.year}-${now.month}-${now.day}';
  String time = '${now.hour}-${now.minute}-${now.second}';
  return '$date-$time';
}

class FilePickerServices {
  FilePickerServices();

  Future<void> shareFile(BuildContext context, File file) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.shareXFiles(
      [XFile(file.path)],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  Future<Directory?> selectDir() async {
    final result = await getDirectoryPath();
    if (result != null) {
      if (kDebugMode) {
        print('Selected directory: $result');
      }
      return Directory(result);
    }
    return null;
  }

  Future<XFile?> selectAnyFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return XFile(result.files.single.path!);
    }
    return null;
  }

  Future<XFile?> selectFile(List<XTypeGroup> allowedExtension) async {
    return await openFile(acceptedTypeGroups: allowedExtension);
  }

  Future<List<XFile>> pickMultiFiles(List<XTypeGroup> allowedExtension) async {
    return await openFiles(acceptedTypeGroups: allowedExtension);
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
  const DbAccess({required this.ref});

  final WidgetRef ref;

  Database get dbAccess => ref.read(databaseProvider);
  String get currentProjectUuid => ref.read(projectUuidProvider);
}

class FileServices extends DbAccess {
  FileServices({required super.ref});

  Future<Directory> get currentProjectDir async {
    final documentDir = await nahpuDocumentDir;
    final projectDir =
        Directory(path.join(documentDir.path, currentProjectUuid));
    return projectDir;
  }

  Future<String> get appDataUsage async {
    try {
      final nahpuDir = await nahpuDocumentDir;
      final dirSize = nahpuDir.listSync(recursive: true);
      int size = 0;
      for (final file in dirSize) {
        if (file is File) {
          size += file.lengthSync();
        }
      }
      return '${(size / 1024 / 1024).toStringAsFixed(2)} MB';
    } catch (e) {
      rethrow;
    }
  }

  Future<File> copyFileToProjectDir(File from, Directory to) async {
    final projectDir = await currentProjectDir;
    final fileName = path.basename(from.path);
    final targetDir = path.join(projectDir.path, to.path);
    await Directory(targetDir).create(recursive: true);
    final toPath = path.join(targetDir, fileName);
    await from.copy(toPath);
    return File(toPath);
  }
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

Future<Directory> get tempDirectory async {
  final dbDir = await getApplicationDocumentsDirectory();
  final tempDir = Directory(path.join(dbDir.path, 'temp'));
  await tempDir.create(recursive: true);
  return tempDir;
}
