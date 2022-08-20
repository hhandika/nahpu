import 'package:nahpu/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider<Database>((ref) {
  final db = Database();
  ref.onDispose(db.close);
  return db;
});

final projectListProvider = FutureProvider<List<ListProjectResult>>((ref) {
  return ref.read(databaseProvider).getProjectList();
});

final projectInfoProvider =
    FutureProvider.family<ProjectData?, String>((ref, uuid) async {
  final projectInfo = ref.read(databaseProvider).getProjectByUuid(uuid);
  return await projectInfo;
});

final projectUuidProvider = StateProvider<String>((ref) => '');

final narrativeEntriesProvider =
    FutureProvider.family<List<NarrativeData>, String>(
        (ref, projectUuid) async {
  final narrativeEntries =
      ref.read(databaseProvider).getAllNarrative(projectUuid);
  return await narrativeEntries;
});
