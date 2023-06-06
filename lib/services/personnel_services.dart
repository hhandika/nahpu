import 'dart:math';

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

  Future<void> deleteProjectPersonnel(String personnelUuid) async {
    bool isUsed = await PersonnelQuery(dbAccess)
        .isPersonnelBeingUsedInOtherRecords(personnelUuid);
    if (isUsed) {
      throw Exception(
          'Failed to delete! Personnel is being used in other records');
    } else {
      await PersonnelQuery(dbAccess).deleteProjectPersonnel(personnelUuid);
      invalidatePersonnel();
    }
  }

  Future<void> deletePersonnel(String uuid) async {
    await PersonnelQuery(dbAccess).deletePersonnel(uuid);
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

const String avatarPath = 'assets/avatars/';

const List<String> availableBirdPhoto = [
  'canton_lep_esquisita.png',
  'canton_lep_hybrid2.png',
  'canton_lep_velutina.png',
];

class PersonnelImageService {
  PersonnelImageService();

  String get imageAssets {
    final random = Random();
    final index = random.nextInt(availableBirdPhoto.length);
    return '$avatarPath${availableBirdPhoto[index]}';
  }
}
