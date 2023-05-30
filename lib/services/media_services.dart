import 'package:nahpu/providers/narrative.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/media_queries.dart';
import 'package:nahpu/services/database/narrative_queries.dart';
import 'package:nahpu/services/database/site_queries.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/import.dart';

class MediaServices extends DbAccess {
  MediaServices(super.ref);

  Future<int> createMedia(MediaCompanion form) {
    return MediaDbQuery(dbAccess).createMedia(form);
  }

  Future<void> updateMedia(
      int mediaID, String category, MediaCompanion form) async {
    await MediaDbQuery(dbAccess).updateMedia(mediaID, form);
    MediaCategory mediaCategory = matchMediaCategoryString(category);
    _invalidateMedia(mediaCategory);
  }

  Future<List<MediaData>> getAllMedia() {
    return MediaDbQuery(dbAccess).getAllMedia();
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
    }
    _invalidateMedia(category);
  }

  void _invalidateMedia(MediaCategory category) {
    switch (category) {
      case MediaCategory.narrative:
        ref.invalidate(narrativeMediaProvider);
        break;
      case MediaCategory.site:
        // ref.invalidate(siteMediaProvider);
        break;
      case MediaCategory.specimen:
        // ref.invalidate(specimenMediaProvider);
        break;
    }
  }
}
