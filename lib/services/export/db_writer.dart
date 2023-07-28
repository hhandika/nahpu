import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:nahpu/services/db_services.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;
import 'package:nahpu/services/database/database.dart';
import 'package:path/path.dart' as p;

class DbWriter extends DbAccess {
  const DbWriter({required super.ref});

  Future<File> writeDb(File savePath, bool isWithProjectData) async {
    dbAccess.exportInto(savePath);
    if (isWithProjectData) {
      String archivePath = p.setExtension(savePath.path, '.zip');
      await _archiveProjectData(savePath, archivePath);
      return File(archivePath);
    }
    return savePath;
  }

  Future<void> _archiveProjectData(File dbPath, archivePath) async {
    // List all files in nahpu document
    final nahpuDir = await nahpuDocumentDir;
    final files = nahpuDir.listSync(recursive: true);
    // remove .db file from the list
    files.removeWhere((file) => file.path.endsWith('.db'));
    // Zip all files
    final encoder = ZipFileEncoder();
    encoder.create(archivePath);
    for (var file in files) {
      if (file is File) {
        String filename = p.relative(file.path, from: nahpuDir.path);
        encoder.addFile(file, filename);
      }
    }
    encoder.addFile(dbPath);
    encoder.close();
    dbPath.deleteSync();
  }

  Future<void> replaceDb(File file, File? backupPath, bool isArchived) async {
    String dbImportPath = file.path;
    if (isArchived) {
      await _copyProjectData(file);
      dbImportPath = await _findSqlite3InTempDir();
    }
    if (backupPath != null) {
      await _backUpBeforeDelete(backupPath);
    }
    if (kDebugMode) {
      print('Original database has been closed!');
    }
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

  Future<void> _copyProjectData(File file) async {
    final tempDir = await tempDirectory;
    await extractFileToDisk(file.path, tempDir.path);
    final files = tempDir.listSync(recursive: true);
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
    tempDir.deleteSync(recursive: true);
  }

  Future<String> _findSqlite3InTempDir() async {
    final tempDir = await tempDirectory;
    final files = tempDir.listSync(recursive: true);
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
