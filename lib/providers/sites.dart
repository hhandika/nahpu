import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/site_queries.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/coordinate_queries.dart';

final siteEntryProvider = FutureProvider.autoDispose<List<SiteData>>((ref) {
  final projectUuid = ref.read(projectUuidProvider.notifier).state;
  final siteEntries =
      SiteQuery(ref.read(databaseProvider)).getAllSites(projectUuid);
  return siteEntries;
});

final coordinateBySiteProvider = FutureProvider.family
    .autoDispose<List<CoordinateData>, int>((ref, siteId) =>
        CoordinateQuery(ref.read(databaseProvider))
            .getCoordinatesBySiteID(siteId));

final coordinateByEventProvider = FutureProvider.family
    .autoDispose<List<CoordinateData>, int>((ref, collEventId) async {
  final collEvent = await CollEventQuery(ref.read(databaseProvider))
      .getCollEventById(collEventId);
  if (collEvent.siteID != null) {
    final siteId = collEvent.siteID!;
    final coordinates = CoordinateQuery(ref.read(databaseProvider))
        .getCoordinatesBySiteID(siteId);
    return coordinates;
  } else {
    return [];
  }
});
