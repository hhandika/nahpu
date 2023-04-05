import 'dart:collection';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';
import 'package:nahpu/services/writer/common.dart';

class SpeciesListWriter {
  SpeciesListWriter(this.ref);

  final WidgetRef ref;

  Future<void> writeSpeciesListCompact(String filePath) async {
    final speciesListMap = await countSpeciesList();

    File file = File(filePath);
    IOSink writer = file.openWrite();
    String header = 'Species,Count';
    writer.write('$header$endLine');
    for (var element in speciesListMap.entries) {
      String line = '${element.key},${element.value}';
      writer.write('$line$endLine');
    }
  }

  Future<Map<String, int>> countSpeciesList() async {
    final speciesList = await getSpeciesList();
    SplayTreeMap<String, int> speciesListMap = SplayTreeMap();
    for (var speciesID in speciesList) {
      if (speciesID != null) {
        String species = await getSpeciesName(speciesID);
        speciesListMap[species] = (speciesListMap[species] ?? 0) + 1;
      }
    }
    return speciesListMap;
  }

  Future<List<int?>> getSpeciesList() async {
    final projectUuid = ref.read(projectUuidProvider);
    final db = ref.read(databaseProvider);
    final speciesList = await SpecimenQuery(db).getAllSpecies(projectUuid);
    return speciesList;
  }

  Future<String> getSpeciesName(int speciesID) async {
    TaxonomyData taxonData =
        await TaxonomyQuery(ref.read(databaseProvider)).getTaxonById(speciesID);
    return '${taxonData.genus} ${taxonData.specificEpithet}';
  }
}
