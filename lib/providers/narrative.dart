import 'package:nahpu/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/project.dart';

final narrativeEntryProvider =
    FutureProvider.autoDispose<List<NarrativeData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider.state).state;
  final narrativeEntries =
      ref.read(databaseProvider).getAllNarrative(projectUuid);
  return narrativeEntries;
});
