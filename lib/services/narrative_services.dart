import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/narrative_queries.dart';
import 'package:drift/drift.dart' as db;

class NarrativeServices extends DbAccess {
  NarrativeServices(super.ref);

  Database get dbase => ref.read(databaseProvider);
  String get projectUuid => ref.read(projectUuidProvider);

  Future<int> createNewNarrative() async {
    int narrativeID =
        await NarrativeQuery(dbase).createNarrative(NarrativeCompanion(
      projectUuid: db.Value(projectUuid),
    ));
    invalidateNarrative();
    return narrativeID;
  }

  Future<List<NarrativeData>> getAllNarrative() async {
    return NarrativeQuery(dbase).getAllNarrative(projectUuid);
  }

  void updateNarrative(int id, NarrativeCompanion entries) {
    NarrativeQuery(dbase).updateNarrativeEntry(id, entries);
  }

  void deleteNarrative(int id) {
    NarrativeQuery(dbase).deleteNarrative(id);
    invalidateNarrative();
  }

  void deleteAllNarrative(String projectUuid) {
    NarrativeQuery(dbase).deleteAllNarrative(projectUuid);
    invalidateNarrative();
  }

  void invalidateNarrative() {
    ref.invalidate(narrativeEntryProvider);
  }
}
