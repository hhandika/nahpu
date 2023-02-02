import 'package:drift/drift.dart';
import 'package:nahpu/services/database.dart';

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

  Future<void> deleteSite(String siteId) {
    return (delete(site)..where((t) => t.siteID.equals(siteId))).go();
  }

  Future<SiteData> getSiteById(int id) async {
    return await (select(site)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> deleteAllSites(String projectUuid) {
    return (delete(site)..where((t) => t.projectUuid.equals(projectUuid))).go();
  }
}
