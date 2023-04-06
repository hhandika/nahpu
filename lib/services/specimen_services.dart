import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/personnel_queries.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/project_services.dart';

class SpecimenServices extends DbAccess {
  SpecimenServices(super.ref);

  Database get dbase => ref.read(databaseProvider);

  Future<void> createSpecimen() async {
    String projectUuid = ref.watch(projectUuidProvider);
    CatalogFmt catalogFmt = ref.watch(catalogFmtNotifier);
    final String specimenUuid = uuid;
    await SpecimenQuery(dbase).createSpecimen(SpecimenCompanion(
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
  }

  Future<List<SpecimenData>> getSpecimenList() async {
    String projectUuid = ref.read(projectUuidProvider);

    return SpecimenQuery(dbase).getAllSpecimens(projectUuid);
  }

  Future<int> getSpecimenFieldNumber(
      String personnelUuid, String specimenUuid) async {
    String projectUuid = ref.read(projectUuidProvider);
    // final db = dbase;
    SpecimenData? specimenData = await SpecimenQuery(dbase)
        .getLastCatFieldNumber(projectUuid, specimenUuid, personnelUuid);

    ref.invalidate(personnelListProvider);
    if (specimenData == null) {
      try {
        int? fieldNumber = await PersonnelQuery(dbase)
            .getCurrentFieldNumberByUuid(personnelUuid);
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
    MammalSpecimenQuery(dbase).createMammalMeasurements(
        MammalMeasurementCompanion(specimenUuid: db.Value(specimenUuid)));
  }

  Future<MammalMeasurementData> getMammalMeasurementData(String specimenUuid) {
    return MammalSpecimenQuery(dbase).getMammalMeasurementByUuid(specimenUuid);
  }

  void updateMammalMeasurement(
      String specimenUuid, MammalMeasurementCompanion entries) {
    MammalSpecimenQuery(dbase).updateMammalMeasurements(specimenUuid, entries);
  }

  void _createBirdSpecimen(String specimenUuid) {
    BirdSpecimenQuery(dbase).createBirdMeasurements(
        BirdMeasurementCompanion(specimenUuid: db.Value(specimenUuid)));
  }

  void updateSpecimen(String uuid, SpecimenCompanion entries) {
    SpecimenQuery(dbase).updateSpecimenEntry(uuid, entries);
    ref.invalidate(taxonDataProvider);
  }

  Future<BirdMeasurementData> getBirdMeasurementData(String specimenUuid) {
    return BirdSpecimenQuery(dbase).getBirdMeasurementByUuid(specimenUuid);
  }

  void updateBirdMeasurement(
      String specimenUuid, BirdMeasurementCompanion entries) {
    BirdSpecimenQuery(dbase).updateBirdMeasurements(specimenUuid, entries);
  }

  Future<void> createSpecimenPart(SpecimenPartCompanion form) async {
    SpecimenPartQuery(dbase).createSpecimenPart(form);
    ref.invalidate(partBySpecimenProvider);
  }

  Future<void> updateSpecimenPart(
      int partId, SpecimenPartCompanion form) async {
    SpecimenPartQuery(dbase).updateSpecimenPart(partId, form);
    ref.invalidate(partBySpecimenProvider);
  }

  void deleteSpecimenPart(int partId) {
    SpecimenPartQuery(dbase).deleteSpecimenPart(partId);
    ref.invalidate(partBySpecimenProvider);
  }

  void _invalidateSpecimenList() {
    ref.invalidate(specimenEntryProvider);
    ref.invalidate(taxonDataProvider);
    ref.invalidate(personnelListProvider);
  }
}
