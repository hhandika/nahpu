import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';

const String endLine = '\n';

class CsvWriter {
  CsvWriter(this.ref);

  final WidgetRef ref;

  Future<void> writeCsv(String filePath) async {
    List<SpecimenData> specimenList =
        await SpecimenServices(ref).getSpecimenList();

    File file = File(filePath);
    IOSink writer = file.openWrite();
    for (var element in specimenList) {
      // CollEventData? collEventData =
      //     await CollEventServices(ref).getCollEvent(element.collEventID);
      // SiteData? siteData =
      //     await SiteServices(ref).getSite(collEventData.siteID);
      String line = writeLine(element);

      writer.write('$line$endLine');
    }
    writer.close();
  }

  String writeLine(SpecimenData specimenData) {
    String collectingRecord =
        '${specimenData.projectUuid},${specimenData.catalogerID},${specimenData.fieldNumber}';
    String measurement =
        '${specimenData.speciesID},${specimenData.captureDate}';
    String line = '$collectingRecord,$measurement';
    return line;
  }
}
