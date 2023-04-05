import 'dart:io';

import 'package:sqlite3/sqlite3.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';

class DbWriter {
  DbWriter(this.ref);

  final WidgetRef ref;

  Future<void> writeDb(String filePath) async {
    final db = ref.read(databaseProvider);

    File file = File(filePath);
    db.exportInto(file);
  }

  Future<void> replaceDb(File file) async {
    final db = ref.read(databaseProvider);
    final newDb = sqlite3.open(file.path);

    final appDb = await dBPath;

    db.close();

    if (appDb.existsSync()) {
      appDb.deleteSync();
    }

    newDb.execute('VACUUM INTO ?', [appDb.path]);
    newDb.dispose();
  }
}
