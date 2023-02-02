import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database.dart';
import 'package:nahpu/services/specimen_queries.dart';
import 'package:drift/drift.dart' as db;

class SpecimenServices {
  SpecimenServices(this.ref);

  final WidgetRef ref;

  void createMammalSpecimen(String specimenUuid) {
    SpecimenQuery(ref.read(databaseProvider)).createMammalMeasurements(
        MammalMeasurementCompanion(specimenUuid: db.Value(specimenUuid)));
  }

  void createBirdSpecimen(String specimenUuid) {
    SpecimenQuery(ref.read(databaseProvider)).createBirdMeasurements(
        BirdMeasurementCompanion(specimenUuid: db.Value(specimenUuid)));
  }

  void updateSpecimen(String uuid, SpecimenCompanion entries) {
    SpecimenQuery(ref.read(databaseProvider))
        .updateSpecimenEntry(uuid, entries);
  }

  void updateBirdMeasurement(
      String specimenUuid, BirdMeasurementCompanion entries, WidgetRef ref) {
    SpecimenQuery(ref.read(databaseProvider))
        .updateBirdMeasurements(specimenUuid, entries);
  }
}
