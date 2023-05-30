import 'package:nahpu/providers/collevents.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/site_services.dart';
import 'package:nahpu/services/types/collecting.dart';

class CollEventServices extends DbAccess {
  CollEventServices(super.ref);

  Future<int> createNewCollEvents() async {
    int eventID =
        await CollEventQuery(dbAccess).createCollEvent(CollEventCompanion(
      projectUuid: db.Value(projectUuid),
    ));
    // Weather data used collecting event id as a foreign key
    // so we need to create a new weather data entry
    // for the new collecting event
    WeatherDataQuery(dbAccess)
        .createWeatherData(WeatherCompanion(eventID: db.Value(eventID)));
    invalidateCollEvent();
    return eventID;
  }

  Future<String> getCollEventID(CollEventData collEventData) async {
    final site = await SiteServices(ref).getSite(collEventData.siteID);
    String siteID = site != null ? site.siteID ?? '' : '';
    String startDate = collEventData.startDate != null
        ? collEventData.startDate.toString()
        : '';
    String suffix =
        collEventData.idSuffix != null && collEventData.idSuffix!.isNotEmpty
            ? '-${collEventData.idSuffix ?? ''}'
            : '';
    return '$siteID-$startDate$suffix';
  }

  Future<List<CollEventData>> getAllCollEvents() async {
    return CollEventQuery(dbAccess).getAllCollEvents(projectUuid);
  }

  Future<List<CollPersonnelData>> getAllCollPersonnel(int collEventId) async {
    return CollPersonnelQuery(dbAccess).getCollPersonnelByEventId(collEventId);
  }

  Future<List<CollEffortData>> getAllCollEffort(int collEventId) async {
    return CollEffortQuery(dbAccess).getCollEffortByEventId(collEventId);
  }

  Future<WeatherData> getAllWeatherData(int collEventId) async {
    return WeatherDataQuery(dbAccess).getWeatherDataByEventId(collEventId);
  }

  Future<CollEventData?> getCollEvent(int? eventID) async {
    if (eventID == null) {
      return null;
    } else {
      return CollEventQuery(dbAccess).getCollEventById(eventID);
    }
  }

  Future<int> createCollPersonnel(CollPersonnelCompanion form) async {
    int id = await CollPersonnelQuery(dbAccess).createCollPersonnel(form);
    invalidateCollPersonnel();
    return id;
  }

  Future<int> createCollEffort(CollEffortCompanion form) async {
    return await CollEffortQuery(dbAccess).createCollEffort(form);
  }

  void updateCollPersonnel(int id, CollPersonnelCompanion form) async {
    CollPersonnelQuery(dbAccess).updateCollPersonnelEntry(id, form);
    invalidateCollPersonnel();
  }

  void updateCollEvent(int id, CollEventCompanion entries) {
    CollEventQuery(dbAccess).updateCollEventEntry(id, entries);
  }

  void updateWeatherData(int eventID, WeatherCompanion weatherData) {
    WeatherDataQuery(dbAccess).updateWeatherDataEntry(eventID, weatherData);
  }

  Future<void> updateCollEffortEntry(int id, CollEffortCompanion entry) async {
    return await CollEffortQuery(dbAccess).updateCollEffortEntry(id, entry);
  }

  void deleteCollEvent(int collEvenId) {
    CollEventQuery(dbAccess).deleteCollEvent(collEvenId);
    WeatherDataQuery(dbAccess).deleteWeatherData(collEvenId);
    invalidateCollEvent();
  }

  Future<void> deleteCollEffort(int id) async {
    return await CollEffortQuery(dbAccess).deleteCollEffort(id);
  }

  Future<void> deleteAllCollEvents(String projectUuid) {
    return CollEventQuery(dbAccess).deleteAllCollEvents(projectUuid);
  }

  void deleteCollPersonnel(int id) {
    CollPersonnelQuery(dbAccess).deleteCollPersonnel(id);
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

class CollEvenPersonnelServices extends DbAccess {
  CollEvenPersonnelServices(super.ref);

  Future<void> getAllRoles() async {
    List<String> data = await CollPersonnelQuery(dbAccess).getDistinctRoles();
    final notifier = ref.read(collPersonnelRoleProvider.notifier);
    List<String> roles = data.isEmpty ? defaultCollPersonnelRoles : data;
    notifier.replaceAll(roles);
    _invalidateCollPersonnel();
  }

  Future<void> addRole(String role) async {
    await ref.read(collPersonnelRoleProvider.notifier).add(role);
    _invalidateCollPersonnel();
  }

  Future<void> removeRole(String role) async {
    await ref.read(collPersonnelRoleProvider.notifier).remove(role);
    _invalidateCollPersonnel();
  }

  Future<void> removeAllRoles() async {
    await ref.read(collPersonnelRoleProvider.notifier).clear();
    _invalidateCollPersonnel();
  }

  void _invalidateCollPersonnel() {
    ref.invalidate(collPersonnelProvider);
  }
}

class CollMethodServices extends DbAccess {
  CollMethodServices(super.ref);

  Future<void> getAllMethods() async {
    List<String> data = await CollEffortQuery(dbAccess).getDistinctMethods();
    final notifier = ref.read(collEventMethodProvider.notifier);
    List<String> methods = data.isEmpty ? defaultCollMethods : data;
    notifier.replaceAll(methods);
    _invalidateCollEffort();
  }

  Future<void> addMethod(String method) async {
    await ref.read(collEventMethodProvider.notifier).add(method);
    _invalidateCollEffort();
  }

  Future<void> removeMethod(String method) async {
    await ref.read(collEventMethodProvider.notifier).remove(method);
    _invalidateCollEffort();
  }

  Future<void> removeAllMethods() async {
    await ref.read(collEventMethodProvider.notifier).clear();
    _invalidateCollEffort();
  }

  void _invalidateCollEffort() {
    ref.invalidate(collEventMethodProvider);
  }
}
