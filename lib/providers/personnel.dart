import 'package:nahpu/providers/database.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/personnel_queries.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'personnel.g.dart';

@riverpod
Future<List<PersonnelData>> allPersonnel(AllPersonnelRef ref) async {
  List<PersonnelData> personnelData =
      await PersonnelQuery(ref.read(databaseProvider)).getAllPersonnel();
  return personnelData;
}

final personnelListProvider =
    FutureProvider.autoDispose<List<PersonnelData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  return PersonnelQuery(ref.read(databaseProvider))
      .getPersonnelByProjectUuid(projectUuid);
});

final personnelNameProvider =
    FutureProvider.family.autoDispose<PersonnelData, String>((ref, uuid) {
  final person =
      PersonnelQuery(ref.read(databaseProvider)).getPersonnelByUuid(uuid);
  return person;
});

final personnelInitialProvider =
    FutureProvider.family.autoDispose<String?, String>((ref, uuid) async {
  final personInitial =
      PersonnelQuery(ref.read(databaseProvider)).getInitial(uuid);
  return personInitial;
});
