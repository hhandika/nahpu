import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/export/common.dart';
import 'package:nahpu/services/site_services.dart';
import 'package:nahpu/services/types/export.dart';

class SiteWriterServices {
  SiteWriterServices({
    required this.ref,
    this.delimiter = csvDelimiter,
  });

  final WidgetRef ref;

  String delimiter;

  Future<void> writeSiteDelimited(File filePath, bool isCsv) async {
    delimiter = isCsv ? csvDelimiter : tsvDelimiter;
    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();
    _writeHeaderLast(writer, siteExportList);

    List<SiteData> siteList = await SiteServices(ref: ref).getAllSites();
    for (var site in siteList) {
      String siteDetails = await getSiteDetails(site.id, true);
      writer.writeln(siteDetails);
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

  Future<String> getSiteDetails(int? siteID, bool withHabitat) async {
    if (siteID == null) {
      return '';
    } else {
      SiteData? data = await SiteServices(ref: ref).getSite(siteID);

      if (data == null) {
        return delimiter * 5;
      } else {
        String siteSeparated = _getSiteSeparated(data);
        String country = _getCountry(data.country);
        String stateProvince = _getStateProvince(data.stateProvince);
        String county = _getCounty(data.county);
        String municipality = _getMunicipality(data.municipality);
        String locality = _getLocality(data.locality);
        String coordinates = await getCoordinates(siteID);
        String siteDetails =
            '$country$stateProvince$county$municipality$locality'.trim();
        String siteLocality =
            '$siteSeparated$siteDetails$delimiter$coordinates';
        return withHabitat
            ? '${data.siteID}$delimiter${data.habitatType}$delimiter$siteLocality'
            : siteLocality;
      }
    }
  }

  String _getSiteSeparated(SiteData data) {
    return '${data.country ?? ''}$delimiter'
        '${data.stateProvince ?? ''}$delimiter'
        '${data.county ?? ''}$delimiter'
        '${data.municipality ?? ''}$delimiter'
        '"${data.locality ?? ''}"$delimiter';
  }

  String _getCountry(String? country) {
    if (country == null) {
      return '';
    } else {
      return '$country: ';
    }
  }

  String _getStateProvince(String? stateProvince) {
    if (stateProvince == null) {
      return '';
    } else {
      return '$stateProvince; ';
    }
  }

  String _getCounty(String? county) {
    if (county == null) {
      return '';
    } else {
      return '$county; ';
    }
  }

  String _getMunicipality(String? municipality) {
    if (municipality == null) {
      return '';
    } else {
      return '$municipality; ';
    }
  }

  String _getLocality(String? locality) {
    if (locality == null) {
      return '';
    } else {
      return '"$locality"';
    }
  }

  Future<String> getCoordinates(int? siteID) async {
    if (siteID == null) {
      return '';
    } else {
      List<CoordinateData> coordinateList =
          await CoordinateServices(ref: ref).getCoordinatesBySiteID(siteID);
      return coordinateList
          .map((e) => '${e.nameId ?? ''};'
              '${e.decimalLatitude ?? ''},${e.decimalLongitude ?? ''};'
              '${e.elevationInMeter ?? ''}m;±${e.uncertaintyInMeters ?? ''}m;'
              '${e.datum ?? ''};${e.gpsUnit ?? ''}')
          .join(writerSeparator);
    }
  }
}
