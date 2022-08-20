import 'package:nahpu/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/project.dart';

final narrativeEntryProvider = FutureProvider<List<NarrativeData>>((ref) async {
  final narrativeEntries = await ref.watch(narrativeProvider.future);
  return narrativeEntries;
});

final narrativeProvider = StreamProvider<List<NarrativeData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider.state).state;
  final narrativeEntries =
      ref.read(databaseProvider).watchAllNarrative(projectUuid);
  return narrativeEntries;
});
