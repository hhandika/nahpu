import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/personnel_queries.dart';

class PersonnelServices {
  PersonnelServices(this.ref);

  final WidgetRef ref;

  Future<int> createPersonnel(PersonnelCompanion personnel) async {
    final db = ref.read(databaseProvider);
    return await PersonnelQuery(db).createPersonnel(personnel);
  }

  void updatePersonnelEntry(String uuid, PersonnelCompanion personnel) {
    final db = ref.read(databaseProvider);
    PersonnelQuery(db).updatePersonnelEntry(uuid, personnel);
  }

  void updateAllCatalogerFieldNumbers() async {
    List<PersonnelData> allPersonnel = [];
    ref.read(personnelListProvider).whenData((value) => allPersonnel = value);
    for (PersonnelData person in allPersonnel) {
      await PersonnelQuery(ref.read(databaseProvider))
          .updateCatalogerFieldNumber(person.uuid);
    }
  }

  Future<int?> getCurrentPersonnelFieldNumber(String personnelUuid) async {
    final db = ref.read(databaseProvider);
    return await PersonnelQuery(db).getCurrentFieldNumberByUuid(personnelUuid);
  }

  Future<PersonnelData> getPersonnelByUuid(String uuid) async {
    final db = ref.read(databaseProvider);
    return await PersonnelQuery(db).getPersonnelByUuid(uuid);
  }

  Future<List<PersonnelData>> getAllPersonnel() async {
    final db = ref.read(databaseProvider);
    return await PersonnelQuery(db).getAllPersonnel();
  }

  void deletePersonnel(String uuid) {
    final db = ref.read(databaseProvider);
    PersonnelQuery(db).deletePersonnel(uuid);
    invalidatePersonnel();
  }

  void deleteAllPersonnelDb() {
    final db = ref.read(databaseProvider);
    PersonnelQuery(db).deleteAllPersonnel();
    invalidatePersonnel();
  }

  void invalidatePersonnel() {
    ref.invalidate(personnelListProvider);
  }
}
