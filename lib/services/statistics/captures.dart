import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/statistics/common.dart';
import 'package:nahpu/services/taxonomy_services.dart';

class CaptureRecordStats {
  CaptureRecordStats({
    required this.ref,
  });

  final WidgetRef ref;

  Future<({int specimenCount, int speciesCount, int familyCount})>
      countAll() async {
    List<SpecimenData> specimenList = await _getSpecimenData();
    int specimenCount = specimenList.length;
    Map<String, int> speciesCount = await _countSpecies(specimenList);
    Map<String, int> familyCount = await _countFamily(specimenList);
    specimenList.clear();
    return (
      specimenCount: specimenCount,
      speciesCount: speciesCount.length,
      familyCount: familyCount.length
    );
  }

  Future<DataPoints> getSpeciesDataPoint() async {
    List<SpecimenData> specimenList = await _getSpecimenData();
    Map<String, int> speciesCount = await _countSpecies(specimenList);
    specimenList.clear();
    // sort speciesCount by value
    speciesCount = _sortMap(speciesCount);

    return DataPoints.fromData(speciesCount);
  }

  Future<DataPoints> getFamilyDataPoint() async {
    List<SpecimenData> specimenList = await _getSpecimenData();
    Map<String, int> familyCount = await _countFamily(specimenList);
    specimenList.clear();
    // sort familyCount by value
    familyCount = _sortMap(familyCount);
    return DataPoints.fromData(familyCount);
  }

  Future<DataPoints> getSpeciesPerSiteDataPoint(int? siteID) async {
    if (siteID == null) {
      return DataPoints.empty();
    }
    List<SpecimenData> specimenPerSite =
        await SpecimenServices(ref: ref).getSpecimenPerSite(siteID);
    Map<String, int> speciesCount = await _countSpecies(specimenPerSite);
    specimenPerSite.clear();
    // sort speciesCount by value
    speciesCount = _sortMap(speciesCount);
    return DataPoints.fromData(speciesCount);
  }

  Future<DataPoints> getSpecimenPartDataPoint() async {
    final specimenList = await _getSpecimenData();
    SplayTreeMap<String, int> partCount =
        await _countSpecimenPart(specimenList);
    // sort partCount by value
    return DataPoints.fromData(partCount);
  }

  Future<DataPoints> getPartPerSpeciesDataPoint(int? taxonID) async {
    if (taxonID == null) {
      return DataPoints.empty();
    }
    TaxonomyData data = await _getTaxonData(taxonID);
    final specimenList = await _getSpecimenData();
    List<SpecimenData> specimenPerTaxon = specimenList
        .where((element) => element.speciesID == data.id)
        .toList(growable: false);
    SplayTreeMap<String, int> partCount =
        await _countSpecimenPart(specimenPerTaxon);
    // sort partCount by value
    return DataPoints.fromData(partCount);
  }

  Map<String, int> _sortMap(Map<String, int> map) {
    return Map.fromEntries(
        map.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
  }

  Future<Map<String, int>> _countSpecies(
      List<SpecimenData> specimenList) async {
    Map<String, int> speciesCount = {};

    for (var specimen in specimenList) {
      if (specimen.speciesID != null) {
        TaxonomyData data = await _getTaxonData(specimen.speciesID!);
        String speciesName = getSpeciesName(data);
        _count(speciesCount, speciesName);
      }
    }

    return speciesCount;
  }

  Future<Map<String, int>> _countFamily(List<SpecimenData> specimenList) async {
    Map<String, int> familyCount = {};

    for (var specimen in specimenList) {
      if (specimen.speciesID != null) {
        TaxonomyData data = await _getTaxonData(specimen.speciesID!);
        if (data.taxonFamily != null) {
          _count(familyCount, data.taxonFamily!);
        }
      }
    }
    return familyCount;
  }

  Future<List<SpecimenData>> _getSpecimenData() async {
    return await SpecimenServices(ref: ref).getSpecimenList();
  }

  Future<TaxonomyData> _getTaxonData(int speciesID) async {
    return await TaxonomyServices(ref: ref).getTaxonById(speciesID);
  }

  Future<SplayTreeMap<String, int>> _countSpecimenPart(
      List<SpecimenData> specimenList) async {
    SplayTreeMap<String, int> partCount = SplayTreeMap();

    for (var specimen in specimenList) {
      final partList =
          await SpecimenPartServices(ref: ref).getSpecimenParts(specimen.uuid);
      for (var part in partList) {
        String treatment = part.treatment == null ||
                part.treatment!.toLowerCase() == 'none' ||
                part.treatment!.isEmpty
            ? '-None'
            : '-${part.treatment}';
        String partAndTreatment = "${part.type ?? ''}$treatment";
        _count(partCount, partAndTreatment);
      }
    }

    return partCount;
  }

  void _count(Map<String, int> data, String record) {
    if (!data.containsKey(record)) {
      data[record] = 1;
    } else {
      data[record] = data[record]! + 1;
    }
  }
}
