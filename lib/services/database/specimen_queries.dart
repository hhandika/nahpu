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

  Future<List<SpecimenData>> getAllBirdSpecimens(String projectUuid) {
    return (select(specimen)
          ..where((t) => t.projectUuid.equals(projectUuid))
          ..where((t) => t.taxonGroup.equals('Birds')))
        .get();
  }

  Future<List<SpecimenData>> getAllMammalSpecimens(String projectUuid) {
    return (select(specimen)
          ..where((t) => t.projectUuid.equals(projectUuid))
          ..where((t) => t.taxonGroup.equals('General Mammals')))
        .get();
  }

  Future<List<SpecimenData>> getAllBatSpecimens(String projectUuid) {
    return (select(specimen)
          ..where((t) => t.projectUuid.equals(projectUuid))
          ..where((t) => t.taxonGroup.equals('Bats')))
        .get();
  }

  Future<List<int?>> getAllSpecies(String uuid) {
    return (select(specimen)..where((t) => t.projectUuid.equals(uuid)))
        .map((e) => e.speciesID)
        .get();
  }

  Future<int?> getSpecimenByUuid(String uuid) async {
    SpecimenData? specimenData =
        await (select(specimen)..where((t) => t.uuid.equals(uuid))).getSingle();

    return specimenData.speciesID;
  }

  Future<SpecimenData?> getLastCatFieldNumber(
      String projectUuid, String specimenUuid, String catalogerUuid) async {
    try {
      return await (select(specimen)
            ..where((t) => t.projectUuid.equals(projectUuid))
            ..where((t) => t.uuid.equals(specimenUuid))
            ..where((t) => t.catalogerID.equals(catalogerUuid))
            ..orderBy([
              (t) => OrderingTerm(
                  expression: t.fieldNumber, mode: OrderingMode.desc)
            ]))
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

  Future<void> deleteMammalMeasurements(String specimenUuid) {
    return (delete(mammalMeasurement)
          ..where((t) => t.specimenUuid.equals(specimenUuid)))
        .go();
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

  Future<void> deleteBirdMeasurements(String specimenUuid) {
    return (delete(birdMeasurement)
          ..where((t) => t.specimenUuid.equals(specimenUuid)))
        .go();
  }
}

class SpecimenPartQuery extends DatabaseAccessor<Database>
    with _$SpecimenQueryMixin {
  SpecimenPartQuery(Database db) : super(db);

  Future<int> createSpecimenPart(SpecimenPartCompanion form) =>
      into(specimenPart).insert(form);

  Future<List<SpecimenPartData>> getSpecimenParts(String specimenUuid) {
    return (select(specimenPart)
          ..where((t) => t.specimenUuid.equals(specimenUuid)))
        .get();
  }

  Future<void> updateSpecimenPart(int id, SpecimenPartCompanion entry) {
    return (update(specimenPart)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<void> deleteSpecimenPart(int partId) {
    return (delete(specimenPart)..where((t) => t.id.equals(partId))).go();
  }

  Future<void> deleteAllSpecimenParts(String specimenUuid) {
    return (delete(specimenPart)
          ..where((t) => t.specimenUuid.equals(specimenUuid)))
        .go();
  }

  Future updateSpecimenPartEntry(String uuid, SpecimenPartCompanion entry) {
    return (update(specimenPart)..where((t) => t.specimenUuid.equals(uuid)))
        .write(entry);
  }
}
