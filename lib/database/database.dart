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
  int get schemaVersion => 1; // bump this when you change the schema

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (m) async {
      await m.createAll(); // create all tables
    });
  }

  Future<void> createProject(ProjectCompanion form) =>
      into(project).insert(form);

  Future<List<ProjectData>> getAllProjects() => select(project).get();

  Future<ProjectData> getProjectByUuid(String uuid) async {
    return await (select(project)..where((t) => t.projectUuid.equals(uuid)))
        .getSingle();
  }

  Future<ProjectData?> getProjectByName(String? name) async {
    return await (select(project)..where((t) => t.projectName.equals(name)))
        .getSingle();
  }

  Future<List<ListProjectResult>> getProjectList() => listProject().get();

  Future<void> deleteProject(String id) {
    return (delete(project)..where((t) => t.projectUuid.equals(id))).go();
  }

  Future updateEntry(ProjectData entry) => update(project).replace(entry);

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

  Future<void> deleteAllSites(String projectUuid) {
    return (delete(site)..where((t) => t.projectUuid.equals(projectUuid))).go();
  }

  // Collecting event table
  Future<int> createCollEvent(CollEventCompanion form) =>
      into(collEvent).insert(form);

  Future updateCollEventEntry(int id, CollEventCompanion entry) {
    return (update(collEvent)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<List<CollEventData>> getAllCollEvents(String projectUuid) {
    return (select(collEvent)..where((t) => t.projectUuid.equals(projectUuid)))
        .get();
  }

  Future<void> deleteCollEvent(int id) {
    return (delete(collEvent)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllCollEvents(String projectUuid) {
    return (delete(collEvent)..where((t) => t.projectUuid.equals(projectUuid)))
        .go();
  }

  // Specimen General table
  Future<int> createSpecimen(SpecimenCompanion form) =>
      into(specimen).insert(form);

  Future updateSpecimenEntry(String uuid, SpecimenCompanion entry) {
    return (update(specimen)..where((t) => t.specimenUuid.equals(uuid)))
        .write(entry);
  }

  Future<List<SpecimenData>> getAllSpecimens(String projectUuid) {
    return (select(specimen)..where((t) => t.projectUuid.equals(projectUuid)))
        .get();
  }

  Future<void> deleteSpecimen(String uuid) {
    return (delete(specimen)..where((t) => t.specimenUuid.equals(uuid))).go();
  }

  Future<void> deleteAllSpecimens(String projectUuid) {
    return (delete(specimen)..where((t) => t.projectUuid.equals(projectUuid)))
        .go();
  }

  // Personnel table
  Future<int> createPersonnel(PersonnelCompanion form) =>
      into(personnel).insert(form);

  Future updatePersonnelEntry(String id, PersonnelCompanion entry) {
    return (update(personnel)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<List<PersonnelData>> getAllPersonnel() {
    return select(personnel).get();
  }
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
