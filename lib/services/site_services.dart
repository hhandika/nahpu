import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/site_queries.dart';
import 'package:drift/drift.dart' as db;

class SiteServices {
  SiteServices(this.ref);

  final WidgetRef ref;

  Future<int> createNewSite(String projectUuid) async {
    int siteID =
        await SiteQuery(ref.read(databaseProvider)).createSite(SiteCompanion(
      projectUuid: db.Value(projectUuid),
    ));
    invalidateSite();
    return siteID;
  }

  void updateSite(int id, SiteCompanion entries) {
    SiteQuery(ref.read(databaseProvider)).updateSiteEntry(id, entries);
  }

  void deleteSite(int id) {
    SiteQuery(ref.read(databaseProvider)).deleteSite(id);
    invalidateSite();
  }

  void deleteAllSites() {
    // TODO: prevent deletion of records if they are in used
    final projectUuid = ref.read(projectUuidProvider.notifier).state;
    SiteQuery(ref.read(databaseProvider)).deleteAllSites(projectUuid);
    invalidateSite();
  }

  void invalidateSite() {
    ref.invalidate(siteEntryProvider);
  }
}
