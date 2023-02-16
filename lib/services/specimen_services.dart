import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/personnel_queries.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/project_services.dart';

class SpecimenServices {
  SpecimenServices(this.ref);

  final WidgetRef ref;

  String createSpecimen() {
    String projectUuid = ref.watch(projectUuidProvider);
    CatalogFmt catalogFmt = ref.watch(catalogFmtNotifier);
    final String specimenUuid = uuid;
    SpecimenQuery(ref.read(databaseProvider)).createSpecimen(SpecimenCompanion(
      uuid: db.Value(specimenUuid),
      projectUuid: db.Value(projectUuid),
      taxonGroup: db.Value(matchCatFmtToTaxonGroup(catalogFmt)),
    ));

    switch (catalogFmt) {
      case CatalogFmt.birds:
        _createBirdSpecimen(specimenUuid);
        break;
      case CatalogFmt.bats:
        _createMammalSpecimen(specimenUuid);
        break;
      case CatalogFmt.generalMammals:
        _createMammalSpecimen(specimenUuid);
        break;
      default:
        _createMammalSpecimen(specimenUuid);
        break;
    }
    _invalidateSpecimenList();
    return specimenUuid;
  }

  Future<int> getSpecimenFieldNumber(
      String personnelUuid, String specimenUuid) async {
    String projectUuid = ref.read(projectUuidProvider);
    final db = ref.read(databaseProvider);
    SpecimenData? specimenData = await SpecimenQuery(db)
        .getLastCatFieldNumber(projectUuid, specimenUuid, personnelUuid);

    ref.invalidate(personnelListProvider);
    if (specimenData == null) {
      try {
        int? fieldNumber =
            await PersonnelQuery(db).getCurrentFieldNumberByUuid(personnelUuid);
        return _getCurrentFieldNumber(fieldNumber);
      } catch (e) {
        return 0;
      }
    } else {
      return _getFieldNumber(specimenData.fieldNumber!);
    }
  }

  int _getCurrentFieldNumber(int? currentFieldNum) {
    if (currentFieldNum == null) {
      return 0;
    } else {
      return currentFieldNum;
    }
  }

  int _getFieldNumber(int lastFieldNumber) {
    return lastFieldNumber + 1;
  }

  void _createMammalSpecimen(String specimenUuid) {
    MammalSpecimenQuery(ref.read(databaseProvider)).createMammalMeasurements(
        MammalMeasurementCompanion(specimenUuid: db.Value(specimenUuid)));
  }

  Future<MammalMeasurementData> getMammalMeasurementData(String specimenUuid) {
    return MammalSpecimenQuery(ref.read(databaseProvider))
        .getMammalMeasurementByUuid(specimenUuid);
  }

  void updateMammalMeasurement(
      String specimenUuid, MammalMeasurementCompanion entries) {
    MammalSpecimenQuery(ref.read(databaseProvider))
        .updateMammalMeasurements(specimenUuid, entries);
  }

  void _createBirdSpecimen(String specimenUuid) {
    BirdSpecimenQuery(ref.read(databaseProvider)).createBirdMeasurements(
        BirdMeasurementCompanion(specimenUuid: db.Value(specimenUuid)));
  }

  void updateSpecimen(String uuid, SpecimenCompanion entries) {
    SpecimenQuery(ref.read(databaseProvider))
        .updateSpecimenEntry(uuid, entries);
    ref.invalidate(taxonDataProvider);
  }

  Future<BirdMeasurementData> getBirdMeasurementData(String specimenUuid) {
    return BirdSpecimenQuery(ref.read(databaseProvider))
        .getBirdMeasurementByUuid(specimenUuid);
  }

  void updateBirdMeasurement(
      String specimenUuid, BirdMeasurementCompanion entries) {
    BirdSpecimenQuery(ref.read(databaseProvider))
        .updateBirdMeasurements(specimenUuid, entries);
  }

  Future<List<SpecimenPartData>> getSpecimenParts(String specimenUuid) {
    return SpecimenPartQuery(ref.read(databaseProvider))
        .getSpecimenParts(specimenUuid);
  }

  void _invalidateSpecimenList() {
    ref.invalidate(specimenEntryProvider);
    ref.invalidate(taxonDataProvider);
    ref.invalidate(personnelListProvider);
  }
}
