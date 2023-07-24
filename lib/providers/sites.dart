import 'package:nahpu/providers/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/media_queries.dart';
import 'package:nahpu/services/database/site_queries.dart';
import 'package:nahpu/services/database/coordinate_queries.dart';
import 'package:nahpu/services/site_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sites.g.dart';

@riverpod
class SiteEntry extends _$SiteEntry {
  Future<List<SiteData>> _fetchSiteEntry() async {
    final projectUuid = ref.watch(projectUuidProvider);

    final siteEntries =
        SiteQuery(ref.read(databaseProvider)).getAllSites(projectUuid);

    return siteEntries;
  }

  @override
  FutureOr<List<SiteData>> build() async {
    return await _fetchSiteEntry();
  }

  Future<void> search(String? query) async {
    if (query == null || query.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (state.value == null) return [];
      final projectUuid = ref.watch(projectUuidProvider);
      final sites =
          await SiteQuery(ref.read(databaseProvider)).getAllSites(projectUuid);

      final filteredSites =
          SiteSearchServices(siteEntries: sites).search(query.toLowerCase());
      return filteredSites;
    });
  }
}

final coordinateBySiteProvider = FutureProvider.family
    .autoDispose<List<CoordinateData>, int>((ref, siteId) =>
        CoordinateQuery(ref.read(databaseProvider))
            .getCoordinatesBySiteID(siteId));

final coordinateByEventProvider = FutureProvider.family
    .autoDispose<List<CoordinateData>, int>((ref, collEventId) async {
  final collEvent = await CollEventQuery(ref.read(databaseProvider))
      .getCollEventById(collEventId);
  if (collEvent.siteID != null) {
    final siteId = collEvent.siteID!;
    final coordinates = CoordinateQuery(ref.read(databaseProvider))
        .getCoordinatesBySiteID(siteId);
    return coordinates;
  } else {
    return [];
  }
});

@riverpod
Future<List<MediaData>> siteMedia(SiteMediaRef ref,
    {required int siteId}) async {
  List<SiteMediaData> mediaList =
      await SiteQuery(ref.read(databaseProvider)).getSiteMedia(siteId);
  List<MediaData> mediaDataList = [];
  for (SiteMediaData media in mediaList) {
    if (media.mediaId != null) {
      mediaDataList.add(
        await MediaDbQuery(ref.read(databaseProvider)).getMedia(media.mediaId!),
      );
    }
  }
  return mediaDataList;
}
