import 'dart:io';

import 'package:sqlite3/sqlite3.dart' as sqlite3;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';

class DbWriter {
  DbWriter(this.ref);

  final WidgetRef ref;

  Database get db => ref.read(databaseProvider);

  Future<void> writeDb(String filePath) async {
    File file = File(filePath);
    db.exportInto(file);
  }

  Future<void> replaceDb(File file) async {
    final newDb = sqlite3.sqlite3.open(file.path);
    final appDb = await dBPath;

    db.close();
    if (appDb.existsSync()) {
      appDb.deleteSync();
    }

    newDb.execute('VACUUM INTO ?', [appDb.path]);
    newDb.dispose();
  }
}
