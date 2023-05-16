import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/taxonomy_services.dart';

class CaptureRecordStats {
  CaptureRecordStats(
    this.orderCount,
    this.familyCount,
    this.speciesCount,
    this.specimenCount,
  );

  SplayTreeMap<String, int> orderCount;
  SplayTreeMap<String, int> familyCount;
  SplayTreeMap<String, int> speciesCount;
  int specimenCount;

  Future<void> count(WidgetRef ref) async {
    List<SpecimenData> specimenList =
        await SpecimenServices(ref).getSpecimenList();
    specimenCount = specimenList.length;
    for (var specimen in specimenList) {
      _countTaxa(specimen.speciesID, ref);
    }
  }

  factory CaptureRecordStats.empty() {
    return CaptureRecordStats(
      SplayTreeMap(),
      SplayTreeMap(),
      SplayTreeMap(),
      0,
    );
  }

  factory CaptureRecordStats.fromData(
      List<SpecimenData> specimenList, WidgetRef ref) {
    CaptureRecordStats stats = CaptureRecordStats.empty();
    stats.specimenCount = specimenList.length;
    for (var specimen in specimenList) {
      stats._countTaxa(specimen.speciesID, ref);
    }
    return stats;
  }

  Future<void> _countTaxa(int? speciesID, WidgetRef ref) async {
    if (speciesID != null) {
      TaxonomyData data = await TaxonomyService(ref).getTaxonById(speciesID);
      _countSpecies(getSpeciesName(data));
      _countFamily(data.taxonFamily ?? '');
      _countOrder(data.taxonOrder ?? '');
    }
  }

  void _countSpecies(String species) {
    if (!speciesCount.containsKey(species)) {
      speciesCount[species] = 1;
    } else {
      speciesCount[species] = speciesCount[species]! + 1;
    }
  }

  void _countFamily(String family) {
    if (!familyCount.containsKey(family)) {
      familyCount[family] = 1;
    } else {
      familyCount[family] = familyCount[family]! + 1;
    }
  }

  void _countOrder(String order) {
    if (!orderCount.containsKey(order)) {
      orderCount[order] = 1;
    } else {
      orderCount[order] = orderCount[order]! + 1;
    }
  }
}
