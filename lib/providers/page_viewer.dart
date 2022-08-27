import 'package:nahpu/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/project.dart';

import 'package:nahpu/models/page_viewer.dart';

final narrativeEntryProvider =
    FutureProvider.autoDispose<List<NarrativeData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider.state).state;
  final narrativeEntries =
      ref.read(databaseProvider).getAllNarrative(projectUuid);
  return narrativeEntries;
});

final siteEntryProvider = FutureProvider.autoDispose<List<SiteData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider.state).state;
  final siteEntries = ref.read(databaseProvider).getAllSites(projectUuid);
  return siteEntries;
});

final collEventEntryProvider =
    FutureProvider.autoDispose<List<CollEventData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider.state).state;
  final collEvents = ref.read(databaseProvider).getAllCollEvents(projectUuid);
  return collEvents;
});

final pageNavigationProvider =
    StateProvider.autoDispose<PageNavigation>((ref) => PageNavigation());

final specimenEntryProvider =
    FutureProvider.autoDispose<List<SpecimenData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider.state).state;
  final specimenEntries =
      ref.read(databaseProvider).getAllSpecimens(projectUuid);
  return specimenEntries;
});
