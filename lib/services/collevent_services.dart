import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;

class CollEventServices extends DbAccess {
  CollEventServices(super.ref);

  Database get dbase => ref.read(databaseProvider);

  Future<int> createNewCollEvents() async {
    String projectUuid = ref.read(projectUuidProvider);

    int eventID =
        await CollEventQuery(dbase).createCollEvent(CollEventCompanion(
      projectUuid: db.Value(projectUuid),
    ));
    // Weather data used collecting event id as a foreign key
    // so we need to create a new weather data entry
    // for the new collecting event
    WeatherDataQuery(dbase)
        .createWeatherData(WeatherCompanion(eventID: db.Value(eventID)));
    invalidateCollEvent();
    return eventID;
  }

  Future<CollEventData?> getCollEvent(int? eventID) async {
    if (eventID == null) {
      return null;
    } else {
      return CollEventQuery(dbase).getCollEventById(eventID);
    }
  }

  Future<int> createCollPersonnel(CollPersonnelCompanion form) async {
    int id = await CollPersonnelQuery(dbase).createCollPersonnel(form);
    invalidateCollPersonnel();
    return id;
  }

  void updateCollPersonnel(int id, CollPersonnelCompanion form) async {
    CollPersonnelQuery(dbase).updateCollPersonnelEntry(id, form);
    invalidateCollPersonnel();
  }

  void updateCollEvent(int id, CollEventCompanion entries) {
    CollEventQuery(dbase).updateCollEventEntry(id, entries);
  }

  void updateWeatherData(int eventID, WeatherCompanion weatherData) {
    WeatherDataQuery(dbase).updateWeatherDataEntry(eventID, weatherData);
  }

  void deleteCollEvent(int collEvenId) {
    CollEventQuery(dbase).deleteCollEvent(collEvenId);
    WeatherDataQuery(dbase).deleteWeatherData(collEvenId);
    invalidateCollEvent();
  }

  void deleteCollPersonnel(int id) {
    CollPersonnelQuery(dbase).deleteCollPersonnel(id);
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
