import 'dart:collection';
import 'dart:io';

import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/export/media_writer.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/types/export.dart';

class ReportServices extends DbAccess {
  const ReportServices({required super.ref});

  Future<void> writeReport(File savePath, ReportType reportType) async {
    switch (reportType) {
      case ReportType.speciesCount:
        await SpeciesListWriter(ref: ref).writeSpeciesListCompact(savePath);
        break;
      case ReportType.mediaData:
        await MediaWriterServices(ref: ref)
            .writeAllMediaDelimited(savePath, true);
        break;
      case ReportType.all:
        await SpeciesListWriter(ref: ref).writeSpeciesListCompact(savePath);
        await MediaWriterServices(ref: ref)
            .writeAllMediaDelimited(savePath, true);
        break;
      default:
        await SpeciesListWriter(ref: ref).writeSpeciesListCompact(savePath);
        break;
    }
  }
}

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
    final speciesList = await SpecimenServices(ref: ref).getAllSpecies();
    return speciesList;
  }

  Future<String> getSpeciesName(int speciesID) async {
    TaxonomyData taxonData =
        await SpecimenServices(ref: ref).getTaxonById(speciesID);
    return '${taxonData.genus} ${taxonData.specificEpithet}';
  }
}
