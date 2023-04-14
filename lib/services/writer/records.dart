import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<void> writeSpeciesList(String filePath) async {
    List<SpecimenData> specimenList =
        await SpecimenServices(ref).getSpecimenList();

    File file = File(filePath);
    IOSink writer = file.openWrite();
    String mainHeader =
        'cataloger,fieldID,preparator,family,species,preparation,condition';
    String eventHeader = 'site,habitatType,locality,coordinates';
    String measureHeader =
        'TotalLength,TailLength,HindFootLength,EarLength,Weight,Accuracy,'
        'age,sex,testisPos,testisSize,'
        'ovaryOpening,MammaeCondition,MammaeFormula';
    writer.write('$mainHeader,$eventHeader,$measureHeader$endLine');

    for (var element in specimenList) {
      String cataloger = await _getCatalogerName(element.catalogerID);
      String fieldId = '${element.fieldNumber ?? ''}';
      String preparator = await _getPreparatorName(element.preparatorID);
      String species = await _getSpeciesName(element.speciesID);
      String parts = await _getPartList(element.uuid);
      String condition = element.condition ?? '';
      String collId = await _getCollEventName(element.collEventID);
      String measurement =
          await _getMeasurement(element.taxonGroup, element.uuid);
      String mainLine =
          '$cataloger$fieldId,$preparator,$species,$parts,$condition,$collId';
      writer.write('$mainLine,$measurement$endLine');
    }

    writer.close();
  }

  Future<String> _getSpeciesName(int? speciesId) async {
    if (speciesId == null) {
      return '';
    } else {
      TaxonomyData taxon = await TaxonomyQuery(ref.read(databaseProvider))
          .getTaxonById(speciesId);

      return '${taxon.taxonFamily},${taxon.genus} ${taxon.specificEpithet}';
    }
  }

  Future<String> _getCatalogerName(String? catalogerUuid) async {
    if (catalogerUuid == null) {
      return '';
    } else {
      PersonnelData person =
          await PersonnelServices(ref).getPersonnelByUuid(catalogerUuid);
      return '${person.name},${person.initial}';
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
        return '$siteDetails,"$coordinateDetails"';
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
            ' ${data.county}; ${data.municipality}; ${data.locality}';
        return '${data.siteID},${data.habitatType},"$siteDetails"';
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
          .map((e) =>
              '${e.nameId ?? ''};${e.decimalLatitude ?? ''},${e.decimalLongitude ?? ''};'
              '${e.elevationInMeter ?? ''}m;±${e.uncertaintyInMeters ?? ''}m;${e.datum ?? ''}')
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
      String? taxonGroup, String? specimenUuid) async {
    CatalogFmt catalogFmt = matchTaxonGroupToCatFmt(taxonGroup);

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
      String measurement = '${data.totalLength ?? ''},${data.tailLength ?? ''},'
          '${data.hindFootLength ?? ''},${data.earLength ?? ''},'
          '${data.weight ?? ''}';
      String accuracy = data.accuracy ?? '';
      String maleGonad =
          '${data.testisPosition ?? ''},${data.testisLength ?? ''} x ${data.testisWidth ?? ''}mm';
      String femaleGonad =
          '${data.vaginaOpening ?? ''},${data.mammaeCondition ?? ''},'
          '${data.mammaeInguinalCount ?? ''} ing;${data.mammaeAbdominalCount ?? ''} abd;${data.mammaeAxillaryCount ?? ''} ax';
      String age = data.age != null ? specimenAgeList[data.age!] : '';
      String sex = data.sex != null ? specimenSexList[data.sex!] : '';
      return '$measurement,$accuracy,$age,$sex,$maleGonad,$femaleGonad';
    } else {
      return ',,';
    }
  }
}
