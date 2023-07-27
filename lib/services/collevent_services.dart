import 'package:intl/intl.dart';
import 'package:nahpu/providers/collevents.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/site_services.dart';
import 'package:nahpu/services/types/collecting.dart';

class CollEventServices extends DbAccess {
  const CollEventServices({required super.ref});

  Future<int> createNewCollEvents() async {
    int eventID =
        await CollEventQuery(dbAccess).createCollEvent(CollEventCompanion(
      projectUuid: db.Value(currentProjectUuid),
    ));
    // Weather data used collecting event id as a foreign key
    // so we need to create a new weather data entry
    // for the new collecting event
    createWeatherData(eventID);
    invalidateCollEvent();
    return eventID;
  }

  Future<void> createWeatherData(int eventID) async {
    await WeatherDataQuery(dbAccess)
        .createWeatherData(WeatherCompanion(eventID: db.Value(eventID)));
  }

  Future<String> getCollEventID(CollEventData collEventData) async {
    final site = await SiteServices(ref: ref).getSite(collEventData.siteID);
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
    return CollEventQuery(dbAccess).getAllCollEvents(currentProjectUuid);
  }

  Future<List<CollPersonnelData>> getAllCollPersonnel(int collEventId) async {
    return CollPersonnelQuery(dbAccess).getCollPersonnelByEventId(collEventId);
  }

  Future<CollPersonnelData> getCollPersonnel(int id) async {
    return CollPersonnelQuery(dbAccess).getCollPersonnelById(id);
  }

  Future<List<CollEffortData>> getAllCollEffort(int collEventId) async {
    return CollEffortQuery(dbAccess).getCollEffortByEventId(collEventId);
  }

  Future<CollEffortData> getCollEffort(int id) async {
    return CollEffortQuery(dbAccess).getCollEffortById(id);
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

  Future<void> deleteCollEvent(int collEvenId) async {
    try {
      await WeatherDataQuery(dbAccess).deleteWeatherData(collEvenId);
      await CollPersonnelQuery(dbAccess)
          .deleteCollPersonnelByEventId(collEvenId);
      await CollEffortQuery(dbAccess).deleteCollEffortByEventId(collEvenId);
      await CollEventQuery(dbAccess).deleteCollEvent(collEvenId);
      invalidateCollEvent();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCollEffort(int id) async {
    try {
      await CollEffortQuery(dbAccess).deleteCollEffort(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAllCollEvents(String projectUuid) async {
    try {
      List<CollEventData> collEvents = await getAllCollEvents();
      for (CollEventData collEvent in collEvents) {
        await WeatherDataQuery(dbAccess).deleteWeatherData(collEvent.id);
        await CollPersonnelQuery(dbAccess)
            .deleteCollPersonnelByEventId(collEvent.id);
        await CollEffortQuery(dbAccess).deleteCollEffortByEventId(collEvent.id);
      }
      await CollEventQuery(dbAccess).deleteAllCollEvents(projectUuid);
      invalidateCollEvent();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCollPersonnel(int id) async {
    await CollPersonnelQuery(dbAccess).deleteCollPersonnel(id);
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

class EventDuplicateService extends DbAccess {
  const EventDuplicateService({required super.ref});

  CollEventServices get collEventServices => CollEventServices(ref: ref);

  /// We duplicate most of the data from the origin event
  Future<void> duplicate(int originEventID) async {
    CollEventData? collEventData =
        await collEventServices.getCollEvent(originEventID);

    if (collEventData == null) {
      return;
    }
    String newStartDate = _incrementDate(collEventData.startDate ?? '') ?? '';
    String newEndDate = _incrementDate(collEventData.endDate ?? '') ?? '';
    int destinationEventId =
        await CollEventQuery(dbAccess).createCollEvent(CollEventCompanion(
      projectUuid: db.Value(currentProjectUuid),
      siteID: db.Value(collEventData.siteID),
      startDate: db.Value(newStartDate),
      endDate: db.Value(newEndDate),
      startTime: db.Value(collEventData.startTime),
      endTime: db.Value(collEventData.endTime),
      idSuffix: db.Value(collEventData.idSuffix),
      primaryCollMethod: db.Value(collEventData.primaryCollMethod),
      collMethodNotes: db.Value(collEventData.collMethodNotes),
    ));
    await _duplicateCollEffort(originEventID, destinationEventId);
    await _duplicateCollPersonnel(originEventID, destinationEventId);
    collEventServices.createWeatherData(destinationEventId);
    collEventServices.invalidateCollEvent();
  }

  Future<void> _duplicateCollEffort(
      int originEventID, int destinationEventId) async {
    List<CollEffortData> collEfforts =
        await collEventServices.getAllCollEffort(originEventID);
    for (CollEffortData collEffort in collEfforts) {
      await collEventServices.createCollEffort(CollEffortCompanion(
        eventID: db.Value(destinationEventId),
        method: db.Value(collEffort.method),
        brand: db.Value(collEffort.brand),
        count: db.Value(collEffort.count),
        size: db.Value(collEffort.size),
        notes: db.Value(collEffort.notes),
      ));
    }
  }

  Future<void> _duplicateCollPersonnel(
      int originEventID, int destinationEventId) async {
    List<CollPersonnelData> collPersonnel =
        await collEventServices.getAllCollPersonnel(originEventID);
    for (CollPersonnelData personnel in collPersonnel) {
      await collEventServices.createCollPersonnel(CollPersonnelCompanion(
        eventID: db.Value(destinationEventId),
        personnelId: db.Value(personnel.personnelId),
        name: db.Value(personnel.name),
        role: db.Value(personnel.role),
      ));
    }
  }

  // Increment date by one day
  String? _incrementDate(String date) {
    DateFormat dateFormat = DateFormat.yMMMd();
    try {
      DateTime? parsedDate = dateFormat.parse(date);
      DateTime newDate = parsedDate.add(const Duration(days: 1));
      return dateFormat.format(newDate);
    } catch (e) {
      return null;
    }
  }
}

class CollEventSearchServices {
  final List<CollEventData> collEvents;

  CollEventSearchServices({required this.collEvents});

  List<CollEventData> search(String query) {
    List<CollEventData> filteredCollEvents = collEvents
        .where((collEvent) =>
            _isMatch(collEvent.startDate, query) ||
            _isMatch(collEvent.endDate, query))
        .toList();
    return filteredCollEvents;
  }

  bool _isMatch(String? value, String query) {
    if (value == null) return false;
    return value.toLowerCase().contains(query);
  }
}

class CollEvenPersonnelServices extends DbAccess {
  const CollEvenPersonnelServices({required super.ref});

  Future<void> getAllRoles() async {
    List<String> data = await CollPersonnelQuery(dbAccess).getDistinctRoles();
    final notifier = ref.read(collPersonnelRoleProvider.notifier);
    List<String> roles = data.isEmpty ? defaultCollPersonnelRoles : data;
    notifier.replaceAll(roles);
    _invalidateCollPersonnel();
  }

  Future<List<int>> searchPersonnel(String query) async {
    List<CollPersonnelData> data =
        await CollPersonnelQuery(dbAccess).searchCollectingPersonnel(query);
    return data.map((e) => e.id).toList();
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
  const CollMethodServices({required super.ref});

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
