import 'package:nahpu/providers/database.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/media_queries.dart';
import 'package:nahpu/services/database/narrative_queries.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'narrative.g.dart';

final narrativeEntryProvider =
    FutureProvider.autoDispose<List<NarrativeData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final narrativeEntries =
      NarrativeQuery(ref.read(databaseProvider)).getAllNarrative(projectUuid);
  return narrativeEntries;
});

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
