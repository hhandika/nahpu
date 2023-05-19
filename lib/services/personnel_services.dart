import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/personnel_queries.dart';
import 'package:nahpu/services/io_services.dart';

class PersonnelServices extends DbAccess {
  PersonnelServices(super.ref);

  Future<int> createPersonnel(PersonnelCompanion personnel) async {
    return await PersonnelQuery(dbAccess).createPersonnel(personnel);
  }

  Future<void> createProjectPersonnel(PersonnelListCompanion form) async {
    await PersonnelQuery(dbAccess).createProjectPersonnelEntry(form);
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
