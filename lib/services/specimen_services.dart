import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/providers/taxa.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';
import 'package:nahpu/services/types/specimens.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/personnel_queries.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/project_services.dart';

class SpecimenServices extends DbAccess {
  SpecimenServices(super.ref);

  Future<void> createSpecimen() async {
    CatalogFmt catalogFmt = ref.watch(catalogFmtNotifier);
    final String specimenUuid = uuid;
    await SpecimenQuery(dbAccess).createSpecimen(SpecimenCompanion(
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
    return SpecimenQuery(dbAccess).getAllMammalSpecimens(projectUuid);
  }

  Future<List<SpecimenData>> getBirdSpecimens() async {
    return SpecimenQuery(dbAccess).getAllAvianSpecimens(projectUuid);
  }

  Future<List<SpecimenData>> getBatSpecimens() async {
    return SpecimenQuery(dbAccess).getAllBatSpecimens(projectUuid);
  }

  Future<List<SpecimenData>> getSpecimenList() async {
    return SpecimenQuery(dbAccess).getAllSpecimens(projectUuid);
  }

  Future<List<SpecimenData>> getSpecimenListByTaxonGroup(
      String taxonGroup) async {
    List<SpecimenData> specimenList = await getSpecimenList();
    List<SpecimenData> filteredList = specimenList
        .where((element) => element.taxonGroup == taxonGroup)
        .toList();
    return filteredList;
  }

  Future<List<int?>> getAllSpecies(String uuid) {
    return SpecimenQuery(dbAccess).getAllSpecies(uuid);
  }

  Future<TaxonomyData> getTaxonById(int id) {
    return TaxonomyQuery(dbAccess).getTaxonById(id);
  }

  Future<TaxonomyData> getTaxonIdByGenusEpithet(
      String genus, String epithet) async {
    return TaxonomyQuery(dbAccess).getTaxonIdByGenusEpithet(genus, epithet);
  }

  Future<int> getSpecimenFieldNumber(
    String personnelUuid,
  ) async {
    int? fieldNumber = await PersonnelQuery(dbAccess)
        .getCurrentFieldNumberByUuid(personnelUuid);
    return _getCurrentFieldNumber(fieldNumber);
  }

  Future<String?> getLastEnteredTissueID(String specimenUuid) async {
    return SpecimenPartQuery(dbAccess).getLastEnteredTissueID(specimenUuid);
  }

  int _getCurrentFieldNumber(int? currentFieldNum) {
    if (currentFieldNum == null) {
      return 0;
    } else {
      return currentFieldNum;
    }
  }

  void _createMammalSpecimen(String specimenUuid) {
    MammalSpecimenQuery(dbAccess).createMammalMeasurements(
        MammalMeasurementCompanion(specimenUuid: db.Value(specimenUuid)));
  }

  Future<MammalMeasurementData> getMammalMeasurementData(String specimenUuid) {
    return MammalSpecimenQuery(dbAccess)
        .getMammalMeasurementByUuid(specimenUuid);
  }

  void updateMammalMeasurement(
      String specimenUuid, MammalMeasurementCompanion entries) {
    MammalSpecimenQuery(dbAccess)
        .updateMammalMeasurements(specimenUuid, entries);
  }

  void _createBirdSpecimen(String specimenUuid) {
    AvianSpecimenQuery(dbAccess).createAvianMeasurements(
        AvianMeasurementCompanion(specimenUuid: db.Value(specimenUuid)));
  }

  Future<void> updateSpecimen(String uuid, SpecimenCompanion entries) async {
    try {
      await SpecimenQuery(dbAccess).updateSpecimenEntry(uuid, entries);
    } catch (_) {
      await dbAccess.addColumnToTable('specimen', 'collectedTime');
      await SpecimenQuery(dbAccess).updateSpecimenEntry(uuid, entries);
    }
    _invalidateSpecimenList();
  }

  Future<AvianMeasurementData> getAvianMeasurementData(String specimenUuid) {
    return AvianSpecimenQuery(dbAccess).getAvianMeasurementByUuid(specimenUuid);
  }

  void updateAvianMeasurement(
      String specimenUuid, AvianMeasurementCompanion entries) {
    AvianSpecimenQuery(dbAccess).updateAvianMeasurements(specimenUuid, entries);
  }

  Future<void> deleteAvianMeasurements(String specimenUuid) async {
    await AvianSpecimenQuery(dbAccess).deleteAvianMeasurements(specimenUuid);
  }

  Future<void> deleteMammalMeasurements(String specimenUuid) async {
    await MammalSpecimenQuery(dbAccess).deleteMammalMeasurements(specimenUuid);
  }

  Future<void> deleteSpecimen(
      String specimenUuid, CatalogFmt catalogFmt) async {
    await SpecimenQuery(dbAccess).deleteSpecimen(specimenUuid);
    await deleteAllSpecimenParts(specimenUuid);
    switch (catalogFmt) {
      case CatalogFmt.birds:
        await deleteAvianMeasurements(specimenUuid);
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
    await SpecimenQuery(dbAccess).deleteAllSpecimens(projectUuid);
    _invalidateSpecimenList();
  }

  Future<void> deleteAllSpecimenParts(String specimenUuid) async {
    await SpecimenPartQuery(dbAccess).deleteAllSpecimenParts(specimenUuid);
  }

  void deleteSpecimenPart(int partId) {
    SpecimenPartQuery(dbAccess).deleteSpecimenPart(partId);
    ref.invalidate(partBySpecimenProvider);
  }

  void _invalidateSpecimenList() {
    ref.invalidate(specimenEntryProvider);
    ref.invalidate(taxonDataProvider);
    ref.invalidate(personnelListProvider);
  }
}

class TissueIdServices {
  const TissueIdServices(this.ref);
  final WidgetRef ref;

  Future<String> getNewNumber() async {
    TissueID tissueID = await _getTissueID();
    String prefix = tissueID.prefix;
    int number = tissueID.number;
    ref.read(tissueIDNotifierProvider.notifier).incrementNumber();
    return '$prefix$number';
  }

  Future<String?> repeatNumber(String specimenUuid) async {
    return await SpecimenServices(ref).getLastEnteredTissueID(specimenUuid);
  }

  Future<String> setTissueID(String prefix, String number) async {
    await setPrefix(prefix);
    await setNumber(number);
    return '$prefix$number';
  }

  Future<void> setPrefix(String prefix) async {
    ref.read(tissueIDNotifierProvider.notifier).setPrefix(prefix);
  }

  Future<void> setNumber(String number) async {
    ref
        .read(tissueIDNotifierProvider.notifier)
        .setNumber(int.tryParse(number) ?? 0);
  }

  Future<TissueID> _getTissueID() async {
    return ref.read(tissueIDNotifierProvider.future);
  }
}

class SpecimenPartServices extends DbAccess {
  SpecimenPartServices(super.ref);

  Future<void> createSpecimenPart(SpecimenPartCompanion form) async {
    SpecimenPartQuery(dbAccess).createSpecimenPart(form);
    ref.invalidate(partBySpecimenProvider);
  }

  Future<List<SpecimenPartData>> getSpecimenParts(String specimenUuid) {
    return SpecimenPartQuery(dbAccess).getSpecimenParts(specimenUuid);
  }

  Future<void> updateSpecimenPart(
      int partId, SpecimenPartCompanion form) async {
    SpecimenPartQuery(dbAccess).updateSpecimenPart(partId, form);
    ref.invalidate(partBySpecimenProvider);
  }

  Future<void> getSpecimenTypes() async {
    final List<String> typeList =
        await SpecimenPartQuery(dbAccess).getDistinctTypes();
    final notifier = ref.read(specimenTypesProvider.notifier);
    List<String> finalList = typeList.isEmpty ? defaultSpecimenType : typeList;
    notifier.replaceAll(finalList);
    _invalidateTypes();
  }

  Future<void> getTreatmentOptions() async {
    final List<String> treatmentList =
        await SpecimenPartQuery(dbAccess).getDistinctTreatments();
    final notifier = ref.read(treatmentOptionsProvider.notifier);
    List<String> finalList =
        treatmentList.isEmpty ? defaultSpecimenTreatment : treatmentList;
    notifier.replaceAll(finalList);
    _invalidateTreatmentOptions();
  }

  Future<void> addType(String part) async {
    await ref.read(specimenTypesProvider.notifier).add(part);
    _invalidateTypes();
  }

  Future<void> removeType(String specimenType) async {
    ref.read(specimenTypesProvider.notifier).remove(specimenType);
    _invalidateTypes();
  }

  Future<void> clearTypes() async {
    ref.read(specimenTypesProvider.notifier).clear();
    _invalidateTypes();
  }

  Future<void> addTreatment(String treatment) async {
    await ref.read(treatmentOptionsProvider.notifier).add(treatment);
    _invalidateTreatmentOptions();
  }

  Future<void> removeTreatment(String treatment) async {
    ref.read(treatmentOptionsProvider.notifier).remove(treatment);
    _invalidateTreatmentOptions();
  }

  Future<void> clearTreatments() async {
    ref.read(treatmentOptionsProvider.notifier).clear();
    _invalidateTreatmentOptions();
  }

  void _invalidateTreatmentOptions() {
    ref.invalidate(treatmentOptionsProvider);
  }

  void _invalidateTypes() {
    ref.invalidate(specimenTypesProvider);
  }
}
