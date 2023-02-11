import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/narrative_queries.dart';
import 'package:drift/drift.dart' as db;

class NarrativeServices {
  NarrativeServices(this.ref);

  final WidgetRef ref;

  Future<int> createNewNarrative(String projectUuid) async {
    int narrativeID = await NarrativeQuery(ref.read(databaseProvider))
        .createNarrative(NarrativeCompanion(
      projectUuid: db.Value(projectUuid),
    ));
    invalidateNarrative();
    return narrativeID;
  }

  void updateNarrative(int id, NarrativeCompanion entries) {
    NarrativeQuery(ref.read(databaseProvider))
        .updateNarrativeEntry(id, entries);
  }

  void deleteNarrative(int id) {
    NarrativeQuery(ref.read(databaseProvider)).deleteNarrative(id);
    invalidateNarrative();
  }

  void deleteAllNarrative(String projectUuid) {
    NarrativeQuery(ref.read(databaseProvider)).deleteAllNarrative(projectUuid);
    invalidateNarrative();
  }

  void invalidateNarrative() {
    ref.invalidate(narrativeEntryProvider);
  }
}
