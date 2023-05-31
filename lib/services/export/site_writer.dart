import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/export/common.dart';
import 'package:nahpu/services/site_services.dart';

class SiteWriterServices {
  SiteWriterServices({
    required this.ref,
    required this.siteID,
    required this.delimiter,
  });

  final WidgetRef ref;
  final int? siteID;
  final String delimiter;

  Future<String> getSiteDetails(bool withHabitat) async {
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
        String siteDetails =
            '$country$stateProvince$county$municipality$locality'.trim();
        String siteLocality = '$siteSeparated$siteDetails';
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

  Future<String> getCoordinates() async {
    if (siteID == null) {
      return '';
    } else {
      List<CoordinateData> coordinateList =
          await CoordinateServices(ref: ref).getCoordinatesBySiteID(siteID!);
      return coordinateList
          .map((e) => '${e.nameId ?? ''};'
              '${e.decimalLatitude ?? ''},${e.decimalLongitude ?? ''};'
              '${e.elevationInMeter ?? ''}m;±${e.uncertaintyInMeters ?? ''}m;'
              '${e.datum ?? ''};${e.gpsUnit ?? ''}')
          .join(writerSeparator);
    }
  }
}
