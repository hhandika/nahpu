import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/export/common.dart';
import 'package:nahpu/services/media_services.dart';
import 'package:nahpu/services/narrative_services.dart';
import 'package:nahpu/services/site_services.dart';
import 'package:nahpu/services/specimen_services.dart';

class MediaWriterServices {
  MediaWriterServices({
    required this.ref,
    this.delimiter = csvDelimiter,
  });

  final WidgetRef ref;
  String delimiter;

  Future<String> getSpecimenMedias(String specimenUuid) async {
    List<SpecimenMediaData> mediaList =
        await SpecimenServices(ref: ref).getSpecimenMedia(specimenUuid);
    List<MediaData> mediaDataList = [];
    for (var media in mediaList) {
      if (media.mediaId != null) {
        MediaData mediaData =
            await MediaServices(ref: ref).getMediaById(media.mediaId!);
        mediaDataList.add(mediaData);
      }
    }
    String mediaDetails =
        mediaDataList.map((e) => _getMedia(e)).join(writerSeparator);
    return '"$mediaDetails"';
  }

  Future<String> getSiteMedias(int? siteID) async {
    if (siteID == null) {
      return '';
    }
    List<SiteMediaData> mediaList =
        await SiteServices(ref: ref).getSiteMedia(siteID);
    List<MediaData> mediaDataList = [];
    for (var media in mediaList) {
      if (media.mediaId != null) {
        MediaData mediaData =
            await MediaServices(ref: ref).getMediaById(media.mediaId!);
        mediaDataList.add(mediaData);
      }
    }

    String mediaDetails =
        mediaDataList.map((e) => _getMedia(e)).join(writerSeparator);

    return '"$mediaDetails"';
  }

  Future<String> getNarrativeMedias(int? narrativeId) async {
    if (narrativeId == null) {
      return '';
    }
    List<NarrativeMediaData> mediaList =
        await NarrativeServices(ref: ref).getNarrativeMedia(narrativeId);
    List<MediaData> mediaDataList = [];
    for (var media in mediaList) {
      if (media.mediaId != null) {
        MediaData mediaData =
            await MediaServices(ref: ref).getMediaById(media.mediaId!);
        mediaDataList.add(mediaData);
      }
    }

    String mediaDetails =
        mediaDataList.map((e) => _getMedia(e)).join(writerSeparator);

    return '"$mediaDetails"';
  }

  String _getMedia(MediaData data) {
    String category = data.category != null ? '${data.category};' : '';
    String tag = data.tag != null ? '${data.tag};' : '';
    String camera = data.camera != null ? '${data.camera};' : 'unknown camera;';
    String taken = data.taken != null ? '${data.taken};' : 'unknown date;';
    String lenses = data.lenses != null ? '${data.lenses};' : 'unknown lenses;';
    String additionalExif =
        data.additionalExif != null ? '${data.additionalExif};' : '';
    String fileName = data.fileName != null ? '${data.fileName}' : '';
    String caption = data.caption != null ? '${data.caption}' : '';

    return '$category$tag'
        '$camera$taken$lenses$additionalExif'
        '$fileName$caption';
  }
}
