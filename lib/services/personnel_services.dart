import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/personnel_queries.dart';

class PersonnelServices extends DbAccess {
  PersonnelServices(super.ref);

  Database get db => ref.read(databaseProvider);
  String get projectUuid => ref.read(projectUuidProvider);

  Future<int> createPersonnel(PersonnelCompanion personnel) async {
    return await PersonnelQuery(db).createPersonnel(personnel);
  }

  Future<void> createProjectPersonnel(PersonnelListCompanion form) async {
    await PersonnelQuery(db).createProjectPersonnelEntry(form);
  }

  Future<void> updatePersonnelEntry(
      String uuid, PersonnelCompanion personnel) async {
    await PersonnelQuery(db).updatePersonnelEntry(uuid, personnel);
    invalidatePersonnel();
  }

  void updateAllCatalogerFieldNumbers() async {
    List<PersonnelData> allPersonnel = [];
    ref.read(personnelListProvider).whenData((value) => allPersonnel = value);
    for (PersonnelData person in allPersonnel) {
      await PersonnelQuery(db).updateCatalogerFieldNumber(person.uuid);
    }
  }

  Future<int?> getCurrentPersonnelFieldNumber(String personnelUuid) async {
    return await PersonnelQuery(db).getCurrentFieldNumberByUuid(personnelUuid);
  }

  Future<PersonnelData> getPersonnelByUuid(String uuid) async {
    return await PersonnelQuery(db).getPersonnelByUuid(uuid);
  }

  Future<List<PersonnelData>> getAllPersonnel() async {
    return await PersonnelQuery(db).getAllPersonnel();
  }

  void deletePersonnel(String uuid) {
    PersonnelQuery(db).deletePersonnel(uuid);
    invalidatePersonnel();
  }

  void deleteAllPersonnelDb() {
    PersonnelQuery(db).deleteAllPersonnel();
    invalidatePersonnel();
  }

  void invalidatePersonnel() {
    ref.invalidate(personnelListProvider);
  }
}
