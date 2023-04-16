import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/export.dart';
import 'package:nahpu/models/mammals.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/site_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/writer/common.dart';

class SpecimenRecordWriter {
  SpecimenRecordWriter(this.ref);

  final WidgetRef ref;
  late String delimiter;

  Future<void> writeRecordDelimited(File filePath, bool isCsv) async {
    delimiter = isCsv ? csvDelimiter : tsvDelimiter;
    List<SpecimenData> specimenList =
        await SpecimenServices(ref).getSpecimenList();
    IOSink writer = filePath.openWrite();
    _writeHeader(writer, collRecordExportList);
    _writeHeader(writer, specimenExportList);
    _writeHeader(writer, collEventExportList);
    _writeHeaderLast(writer, mammalMeasurementExportList);

    for (var element in specimenList) {
      String cataloger = await _getCatalogerName(element.catalogerID);
      String fieldId = '${element.fieldNumber ?? ''}';
      String preparator = await _getPreparatorName(element.preparatorID);
      String species = await _getSpeciesName(element.speciesID);
      String parts = await _getPartList(element.uuid);
      String condition = element.condition ?? '';
      String collId = await _getCollEventName(element.collEventID);
      CatalogFmt catalogFmt = matchTaxonGroupToCatFmt(element.taxonGroup);
      String measurement = await _getMeasurement(catalogFmt, element.uuid);
      String mainLine =
          '$cataloger$fieldId$delimiter$preparator$delimiter$species$delimiter$parts$delimiter$condition$delimiter$collId';
      writer.write('$mainLine$delimiter$measurement$endLine');
    }

    writer.close();
  }

  void _writeHeader(IOSink writer, List<String> headerList) {
    for (var val in headerList) {
      writer.write('$val$delimiter');
    }
  }

  void _writeHeaderLast(IOSink writer, List<String> headerList) {
    int last = headerList.length - 1;
    int count = 0;
    for (var val in headerList) {
      if (count == last) {
        writer.write('$val$endLine');
      } else {
        writer.write('$val$delimiter');
      }
      count++;
    }
  }

  Future<String> _getSpeciesName(int? speciesId) async {
    if (speciesId == null) {
      return '';
    } else {
      TaxonomyData taxon = await TaxonomyQuery(ref.read(databaseProvider))
          .getTaxonById(speciesId);

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
        String siteDetails = await _getSiteDetails(collEventData.siteID);
        String coordinateDetails = await _getCoordinates(collEventData.siteID);
        return '$siteDetails$delimiter"$coordinateDetails"';
      }
    }
  }

  Future<String> _getSiteDetails(int? siteId) async {
    if (siteId == null) {
      return '';
    } else {
      SiteData? data = await SiteServices(ref).getSite(siteId);

      if (data == null) {
        return '';
      } else {
        String siteDetails = '${data.country}: ${data.stateProvince};'
                ' ${data.county}; ${data.municipality}; ${data.locality}'
            .trim();
        return '${data.siteID}$delimiter${data.habitatType}$delimiter"$siteDetails"';
      }
    }
  }

  Future<String> _getCoordinates(int? siteID) async {
    if (siteID == null) {
      return '';
    } else {
      List<CoordinateData> coordinateList =
          await CoordinateServices(ref).getCoordinatesBySiteID(siteID);
      return coordinateList
          .map((e) => '${e.nameId ?? ''};'
              '${e.decimalLatitude ?? ''},${e.decimalLongitude ?? ''};'
              '${e.elevationInMeter ?? ''}m;±${e.uncertaintyInMeters ?? ''}m;'
              '${e.datum ?? ''}')
          .join('|');
    }
  }

  Future<String> _getPartList(String specimenUuid) async {
    List<SpecimenPartData> partList =
        await SpecimenPartQuery(ref.read(databaseProvider))
            .getSpecimenParts(specimenUuid);
    return partList.map((e) => '${e.type};${e.treatment}').join('|');
  }

  Future<String> _getMeasurement(
      CatalogFmt catalogFmt, String? specimenUuid) async {
    switch (catalogFmt) {
      case CatalogFmt.generalMammals:
        return await _getMeasurementGeneralMammals(specimenUuid);
      case CatalogFmt.birds:
        return ' ';
      default:
        return ' ';
    }
  }

  Future<String> _getMeasurementGeneralMammals(String? specimenUuid) async {
    if (specimenUuid != null) {
      MammalMeasurementData data =
          await SpecimenServices(ref).getMammalMeasurementData(specimenUuid);
      String measurement =
          '${data.totalLength ?? ''}$delimiter${data.tailLength ?? ''}$delimiter'
          '${data.hindFootLength ?? ''}$delimiter${data.earLength ?? ''}$delimiter'
          '${data.weight ?? ''}';
      String accuracy = data.accuracy ?? '';
      String age = data.age != null ? specimenAgeList[data.age!] : '';
      String sexData = _getSexData(data);
      return '$measurement$delimiter$accuracy$delimiter$age$delimiter$sexData';
    } else {
      return delimiter * 7;
    }
  }

  String _getSexData(MammalMeasurementData data) {
    SpecimenSex? sexEnum = getSpecimenSex(data.sex);
    String sex = data.sex != null ? specimenSexList[data.sex!] : '';
    String emptyMale = delimiter;
    String emptyFemale = delimiter * 2;
    switch (sexEnum) {
      case SpecimenSex.male:
        String maleGonad = _getMaleGonad(data);
        return '$sex$delimiter$maleGonad$emptyFemale';
      case SpecimenSex.female:
        String femaleGonad = _getFemaleGonad(data);
        return '$sex$delimiter$emptyMale$delimiter$femaleGonad';
      case SpecimenSex.unknown:
        return '$sex$delimiter$emptyMale$emptyFemale';
      default:
        return '$sex$delimiter$emptyMale$emptyFemale';
    }
  }

  String _getFemaleGonad(MammalMeasurementData data) {
    String vaginaOpening = data.vaginaOpening != null
        ? vaginaOpeningList[data.vaginaOpening!]
        : '';
    if (data.mammaeCondition != null) {
      String mammaeCondition = mammaeConditionList[data.mammaeCondition!];
      String ingCount = data.mammaeInguinalCount != null
          ? '${data.mammaeInguinalCount} ing;'
          : '';
      String abdCount = data.mammaeAbdominalCount != null
          ? '${data.mammaeAbdominalCount} abd;'
          : '';
      String axCount = data.mammaeAxillaryCount != null
          ? '${data.mammaeAxillaryCount} ax'
          : '';
      String mammaeCount = '$ingCount$abdCount$axCount';
      return '$vaginaOpening$delimiter$mammaeCondition$delimiter$mammaeCount';
    } else {
      String empty = delimiter * 2;
      return '$vaginaOpening$empty';
    }
  }

  String _matchTestisPos(int? testisPos) {
    if (testisPos == null) {
      return '';
    } else {
      return testisPositionList[testisPos];
    }
  }

  String _getMaleGonad(MammalMeasurementData data) {
    TestisPosition? posEnum = getTestisPosition(data.testisPosition);

    if (posEnum == TestisPosition.scrotal) {
      String testisPos = _matchTestisPos(data.testisPosition);
      String testisLength =
          data.testisLength != null ? '${data.testisLength}' : '';
      String testisWidth =
          data.testisWidth != null ? 'x${data.testisWidth}mm' : '';
      return '$testisPos$delimiter$testisLength$testisWidth';
    } else {
      return delimiter;
    }
  }
}
