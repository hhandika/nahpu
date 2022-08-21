import 'package:nahpu/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/project.dart';

final narrativeEntryProvider =
    FutureProvider.autoDispose<List<NarrativeData>>((ref) async {
  final projectUuid = ref.watch(projectUuidProvider.state).state;
  final narrativeEntries =
      ref.read(databaseProvider).getAllNarrative(projectUuid);
  return await narrativeEntries;
});

// final narrativeEntryProvider =
//     FutureProvider.autoDispose<List<NarrativeData>>((ref) async {
//   return ref.watch(narrativeProvider.future);
// });

class NarrativeEntryProvider extends StateNotifier<List<NarrativeData>> {
  NarrativeEntryProvider() : super([]);

  void addNarrativeEntry(NarrativeData narrativeEntry) {
    state = [...state, narrativeEntry];
  }

  void removeNarrativeEntry(NarrativeData narrativeEntry) {
    state = state.where((element) => element.id != narrativeEntry.id).toList();
  }

  void updateNarrativeEntry(NarrativeData narrativeEntry) {
    state = state
        .map((element) =>
            element.id == narrativeEntry.id ? narrativeEntry : element)
        .toList();
  }
}
