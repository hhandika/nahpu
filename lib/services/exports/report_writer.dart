import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/exports/common.dart';

class SpeciesListWriter {
  SpeciesListWriter(this.ref);

  final WidgetRef ref;

  Future<void> writeSpeciesList(String filePath) async {
    List<SpecimenData> specimenList =
        await SpecimenServices(ref).getSpecimenList();

    File file = File(filePath);
    IOSink writer = file.openWrite();
    for (var element in specimenList) {
      String line = '${element.collec}';
      writer.write('$line$endLine');
    }

    writer.close();
  }

  Future<String> _getSpeciesName(String speciesUuid) async {
    SpecimenData speciesName =
        await SpecimenQuery(ref).getSpecimenByUuid(speciesUuid);

    return speciesName;
  }
}
