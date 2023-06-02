import 'package:drift/drift.dart';
import 'package:nahpu/services/database/database.dart';

part 'narrative_queries.g.dart';

@DriftAccessor(
  include: {'tables.drift'},
)
class NarrativeQuery extends DatabaseAccessor<Database>
    with _$NarrativeQueryMixin {
  NarrativeQuery(Database db) : super(db);

  Future<int> createNarrative(NarrativeCompanion form) =>
      into(narrative).insert(form);

  Future updateNarrativeEntry(int id, NarrativeCompanion entry) {
    return (update(narrative)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<List<NarrativeData>> searchNarrative(String query) async {
    return await (select(narrative)
          ..where(
              (t) => t.narrative.like('%$query%') | t.date.like('%$query%')))
        .get();
  }

  Future<List<NarrativeData>> getAllNarrative(String projectUuid) {
    return (select(narrative)..where((t) => t.projectUuid.equals(projectUuid)))
        .get();
  }

  Future<void> createNarrativeMedia(NarrativeMediaCompanion form) {
    return into(narrativeMedia).insert(form);
  }

  Future<List<NarrativeMediaData>> getNarrativeMedia(int narrativeId) {
    return (select(narrativeMedia)
          ..where((t) => t.narrativeId.equals(narrativeId)))
        .get();
  }

  Future<void> updateNarrativeMedia(
      int narrativeId, NarrativeMediaCompanion form) {
    return (update(narrativeMedia)
          ..where((t) => t.narrativeId.equals(narrativeId)))
        .write(form);
  }

  Future<void> deleteNarrativeMedia(int mediaId) {
    return (delete(narrativeMedia)..where((t) => t.mediaId.equals(mediaId)))
        .go();
  }

  Future<void> deleteAllNarrativeMedia(int narrativeId) {
    return (delete(narrativeMedia)
          ..where((t) => t.narrativeId.equals(narrativeId)))
        .go();
  }

  Future<void> deleteNarrative(int id) {
    return (delete(narrative)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllNarrative(String projectUuid) {
    return (delete(narrative)..where((t) => t.projectUuid.equals(projectUuid)))
        .go();
  }
}
