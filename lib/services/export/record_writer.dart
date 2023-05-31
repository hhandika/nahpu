import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/export.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/export/avian_records.dart';
import 'package:nahpu/services/export/common.dart';
import 'package:nahpu/services/export/mammalian_records.dart';
import 'package:nahpu/services/export/site_writer.dart';

class SpecimenRecordWriter {
  SpecimenRecordWriter({required this.ref, required this.recordType});

  final WidgetRef ref;
  final SpecimenRecordType recordType;
  late String delimiter;

  Future<void> writeRecordDelimited(File filePath, bool isCsv) async {
    delimiter = isCsv ? csvDelimiter : tsvDelimiter;
    String taxonGroup = matchRecordTypeToTaxonGroup(recordType);
    List<SpecimenData> specimenList = await SpecimenServices(ref: ref)
        .getSpecimenListByTaxonGroup(taxonGroup);
    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();
    _writeHeader(writer, collRecordExportList);
    _writeHeader(writer, specimenExportList);
    _writeHeader(writer, siteExportList);
    _writeHeaderLast(writer, _getMeasurementHeader());

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
      TaxonomyData taxon =
          await TaxonomyService(ref: ref).getTaxonById(speciesId);

      return '${taxon.taxonOrder}$delimiter${taxon.taxonFamily}$delimiter'
          '${taxon.genus}$delimiter${taxon.specificEpithet}';
    }
  }

  Future<String> _getCatalogerName(String? catalogerUuid) async {
    if (catalogerUuid == null) {
      return '';
    } else {
      PersonnelData person =
          await PersonnelServices(ref: ref).getPersonnelByUuid(catalogerUuid);
      return '${person.name}$delimiter${person.initial}';
    }
  }

  Future<String> _getPreparatorName(String? preparatorUuid) async {
    if (preparatorUuid == null) {
      return '';
    } else {
      PersonnelData person =
          await PersonnelServices(ref: ref).getPersonnelByUuid(preparatorUuid);
      return '${person.name}';
    }
  }

  Future<String> _getCollEventName(int? collEventId) async {
    if (collEventId == null) {
      return '';
    } else {
      CollEventData? collEventData =
          await CollEventServices(ref: ref).getCollEvent(collEventId);

      if (collEventData == null) {
        return ',,';
      } else {
        SiteWriterServices siteServices =
            SiteWriterServices(ref: ref, delimiter: delimiter);
        String siteDetails =
            await siteServices.getSiteDetails(collEventData.siteID, true);
        String coordinateDetails =
            await siteServices.getCoordinates(collEventData.siteID);
        return '$siteDetails$delimiter"$coordinateDetails"';
      }
    }
  }

  Future<String> _getPartList(String specimenUuid) async {
    List<SpecimenPartData> partList =
        await SpecimenPartServices(ref: ref).getSpecimenParts(specimenUuid);
    return partList
        .map((e) => '${e.type};${e.treatment}')
        .join(writerSeparator);
  }

  List<String> _getMeasurementHeader() {
    switch (recordType) {
      case SpecimenRecordType.generalMammals:
        return mammalMeasurementExportList;
      case SpecimenRecordType.birds:
        return avianMeasurementExportList;
      case SpecimenRecordType.bats:
        return batMeasurementExportList;
      default:
        return mammalMeasurementExportList;
    }
  }

  Future<String> _getMeasurement(String specimenUuid) async {
    switch (recordType) {
      case SpecimenRecordType.generalMammals:
        return await _getMeasurementGeneralMammals(specimenUuid);
      case SpecimenRecordType.birds:
        return await _getMeasurementBirds(specimenUuid);
      default:
        return ' ';
    }
  }

  Future<String> _getMeasurementGeneralMammals(String specimenUuid) async {
    MammalianMeasurements mammals = MammalianMeasurements(
        specimenUuid: specimenUuid, ref: ref, delimiter: delimiter);
    return await mammals.getMeasurements();
  }

  Future<String> _getMeasurementBirds(String specimenUuid) async {
    AvianMeasurements birds = AvianMeasurements(
        specimenUuid: specimenUuid, ref: ref, delimiter: delimiter);
    return await birds.getMeasurements();
  }
}
