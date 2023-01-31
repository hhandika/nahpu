import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
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

  Future<int> createNarrative(NarrativeCompanion form) =>
      into(narrative).insert(form);

  Future updateNarrativeEntry(int id, NarrativeCompanion entry) {
    return (update(narrative)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<List<NarrativeData>> getAllNarrative(String projectUuid) {
    return (select(narrative)..where((t) => t.projectUuid.equals(projectUuid)))
        .get();
  }

  Future<void> deleteNarrative(int id) {
    return (delete(narrative)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllNarrative(String projectUuid) {
    return (delete(narrative)..where((t) => t.projectUuid.equals(projectUuid)))
        .go();
  }

  // Site table
  Future<int> createSite(SiteCompanion form) => into(site).insert(form);

  Future updateSiteEntry(int id, SiteCompanion entry) {
    return (update(site)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<List<SiteData>> getAllSites(String projectUuid) {
    return (select(site)..where((t) => t.projectUuid.equals(projectUuid)))
        .get();
  }

  Future<void> deleteSite(String siteId) {
    return (delete(site)..where((t) => t.siteID.equals(siteId))).go();
  }

  Future<SiteData> getSiteById(int id) async {
    return await (select(site)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> deleteAllSites(String projectUuid) {
    return (delete(site)..where((t) => t.projectUuid.equals(projectUuid))).go();
  }

  // Personnel table
  Future<int> createPersonnel(PersonnelCompanion form) =>
      into(personnel).insert(form);

  Future updatePersonnelEntry(String id, PersonnelCompanion entry) {
    return (update(personnel)..where((t) => t.uuid.equals(id))).write(entry);
  }

  Future<void> deletePersonnel(String uuid) {
    return (delete(personnel)..where((t) => t.uuid.equals(uuid))).go();
  }

  Future<List<PersonnelData>> getAllPersonnel() {
    return select(personnel).get();
  }

  Future<void> deleteAllPersonnel() {
    return delete(personnel).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // We save database to the default document directory locations.
    final dbDir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbDir.path, 'nahpu/nahpu.db'));
    if (kDebugMode) {
      print('App database path: ${file.path}');
    }
    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}
