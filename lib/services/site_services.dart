import 'package:nahpu/providers/sites.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/coordinate_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/media_queries.dart';
import 'package:nahpu/services/database/site_queries.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:path/path.dart';

class SiteServices extends DbAccess {
  const SiteServices({required super.ref});

  Future<int> createNewSite(String projectUuid) async {
    int siteID = await SiteQuery(dbAccess).createSite(SiteCompanion(
      projectUuid: db.Value(projectUuid),
    ));
    invalidateSite();
    return siteID;
  }

  Future<SiteData?> getSite(int? id) async {
    if (id == null) {
      return null;
    } else {
      return SiteQuery(dbAccess).getSiteById(id);
    }
  }

  Future<List<SiteData>> getAllSites() async {
    return SiteQuery(dbAccess).getAllSites(projectUuid);
  }

  Future<void> updateSite(int id, SiteCompanion entries) async {
    await SiteQuery(dbAccess).updateSiteEntry(id, entries);
  }

  Future<void> createSiteMedia(int siteId, String filePath) async {
    int mediaId = await MediaDbQuery(dbAccess).createMedia(MediaCompanion(
      projectUuid: db.Value(projectUuid),
      fileName: db.Value(basename(filePath)),
      category: db.Value(matchMediaCategory(MediaCategory.site)),
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

  Future<void> deleteSite(int id) async {
    await CoordinateServices(ref: ref).deleteCoordinateBySiteID(id);
    await SiteQuery(dbAccess).deleteAllSiteMedias(id);
    await SiteQuery(dbAccess).deleteSite(id);
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
