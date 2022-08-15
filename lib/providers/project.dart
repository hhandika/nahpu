import 'package:nahpu/database/database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final databaseProvider = Provider<Database>((ref) {
  return Database();
});

final projectListProvider = FutureProvider<List<ListProjectResult>>((ref) {
  return ref.read(databaseProvider).getProjectList();
});

final projectInfoProvider =
    FutureProvider.family<ProjectData?, String>((ref, uuid) async {
  final projectInfo = ref.read(databaseProvider).getProjectByUuid(uuid);
  return await projectInfo;
});
