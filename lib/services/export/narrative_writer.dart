import 'dart:io';

import 'package:nahpu/services/export/common.dart';
import 'package:nahpu/services/export/media_writer.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/export.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/narrative_services.dart';
import 'package:nahpu/services/export/site_writer.dart';

class NarrativeRecordWriter extends DbAccess {
  NarrativeRecordWriter({required super.ref});

  late String delimiter;

  Future<void> writeNarrativeDelimited(File filePath, bool isCsv) async {
    delimiter = isCsv ? csvDelimiter : tsvDelimiter;
    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();
    String narrativeHeader =
        narrativeExportList.map((e) => '"$e"').join(delimiter);
    writer.writeln(narrativeHeader);
    List<NarrativeData> narrativeList =
        await NarrativeServices(ref: ref).getAllNarrative();
    for (var narrative in narrativeList) {
      List<String> narrativeList = await getNarrativeExportList(narrative);
      String narrativeDelimited = narrativeList.join(delimiter);
      writer.writeln(narrativeDelimited);
    }

    await writer.close();
  }

  Future<List<String>> getNarrativeExportList(NarrativeData narrative) async {
    String verbatimLocality =
        await SiteWriterServices(ref: ref, delimiter: delimiter)
            .getSiteDetails(narrative.siteID, false);
    String mediaDetails = await getNarrativeMedia(narrative.id);
    String narrativeDate = narrative.date ?? '';
    String fieldNote = narrative.narrative ?? '';
    List<String> narrativeList = [
      '"$narrativeDate"',
      verbatimLocality,
      '"$fieldNote"',
      mediaDetails
    ];
    return narrativeList;
  }

  Future<String> getNarrativeMedia(int? narrativeID) async {
    String mediaDetails =
        await MediaWriterServices(ref: ref).getNarrativeMedias(narrativeID);

    return mediaDetails;
  }
}
