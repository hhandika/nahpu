import 'package:drift/drift.dart';
import 'package:nahpu/services/database/database.dart';

part 'site_queries.g.dart';

@DriftAccessor(
  include: {'tables.drift'},
)
class SiteQuery extends DatabaseAccessor<Database> with _$SiteQueryMixin {
  SiteQuery(Database db) : super(db);

  Future<int> createSite(SiteCompanion form) => into(site).insert(form);

  Future updateSiteEntry(int id, SiteCompanion entry) {
    return (update(site)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<List<SiteData>> getAllSites(String projectUuid) {
    return (select(site)..where((t) => t.projectUuid.equals(projectUuid)))
        .get();
  }

  Future<void> createSiteMedia(SiteMediaCompanion form) {
    return into(siteMedia).insert(form);
  }

  Future<List<SiteMediaData>> getSiteMedia(int siteId) {
    return (select(siteMedia)..where((t) => t.siteId.equals(siteId))).get();
  }

  Future<void> updateSiteMedia(int siteId, SiteMediaCompanion form) {
    return (update(siteMedia)..where((t) => t.siteId.equals(siteId)))
        .write(form);
  }

  Future<void> deleteSiteMedia(int mediaId) {
    return (delete(siteMedia)..where((t) => t.mediaId.equals(mediaId))).go();
  }

  Future<void> deleteAllSiteMedias(int siteID) {
    return (delete(siteMedia)..where((t) => t.siteId.equals(siteID))).go();
  }

  Future<void> deleteSite(int id) {
    return (delete(site)..where((t) => t.id.equals(id))).go();
  }

  Future<SiteData> getSiteById(int id) async {
    return await (select(site)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> deleteAllSites(String projectUuid) {
    return (delete(site)..where((t) => t.projectUuid.equals(projectUuid))).go();
  }
}
