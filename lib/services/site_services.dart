import 'dart:io';

import 'package:nahpu/providers/sites.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/coordinate_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/media_queries.dart';
import 'package:nahpu/services/database/site_queries.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/import/multimedia.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:path/path.dart';

class SiteServices extends DbAccess {
  const SiteServices({required super.ref});

  Future<int> createNewSite() async {
    int siteID = await SiteQuery(dbAccess).createSite(SiteCompanion(
      projectUuid: db.Value(currentProjectUuid),
    ));
    invalidateSite();
    return siteID;
  }

  Future<void> duplicateSite(int originID) async {
    SiteData? siteData = await getSite(originID);
    if (siteData == null) {
      return;
    }
    int _ = await SiteQuery(dbAccess).createSite(SiteCompanion(
      projectUuid: db.Value(currentProjectUuid),
      leadStaffId: db.Value(siteData.leadStaffId),
      siteType: db.Value(siteData.siteType),
      country: db.Value(siteData.country),
      stateProvince: db.Value(siteData.stateProvince),
      county: db.Value(siteData.county),
      municipality: db.Value(siteData.municipality),
      locality: db.Value(siteData.locality),
      remark: db.Value(siteData.remark),
      habitatType: db.Value(siteData.habitatType),
      habitatCondition: db.Value(siteData.habitatCondition),
      habitatDescription: db.Value(siteData.habitatDescription),
    ));
    invalidateSite();
  }

  Future<SiteData?> getSite(int? id) async {
    if (id == null) {
      return null;
    } else {
      return await SiteQuery(dbAccess).getSiteById(id);
    }
  }

  Future<List<SiteData>> getAllSites() async {
    return SiteQuery(dbAccess).getAllSites(currentProjectUuid);
  }

  Future<void> updateSite(int id, SiteCompanion entries) async {
    await SiteQuery(dbAccess).updateSiteEntry(id, entries);
  }

  Future<void> createSiteMedia(int siteId, String filePath) async {
    ExifData exifData = ExifData.empty();
    await exifData.readExif(File(filePath));

    int mediaId = await MediaDbQuery(dbAccess).createMedia(MediaCompanion(
      projectUuid: db.Value(currentProjectUuid),
      fileName: db.Value(basename(filePath)),
      category: db.Value(matchMediaCategory(MediaCategory.site)),
      taken: db.Value(exifData.dateTaken),
      camera: db.Value(exifData.camera),
      lenses: db.Value(exifData.lenseModel),
      additionalExif: db.Value(exifData.additionalExif),
    ));
    SiteMediaCompanion entries = SiteMediaCompanion(
      siteId: db.Value(siteId),
      mediaId: db.Value(mediaId),
    );
    await SiteQuery(dbAccess).createSiteMedia(entries);
    ref.invalidate(siteMediaProvider);
  }

  Future<List<SiteMediaData>> getSiteMedia(int siteId) async {
    return SiteQuery(dbAccess).getSiteMedia(siteId);
  }

  Future<SiteMediaData> getSiteMediaByMediaId(int siteMediaId) async {
    return await SiteQuery(dbAccess).getSiteMediaById(siteMediaId);
  }

  Future<void> deleteSite(int id) async {
    try {
      await CoordinateServices(ref: ref).deleteCoordinateBySiteID(id);
      await SiteQuery(dbAccess).deleteAllSiteMedias(id);
      await SiteQuery(dbAccess).deleteSite(id);
    } catch (e) {
      rethrow;
    }

    invalidateSite();
  }

  Future<void> deleteAllSites() async {
    final projectUuid = ref.read(projectUuidProvider);
    await SiteQuery(dbAccess).deleteAllSites(projectUuid);
    invalidateSite();
  }

  void invalidateSite() {
    ref.invalidate(siteEntryProvider);
  }
}

class SiteSearchServices {
  const SiteSearchServices({required this.siteEntries});
  final List<SiteData> siteEntries;

  List<SiteData> search(String query) {
    final filteredSites = siteEntries
        .where((site) =>
            _isMatchSiteID(site.siteID, query) ||
            _isMatchSiteType(site.siteType, query) ||
            _isMatchCountry(site.country, query) ||
            _isMatchStateProvince(site.stateProvince, query) ||
            _isMatchCounty(site.county, query) ||
            _isMatchMunicipality(site.municipality, query) ||
            _isMatchLocality(site.locality, query) ||
            _isMatchRemark(site.remark, query) ||
            _isMatchHabitatType(site.habitatType, query) ||
            _isMatchHabitatCondition(site.habitatCondition, query) ||
            _isMatchHabitatDescription(site.habitatDescription, query))
        .toList();
    return filteredSites;
  }

  bool _isMatchSiteID(String? siteID, String query) {
    if (siteID == null) {
      return false;
    } else {
      return siteID.toLowerCase().contains(query);
    }
  }

  bool _isMatchSiteType(String? siteType, String query) {
    if (siteType == null) {
      return false;
    } else {
      return siteType.toLowerCase().contains(query);
    }
  }

  bool _isMatchCountry(String? country, String query) {
    if (country == null) {
      return false;
    } else {
      return country.toLowerCase().contains(query);
    }
  }

  bool _isMatchStateProvince(String? stateProvince, String query) {
    if (stateProvince == null) {
      return false;
    } else {
      return stateProvince.toLowerCase().contains(query);
    }
  }

  bool _isMatchCounty(String? county, String query) {
    if (county == null) {
      return false;
    } else {
      return county.toLowerCase().contains(query);
    }
  }

  bool _isMatchMunicipality(String? municipality, String query) {
    if (municipality == null) {
      return false;
    } else {
      return municipality.toLowerCase().contains(query);
    }
  }

  bool _isMatchLocality(String? locality, String query) {
    if (locality == null) {
      return false;
    } else {
      return locality.toLowerCase().contains(query);
    }
  }

  bool _isMatchRemark(String? remark, String query) {
    if (remark == null) {
      return false;
    } else {
      return remark.toLowerCase().contains(query);
    }
  }

  bool _isMatchHabitatType(String? habitatType, String query) {
    if (habitatType == null) {
      return false;
    } else {
      return habitatType.toLowerCase().contains(query);
    }
  }

  bool _isMatchHabitatCondition(String? habitatCondition, String query) {
    if (habitatCondition == null) {
      return false;
    } else {
      return habitatCondition.toLowerCase().contains(query);
    }
  }

  bool _isMatchHabitatDescription(String? habitatDescription, String query) {
    if (habitatDescription == null) {
      return false;
    } else {
      return habitatDescription.toLowerCase().contains(query);
    }
  }
}

class CoordinateServices extends DbAccess {
  const CoordinateServices({required super.ref});

  Future<List<CoordinateData>> getCoordinatesBySiteID(int siteID) async {
    return CoordinateQuery(dbAccess).getCoordinatesBySiteID(siteID);
  }

  Future<CoordinateData?> getCoordinateById(int coordinateId) async {
    return CoordinateQuery(dbAccess).getCoordinateById(coordinateId);
  }

  Future<void> createCoordinate(CoordinateCompanion form) async {
    await CoordinateQuery(dbAccess).createCoordinate(form);
  }

  Future<void> updateCoordinate(
      int coordinateId, CoordinateCompanion form) async {
    await CoordinateQuery(dbAccess).updateCoordinate(coordinateId, form);
  }

  Future<void> deleteCoordinateBySiteID(int siteID) async {
    await CoordinateQuery(dbAccess).deleteCoordinateBySiteID(siteID);
  }

  Future<void> deleteCoordinate(int coordinateId) async {
    await CoordinateQuery(dbAccess).deleteCoordinate(coordinateId);
  }
}
