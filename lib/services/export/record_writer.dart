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

  Future<void> writeRecordDelimited(File filePath, bool isCsv) async {
    String delimiter = isCsv ? csvDelimiter : tsvDelimiter;

    List<SpecimenData> specimenList = await _getSpecimenListByTaxonGroup();
    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();
    List<String> header = [
      ...collRecordExportList,
      ...specimenExportList,
      ...siteExportList,
      ...collEventExportList,
      ..._getMeasurementHeader(),
      'media'
    ];
    writer.writeln(header.toDelimitedText(delimiter));

    for (var element in specimenList) {
      ({String name, String initial}) cataloger =
          await _getCatalogerIdentity(element.catalogerID);
      String fieldId = '${cataloger.initial}${element.fieldNumber ?? ' '}';
      String preparator = await _getPreparatorName(element.preparatorID);
      List<String> taxonomy = await _getSpeciesName(element.speciesID);
      String parts = await _getPartList(element.uuid);
      String condition = element.condition ?? '';
      String specimenCoordinate =
          await _getSpecimenCoordinate(element.coordinateID);
      List<String> collSiteDetails = await _getCollEventSiteDetails(
        element.collEventID,
      );
      List<String> measurement = await _getMeasurement(element.uuid);

      String media = await _getSpecimenMedia(element.uuid);
      List<String> content = [
        element.uuid.toString(),
        cataloger.name,
        fieldId,
        preparator,
        ...taxonomy,
        parts,
        condition,
        specimenCoordinate,
        ...collSiteDetails,
        ...measurement,
        media
      ];
      writer.writeln(content.toDelimitedText(delimiter));
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

  Future<List<String>> _getSpeciesName(int? speciesId) async {
    if (speciesId == null) {
      return [''];
    } else {
      TaxonomyData taxon =
          await TaxonomyService(ref: ref).getTaxonById(speciesId);

      return [
        taxon.taxonOrder ?? '',
        taxon.taxonFamily ?? '',
        taxon.genus ?? '',
        taxon.specificEpithet ?? '',
      ];
    }
  }

  Future<({String name, String initial})> _getCatalogerIdentity(
      String? catalogerUuid) async {
    if (catalogerUuid == null) {
      return (name: '', initial: '');
    } else {
      PersonnelData person =
          await PersonnelServices(ref: ref).getPersonnelByUuid(catalogerUuid);
      return (name: person.name ?? '', initial: person.initial ?? '');
    }
  }

  Future<String> _getPreparatorName(String? preparatorUuid) async {
    if (preparatorUuid == null) {
      return '';
    } else {
      PersonnelData person =
          await PersonnelServices(ref: ref).getPersonnelByUuid(preparatorUuid);
      return person.name ?? '';
    }
  }

  Future<List<String>> _getCollEventSiteDetails(int? collEventId) async {
    return await CollEventRecordWriter(ref: ref)
        .getCOllEventSiteDetails(collEventId);
  }

  Future<String> _getSpecimenCoordinate(int? coordinateId) async {
    if (coordinateId == null) {
      return '';
    } else {
      List<String> coordinate =
          await SiteWriterServices(ref: ref).getCoordinateById(
        coordinateId,
      );
      return coordinate.join();
    }
  }

  Future<String> _getPartList(String specimenUuid) async {
    List<SpecimenPartData> partList =
        await SpecimenPartServices(ref: ref).getSpecimenParts(specimenUuid);
    return partList
        .map((e) => '${e.type};${e.treatment}')
        .join(writerSeparator);
  }

  Future<List<String>> _getMeasurement(String specimenUuid) async {
    bool isBat = recordType == SpecimenRecordType.bats ||
        recordType == SpecimenRecordType.allMammals;
    switch (recordType) {
      case SpecimenRecordType.generalMammals:
        return await _getMeasurementGeneralMammals(specimenUuid, isBat);
      case SpecimenRecordType.birds:
        return await _getMeasurementBirds(specimenUuid);
      case SpecimenRecordType.bats:
        return await _getMeasurementGeneralMammals(specimenUuid, isBat);
      case SpecimenRecordType.allMammals:
        return await _getMeasurementGeneralMammals(specimenUuid, isBat);
      default:
        throw Exception('Invalid record type');
    }
  }

  Future<List<String>> _getMeasurementGeneralMammals(
      String specimenUuid, bool isBatRecord) async {
    MammalianMeasurements mammals = MammalianMeasurements(
      specimenUuid: specimenUuid,
      ref: ref,
      isBatRecord: isBatRecord,
    );
    return await mammals.getMeasurements();
  }

  Future<List<String>> _getMeasurementBirds(String specimenUuid) async {
    AvianMeasurements birds =
        AvianMeasurements(specimenUuid: specimenUuid, ref: ref);
    return await birds.getMeasurements();
  }

  Future<String> _getSpecimenMedia(String specimenUuid) async {
    String specimenMedia =
        await MediaWriterServices(ref: ref).getSpecimenMedias(specimenUuid);
    return specimenMedia;
  }
}
