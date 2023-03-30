import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/site_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/exports/common.dart';

class SpeciesListWriter {
  SpeciesListWriter(this.ref);

  final WidgetRef ref;

  Future<void> writeSpeciesList(String filePath) async {
    List<SpecimenData> specimenList =
        await SpecimenServices(ref).getSpecimenList();

    File file = File(filePath);
    IOSink writer = file.openWrite();
    writer.write(
        'cataloger,fieldID,preparator,family,species,preparation,condition,site,habitatType$endLine');
    for (var element in specimenList) {
      String cataloger = await _getCatalogerName(element.catalogerID);
      String fieldId = '${element.fieldNumber ?? ''}';
      String preparator = await _getPreparatorName(element.preparatorID);
      String species = await _getSpeciesName(element.speciesID);
      String parts = await _getPartList(element.uuid);
      String condition = element.condition ?? '';
      String collId = await _getCollEventName(element.collEventID);
      writer.write(
          '$cataloger$fieldId,$preparator,$species,$parts,$condition,$collId$endLine');
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
        return ',';
      } else {
        return _getSiteName(collEventData.siteID);
      }
    }
  }

  Future<String> _getSiteName(int? siteId) async {
    if (siteId == null) {
      return '';
    } else {
      SiteData? siteData = await SiteServices(ref).getSite(siteId);

      if (siteData == null) {
        return '';
      } else {
        return '${siteData.siteID},${siteData.habitatType}';
      }
    }
  }

  Future<String> _getPartList(String specimenUuid) async {
    List<SpecimenPartData> partList =
        await SpecimenPartQuery(ref.read(databaseProvider))
            .getSpecimenParts(specimenUuid);
    return partList.map((e) => '[${e.type}: ${e.treatment}]').join(';');
  }
}
