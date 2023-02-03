import 'package:nahpu/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/narrative_queries.dart';
import 'package:nahpu/services/site_queries.dart';
import 'package:nahpu/services/specimen_queries.dart';
import 'package:nahpu/services/coordinate_queries.dart';
import 'package:nahpu/services/collevent_queries.dart';
import 'package:nahpu/services/taxonomy_queries.dart';
import 'package:nahpu/services/personnel_queries.dart';

void createPersonnel(WidgetRef ref, PersonnelCompanion form) {
  PersonnelQuery(ref.read(databaseProvider)).createPersonnel(form);
}

final narrativeEntryProvider =
    FutureProvider.autoDispose<List<NarrativeData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final narrativeEntries =
      NarrativeQuery(ref.read(databaseProvider)).getAllNarrative(projectUuid);
  return narrativeEntries;
});

final siteEntryProvider = FutureProvider.autoDispose<List<SiteData>>((ref) {
  final projectUuid = ref.read(projectUuidProvider.notifier).state;
  final siteEntries =
      SiteQuery(ref.read(databaseProvider)).getAllSites(projectUuid);
  return siteEntries;
});

final collEventEntryProvider =
    FutureProvider.autoDispose<List<CollEventData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final collEvents =
      CollEventQuery(ref.read(databaseProvider)).getAllCollEvents(projectUuid);
  return collEvents;
});

final specimenEntryProvider =
    FutureProvider.autoDispose<List<SpecimenData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final specimenEntries =
      SpecimenQuery(ref.read(databaseProvider)).getAllSpecimens(projectUuid);
  return specimenEntries;
});

final collEventIDprovider =
    FutureProvider.family.autoDispose<CollEventData, int>((ref, id) async {
  final collEventID =
      CollEventQuery(ref.read(databaseProvider)).getCollEventById(id);
  return collEventID;
});

final personnelListProvider = FutureProvider.autoDispose<List<PersonnelData>>(
    (ref) => PersonnelQuery(ref.read(databaseProvider)).getAllPersonnel());

final coordinateBySiteProvider = FutureProvider.family
    .autoDispose<List<CoordinateData>, int>((ref, siteId) =>
        CoordinateQuery(ref.read(databaseProvider))
            .getCoordinatesBySiteID(siteId));

final collEffortByEventProvider = FutureProvider.family
    .autoDispose<List<CollEffortData>, int>((ref, collEventId) =>
        CollEffortQuery(ref.read(databaseProvider))
            .getCollEffortByEventId(collEventId));

final taxonRegistryProvider =
    FutureProvider.autoDispose<List<TaxonomyData>>((ref) async {
  final projectTaxon = TaxonomyQuery(ref.read(databaseProvider)).getTaxonList();
  return await projectTaxon;
});

final collPersonnelProvider = FutureProvider.family
    .autoDispose<List<CollPersonnelData>, int>((ref, collEventId) =>
        CollPersonnelQuery(ref.read(databaseProvider))
            .getCollPersonnelByEventId(collEventId));

final weatherDataProvider = FutureProvider.family.autoDispose<WeatherData, int>(
    (ref, collEventId) => WeatherDataQuery(ref.read(databaseProvider))
        .getWeatherDataByEventId(collEventId));

final personnelNameProvider =
    FutureProvider.family.autoDispose<PersonnelData, String>((ref, uuid) {
  final person =
      PersonnelQuery(ref.read(databaseProvider)).getPersonnelByUuid(uuid);
  return person;
});
