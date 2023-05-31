import 'dart:io';

import 'package:nahpu/services/export/common.dart';
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
    _writeHeader(writer);
    List<NarrativeData> narrativeList =
        await NarrativeServices(ref: ref).getAllNarrative();
    for (var narrative in narrativeList) {
      writer.write('"${narrative.date}"');
      writer.write(delimiter);
      String siteDetails =
          await SiteWriterServices(ref: ref, delimiter: delimiter)
              .getSiteDetails(narrative.siteID, false);
      writer.write(siteDetails);
      writer.write(delimiter);
      writer.writeln('"${narrative.narrative}"');
    }

    await writer.close();
  }

  void _writeHeader(IOSink writer) async {
    for (var val in narrativeExportList) {
      if (val == narrativeExportList.last) {
        writer.writeln(val);
      } else {
        writer.write('$val$delimiter');
      }
    }
  }
}
