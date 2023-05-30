import 'package:nahpu/providers/narrative.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/media_queries.dart';
import 'package:nahpu/services/database/narrative_queries.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/io_services.dart';

class NarrativeServices extends DbAccess {
  NarrativeServices(super.ref);

  Future<int> createNewNarrative() async {
    int narrativeID =
        await NarrativeQuery(dbAccess).createNarrative(NarrativeCompanion(
      projectUuid: db.Value(projectUuid),
    ));
    invalidateNarrative();
    return narrativeID;
  }

  Future<List<NarrativeData>> getAllNarrative() async {
    return NarrativeQuery(dbAccess).getAllNarrative(projectUuid);
  }

  void updateNarrative(int id, NarrativeCompanion entries) {
    NarrativeQuery(dbAccess).updateNarrativeEntry(id, entries);
  }

  Future<void> createNarrativeMedia(int narrativeId, String filePath) async {
    int mediaId = await MediaQuery(dbAccess).createMedia(MediaCompanion(
      projectUuid: db.Value(projectUuid),
      filePath: db.Value(filePath),
    ));
    NarrativeMediaCompanion entries = NarrativeMediaCompanion(
      narrativeId: db.Value(narrativeId),
      mediaId: db.Value(mediaId),
    );
    await NarrativeQuery(dbAccess).createNarrativeMedia(entries);
  }

  Future<List<MediaData>> getNarrativeMedia(int narrativeId) async {
    List<NarrativeMediaData> mediaList =
        await NarrativeQuery(dbAccess).getNarrativeMedia(narrativeId);
    List<MediaData> mediaDataList = [];
    for (NarrativeMediaData media in mediaList) {
      if (media.mediaId != null) {
        mediaDataList.add(
          await MediaQuery(dbAccess).getMedia(media.mediaId!),
        );
      }
    }
    return mediaDataList;
  }

  void deleteNarrative(int id) {
    NarrativeQuery(dbAccess).deleteNarrative(id);
    invalidateNarrative();
  }

  void deleteAllNarrative(String projectUuid) {
    NarrativeQuery(dbAccess).deleteAllNarrative(projectUuid);
    invalidateNarrative();
  }

  void invalidateNarrative() {
    ref.invalidate(narrativeEntryProvider);
  }
}
