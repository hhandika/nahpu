import 'package:nahpu/services/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/narrative_queries.dart';

final narrativeEntryProvider =
    FutureProvider.autoDispose<List<NarrativeData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final narrativeEntries =
      NarrativeQuery(ref.read(databaseProvider)).getAllNarrative(projectUuid);
  return narrativeEntries;
});
