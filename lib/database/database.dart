import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  include: {'tables.drift'},
)
class Database extends _$Database {
  final String dbName;
  Database({required this.dbName}) : super(_openConnection(dbName));

  @override
  int get schemaVersion => 1;

  Future<int> createProject(ProjectCompanion name) async {
    return await into(project).insert(name);
  }
}

LazyDatabase _openConnection(String dbName) {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbDir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbDir.path, '$dbName.db'));
    return NativeDatabase(file);
  });
}
