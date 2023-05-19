import 'dart:io';

import 'package:nahpu/services/io_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:path/path.dart' as p;

class DbWriter extends DbAccess {
  DbWriter(super.ref);

  Database get db => ref.read(databaseProvider);

  Future<void> writeDb(File file) async {
    db.exportInto(file);
  }

  Future<void> replaceDb(File file) async {
    final newDb = sqlite3.sqlite3.open(file.path);
    final appDb = await dBPath;
    await _backUpBeforeDelete();
    db.close();
    if (appDb.existsSync()) {
      appDb.deleteSync();
    }

    newDb.execute('VACUUM INTO ?', [appDb.path]);
    newDb.dispose();
  }

  Future<void> _backUpBeforeDelete() async {
    final dbDir = await getApplicationDocumentsDirectory();
    final backupDir = Directory(p.join(dbDir.path, 'nahpu/backup'));
    final backupFile =
        File(p.join(backupDir.path, 'nahpu_backup$dateTimeStamp.sqlite3'));

    await backupDir.create(recursive: true);
    if (backupFile.existsSync()) {
      backupFile.deleteSync();
    }

    await db.exportInto(backupFile);
  }
}
