import 'dart:io';

import 'package:nahpu/providers/narrative.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/media_queries.dart';
import 'package:nahpu/services/database/narrative_queries.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/import/multimedia.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:path/path.dart';

class NarrativeServices extends DbAccess {
  const NarrativeServices({required super.ref});

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
    ExifData exifData = ExifData.empty();
    await exifData.readExif(File(filePath));
    int mediaId = await MediaDbQuery(dbAccess).createMedia(MediaCompanion(
      projectUuid: db.Value(projectUuid),
      fileName: db.Value(basename(filePath)),
      category: db.Value(matchMediaCategory(MediaCategory.narrative)),
      taken: db.Value(exifData.dateTaken),
      camera: db.Value(exifData.camera),
      lenses: db.Value(exifData.lenseModel),
      additionalExif: db.Value(exifData.additionalExif),
    ));
    NarrativeMediaCompanion entries = NarrativeMediaCompanion(
      narrativeId: db.Value(narrativeId),
      mediaId: db.Value(mediaId),
    );
    await NarrativeQuery(dbAccess).createNarrativeMedia(entries);
    ref.invalidate(narrativeMediaProvider);
  }

  Future<List<NarrativeMediaData>> getNarrativeMedia(int narrativeId) async {
    return NarrativeQuery(dbAccess).getNarrativeMedia(narrativeId);
  }

  void deleteNarrative(int id) {
    deleteAllNarrativeMedia(id);
    NarrativeQuery(dbAccess).deleteNarrative(id);
    invalidateNarrative();
  }

  Future<void> deleteAllNarrativeMedia(int narrativeId) async {
    await NarrativeQuery(dbAccess).deleteAllNarrativeMedia(narrativeId);
  }

  Future<void> deleteAllNarrative(String projectUuid) async {
    List<NarrativeData> narratives =
        await NarrativeQuery(dbAccess).getAllNarrative(projectUuid);
    for (NarrativeData narrative in narratives) {
      await deleteAllNarrativeMedia(narrative.id);
    }
    NarrativeQuery(dbAccess).deleteAllNarrative(projectUuid);
    invalidateNarrative();
  }

  void invalidateNarrative() {
    ref.invalidate(narrativeEntryProvider);
  }
}
