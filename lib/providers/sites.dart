import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/site_queries.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final siteEntryProvider = FutureProvider.autoDispose<List<SiteData>>((ref) {
  final projectUuid = ref.read(projectUuidProvider.notifier).state;
  final siteEntries =
      SiteQuery(ref.read(databaseProvider)).getAllSites(projectUuid);
  return siteEntries;
});
