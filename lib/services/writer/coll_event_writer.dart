import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/export.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/writer/site_writer.dart';

class CollEventRecordWriter {
  CollEventRecordWriter(this.ref);

  final WidgetRef ref;
  late String delimiter;

  Future<void> writeCollEventDelimited(File filePath, bool isCsv) async {
    delimiter = isCsv ? ',' : '\t';
    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();
    _writeHeader(writer);
    List<CollEventData> collEventList =
        await CollEventServices(ref).getAllCollEvents();
    for (var collEvent in collEventList) {
      writer.write('"${collEvent.eventID}"');
      _writeDelimiter(writer);
      String siteDetails = await _getSite(collEvent.siteID, delimiter);
      writer.write(siteDetails);
      _writeDelimiter(writer);
      writer.write('"${collEvent.primaryCollMethod}"');
      _writeDelimiter(writer);
      writer.write('"${collEvent.startDate}"');
      _writeDelimiter(writer);
      writer.write('"${collEvent.endDate}"');
      _writeDelimiter(writer);
      writer.write('"${collEvent.startTime}"');
      _writeDelimiter(writer);
      writer.write('"${collEvent.endTime}"');
      _writeDelimiter(writer);
      String effort = await _writeEffort(collEvent.id);
      writer.write(effort);
      _writeDelimiter(writer);
      String person = await _writePersonnel(collEvent.id);
      writer.write(person);
      writer.writeln();
    }

    await writer.close();
  }

  Future<String> _getSite(int? siteID, String delimiter) async {
    String siteDetails =
        await SiteWriterServices(ref: ref, siteID: siteID, delimiter: delimiter)
            .getSiteDetails(false);
    return siteDetails;
  }

  Future<String> _writeEffort(int id) async {
    List<CollEffortData> effort =
        await CollEventServices(ref).getAllCollEffort(id);
    return effort.map((e) => '"${e.type}";${e.count}').join(listSeparator);
  }

  Future<String> _writePersonnel(int id) async {
    List<CollPersonnelData> personnel =
        await CollEventServices(ref).getAllCollPersonnel(id);

    String person =
        await Future.wait(personnel.map((e) async => await _getPersonnel(e)))
            .then((value) => value.join(listSeparator));

    return person;
  }

  Future<String> _getPersonnel(CollPersonnelData data) async {
    if (data.personnelId == null) {
      return '';
    } else {
      PersonnelData personnel =
          await PersonnelServices(ref).getPersonnelByUuid(data.personnelId!);
      return '${personnel.name};${data.role}';
    }
  }

  void _writeDelimiter(IOSink writer) {
    writer.write(delimiter);
  }

  void _writeHeader(IOSink writer) {
    for (var val in collEventExportList) {
      if (val == collEventExportList.last) {
        writer.writeln('"$val"');
      } else {
        writer.write('"$val"$delimiter');
      }
    }
  }
}
