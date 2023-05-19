import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/coordinate_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/site_queries.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/io_services.dart';

class SiteServices extends DbAccess {
  SiteServices(super.ref);

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

  Future<void> updateSite(int id, SiteCompanion entries) async {
    await SiteQuery(dbAccess).updateSiteEntry(id, entries);
  }

  Future<void> deleteSite(int id) async {
    await SiteQuery(dbAccess).deleteSite(id);
    await CoordinateServices(ref).deleteCoordinateBySiteID(id);
    invalidateSite();
  }

  void deleteAllSites() {
    final projectUuid = ref.read(projectUuidProvider);
    SiteQuery(dbAccess).deleteAllSites(projectUuid);
    invalidateSite();
  }

  void invalidateSite() {
    ref.invalidate(siteEntryProvider);
  }
}

class CoordinateServices extends DbAccess {
  CoordinateServices(super.ref);

  Future<List<CoordinateData>> getCoordinatesBySiteID(int siteID) async {
    return CoordinateQuery(dbAccess).getCoordinatesBySiteID(siteID);
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
