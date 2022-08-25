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

final pageNavigationProvider =
    StateProvider.autoDispose<PageNavigation>((ref) => PageNavigation());
