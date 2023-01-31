import 'package:drift/drift.dart';
import 'package:nahpu/services/database.dart';

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

  Future<void> deleteSpecimen(String uuid) {
    return (delete(specimen)..where((t) => t.uuid.equals(uuid))).go();
  }

  Future<void> deleteAllSpecimens(String projectUuid) {
    return (delete(specimen)..where((t) => t.projectUuid.equals(projectUuid)))
        .go();
  }

  Future<int> createBirdMeasurements(BirdMeasurementCompanion form) =>
      into(birdMeasurement).insert(form);

  Future<int> createMammalMeasurements(MammalMeasurementCompanion form) =>
      into(mammalMeasurement).insert(form);

  Future updateSpecimenEntry(String uuid, SpecimenCompanion entry) {
    return (update(specimen)..where((t) => t.uuid.equals(uuid))).write(entry);
  }

  Future updateBirdMeasurements(
      String specimenUuid, BirdMeasurementCompanion entry) {
    return (update(birdMeasurement)
          ..where((t) => t.specimenUuid.equals(specimenUuid)))
        .write(entry);
  }

  Future<BirdMeasurementData?> getBirdMeasurementByUuid(
      String specimenUuid) async {
    try {
      return (select(birdMeasurement)
            ..where((t) => t.specimenUuid.equals(specimenUuid)))
          .getSingle();
    } catch (e) {
      return null;
    }
  }
}
