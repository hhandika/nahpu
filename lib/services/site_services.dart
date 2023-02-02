import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database.dart';
import 'package:nahpu/services/site_queries.dart';

class SiteServices {
  SiteServices(this.ref);

  final WidgetRef ref;

  void updateSite(int id, SiteCompanion entries) {
    SiteQuery(ref.read(databaseProvider)).updateSiteEntry(id, entries);
  }
}
