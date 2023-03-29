import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;

class CollEventServices {
  CollEventServices(this.ref);

  final WidgetRef ref;

  Future<int> createNewCollEvents() async {
    String projectUuid = ref.read(projectUuidProvider);

    int eventID = await CollEventQuery(ref.read(databaseProvider))
        .createCollEvent(CollEventCompanion(
      projectUuid: db.Value(projectUuid),
    ));
    // Weather data used collecting event id as a foreign key
    // so we need to create a new weather data entry
    // for the new collecting event
    WeatherDataQuery(ref.read(databaseProvider))
        .createWeatherData(WeatherCompanion(eventID: db.Value(eventID)));
    invalidateCollEvent();
    return eventID;
  }

  Future<CollEventData?> getCollEvent(int? eventID) async {
    if (eventID == null) {
      return null;
    } else {
      return CollEventQuery(ref.read(databaseProvider))
          .getCollEventById(eventID);
    }
  }

  Future<int> createCollPersonnel(CollPersonnelCompanion form) async {
    int id = await CollPersonnelQuery(ref.read(databaseProvider))
        .createCollPersonnel(form);
    invalidateCollPersonnel();
    return id;
  }

  void updateCollPersonnel(int id, CollPersonnelCompanion form) async {
    CollPersonnelQuery(ref.read(databaseProvider))
        .updateCollPersonnelEntry(id, form);
    invalidateCollPersonnel();
  }

  void updateCollEvent(int id, CollEventCompanion entries) {
    CollEventQuery(ref.read(databaseProvider))
        .updateCollEventEntry(id, entries);
  }

  void updateWeatherData(int eventID, WeatherCompanion weatherData) {
    WeatherDataQuery(ref.read(databaseProvider))
        .updateWeatherDataEntry(eventID, weatherData);
  }

  void deleteCollPersonnel(int id) {
    CollPersonnelQuery(ref.read(databaseProvider)).deleteCollPersonnel(id);
    invalidateCollPersonnel();
  }

  void invalidateCollEvent() {
    ref.invalidate(collEventEntryProvider);
    ref.invalidate(weatherDataProvider);
    ref.invalidate(collPersonnelProvider);
  }

  void invalidateCollPersonnel() {
    ref.invalidate(collPersonnelProvider);
  }
}
