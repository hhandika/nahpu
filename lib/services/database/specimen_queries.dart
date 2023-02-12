import 'package:drift/drift.dart';
import 'package:nahpu/services/database/database.dart';

part 'specimen_queries.g.dart';

@DriftAccessor(
  include: {'tables.drift'},
)
class SpecimenQuery extends DatabaseAccessor<Database>
    with _$SpecimenQueryMixin {
  SpecimenQuery(Database db) : super(db);

  // Specimen General table
  Future<int> createSpecimen(SpecimenCompanion form) =>
      into(specimen).insert(form);

  Future<List<SpecimenData>> getAllSpecimens(String projectUuid) {
    return (select(specimen)..where((t) => t.projectUuid.equals(projectUuid)))
        .get();
  }

  Future<SpecimenData?> getLastCatFieldNumber(
      String projectUuid, String catalogerUuid) async {
    try {
      return await (select(specimen)
            ..where((t) => t.projectUuid.equals(projectUuid))
            ..where((t) => t.catalogerID.equals(catalogerUuid)))
          .getSingle();
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteSpecimen(String uuid) {
    return (delete(specimen)..where((t) => t.uuid.equals(uuid))).go();
  }

  Future<void> deleteAllSpecimens(String projectUuid) {
    return (delete(specimen)..where((t) => t.projectUuid.equals(projectUuid)))
        .go();
  }

  Future updateSpecimenEntry(String uuid, SpecimenCompanion entry) {
    return (update(specimen)..where((t) => t.uuid.equals(uuid))).write(entry);
  }
}

class MammalSpecimenQuery extends DatabaseAccessor<Database>
    with _$SpecimenQueryMixin {
  MammalSpecimenQuery(Database db) : super(db);

  Future<int> createMammalMeasurements(MammalMeasurementCompanion form) =>
      into(mammalMeasurement).insert(form);

  Future updateMammalMeasurements(
      String specimenUuid, MammalMeasurementCompanion form) {
    return (update(mammalMeasurement)
          ..where((t) => t.specimenUuid.equals(specimenUuid)))
        .write(form);
  }

  Future<MammalMeasurementData> getMammalMeasurementByUuid(
      String specimenUuid) async {
    return await (select(mammalMeasurement)
          ..where((t) => t.specimenUuid.equals(specimenUuid)))
        .getSingle();
  }
}

class BirdSpecimenQuery extends DatabaseAccessor<Database>
    with _$SpecimenQueryMixin {
  BirdSpecimenQuery(Database db) : super(db);

  Future<int> createBirdMeasurements(BirdMeasurementCompanion form) =>
      into(birdMeasurement).insert(form);

  Future updateBirdMeasurements(
      String specimenUuid, BirdMeasurementCompanion entry) {
    return (update(birdMeasurement)
          ..where((t) => t.specimenUuid.equals(specimenUuid)))
        .write(entry);
  }

  Future<BirdMeasurementData> getBirdMeasurementByUuid(
      String specimenUuid) async {
    return await (select(birdMeasurement)
          ..where((t) => t.specimenUuid.equals(specimenUuid)))
        .getSingle();
  }
}
