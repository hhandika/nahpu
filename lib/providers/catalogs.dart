import 'package:nahpu/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/models/catalogs.dart';

final narrativeEntryProvider =
    FutureProvider.autoDispose<List<NarrativeData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final narrativeEntries =
      ref.read(databaseProvider).getAllNarrative(projectUuid);
  return narrativeEntries;
});

final siteEntryProvider = FutureProvider.autoDispose<List<SiteData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider.notifier).state;
  final siteEntries = ref.read(databaseProvider).getAllSites(projectUuid);
  return siteEntries;
});

final collEventEntryProvider =
    FutureProvider.autoDispose<List<CollEventData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final collEvents = ref.read(databaseProvider).getAllCollEvents(projectUuid);
  return collEvents;
});

// final pageNavigationProvider =
//     StateProvider.autoDispose<PageNavigation>((ref) => PageNavigation());

// final siteNavProvider =
//     StateProvider.autoDispose<SiteNavigation>((ref) => SiteNavigation());

// final collEventNavProvider =
//     StateProvider.autoDispose<PageNavigation>((ref) => PageNavigation());

// final specimenNavProvider =
//     StateProvider.autoDispose<PageNavigation>((ref) => PageNavigation());

PageNavigation updatePageNavigation(PageNavigation pageState) {
  if (pageState.currentPage == 1) {
    pageState.isFirstPage = true;
    pageState.isLastPage = false;
  } else if (pageState.currentPage == pageState.pageCounts) {
    pageState.isFirstPage = false;
    pageState.isLastPage = true;
  } else {
    pageState.isFirstPage = false;
    pageState.isLastPage = false;
  }

  return pageState;
}

final specimenEntryProvider =
    FutureProvider.autoDispose<List<SpecimenData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final specimenEntries =
      ref.read(databaseProvider).getAllSpecimens(projectUuid);
  return specimenEntries;
});

final personnelListProvider = FutureProvider.autoDispose<List<PersonnelData>>(
    (ref) => ref.read(databaseProvider).getAllPersonnel());

final coordinateListProvider = FutureProvider.autoDispose<List<CoordinateData>>(
    (ref) => ref.read(databaseProvider).getAllCoordinates());

void updateSite(int id, SiteCompanion site, WidgetRef ref) {
  ref.read(databaseProvider).updateSiteEntry(id, site);
}

void updateNarrative(int id, NarrativeCompanion entries, WidgetRef ref) {
  ref.read(databaseProvider).updateNarrativeEntry(id, entries);
}

void updateCollEvent(int id, CollEventCompanion entries, WidgetRef ref) {
  ref.read(databaseProvider).updateCollEventEntry(id, entries);
}

void updateSpecimen(String uuid, SpecimenCompanion entries, WidgetRef ref) {
  ref.read(databaseProvider).updateSpecimenEntry(uuid, entries);
}
