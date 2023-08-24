import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/providers/taxa.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/media_queries.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';
import 'package:nahpu/services/import/multimedia.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/types/specimens.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/personnel_queries.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/project_services.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String tissueIDPrefixKey = 'tissueIDPrefix';
const String tissueIDNumberKey = 'tissueIDNumber';

class SpecimenServices extends DbAccess {
  const SpecimenServices({required super.ref});

  Future<String> createSpecimen() async {
    CatalogFmt catalogFmt = await ref.watch(catalogFmtNotifierProvider.future);
    final String specimenUuid = uuid;
    await SpecimenQuery(dbAccess).createSpecimen(SpecimenCompanion(
      uuid: db.Value(specimenUuid),
      projectUuid: db.Value(currentProjectUuid),
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
    invalidateSpecimenList();
    return specimenUuid;
  }

  String getIconPath() {
    return ref.watch(catalogFmtNotifierProvider).when(
          data: (fmt) {
            switch (fmt) {
              case CatalogFmt.generalMammals:
                return 'assets/icons/mouse.svg';
              case CatalogFmt.bats:
                return 'assets/icons/bat.svg';
              case CatalogFmt.birds:
                return 'assets/icons/bird.svg';
              default:
                return 'assets/icons/mouse.svg';
            }
          },
          loading: () => 'assets/icons/mouse.svg',
          error: (error, stack) => 'assets/icons/mouse.svg',
        );
  }

  Future<void> createSpecimenDuplicatePart(String specimenUuid) async {
    List<SpecimenPartData> partData =
        await SpecimenPartQuery(dbAccess).getSpecimenParts(specimenUuid);
    if (partData.isEmpty) {
      return;
    }
    String newSpecimenUuid = await createSpecimen();

    for (var part in partData) {
      SpecimenPartServices(ref: ref).createSpecimenPart(SpecimenPartCompanion(
        specimenUuid: db.Value(newSpecimenUuid),
        type: db.Value(part.type),
        count: db.Value(part.count),
        treatment: db.Value(part.treatment),
        additionalTreatment: db.Value(part.additionalTreatment),
        museumPermanent: db.Value(part.museumPermanent),
        museumLoan: db.Value(part.museumLoan),
      ));
    }

    ref.invalidate(partBySpecimenProvider);
  }

  Future<List<SpecimenData>> getAllSpecimens() async {
    return SpecimenQuery(dbAccess).getAllSpecimens(currentProjectUuid);
  }

  Future<List<String>> getAllSpecimenUuids() async {
    return SpecimenQuery(dbAccess).getAllSpecimenUuids(currentProjectUuid);
  }

  Future<SpecimenData> getSpecimen(String specimenUuid) async {
    return SpecimenQuery(dbAccess).getSpecimenByUuid(specimenUuid);
  }

  Future<List<String>> getRecordedGroupList() async {
    return SpecimenQuery(dbAccess).getUniqueTaxonGroup(currentProjectUuid);
  }

  Future<void> createSpecimenMediaFromList(
    String specimenUuid,
    List<String> filePaths,
  ) async {
    for (String filePath in filePaths) {
      await createSpecimenMedia(specimenUuid, filePath);
    }
  }

  Future<void> createSpecimenMedia(
    String specimenUuid,
    String filePath,
  ) async {
    ExifData exifData = ExifData.empty();
    await exifData.readExif(File(filePath));
    int mediaId = await MediaDbQuery(dbAccess).createMedia(MediaCompanion(
      projectUuid: db.Value(currentProjectUuid),
      fileName: db.Value(basename(filePath)),
      category: db.Value(matchMediaCategory(MediaCategory.specimen)),
      taken: db.Value(exifData.dateTaken),
      camera: db.Value(exifData.camera),
      lenses: db.Value(exifData.lenseModel),
      additionalExif: db.Value(exifData.additionalExif),
    ));
    SpecimenMediaCompanion entries = SpecimenMediaCompanion(
      specimenUuid: db.Value(specimenUuid),
      mediaId: db.Value(mediaId),
    );
    await SpecimenQuery(dbAccess).createSpecimenMedia(entries);
    ref.invalidate(specimenMediaProvider);
  }

  Future<SpecimenMediaData> getSpecimenMediaByMediaId(int mediaId) async {
    return await SpecimenQuery(dbAccess).getSpecimenMediaByMediaId(mediaId);
  }

  Future<List<SpecimenData>> getMammalSpecimens() async {
    return SpecimenQuery(dbAccess).getAllMammalSpecimens(currentProjectUuid);
  }

  Future<List<SpecimenData>> getBirdSpecimens() async {
    return SpecimenQuery(dbAccess).getAllAvianSpecimens(currentProjectUuid);
  }

  Future<List<SpecimenData>> getBatSpecimens() async {
    return SpecimenQuery(dbAccess).getAllBatSpecimens(currentProjectUuid);
  }

  Future<List<SpecimenData>> getSpecimenList() async {
    return SpecimenQuery(dbAccess).getAllSpecimens(currentProjectUuid);
  }

  Future<List<SpecimenData>> getSpecimenPerSite(int siteID) async {
    List<int> eventID =
        await CollEventServices(ref: ref).getEventPerSite(siteID);
    List<SpecimenData> allSpecimens = [];
    for (var id in eventID) {
      List<SpecimenData> specimenList =
          await SpecimenQuery(dbAccess).getSpecimenPerEvent(id);
      allSpecimens.addAll(specimenList);
    }
    return allSpecimens;
  }

  Future<List<SpecimenData>> getSpecimenListByTaxonGroup(
      String taxonGroup) async {
    List<SpecimenData> specimenList = await getSpecimenList();
    List<SpecimenData> filteredList = specimenList
        .where((element) => element.taxonGroup == taxonGroup)
        .toList();
    return filteredList;
  }

  Future<List<SpecimenData>> getSpecimenListForAllMammals() async {
    List<SpecimenData> specimenList = await getSpecimenList();
    List<SpecimenData> filteredList = specimenList
        .where((element) =>
            element.taxonGroup == 'General Mammals' ||
            element.taxonGroup == 'Bats')
        .toList();
    return filteredList;
  }

  Future<List<int?>> getAllSpecies(String uuid) {
    return SpecimenQuery(dbAccess).getAllSpecies(uuid);
  }

  Future<TaxonomyData> getTaxonById(int id) {
    return TaxonomyQuery(dbAccess).getTaxonById(id);
  }

  Future<int> getSpecimenFieldNumber(
    String personnelUuid,
  ) async {
    int? fieldNumber = await PersonnelQuery(dbAccess)
        .getCurrentFieldNumberByUuid(personnelUuid);
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

  Future<void> updateSpecimenSkipInvalidation(
      String uuid, SpecimenCompanion entries) async {
    await _updateSpecimen(uuid, entries);
  }

  Future<void> updateSpecimen(String uuid, SpecimenCompanion entries) async {
    _updateSpecimen(uuid, entries);
    invalidateSpecimenList();
  }

  Future<void> _updateSpecimen(String uuid, SpecimenCompanion entries) async {
    try {
      await SpecimenQuery(dbAccess).updateSpecimenEntry(uuid, entries);
    } catch (_) {
      rethrow;
    }
  }

  Future<AvianMeasurementData> getAvianMeasurementData(String specimenUuid) {
    return AvianSpecimenQuery(dbAccess).getAvianMeasurementByUuid(specimenUuid);
  }

  Future<List<SpecimenMediaData>> getSpecimenMedia(String specimenUuid) async {
    return await SpecimenQuery(dbAccess).getSpecimenMedia(specimenUuid);
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
    await SpecimenQuery(dbAccess).deleteAllSpecimenMedias(specimenUuid);
    await SpecimenQuery(dbAccess).deleteSpecimen(specimenUuid);
    invalidateSpecimenList();
  }

  Future<void> deleteAllSpecimens() async {
    List<SpecimenData> specimenList = await getSpecimenList();
    for (var specimen in specimenList) {
      await deleteAllSpecimenParts(specimen.uuid);
      await SpecimenQuery(dbAccess).deleteAllSpecimenMedias(specimen.uuid);
      CatalogFmt catalogFmt = matchTaxonGroupToCatFmt(specimen.taxonGroup);
      switch (catalogFmt) {
        case CatalogFmt.birds:
          await deleteAvianMeasurements(specimen.uuid);
          break;
        case CatalogFmt.bats:
          await deleteMammalMeasurements(specimen.uuid);
          break;
        case CatalogFmt.generalMammals:
          await deleteMammalMeasurements(specimen.uuid);
          break;
      }
    }
    await SpecimenQuery(dbAccess).deleteAllSpecimens(currentProjectUuid);
    invalidateSpecimenList();
  }

  Future<void> deleteAllSpecimenParts(String specimenUuid) async {
    await SpecimenPartQuery(dbAccess).deleteAllSpecimenParts(specimenUuid);
  }

  void deleteSpecimenPart(int partId) {
    SpecimenPartQuery(dbAccess).deleteSpecimenPart(partId);
    ref.invalidate(partBySpecimenProvider);
  }

  void invalidateSpecimenList() {
    ref.invalidate(specimenEntryProvider);
    ref.invalidate(taxonDataProvider);
    ref.invalidate(projectPersonnelProvider);
  }
}

class SpecimenSearchServices {
  SpecimenSearchServices({
    required this.db,
    required this.specimenEntries,
    required this.searchOption,
  });

  final List<SpecimenData> specimenEntries;
  final Database db;
  final SpecimenSearchOption searchOption;

  Future<List<SpecimenData>> search(String query) async {
    switch (searchOption) {
      case SpecimenSearchOption.all:
        return await searchAll(query);
      case SpecimenSearchOption.fieldNumber:
        return specimenEntries
            .where((element) => _isMatchFieldNum(
                  element.fieldNumber,
                  query,
                ))
            .toList();
      case SpecimenSearchOption.cataloger:
        List<String> matchedPersons = await _searchPersonnel(query);
        return specimenEntries
            .where((element) => _isMatchedPerson(
                  matchedPersons,
                  element.catalogerID,
                ))
            .toList();
      case SpecimenSearchOption.preparator:
        List<String> matchedPersons = await _searchPersonnel(query);
        return specimenEntries
            .where((element) => _isMatchedPerson(
                  matchedPersons,
                  element.preparatorID,
                ))
            .toList();
      case SpecimenSearchOption.collector:
        List<String> matchedPersons = await _searchPersonnel(query);
        List<int> matchedColPersons =
            await _searchColPersonnel(matchedPersons, query);
        return specimenEntries
            .where((element) => _isMatchedColPerson(
                  matchedColPersons,
                  element.collPersonnelID,
                ))
            .toList();
      case SpecimenSearchOption.condition:
        return specimenEntries
            .where((element) => element.condition.isContain(query))
            .toList();
      case SpecimenSearchOption.prepDate:
        return specimenEntries
            .where((element) => element.prepDate.isContain(query))
            .toList();
      case SpecimenSearchOption.prepTime:
        return specimenEntries
            .where((element) => element.prepTime.isContain(query))
            .toList();
      case SpecimenSearchOption.taxa:
        List<int> matchedTaxa = await _searchTaxa(query);
        return specimenEntries
            .where((element) => _isMatchTaxa(
                  matchedTaxa,
                  element.speciesID,
                ))
            .toList();
      case SpecimenSearchOption.prepType:
        List<String> matchedPrepType = await _searchPrepType(query);
        return specimenEntries
            .where((element) => _isMatchPrepType(
                  matchedPrepType,
                  element.uuid,
                ))
            .toList();
    }
  }

  Future<List<SpecimenData>> searchAll(String query) async {
    List<String> matchedPersons = await _searchPersonnel(query);
    List<int> matchedColPersons =
        await _searchColPersonnel(matchedPersons, query);
    List<String> matchedPrepType = await _searchPrepType(query);
    List<int> matchedTaxa = await _searchTaxa(query);
    List<SpecimenData> filteredList = specimenEntries
        .where(
          (e) =>
              _isMatchFieldNum(e.fieldNumber, query) ||
              _isMatchedPerson(matchedPersons, e.catalogerID) ||
              _isMatchedPerson(matchedPersons, e.preparatorID) ||
              _isMatchedColPerson(matchedColPersons, e.collPersonnelID) ||
              e.condition.isContain(query) ||
              e.prepDate.isContain(query) ||
              e.prepTime.isContain(query) ||
              _isMatchTaxa(matchedTaxa, e.speciesID) ||
              _isMatchPrepType(matchedPrepType, e.uuid),
        )
        .toList();
    return filteredList;
  }

  bool _isMatchFieldNum(int? fieldNum, String query) {
    return fieldNum.toString().isContain(query);
  }

  bool _isMatchedPerson(List<String> matchedPersons, String? personnelUuid) {
    if (matchedPersons.isEmpty || personnelUuid == null) {
      return false;
    }
    return matchedPersons.contains(personnelUuid);
  }

  bool _isMatchedColPerson(List<int> matchedColPersons, int? colPersonId) {
    if (matchedColPersons.isEmpty || colPersonId == null) {
      return false;
    }
    return matchedColPersons.contains(colPersonId);
  }

  bool _isMatchPrepType(List<String> matchedPrepType, String specimenUuid) {
    if (matchedPrepType.isEmpty) {
      return false;
    }
    return matchedPrepType.contains(specimenUuid);
  }

  bool _isMatchTaxa(List<int> matchedSpecies, int? speciesId) {
    if (matchedSpecies.isEmpty || speciesId == null) {
      return false;
    }
    return matchedSpecies.contains(speciesId);
  }

  Future<List<String>> _searchPersonnel(String query) async {
    final person = await PersonnelQuery(db).searchPersonnel(query);
    return person.map((e) => e.uuid).toList();
  }

  Future<List<int>> _searchTaxa(String query) async {
    final listSpecies = await TaxonomyQuery(db).searchTaxon(query);
    return listSpecies.map((e) => e.id).toList();
  }

  Future<List<String>> _searchPrepType(String query) async {
    final prepType = await SpecimenPartQuery(db).searchPrepType(query);
    return prepType;
  }

  Future<List<int>> _searchColPersonnel(
      List<String> matchedPersons, String query) async {
    if (matchedPersons.isEmpty) {
      return [];
    }
    final person = await CollPersonnelQuery(db)
        .searchCollectingPersonnel(matchedPersons, query);
    return person.map((e) => e.id).toList();
  }
}

class TissueIdServices extends DbAccess {
  const TissueIdServices({required super.ref});

  SharedPreferences get _prefs => ref.read(settingProvider);

  Future<String> getNewNumber() async {
    String prefix = getPrefix();
    int? number = _getSettingNumber();
    String numberString = getNumberString();
    await incrementNumber(number ?? 0);
    return '$prefix$numberString';
  }

  String getPrefix() {
    return _geSettingPrefix() ?? '';
  }

  String getNumberString() {
    return _getSettingNumber() == null ? '' : _getSettingNumber().toString();
  }

  Future<String?> repeatNumber(String specimenUuid) async {
    return SpecimenPartQuery(dbAccess).getLastEnteredTissueID(specimenUuid);
  }

  Future<String> setTissueID(String prefix, String number) async {
    await setPrefix(prefix);
    await setNumber(number);
    return '$prefix$number';
  }

  Future<void> incrementNumber(int number) async {
    await setNumber((number + 1).toString());
  }

  Future<void> setPrefix(String prefix) async {
    await _prefs.setString(tissueIDPrefixKey, prefix);
  }

  Future<void> setNumber(String number) async {
    await _prefs.setInt(tissueIDNumberKey, int.tryParse(number) ?? 0);
  }

  String? _geSettingPrefix() {
    return _prefs.getString(tissueIDPrefixKey);
  }

  int? _getSettingNumber() {
    return _prefs.getInt(tissueIDNumberKey);
  }
}

class SpecimenPartServices extends DbAccess {
  const SpecimenPartServices({required super.ref});

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

const String collectorFieldKey = 'isCollectorFieldAlwaysShown';

class SpecimenSettingServices {
  SpecimenSettingServices({required this.ref});

  final WidgetRef ref;

  SharedPreferences get _prefs => ref.read(settingProvider);

  Future<void> setCollectorFieldAlwaysShown(bool value) async {
    await _prefs.setBool(collectorFieldKey, value);
  }

  bool isCollectorFieldAlwaysShown() {
    return _prefs.getBool(collectorFieldKey) ?? false;
  }
}

class AssociatedDataServices extends DbAccess {
  const AssociatedDataServices({required super.ref});

  Future<List<AssociatedDataData>> getAssociatedData(
      String specimenUuid) async {
    return await AssociatedDataQuery(dbAccess)
        .getAllAssociatedData(specimenUuid);
  }

  Future<void> createAssociatedData(AssociatedDataCompanion form) async {
    await AssociatedDataQuery(dbAccess).createSpecimenDataAssociation(form);
    _invalidateData();
  }

  Future<void> updateAssociatedData(
      int associatedDataId, AssociatedDataCompanion form) async {
    await AssociatedDataQuery(dbAccess)
        .updateAssociatedData(associatedDataId, form);
    _invalidateData();
  }

  Future<bool> isFileUsed(File file) async {
    return await AssociatedDataQuery(dbAccess).isFileUsed(
      basename(file.path),
    );
  }

  Future<void> deleteAssociatedData(int associatedDataId) async {
    await AssociatedDataQuery(dbAccess).deleteAssociatedData(associatedDataId);
    _invalidateData();
  }

  void _invalidateData() {
    ref.invalidate(associatedDataProvider);
  }
}
