import 'dart:io';

import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/export.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/export/common.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/export/site_writer.dart';

class CollEventRecordWriter extends AppServices {
  CollEventRecordWriter({
    required super.ref,
  });

  Future<void> writeCollEventDelimited(File filePath, bool isCsv) async {
    String delimiter = isCsv ? csvDelimiter : tsvDelimiter;
    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();
    List<String> header = [...siteExportList, ...collEventExportList];
    writer.writeln(header.join(delimiter));
    List<CollEventData> collEventList =
        await CollEventServices(ref: ref).getAllCollEvents();

    for (var collEvent in collEventList) {
      List<String> eventDetails = await getCOllEventSiteDetails(collEvent.id);
      String content = eventDetails.toDelimitedText(delimiter);
      writer.writeln(content);
    }

    await writer.close();
  }

  Future<List<String>> getCOllEventSiteDetails(int? collEventId) async {
    int emptySite = siteExportList.length;
    int emptyEvent = collEventExportList.length;
    int emptyAll = emptySite + emptyEvent;
    if (collEventId == null) {
      return List.filled(emptyAll, '');
    } else {
      CollEventData? collEvent =
          await CollEventServices(ref: ref).getCollEvent(collEventId);
      if (collEvent == null) {
        return List.filled(emptyAll, '');
      }

      List<String> siteDetails = await _getSite(collEvent.siteID);
      List<String> collEventDetails = await _getEventDetails(collEvent);
      return [...siteDetails, ...collEventDetails];
    }
  }

  Future<List<String>> _getEventDetails(CollEventData data) async {
    String eventID = await CollEventServices(ref: ref).getCollEventID(data);
    String methods = data.primaryCollMethod ?? '';
    String startDate = data.startDate ?? '';
    String endDate = data.endDate ?? '';
    String startTime = data.startTime ?? '';
    String endTime = data.endTime ?? '';
    String effort = await _getEffort(data.id);
    String person = await _getAllPersonnel(data.id);

    return [
      eventID,
      methods,
      startDate,
      endDate,
      startTime,
      endTime,
      effort,
      person,
    ];
  }

  Future<List<String>> _getSite(int? siteID) async {
    List<String> siteDetails =
        await SiteWriterServices(ref: ref).getSiteDetails(siteID);
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
