import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/projects.dart';

final collEventEntryProvider =
    FutureProvider.autoDispose<List<CollEventData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final collEvents =
      CollEventQuery(ref.read(databaseProvider)).getAllCollEvents(projectUuid);
  return collEvents;
});

final collEventIDprovider =
    FutureProvider.family.autoDispose<CollEventData, int>((ref, id) async {
  final collEventID =
      CollEventQuery(ref.read(databaseProvider)).getCollEventById(id);
  return collEventID;
});

final collEffortByEventProvider = FutureProvider.family
    .autoDispose<List<CollEffortData>, int>((ref, collEventId) =>
        CollEffortQuery(ref.read(databaseProvider))
            .getCollEffortByEventId(collEventId));

final collPersonnelProvider = FutureProvider.family
    .autoDispose<List<CollPersonnelData>, int>((ref, collEventId) =>
        CollPersonnelQuery(ref.read(databaseProvider))
            .getCollPersonnelByEventId(collEventId));

final weatherDataProvider = FutureProvider.family.autoDispose<WeatherData, int>(
    (ref, collEventId) => WeatherDataQuery(ref.read(databaseProvider))
        .getWeatherDataByEventId(collEventId));
