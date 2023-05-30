import 'package:nahpu/providers/narrative.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/narrative_queries.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/io_services.dart';

class NarrativeServices extends DbAccess {
  NarrativeServices(super.ref);

  Future<int> createNewNarrative() async {
    int narrativeID =
        await NarrativeQuery(dbAccess).createNarrative(NarrativeCompanion(
      projectUuid: db.Value(projectUuid),
    ));
    invalidateNarrative();
    return narrativeID;
  }

  Future<List<NarrativeData>> getAllNarrative() async {
    return NarrativeQuery(dbAccess).getAllNarrative(projectUuid);
  }

  void updateNarrative(int id, NarrativeCompanion entries) {
    NarrativeQuery(dbAccess).updateNarrativeEntry(id, entries);
  }

  Future<void> createNarrativeMedia(NarrativeMediaCompanion entries) async {
    await NarrativeQuery(dbAccess).createNarrativeMedia(entries);
  }

  void deleteNarrative(int id) {
    NarrativeQuery(dbAccess).deleteNarrative(id);
    invalidateNarrative();
  }

  void deleteAllNarrative(String projectUuid) {
    NarrativeQuery(dbAccess).deleteAllNarrative(projectUuid);
    invalidateNarrative();
  }

  void invalidateNarrative() {
    ref.invalidate(narrativeEntryProvider);
  }
}
