import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/export/coll_event_writer.dart';
import 'package:nahpu/services/export/media_writer.dart';
import 'package:nahpu/services/export/site_writer.dart';
import 'package:nahpu/services/types/export.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/export/avian_records.dart';
import 'package:nahpu/services/export/common.dart';
import 'package:nahpu/services/export/mammalian_records.dart';

class SpecimenRecordWriter {
  SpecimenRecordWriter({required this.ref, required this.recordType});

  final WidgetRef ref;
  final SpecimenRecordType recordType;
  late String delimiter;

  Future<void> writeRecordDelimited(File filePath, bool isCsv) async {
    delimiter = isCsv ? csvDelimiter : tsvDelimiter;

    List<SpecimenData> specimenList = await _getSpecimenListByTaxonGroup();
    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();
    _writeHeader(writer, collRecordExportList);
    _writeHeader(writer, specimenExportList); // Include specimenCoordinates
    _writeHeader(writer, siteExportList);
    _writeHeader(writer, collEventExportList);
    _writeHeader(writer, _getMeasurementHeader());
    writer.writeln('media');

    for (var element in specimenList) {
      String cataloger = await _getCatalogerName(element.catalogerID);
      String fieldId = '${element.fieldNumber ?? ''}';
      String preparator = await _getPreparatorName(element.preparatorID);
      String species = await _getSpeciesName(element.speciesID);
      String parts = await _getPartList(element.uuid);
      String condition = element.condition ?? '';
      String specimenCoordinate =
          await _getSpecimenCoordinate(element.coordinateID);
      String measurement = await _getMeasurement(element.uuid);
      String collSiteDetails =
          await _getCollEventSiteDetails(element.collEventID, isCsv);

      String media = await _getSpecimenMedia(element.uuid);
      String mainLine =
          '$cataloger$fieldId$delimiter$preparator$delimiter$species$delimiter'
          '$parts$delimiter$condition$delimiter'
          '$specimenCoordinate$delimiter'
          '$collSiteDetails';
      writer.writeln('$mainLine$delimiter$measurement$delimiter$media');
    }

    writer.close();
  }

  List<String> _getMeasurementHeader() {
    switch (recordType) {
      case SpecimenRecordType.generalMammals:
        return mammalMeasurementExportList;
      case SpecimenRecordType.birds:
        return avianMeasurementExportList;
      case SpecimenRecordType.bats:
        return batMeasurementExportList;
      case SpecimenRecordType.allMammals:
        return batMeasurementExportList;
      default:
        throw Exception('Invalid record type');
    }
  }

  Future<List<SpecimenData>> _getSpecimenListByTaxonGroup() async {
    final service = SpecimenServices(ref: ref);

    if (recordType == SpecimenRecordType.allMammals) {
      return await service.getSpecimenListForAllMammals();
    }

    String taxonGroup = matchRecordTypeToTaxonGroup(recordType);
    return await service.getSpecimenListByTaxonGroup(taxonGroup);
  }

  void _writeHeader(IOSink writer, List<String> headerList) {
    for (var val in headerList) {
      writer.write('$val$delimiter');
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

  Future<String> _getCollEventSiteDetails(int? collEventId, bool isCsv) async {
    return await CollEventRecordWriter(ref: ref, isCsv: isCsv)
        .getCOllEventSiteDetails(
      collEventId,
    );
  }

  Future<String> _getSpecimenCoordinate(int? coordinateId) async {
    if (coordinateId == null) {
      return '';
    } else {
      String coordinate = await SiteWriterServices(ref: ref).getCoordinateById(
        coordinateId,
      );
      return coordinate;
    }
  }

  Future<String> _getPartList(String specimenUuid) async {
    List<SpecimenPartData> partList =
        await SpecimenPartServices(ref: ref).getSpecimenParts(specimenUuid);
    return partList
        .map((e) => '${e.type};${e.treatment}')
        .join(writerSeparator);
  }

  Future<String> _getMeasurement(String specimenUuid) async {
    // bool isBat = recordType == SpecimenRecordType.bats ||
    //     recordType == SpecimenRecordType.allMammals;
    switch (recordType) {
      case SpecimenRecordType.generalMammals:
        return await _getMeasurementGeneralMammals(specimenUuid, false);
      case SpecimenRecordType.birds:
        return await _getMeasurementBirds(specimenUuid);
      case SpecimenRecordType.bats:
        return await _getMeasurementGeneralMammals(specimenUuid, true);
      case SpecimenRecordType.allMammals:
        return await _getMeasurementGeneralMammals(specimenUuid, true);
      default:
        throw Exception('Invalid record type');
    }
  }

  Future<String> _getMeasurementGeneralMammals(
      String specimenUuid, bool isBatRecord) async {
    MammalianMeasurements mammals = MammalianMeasurements(
      specimenUuid: specimenUuid,
      ref: ref,
      delimiter: delimiter,
      isBatRecord: isBatRecord,
    );
    return await mammals.getMeasurements();
  }

  Future<String> _getMeasurementBirds(String specimenUuid) async {
    AvianMeasurements birds = AvianMeasurements(
        specimenUuid: specimenUuid, ref: ref, delimiter: delimiter);
    return await birds.getMeasurements();
  }

  Future<String> _getSpecimenMedia(String specimenUuid) async {
    String specimenMedia =
        await MediaWriterServices(ref: ref).getSpecimenMedias(specimenUuid);
    return specimenMedia;
  }
}
