import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/coordinate_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/site_queries.dart';
import 'package:drift/drift.dart' as db;

class SiteServices extends DbAccess {
  SiteServices(super.ref);

  Database get dbase => ref.read(databaseProvider);

  Future<int> createNewSite(String projectUuid) async {
    int siteID = await SiteQuery(dbase).createSite(SiteCompanion(
      projectUuid: db.Value(projectUuid),
    ));
    invalidateSite();
    return siteID;
  }

  Future<SiteData?> getSite(int? id) async {
    if (id == null) {
      return null;
    } else {
      return SiteQuery(dbase).getSiteById(id);
    }
  }

  Future<void> updateSite(int id, SiteCompanion entries) async {
    await SiteQuery(dbase).updateSiteEntry(id, entries);
  }

  Future<void> deleteSite(int id) async {
    await SiteQuery(dbase).deleteSite(id);
    await CoordinateServices(ref).deleteCoordinateBySiteID(id);
    invalidateSite();
  }

  void deleteAllSites() {
    // TODO: prevent deletion of records if they are in used
    final projectUuid = ref.read(projectUuidProvider);
    SiteQuery(dbase).deleteAllSites(projectUuid);
    invalidateSite();
  }

  void invalidateSite() {
    ref.invalidate(siteEntryProvider);
  }
}

class CoordinateServices extends DbAccess {
  CoordinateServices(super.ref);

  Database get dbase => ref.read(databaseProvider);

  Future<List<CoordinateData>> getCoordinatesBySiteID(int siteID) async {
    return CoordinateQuery(dbase).getCoordinatesBySiteID(siteID);
  }

  Future<void> createCoordinate(CoordinateCompanion form) async {
    await CoordinateQuery(dbase).createCoordinate(form);
  }

  Future<void> updateCoordinate(
      int coordinateId, CoordinateCompanion form) async {
    await CoordinateQuery(dbase).updateCoordinate(coordinateId, form);
  }

  Future<void> deleteCoordinateBySiteID(int siteID) async {
    await CoordinateQuery(dbase).deleteCoordinateBySiteID(siteID);
  }

  Future<void> deleteCoordinate(int coordinateId) async {
    await CoordinateQuery(dbase).deleteCoordinate(coordinateId);
  }
}
