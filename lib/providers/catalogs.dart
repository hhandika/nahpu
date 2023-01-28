import 'package:nahpu/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/specimen_queries.dart';

final specimenProvider = Provider<SpecimenQuery>((ref) {
  final specimenTable = SpecimenQuery(ref.read(databaseProvider));
  return specimenTable;
});

final narrativeEntryProvider =
    FutureProvider.autoDispose<List<NarrativeData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final narrativeEntries =
      ref.read(databaseProvider).getAllNarrative(projectUuid);
  return narrativeEntries;
});

final siteEntryProvider = FutureProvider.autoDispose<List<SiteData>>((ref) {
  final projectUuid = ref.read(projectUuidProvider.notifier).state;
  final siteEntries = ref.read(databaseProvider).getAllSites(projectUuid);
  return siteEntries;
});

final collEventEntryProvider =
    FutureProvider.autoDispose<List<CollEventData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final collEvents = ref.read(databaseProvider).getAllCollEvents(projectUuid);
  return collEvents;
});

final specimenEntryProvider =
    FutureProvider.autoDispose<List<SpecimenData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final specimenEntries =
      ref.read(databaseProvider).getAllSpecimens(projectUuid);
  return specimenEntries;
});

final collEventIDprovider =
    FutureProvider.family.autoDispose<CollEventData, int>((ref, id) async {
  final collEventID = ref.read(databaseProvider).getCollEventById(id);
  return collEventID;
});

final personnelListProvider = FutureProvider.autoDispose<List<PersonnelData>>(
    (ref) => ref.read(databaseProvider).getAllPersonnel());

final coordinateListProvider = FutureProvider.autoDispose<List<CoordinateData>>(
    (ref) => ref.read(databaseProvider).getAllCoordinates());
