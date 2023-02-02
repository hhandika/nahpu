import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/collevent_queries.dart';
import 'package:nahpu/services/database.dart';
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
    // Weather data used collect event id as a foreign key
    // so we need to create a new weather data entry
    // for the new collect event
    WeatherDataQuery(ref.read(databaseProvider))
        .createWeatherData(WeatherCompanion(eventID: db.Value(eventID)));
    invalidateCollEvent();
    return eventID;
  }

  void updateWeatherData(int eventID, WeatherCompanion weatherData) {
    WeatherDataQuery(ref.read(databaseProvider))
        .updateWeatherDataEntry(eventID, weatherData);
  }

  void invalidateCollEvent() {
    ref.invalidate(collEventEntryProvider);
    ref.invalidate(weatherDataProvider);
  }
}
