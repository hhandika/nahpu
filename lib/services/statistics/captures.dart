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

  Future<List<DataPoint>> getSpeciesDataPoint() async {
    List<SpecimenData> specimenList = await _getSpecimenData();
    Map<String, int> speciesCount = await _countSpecies(specimenList);
    specimenList.clear();
    // sort speciesCount by value
    speciesCount = _sortMap(speciesCount);

    return createDataPoints(speciesCount);
  }

  Map<String, int> _sortMap(Map<String, int> map) {
    return Map.fromEntries(
        map.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
  }

  Future<List<DataPoint>> getFamilyDataPoint() async {
    List<SpecimenData> specimenList = await _getSpecimenData();
    Map<String, int> familyCount = await _countFamily(specimenList);
    specimenList.clear();
    // sort familyCount by value
    familyCount = _sortMap(familyCount);
    return createDataPoints(familyCount);
  }

  Future<List<DataPoint>> getSpeciesPerSiteDataPoint(int? siteID) async {
    if (siteID == null) {
      return [];
    }
    List<SpecimenData> specimenPerSite =
        await SpecimenServices(ref: ref).getSpecimenPerSite(siteID);
    Map<String, int> speciesCount = await _countSpecies(specimenPerSite);
    specimenPerSite.clear();
    // sort speciesCount by value
    speciesCount = _sortMap(speciesCount);
    return createDataPoints(speciesCount);
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

  void _count(Map<String, int> data, String record) {
    if (!data.containsKey(record)) {
      data[record] = 1;
    } else {
      data[record] = data[record]! + 1;
    }
  }
}
