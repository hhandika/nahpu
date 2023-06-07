import 'package:drift/drift.dart';
import 'package:nahpu/services/database/database.dart';

part 'personnel_queries.g.dart';

@DriftAccessor(
  include: {'tables.drift'},
)
class PersonnelQuery extends DatabaseAccessor<Database>
    with _$PersonnelQueryMixin {
  PersonnelQuery(Database db) : super(db);

  // Personnel table
  Future<int> createPersonnel(PersonnelCompanion form) =>
      into(personnel).insert(form);

  Future updatePersonnelEntry(String id, PersonnelCompanion entry) {
    return (update(personnel)..where((t) => t.uuid.equals(id))).write(entry);
  }

  Future<List<PersonnelData>> searchPersonnel(String search) {
    return (select(personnel)..where((t) => t.name.like('%$search%'))).get();
  }

  Future<void> createProjectPersonnelEntry(PersonnelListCompanion form) =>
      into(personnelList).insert(form);

  Future<int?> getCurrentFieldNumberByUuid(String personnelUuid) async {
    return await (select(personnel)..where((t) => t.uuid.equals(personnelUuid)))
        .map((e) => e.currentFieldNumber)
        .getSingle();
  }

  Future<String?> getInitial(String personnelUuid) {
    return (select(personnel)..where((t) => t.uuid.equals(personnelUuid)))
        .map((e) => e.initial)
        .getSingle();
  }

  Future<void> deletePersonnel(String uuid) {
    return (delete(personnel)..where((t) => t.uuid.equals(uuid))).go();
  }

  Future<PersonnelData> getPersonnelByUuid(String uuid) async {
    return await (select(personnel)..where((t) => t.uuid.equals(uuid)))
        .getSingle();
  }

  Future<bool> isPersonnelBeingUsedInOtherRecords(String uuid) async {
    SpecimenData? specimenRecords = await (select(specimen)
          ..where((t) => t.catalogerID.equals(uuid))
          ..limit(1))
        .getSingleOrNull();
    CollPersonnelData? eventRecords = await (select(collPersonnel)
          ..where((t) => t.personnelId.equals(uuid))
          ..limit(1))
        .getSingleOrNull();
    if (specimenRecords != null || eventRecords != null) {
      return true;
    }
    return false;
  }

  Future<void> deleteProjectPersonnel(String personnelUuid) {
    return (delete(personnelList)
          ..where((t) => t.personnelUuid.equals(personnelUuid)))
        .go();
  }

  Future<List<PersonnelData>> getPersonnelByProjectUuid(
      String projectUuid) async {
    List<PersonnelListData> personnelByProject = await (select(personnelList)
          ..where((t) => t.projectUuid.equals(projectUuid)))
        .get();
    List<PersonnelData> personnelData = [];
    for (PersonnelListData personnel in personnelByProject) {
      if (personnel.personnelUuid != null) {
        personnelData.add(await getPersonnelByUuid(personnel.personnelUuid!));
      }
    }
    return personnelData;
  }

  Future<List<PersonnelData>> getAllPersonnel() {
    return select(personnel).get();
  }

  Future<void> deleteAllPersonnel() {
    return delete(personnel).go();
  }
}
