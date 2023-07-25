import 'package:nahpu/providers/database.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/media_queries.dart';
import 'package:nahpu/services/database/narrative_queries.dart';
import 'package:nahpu/services/narrative_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'narrative.g.dart';

@riverpod
class NarrativeEntry extends _$NarrativeEntry {
  Future<List<NarrativeData>> _fetchNarrativeEntry() async {
    final projectUuid = ref.watch(projectUuidProvider);

    final narrativeEntries =
        NarrativeQuery(ref.read(databaseProvider)).getAllNarrative(projectUuid);

    return narrativeEntries;
  }

  @override
  FutureOr<List<NarrativeData>> build() async {
    return await _fetchNarrativeEntry();
  }

  Future<void> search(String? query) async {
    if (query == null || query.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (state.value == null) return [];
      final narratives = await _fetchNarrativeEntry();
      final filteredNarratives =
          NarrativeSearchServices(narrativeEntries: narratives)
              .search(query.toLowerCase());
      return filteredNarratives;
    });
  }
}

@riverpod
Future<List<MediaData>> narrativeMedia(NarrativeMediaRef ref,
    {required int narrativeId}) async {
  List<NarrativeMediaData> mediaList =
      await NarrativeQuery(ref.read(databaseProvider))
          .getNarrativeMedia(narrativeId);
  List<MediaData> mediaDataList = [];
  for (NarrativeMediaData media in mediaList) {
    if (media.mediaId != null) {
      mediaDataList.add(
        await MediaDbQuery(ref.read(databaseProvider)).getMedia(media.mediaId!),
      );
    }
  }
  return mediaDataList;
}
