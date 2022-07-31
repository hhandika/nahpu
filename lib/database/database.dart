import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  include: {'tables.drift'},
)
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 2; // bump this when you change the schema

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (m) async {
      await m.createAll(); // create all tables
    });
  }

  Future<int> createProject(ProjectCompanion name) =>
      into(project).insert(name);

  Future<List<ProjectData>> getAllProjects() => select(project).get();

  Future<List<ListProjectResult>> getProjectList() => listProject().get();

  Future<void> deleteProject(String id) {
    return (delete(project)..where((t) => t.projectUuid.equals(id))).go();
  }

  Future updateEntry(ProjectData entry) => update(project).replace(entry);
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbDir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbDir.path, 'nahpu/nahpu.db'));
    if (kDebugMode) {
      print('App database path: ${file.path}');
    }
    return NativeDatabase(file, logStatements: true);
  });
}
