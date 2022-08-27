import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';

void updateSite(int id, SiteCompanion site, WidgetRef ref) {
  ref.read(databaseProvider).updateSiteEntry(id, site);
}

void updateNarrative(int id, NarrativeCompanion entries, WidgetRef ref) {
  ref.read(databaseProvider).updateNarrativeEntry(id, entries);
}
