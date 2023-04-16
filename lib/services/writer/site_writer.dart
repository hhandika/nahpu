import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/database.dart';
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
      SiteData? data = await SiteServices(ref).getSite(siteID);

      if (data == null) {
        return '';
      } else {
        String siteDetails = '${data.country ?? ''}: ${data.stateProvince ?? ''};'
                ' ${data.county ?? ''}; ${data.municipality ?? ''}; ${data.locality ?? ''}'
            .trim();
        return withHabitat
            ? '${data.siteID}$delimiter${data.habitatType}$delimiter"$siteDetails"'
            : '"$siteDetails"';
      }
    }
  }

  Future<String> getCoordinates() async {
    if (siteID == null) {
      return '';
    } else {
      List<CoordinateData> coordinateList =
          await CoordinateServices(ref).getCoordinatesBySiteID(siteID!);
      return coordinateList
          .map((e) => '${e.nameId ?? ''};'
              '${e.decimalLatitude ?? ''},${e.decimalLongitude ?? ''};'
              '${e.elevationInMeter ?? ''}m;±${e.uncertaintyInMeters ?? ''}m;'
              '${e.datum ?? ''}')
          .join('|');
    }
  }
}
