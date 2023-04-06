import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  include: {'tables.drift'},
)
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 2; // bump this when you change the schema

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (m) async {
      await m.createAll();
    }, onUpgrade: (Migrator m, int from, int to) async {
      if (from == 1) {
        await m.addColumn(specimen, specimen.taxonGroup);
      }
    });
  }

  Future<void> createProject(ProjectCompanion form) =>
      into(project).insert(form);

  Future<List<ProjectData>> getAllProjects() => select(project).get();

  Future<ProjectData> getProjectByUuid(String uuid) async {
    return await (select(project)..where((t) => t.uuid.equals(uuid)))
        .getSingle();
  }

  Future<ProjectData?> getProjectByName(String name) async {
    try {
      return await (select(project)..where((t) => t.name.equals(name)))
          .getSingle();
    } catch (e) {
      return null;
    }
  }

  Future<List<ListProjectResult>> getProjectList() => listProject().get();

  Future<void> deleteProject(String id) {
    return (delete(project)..where((t) => t.uuid.equals(id))).go();
  }

  Future<void> deleteAllProjects() {
    return (delete(project)).go();
  }

  Future<void> updateProjectEntry(String uuid, ProjectCompanion entry) {
    return (update(project)..where((t) => t.uuid.equals(uuid))).write(entry);
  }

  Future<void> exportInto(File file) async {
    await file.parent.create(recursive: true);

    if (file.existsSync()) {
      file.deleteSync();
    }

    await customStatement('VACUUM INTO ?', [file.path]);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = await dBPath;
    if (kDebugMode) {
      print('App database path: ${file.path}');
    }
    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}

Future<File> get dBPath async {
  // We save database to the default document directory locations.
  final dbDir = await getApplicationDocumentsDirectory();
  return File(p.join(dbDir.path, 'nahpu/nahpu.db'));
}

class DbAccess {
  DbAccess(this.ref);

  final WidgetRef ref;
}
