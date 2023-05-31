import 'dart:collection';
import 'dart:io';

import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/specimen_services.dart';

class SpeciesListWriter extends DbAccess {
  const SpeciesListWriter({required super.ref});

  Future<void> writeSpeciesListCompact(File filePath) async {
    final speciesListMap = await countSpeciesList();

    IOSink writer = filePath.openWrite();
    String header = 'Species,Count';
    writer.writeln(header);
    for (var element in speciesListMap.entries) {
      String line = '${element.key},${element.value}';
      writer.writeln(line);
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
    final speciesList =
        await SpecimenServices(ref: ref).getAllSpecies(projectUuid);
    return speciesList;
  }

  Future<String> getSpeciesName(int speciesID) async {
    TaxonomyData taxonData =
        await SpecimenServices(ref: ref).getTaxonById(speciesID);
    return '${taxonData.genus} ${taxonData.specificEpithet}';
  }
}
