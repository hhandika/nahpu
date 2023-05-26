import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nahpu/services/db_services.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;
import 'package:nahpu/services/database/database.dart';

class DbWriter extends DbAccess {
  DbWriter(super.ref);

  Future<void> writeDb(File file) async {
    dbAccess.exportInto(file);
  }

  Future<void> replaceDb(File file, File? backupPath) async {
    if (backupPath != null) {
      await _backUpBeforeDelete(backupPath);
    }
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
  }

  Future<void> _backUpBeforeDelete(File backupPath) async {
    if (backupPath.existsSync()) {
      backupPath.deleteSync();
    }

    await dbAccess.exportInto(backupPath);
  }
}
