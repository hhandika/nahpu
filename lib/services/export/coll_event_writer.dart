import 'dart:io';

import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/export.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/export/common.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/export/site_writer.dart';

class CollEventRecordWriter extends DbAccess {
  CollEventRecordWriter({required super.ref});

  late String delimiter;

  Future<void> writeCollEventDelimited(File filePath, bool isCsv) async {
    delimiter = isCsv ? csvDelimiter : tsvDelimiter;
    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();
    _writeSiteHeader(writer);
    _writeCollEventHeader(writer);
    List<CollEventData> collEventList =
        await CollEventServices(ref: ref).getAllCollEvents();

    for (var collEvent in collEventList) {
      getCOllEventSiteDetails(collEvent.id, delimiter);
    }

    await writer.close();
  }

  void _writeSiteHeader(IOSink writer) {
    for (var val in siteExportList) {
      writer.write('"$val"$delimiter');
    }
  }

  void _writeCollEventHeader(IOSink writer) {
    for (var val in collEventExportList) {
      if (val == collEventExportList.last) {
        writer.writeln('"$val"');
      } else {
        writer.write('"$val"$delimiter');
      }
    }
  }

  Future<String> getCOllEventSiteDetails(
      int? collEventId, String delimiter) async {
    int columnSize = siteExportList.length + collEventExportList.length;
    String emptyDelimiters = delimiter * columnSize;
    if (collEventId == null) {
      return emptyDelimiters;
    } else {
      CollEventData? collEvent =
          await CollEventServices(ref: ref).getCollEvent(collEventId);
      if (collEvent == null) {
        return emptyDelimiters;
      }

      String siteDetails = await _getSite(collEvent.siteID, delimiter);
      String collEventDetails = await _getEventDetails(collEvent);
      return '$siteDetails$delimiter$collEventDetails';
    }
  }

  Future<String> _getEventDetails(CollEventData data) async {
    String eventID = await CollEventServices(ref: ref).getCollEventID(data);
    String methods = '"${data.primaryCollMethod}"';
    String startDate = '"${data.startDate ?? ''}"';
    String endDate = '"${data.endDate ?? ''}"';
    String startTime = '"${data.startTime ?? ''}"';
    String endTime = '"${data.endTime ?? ''}"';
    String effort = await _getEffort(data.id);
    String person = await _getAllPersonnel(data.id);

    return '$eventID$delimiter$methods$delimiter'
        '$startDate$delimiter$endDate$delimiter'
        '$startTime$delimiter$endTime$delimiter'
        '$effort$delimiter$person';
  }

  Future<String> _getSite(int? siteID, String delimiter) async {
    String siteDetails =
        await SiteWriterServices(ref: ref, delimiter: delimiter)
            .getSiteDetails(siteID, true);
    return siteDetails;
  }

  Future<String> _getEffort(int id) async {
    List<CollEffortData> effort =
        await CollEventServices(ref: ref).getAllCollEffort(id);
    return effort.map((e) => '"${e.method}";${e.count}').join(writerSeparator);
  }

  Future<String> _getAllPersonnel(int id) async {
    List<CollPersonnelData> personnel =
        await CollEventServices(ref: ref).getAllCollPersonnel(id);

    String person =
        await Future.wait(personnel.map((e) async => await _getPersonnel(e)))
            .then((value) => value.join(writerSeparator));

    return person;
  }

  Future<String> _getPersonnel(CollPersonnelData data) async {
    if (data.personnelId == null) {
      return '';
    } else {
      PersonnelData personnel = await PersonnelServices(ref: ref)
          .getPersonnelByUuid(data.personnelId!);
      return '${personnel.name};${data.role}';
    }
  }
}
