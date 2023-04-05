import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/writer/records.dart';

class CsvWriter {
  CsvWriter(this.ref);

  final WidgetRef ref;

  Future<void> writeCsv(String filePath) async {
    SpecimenRecordWriter(ref).writeSpeciesList(filePath);
    // List<SpecimenData> specimenList =
    //     await SpecimenServices(ref).getSpecimenList();

    // File file = File(filePath);
    // IOSink writer = file.openWrite();
    // // for (var element in specimenList) {
    // //   String siteRecords = ',,,'
    // //       ',,,'
    // //       ',,,'
    // //       ',';
    // //   String collRecords = writeCollectingRecords(element);
    // //   CollEventData? collEventData =
    // //       await CollEventServices(ref).getCollEvent(element.collEventID);
    // //   if (collEventData != null) {
    // //     SiteData? siteData =
    // //         await SiteServices(ref).getSite(collEventData.siteID);
    // //     if (siteData != null) {
    // //       String records = writeSite(siteData);
    // //       if (records.isNotEmpty) {
    // //         siteRecords = records;
    // //       }
    // //     }
    // //   }
    // //   String line = '$siteRecords$collRecords';
    // //   writer.write('$line$endLine');
    // // }

    // for (var element in specimenList) {
    //   String line = '${element.speciesID}';
    //   writer.write('$line$endLine');
    // }

    // writer.close();
  }

  // String writeCollectingRecords(SpecimenData specimenData) {
  //   String collectingRecord =
  //       '${specimenData.projectUuid},${specimenData.catalogerID},${specimenData.fieldNumber},'
  //       '${specimenData.condition},${specimenData.prepDate},${specimenData.prepTime},'
  //       '${specimenData.captureDate},${specimenData.captureTime},${specimenData.trapType},'
  //       '${specimenData.collEventID},${specimenData.collPersonnelID},${specimenData.taxonGroup},';

  //   return collectingRecord;
  // }

  // String writeSite(SiteData siteData) {
  //   String siteRecords =
  //       '${siteData.siteID},${siteData.leadStaffId},${siteData.country},'
  //       '${siteData.stateProvince},${siteData.county},${siteData.municipality},'
  //       '${siteData.locality},${siteData.remark},${siteData.habitatType},'
  //       '${siteData.habitatCondition},${siteData.habitatDescription}';

  //   return siteRecords;
  // }
}
