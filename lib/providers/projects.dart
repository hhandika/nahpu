/// Project module providers contain all the providers related to the project,
/// Except for the project form validation provider, which is in the validation.dart file.

import 'package:nahpu/services/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final databaseProvider = Provider<Database>((ref) {
  final db = Database();
  ref.onDispose(db.close);
  return db;
});

final projectListProvider =
    FutureProvider.autoDispose<List<ListProjectResult>>((ref) {
  return ref.read(databaseProvider).getProjectList();
});

final projectInfoProvider =
    FutureProvider.autoDispose.family<ProjectData?, String>((ref, uuid) async {
  final projectInfo = ref.read(databaseProvider).getProjectByUuid(uuid);
  return await projectInfo;
});

final projectUuidProvider = StateProvider<String>((ref) => '');

final projectNavbarIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

get uuid => const Uuid().v4();

void deleteProject(WidgetRef ref, String uuid) {
  ref.read(databaseProvider).deleteProject(uuid);
  ref.invalidate(projectListProvider);
}
