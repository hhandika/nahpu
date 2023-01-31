import 'package:drift/drift.dart';
import 'package:nahpu/services/database.dart';

part 'collevent_queries.g.dart';

@DriftAccessor(
  include: {'tables.drift'},
)
class CollEventQuery extends DatabaseAccessor<Database>
    with _$CollEventQueryMixin {
  CollEventQuery(Database db) : super(db);

  Future<int> createCollEvent(CollEventCompanion form) =>
      into(collEvent).insert(form);

  Future updateCollEventEntry(int id, CollEventCompanion entry) {
    return (update(collEvent)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<List<CollEventData>> getAllCollEvents(String projectUuid) {
    return (select(collEvent)..where((t) => t.projectUuid.equals(projectUuid)))
        .get();
  }

  Future<CollEventData> getCollEventById(int id) async {
    return await (select(collEvent)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> deleteCollEvent(int id) {
    return (delete(collEvent)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllCollEvents(String projectUuid) {
    return (delete(collEvent)..where((t) => t.projectUuid.equals(projectUuid)))
        .go();
  }
}
