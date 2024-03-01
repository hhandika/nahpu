import 'dart:io';

import 'package:nahpu/providers/narrative.dart';
import 'package:nahpu/providers/sites.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/media_queries.dart';
import 'package:nahpu/services/database/narrative_queries.dart';
import 'package:nahpu/services/database/site_queries.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/import/multimedia.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:drift/drift.dart' as db;
import 'package:path/path.dart' as path;

class MediaServices extends AppServices {
  const MediaServices({required super.ref});

  Future<int> createMedia(MediaCompanion form) {
    return MediaDbQuery(dbAccess).createMedia(form);
  }

  Future<void> updateMedia(
      int mediaID, String category, MediaCompanion form) async {
    await MediaDbQuery(dbAccess).updateMedia(mediaID, form);
    MediaCategory mediaCategory = matchMediaCategoryString(category);
    _invalidateMedia(mediaCategory);
  }

  Future<MediaData> getMediaById(int primaryId) async {
    return await MediaDbQuery(dbAccess).getMedia(primaryId);
  }

  Future<bool> isImageUsed(File file) async {
    final String fileName = path.basename(file.path);
    return await MediaDbQuery(dbAccess).isImageUsed(fileName);
  }

  Future<void> renameMedia(int mediaID, String oldName, String newName,
      MediaCategory category) async {
    if (oldName == newName || newName.isEmpty) {
      return;
    }
    File oldPath =
        await ImageServices(ref: ref, category: category).getMediaPath(oldName);
    if (!oldPath.existsSync()) {
      throw Exception('File not found');
    }

    String ext = path.extension(oldPath.path);
    newName = newName.contains(' ') ? newName.replaceAll(' ', '_') : newName;
    String finalName = newName + ext;
    File newPath = await ImageServices(ref: ref, category: category)
        .getMediaPath(finalName);
    if (newPath.existsSync()) {
      throw Exception('File exists');
    }
    try {
      await oldPath.rename(newPath.path);
      await MediaDbQuery(dbAccess).updateMedia(
          mediaID,
          MediaCompanion(
            fileName: db.Value(finalName),
          ));
    } catch (e) {
      throw Exception('Failed to rename file');
    }

    _invalidateMedia(category);
  }

  Future<List<MediaData>> getAllMediaByProject() {
    return MediaDbQuery(dbAccess).getMediaByProject(currentProjectUuid);
  }

  Future<void> deleteMedia(int id, String category) async {
    MediaCategory mediaCategory = matchMediaCategoryString(category);
    await _deleteMatchingCategory(id, mediaCategory);
    await MediaDbQuery(dbAccess).deleteMedia(id);
  }

  Future<void> _deleteMatchingCategory(int id, MediaCategory category) async {
    switch (category) {
      case MediaCategory.narrative:
        await NarrativeQuery(dbAccess).deleteNarrativeMedia(id);

        break;
      case MediaCategory.site:
        await SiteQuery(dbAccess).deleteSiteMedia(id);
        break;
      case MediaCategory.specimen:
        await SpecimenQuery(dbAccess).deleteSpecimenMedia(id);
        break;
      case MediaCategory.personnel:
        break;
    }
    _invalidateMedia(category);
  }

  void _invalidateMedia(MediaCategory category) {
    switch (category) {
      case MediaCategory.narrative:
        ref.invalidate(narrativeMediaProvider);
        break;
      case MediaCategory.site:
        ref.invalidate(siteMediaProvider);
        break;
      case MediaCategory.specimen:
        ref.invalidate(specimenMediaProvider);
        break;
      case MediaCategory.personnel:
        break;
    }
  }
}
