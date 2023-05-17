import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/export.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/writer/common.dart';
import 'package:nahpu/services/writer/mammalian_records.dart';
import 'package:nahpu/services/writer/site_writer.dart';

class SpecimenRecordWriter {
  SpecimenRecordWriter({required this.ref, required this.recordType});

  final WidgetRef ref;
  final SpecimenRecordType recordType;
  late String delimiter;

  Future<void> writeRecordDelimited(File filePath, bool isCsv) async {
    delimiter = isCsv ? csvDelimiter : tsvDelimiter;
    String taxonGroup = matchRecordTypeToTaxonGroup(recordType);
    List<SpecimenData> specimenList =
        await SpecimenServices(ref).getSpecimenListByTaxonGroup(taxonGroup);
    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();
    _writeHeader(writer, collRecordExportList);
    _writeHeader(writer, specimenExportList);
    _writeHeader(writer, siteExportList);
    _writeHeaderLast(writer, mammalMeasurementExportList);

    for (var element in specimenList) {
      String cataloger = await _getCatalogerName(element.catalogerID);
      String fieldId = '${element.fieldNumber ?? ''}';
      String preparator = await _getPreparatorName(element.preparatorID);
      String species = await _getSpeciesName(element.speciesID);
      String parts = await _getPartList(element.uuid);
      String condition = element.condition ?? '';
      String collId = await _getCollEventName(element.collEventID);
      String measurement = await _getMeasurement(element.uuid);
      String mainLine =
          '$cataloger$fieldId$delimiter$preparator$delimiter$species$delimiter$parts$delimiter$condition$delimiter$collId';
      writer.writeln('$mainLine$delimiter$measurement');
    }

    writer.close();
  }

  void _writeHeader(IOSink writer, List<String> headerList) {
    for (var val in headerList) {
      writer.write('$val$delimiter');
    }
  }

  void _writeHeaderLast(IOSink writer, List<String> headerList) {
    for (var val in headerList) {
      if (val == headerList.last) {
        writer.writeln(val);
      } else {
        writer.write('$val$delimiter');
      }
    }
  }

  Future<String> _getSpeciesName(int? speciesId) async {
    if (speciesId == null) {
      return '';
    } else {
      TaxonomyData taxon = await TaxonomyService(ref).getTaxonById(speciesId);

      return '${taxon.taxonOrder}$delimiter${taxon.taxonFamily}$delimiter'
          '${taxon.genus}$delimiter${taxon.specificEpithet}';
    }
  }

  Future<String> _getCatalogerName(String? catalogerUuid) async {
    if (catalogerUuid == null) {
      return '';
    } else {
      PersonnelData person =
          await PersonnelServices(ref).getPersonnelByUuid(catalogerUuid);
      return '${person.name}$delimiter${person.initial}';
    }
  }

  Future<String> _getPreparatorName(String? preparatorUuid) async {
    if (preparatorUuid == null) {
      return '';
    } else {
      PersonnelData person =
          await PersonnelServices(ref).getPersonnelByUuid(preparatorUuid);
      return '${person.name}';
    }
  }

  Future<String> _getCollEventName(int? collEventId) async {
    if (collEventId == null) {
      return '';
    } else {
      CollEventData? collEventData =
          await CollEventServices(ref).getCollEvent(collEventId);

      if (collEventData == null) {
        return ',,';
      } else {
        SiteWriterServices siteServices = SiteWriterServices(
            ref: ref, siteID: collEventData.siteID, delimiter: delimiter);
        String siteDetails = await siteServices.getSiteDetails(true);
        String coordinateDetails = await siteServices.getCoordinates();
        return '$siteDetails$delimiter"$coordinateDetails"';
      }
    }
  }

  Future<String> _getPartList(String specimenUuid) async {
    List<SpecimenPartData> partList =
        await SpecimenPartQuery(ref.read(databaseProvider))
            .getSpecimenParts(specimenUuid);
    return partList.map((e) => '${e.type};${e.treatment}').join(listSeparator);
  }

  Future<String> _getMeasurement(String specimenUuid) async {
    switch (recordType) {
      case SpecimenRecordType.mammalian:
        return await _getMeasurementGeneralMammals(specimenUuid);
      case SpecimenRecordType.avian:
        return ' ';
      default:
        return ' ';
    }
  }

  Future<String> _getMeasurementGeneralMammals(String specimenUuid) async {
    MammalianMeasurements mammals = MammalianMeasurements(
        specimenUuid: specimenUuid, ref: ref, delimiter: delimiter);
    return await mammals.getMeasurements();
  }
}
