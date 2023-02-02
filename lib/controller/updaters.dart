import 'package:nahpu/services/database.dart';
import 'package:nahpu/services/collevent_queries.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void updateSite(int id, SiteCompanion entries, WidgetRef ref) {
  ref.read(databaseProvider).updateSiteEntry(id, entries);
}

void updateNarrative(int id, NarrativeCompanion entries, WidgetRef ref) {
  ref.read(databaseProvider).updateNarrativeEntry(id, entries);
}

void updateCollEvent(int id, CollEventCompanion entries, WidgetRef ref) {
  CollEventQuery(ref.read(databaseProvider)).updateCollEventEntry(id, entries);
}
