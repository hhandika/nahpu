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
    bool withHabitat = false;
    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();
    _writeHeader(writer, siteExportListWithoutHabitat);
    _writeHeader(writer, narrativeExportList);
    writer.writeln('media');
    List<NarrativeData> narrativeList =
        await NarrativeServices(ref: ref).getAllNarrative();
    for (var narrative in narrativeList) {
      String siteDetails =
          await SiteWriterServices(ref: ref, delimiter: delimiter)
              .getSiteDetails(narrative.siteID, withHabitat);
      String mediaDetails = await getNarrativeMedia(narrative.id);
      String narrativeDate = '"${narrative.date ?? ''}"';
      String fieldNote = '"${narrative.narrative ?? ''}"';
      String narrativeDelimited = '$siteDetails$delimiter'
          '$narrativeDate$delimiter$fieldNote$delimiter'
          '$mediaDetails';
      writer.writeln(narrativeDelimited);
    }

    await writer.close();
  }

  void _writeHeader(IOSink writer, List<String> headers) async {
    for (var val in headers) {
      writer.write('$val$delimiter');
    }
  }

  Future<String> getNarrativeMedia(int? narrativeID) async {
    String mediaDetails =
        await MediaWriterServices(ref: ref).getNarrativeMedias(narrativeID);

    return mediaDetails;
  }
}
