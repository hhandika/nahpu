import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/personnel_queries.dart';
import 'package:nahpu/services/io_services.dart';

class PersonnelServices extends DbAccess {
  const PersonnelServices({required super.ref});

  Future<int> createPersonnel(PersonnelCompanion personnel) async {
    int id = await PersonnelQuery(dbAccess).createPersonnel(personnel);
    return id;
  }

  Future<void> createProjectPersonnel(PersonnelListCompanion form) async {
    await PersonnelQuery(dbAccess).createProjectPersonnelEntry(form);
    invalidatePersonnel();
  }

  Future<void> updatePersonnelEntry(
      String uuid, PersonnelCompanion personnel) async {
    await PersonnelQuery(dbAccess).updatePersonnelEntry(uuid, personnel);
    invalidatePersonnel();
  }

  Future<int?> getCurrentPersonnelFieldNumber(String personnelUuid) async {
    return await PersonnelQuery(dbAccess)
        .getCurrentFieldNumberByUuid(personnelUuid);
  }

  Future<PersonnelData> getPersonnelByUuid(String uuid) async {
    return await PersonnelQuery(dbAccess).getPersonnelByUuid(uuid);
  }

  Future<List<PersonnelData>> getAllPersonnel() async {
    return await PersonnelQuery(dbAccess).getAllPersonnel();
  }

  void deletePersonnel(String uuid) {
    PersonnelQuery(dbAccess).deleteProjectPersonnel(uuid, projectUuid);
    PersonnelQuery(dbAccess).deletePersonnel(uuid);
    invalidatePersonnel();
  }

  void deleteAllPersonnelDb() {
    PersonnelQuery(dbAccess).deleteAllPersonnel();
    invalidatePersonnel();
  }

  void invalidatePersonnel() {
    ref.invalidate(personnelListProvider);
  }
}
