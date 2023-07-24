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
            _isMatch(site.siteID, query) ||
            _isMatch(site.siteType, query) ||
            _isMatch(site.country, query) ||
            _isMatch(site.stateProvince, query) ||
            _isMatch(site.county, query) ||
            _isMatch(site.municipality, query) ||
            _isMatch(site.locality, query) ||
            _isMatch(site.remark, query) ||
            _isMatch(site.habitatType, query) ||
            _isMatch(site.habitatCondition, query) ||
            _isMatch(site.habitatDescription, query))
        .toList();
    return filteredSites;
  }

  bool _isMatch(String? value, String query) {
    if (value == null) {
      return false;
    } else {
      return value.toLowerCase().contains(query);
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
