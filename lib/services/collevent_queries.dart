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

// We use the class mixin from CollEventQuery to create a new class
class CollEffortQuery extends DatabaseAccessor<Database>
    with _$CollEventQueryMixin {
  CollEffortQuery(Database db) : super(db);

  Future<int> createCollEffort(CollEffortCompanion form) =>
      into(collEffort).insert(form);

  Future updateCollEffortEntry(int id, CollEffortCompanion entry) {
    return (update(collEffort)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<List<CollEffortData>> getCollEffortByEventId(int collEventId) async {
    return await (select(collEffort)
          ..where((t) => t.eventID.equals(collEventId)))
        .get();
  }

  Future<void> deleteCollEffort(int id) {
    return (delete(collEffort)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllCollEfforts(String projectUuid) {
    return delete(collEffort).go();
  }
}

class CollPersonnelQuery extends DatabaseAccessor<Database>
    with _$CollEventQueryMixin {
  CollPersonnelQuery(Database db) : super(db);

  Future<int> createCollPersonnel(CollPersonnelCompanion form) =>
      into(collPersonnel).insert(form);

  Future updateCollPersonnelEntry(int id, CollPersonnelCompanion entry) {
    return (update(collPersonnel)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<List<CollPersonnelData>> getCollPersonnelByEventId(
      int collEventId) async {
    return await (select(collPersonnel)
          ..where((t) => t.eventID.equals(collEventId)))
        .get();
  }

  Future<void> deleteCollPersonnel(int id) {
    return (delete(collPersonnel)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllCollPersonnel(String projectUuid) {
    return delete(collPersonnel).go();
  }
}

class WeatherDataQuery extends DatabaseAccessor<Database>
    with _$CollEventQueryMixin {
  WeatherDataQuery(Database db) : super(db);

  Future<int> createWeatherData(WeatherCompanion form) =>
      into(weather).insert(form);

  Future updateWeatherDataEntry(int id, WeatherCompanion entry) {
    return (update(weather)..where((t) => t.eventID.equals(id))).write(entry);
  }

  Future<WeatherData> getWeatherDataByEventId(int weatherId) async {
    return await (select(weather)..where((t) => t.eventID.equals(weatherId)))
        .getSingle();
  }

  Future<void> deleteWeatherData(int id) {
    return (delete(weather)..where((t) => t.eventID.equals(id))).go();
  }

  Future<void> deleteAllWeatherData(String projectUuid) {
    return delete(weather).go();
  }
}
