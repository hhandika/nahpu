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
  String get projectUuid => ref.read(projectUuidProvider);

  Future<void> createSpecimen() async {
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

  Future<List<SpecimenData>> getMammalSpecimens() async {
    return SpecimenQuery(dbase).getAllMammalSpecimens(projectUuid);
  }

  Future<List<SpecimenData>> getBirdSpecimens() async {
    return SpecimenQuery(dbase).getAllBirdSpecimens(projectUuid);
  }

  Future<List<SpecimenData>> getSpecimenList() async {
    String projectUuid = ref.read(projectUuidProvider);

    return SpecimenQuery(dbase).getAllSpecimens(projectUuid);
  }

  Future<int> getSpecimenFieldNumber(
    String personnelUuid,
  ) async {
    int? fieldNumber =
        await PersonnelQuery(dbase).getCurrentFieldNumberByUuid(personnelUuid);
    return _getCurrentFieldNumber(fieldNumber);
  }

  int _getCurrentFieldNumber(int? currentFieldNum) {
    if (currentFieldNum == null) {
      return 0;
    } else {
      return currentFieldNum;
    }
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

  Future<void> updateSpecimen(String uuid, SpecimenCompanion entries) async {
    await SpecimenQuery(dbase).updateSpecimenEntry(uuid, entries);
    ref.invalidate(taxonDataProvider);
  }

  Future<BirdMeasurementData> getBirdMeasurementData(String specimenUuid) {
    return BirdSpecimenQuery(dbase).getBirdMeasurementByUuid(specimenUuid);
  }

  void updateBirdMeasurement(
      String specimenUuid, BirdMeasurementCompanion entries) {
    BirdSpecimenQuery(dbase).updateBirdMeasurements(specimenUuid, entries);
  }

  Future<void> deleteBirdMeasurements(String specimenUuid) async {
    await BirdSpecimenQuery(dbase).deleteBirdMeasurements(specimenUuid);
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

  Future<void> deleteMammalMeasurements(String specimenUuid) async {
    await MammalSpecimenQuery(dbase).deleteMammalMeasurements(specimenUuid);
  }

  Future<void> deleteSpecimen(
      String specimenUuid, CatalogFmt catalogFmt) async {
    await SpecimenQuery(dbase).deleteSpecimen(specimenUuid);
    await deleteAllSpecimenParts(specimenUuid);
    switch (catalogFmt) {
      case CatalogFmt.birds:
        await deleteBirdMeasurements(specimenUuid);
        break;
      case CatalogFmt.bats:
        await deleteMammalMeasurements(specimenUuid);
        break;
      case CatalogFmt.generalMammals:
        await deleteMammalMeasurements(specimenUuid);
        break;
    }
    _invalidateSpecimenList();
  }

  Future<void> deleteAllSpecimens() async {
    await SpecimenQuery(dbase).deleteAllSpecimens(projectUuid);
    _invalidateSpecimenList();
  }

  Future<void> deleteAllSpecimenParts(String specimenUuid) async {
    await SpecimenPartQuery(dbase).deleteAllSpecimenParts(specimenUuid);
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
