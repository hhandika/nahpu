import 'package:drift/drift.dart';
import 'package:nahpu/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final databaseProvider = Provider<Database>((ref) {
  final db = Database();
  ref.onDispose(db.close);
  return db;
});

final projectListProvider = FutureProvider<List<ListProjectResult>>((ref) {
  return ref.read(databaseProvider).getProjectList();
});

final projectInfoProvider =
    FutureProvider.autoDispose.family<ProjectData?, String>((ref, uuid) async {
  final projectInfo = ref.read(databaseProvider).getProjectByUuid(uuid);
  return await projectInfo;
});

final projectUuidProvider = StateProvider<String>((ref) => '');

final projectNavbarIndexProvider = StateProvider<int>((ref) => 0);

Future<void> createProject(WidgetRef ref, ProjectCompanion form) async {
  final personnelUuid = uuid;
  createPersonnel(
      ref,
      PersonnelCompanion(
          id: Value(personnelUuid),
          name: form.collector,
          initial: form.collectorInitial));
  await ref.read(databaseProvider).createProject(form);
}

Future<void> createPersonnel(WidgetRef ref, PersonnelCompanion form) async {
  final personnelUuid = uuid;
  await ref.read(databaseProvider).createPersonnel(PersonnelCompanion(
      id: Value(personnelUuid), name: form.name, initial: form.initial));
}

get uuid => const Uuid().v4();

void deleteProject(WidgetRef ref, String uuid) {
  ref.read(databaseProvider).deleteProject(uuid);
  ref.refresh(projectListProvider);
}
