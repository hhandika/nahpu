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
        String verbatimLocality = _getVerbatimLocality(data);
        String siteDelimited = _getSiteDelimited(data);
        String coordinates = await getCoordinates(siteID);
        String siteLocality = '$siteDelimited$delimiter'
            '$verbatimLocality$delimiter$coordinates';
        return withHabitat
            ? '${data.siteID}$delimiter${data.habitatType}$delimiter$siteLocality'
            : siteLocality;
      }
    }
  }

  Future<String> getCoordinates(int? siteID) async {
    if (siteID == null) {
      return '';
    }
    List<CoordinateData> coordinateList =
        await CoordinateServices(ref: ref).getCoordinatesBySiteID(siteID);
    String coordinateDetails =
        coordinateList.map((e) => _getCoordinateData(e)).join(writerSeparator);

    return coordinateDetails;
  }

  Future<String> getCoordinateById(int? coordinateId) async {
    if (coordinateId == null) {
      return '';
    }
    CoordinateData? data =
        await CoordinateServices(ref: ref).getCoordinateById(coordinateId);
    if (data == null) {
      return '';
    } else {
      return _getCoordinateData(data);
    }
  }

  String _getCoordinateData(CoordinateData data) {
    String nameId = data.nameId != null ? '${data.nameId};' : 'No name';
    String latLong =
        data.decimalLatitude != null && data.decimalLongitude != null
            ? '${data.decimalLatitude},${data.decimalLongitude};'
            : 'Unknown Lat/Long;';
    String elevation =
        data.elevationInMeter != null || data.elevationInMeter == 0
            ? '${data.elevationInMeter}m;'
            : 'Unknown elevation;';
    String uncertainty =
        data.uncertaintyInMeters != null || data.uncertaintyInMeters == 0
            ? '±${data.uncertaintyInMeters}m;'
            : 'Unknown uncertainty;';
    String datum = data.datum != null ? '${data.datum};' : 'Unknown datum;';
    String gpsUnit =
        data.gpsUnit != null ? '${data.gpsUnit}' : 'Unknown GPS unit';
    String notes =
        data.notes != null || data.notes!.isNotEmpty ? '${data.notes}' : '';
    return '"$nameId$latLong$elevation$uncertainty$datum$gpsUnit$notes"';
  }

  String _getSiteDelimited(SiteData data) {
    String country =
        data.country != null ? '${data.country}$delimiter' : delimiter;
    String stateProvince = data.stateProvince != null
        ? '${data.stateProvince}$delimiter'
        : delimiter;
    String county =
        data.county != null ? '${data.county}$delimiter' : delimiter;
    String municipality =
        data.municipality != null ? '${data.municipality}$delimiter' : '';
    String specificLocality = data.locality != null ? '"${data.locality}"' : '';
    return '$country$stateProvince$county$municipality$specificLocality';
  }

  String _getVerbatimLocality(SiteData data) {
    String country = data.country != null ? '${data.country}: ' : '';
    String stateProvince =
        data.stateProvince != null ? '${data.stateProvince}; ' : '';
    String county = data.county != null ? '${data.county}; ' : '';
    String municipality =
        data.municipality != null ? '${data.municipality}; ' : '';
    String locality = data.locality != null ? '${data.locality}' : '';
    return '"$country$stateProvince$county$municipality$locality"';
  }
}
