/// Project module providers contain all the providers related to the project,
/// Except for the project form validation provider, which is in the validation.dart file.

import 'package:drift/drift.dart';
import 'package:nahpu/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as db;

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

final taxonRegistryProvider = FutureProvider<List<TaxonomyData>>((ref) async {
  final projectTaxon = ref.read(databaseProvider).getTaxonList();
  return await projectTaxon;
});

final projectUuidProvider = StateProvider<String>((ref) => '');

final projectNavbarIndexProvider = StateProvider<int>((ref) => 0);

Future<void> createProject(
  WidgetRef ref,
  ProjectCompanion form,
  PersonnelCompanion personnel,
) async {
  final personnelUuid = uuid;
  createPersonnel(
    ref,
    PersonnelCompanion(
      uuid: Value(personnelUuid),
      name: personnel.name,
      initial: personnel.initial,
      role: const db.Value('Collector'),
    ),
  );
  await ref.read(databaseProvider).createProject(form);
}

Future<void> createPersonnel(WidgetRef ref, PersonnelCompanion form) async {
  await ref.read(databaseProvider).createPersonnel(form);
}

get uuid => const Uuid().v4();

void deleteProject(WidgetRef ref, String uuid) {
  ref.read(databaseProvider).deleteProject(uuid);
  ref.invalidate(projectListProvider);
}
