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
}
