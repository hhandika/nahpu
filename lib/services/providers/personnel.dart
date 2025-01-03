import 'package:nahpu/services/providers/database.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/providers/projects.dart';
import 'package:nahpu/services/database/personnel_queries.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'personnel.g.dart';

@riverpod
Future<List<PersonnelData>> allPersonnel(Ref ref) async {
  List<PersonnelData> personnelData =
      await PersonnelQuery(ref.read(databaseProvider)).getAllPersonnel();
  return personnelData;
}

@riverpod
Future<List<PersonnelData>> projectPersonnel(Ref ref) async {
  final projectUuid = ref.watch(projectUuidProvider);
  List<PersonnelData> personnelData =
      await PersonnelQuery(ref.read(databaseProvider))
          .getPersonnelByProjectUuid(projectUuid);
  return personnelData;
}

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
