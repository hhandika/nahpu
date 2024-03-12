//! This file contains the class to write the database into a file
// and replace the current database with a new one.
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:nahpu/services/db_services.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/src/rust/api/archive.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;
import 'package:nahpu/services/database/database.dart';
import 'package:path/path.dart' as p;

class DbArchive extends AppServices {
  const DbArchive({required super.ref, required this.filePath});

  final File filePath;

  /// Write the database into a file
  /// If [isWithProjectData] is true, the project data will be included
  /// and the file will be zipped
  Future<File> writeDb(bool isWithProjectData) async {
    await dbAccess.exportInto(filePath);
    if (isWithProjectData) {
      final nahpuDir = await nahpuDocumentDir;
      String archivePath = p.setExtension(filePath.path, '.zip');
      List<String> allAppFiles = await _collectAppFiles(nahpuDir);
      allAppFiles.add(filePath.path);
      // Delete the newly created database file
      filePath.deleteSync();
      await _archiveFiles(nahpuDir, allAppFiles, filePath.path);
      return File(archivePath);
    }
    return filePath;
  }

  Future<List<String>> _collectAppFiles(Directory nahpuDir) async {
    final files = nahpuDir.listSync(recursive: true);
    // remove .db file from the list
    // it redundant to include the database file
    files.removeWhere((file) => file.path.endsWith('.db'));
    List<String> filePaths = [];
    for (var file in files) {
      if (file is File) {
        filePaths.add(file.path);
      }
    }
    return filePaths;
  }

  Future<void> _archiveFiles(
    Directory nahpuDir,
    List<String> files,
    String archivePath,
  ) async {
    final archive = ZipWriter(
      parentDir: nahpuDir.path,
      files: files,
      outputPath: archivePath,
    );
    await archive.write();
  }
}

class DbWriter extends AppServices {
  const DbWriter({required super.ref, required this.filePath});

  final File filePath;

  Future<void> replaceDb(bool backup, bool isArchived) async {
    String dbImportPath = filePath.path;
    if (isArchived) {
      dbImportPath = await _copyProjectData(filePath);
    }
    if (backup) {
      File backupPath = await backupDir;
      await _backUpBeforeDelete(backupPath);
    }
    await _writeDb(dbImportPath);
    final tempDir = await tempDirectory;
    tempDir.deleteSync(recursive: true);
  }

  Future<String> _copyProjectData(File file) async {
    final tempDir = await tempDirectory;
    await extractFileToDisk(file.path, tempDir.path);
    final files = tempDir.listSync(recursive: true);
    final dbPath = await _findSqlite3InTempDir(files);
    final nahpuDir = await nahpuDocumentDir;
    files.removeWhere((file) => file.path.endsWith('.db'));
    for (var file in files) {
      if (file is File) {
        final filename = p.relative(file.path, from: tempDir.path);
        final newPath = p.join(nahpuDir.path, filename);
        // Create directory if not exist
        final newDir = Directory(p.dirname(newPath));
        if (!newDir.existsSync()) {
          newDir.createSync(recursive: true);
        }
        if (!File(newPath).existsSync()) {
          file.copySync(newPath);
        }
      }
    }
    return dbPath;
  }

  Future<void> _writeDb(String dbImportPath) async {
    final newDb = sqlite3.sqlite3.open(dbImportPath);
    dbAccess.close();
    final appDb = await dBPath;
    if (appDb.existsSync()) {
      appDb.deleteSync();
    }
    await DbServices(ref: ref).setNewDatabase();
    newDb.execute('VACUUM INTO ?', [appDb.path]);

    if (kDebugMode) {
      print('Mark new database!');
    }

    newDb.dispose();
  }

  Future<String> _findSqlite3InTempDir(List<FileSystemEntity> files) async {
    for (var file in files) {
      if (file is File) {
        if (file.path.endsWith('.sqlite3')) {
          return file.path;
        }
      }
    }

    throw Exception('No sqlite3 file found in the archive!');
  }

  Future<void> _backUpBeforeDelete(File backupPath) async {
    if (backupPath.existsSync()) {
      backupPath.deleteSync();
    }

    await dbAccess.exportInto(backupPath);
  }
}
