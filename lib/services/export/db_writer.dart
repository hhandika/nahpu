import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nahpu/services/db_services.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;
import 'package:nahpu/services/database/database.dart';
import 'package:path/path.dart' as p;

class DbWriter extends DbAccess {
  DbWriter(super.ref);

  Future<File> getDbBackUpPath() async {
    final dbDir = await getApplicationDocumentsDirectory();
    final backupDir = Directory(p.join(dbDir.path, 'nahpu/backup'));
    await backupDir.create(recursive: true);
    final backupFile =
        File(p.join(backupDir.path, 'nahpu_backup$dateTimeStamp.sqlite3'));
    return backupFile;
  }

  Future<void> writeDb(File file) async {
    dbAccess.exportInto(file);
  }

  Future<File> replaceDb(File file) async {
    final backupPath = await _backUpBeforeDelete();
    if (kDebugMode) {
      print('Original database has closed!');
    }
    final newDb = sqlite3.sqlite3.open(file.path);
    dbAccess.close();
    final appDb = await dBPath;
    if (appDb.existsSync()) {
      appDb.deleteSync();
    }
    await DbServices(ref).setNewDatabase();
    newDb.execute('VACUUM INTO ?', [appDb.path]);
    if (kDebugMode) {
      print('Mark new database!');
    }

    newDb.dispose();
    return backupPath;
  }

  Future<File> _backUpBeforeDelete() async {
    final backupFile = await getDbBackUpPath();
    if (backupFile.existsSync()) {
      backupFile.deleteSync();
    }

    await dbAccess.exportInto(backupFile);
    return backupFile;
  }
}
