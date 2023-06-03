import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/export/common.dart';
import 'package:nahpu/services/media_services.dart';
import 'package:nahpu/services/narrative_services.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/site_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/types/export.dart';
import 'package:nahpu/services/utility_services.dart';

class MediaWriterServices {
  MediaWriterServices({
    required this.ref,
    this.delimiter = csvDelimiter,
  });

  final WidgetRef ref;
  String delimiter;

  Future<void> writeAllMediaDelimited(File filePath, bool isCsv) async {
    delimiter = isCsv ? csvDelimiter : tsvDelimiter;

    final file = await filePath.create(recursive: true);
    final writer = file.openWrite();

    String header = allMediaExportList.join(delimiter);
    writer.writeln(header);

    List<MediaData> mediaList =
        await MediaServices(ref: ref).getAllMediaByProject();

    for (var media in mediaList) {
      List<String> mediaDetails = await _getMedia(media);
      writer.writeln(mediaDetails.map((e) => '"$e"').join(delimiter));
    }

    writer.close();
  }

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
    return await _getConcatenateMediaData(mediaDataList);
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
    return await _getConcatenateMediaData(mediaDataList);
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

    return await _getConcatenateMediaData(mediaDataList);
  }

  Future<String> _getConcatenateMediaData(List<MediaData> data) async {
    List<String> mediaDetails = await Future.wait(data.map((e) async {
      List<String> mediaList = await _getMedia(e);
      mediaList.removeWhere((e) => e.isEmpty);
      return mediaList.join(';');
    }));
    String mediaDetailsString = mediaDetails.join(writerSeparator);
    return '"$mediaDetailsString"';
  }

  Future<List<String>> _getMedia(MediaData data) async {
    String category = data.category != null ? '${data.category}' : '';
    String tag = data.tag != null ? '${data.tag}' : '';
    String camera = data.camera != null ? '${data.camera}' : 'unknown camera';
    String dateTaken = data.taken != null ? '${data.taken}' : 'unknown date';
    String lenseModel =
        data.lenses != null ? '${data.lenses}' : 'unknown lenses';
    String photographer = await _getPhotographer(data.personnelId);
    String additionalExif = _cleanAdditionalExif(data.additionalExif);
    String fileName = data.fileName != null ? '${data.fileName}' : '';
    String caption = data.caption != null ? '${data.caption}' : '';

    return [
      category,
      caption,
      photographer,
      tag,
      dateTaken,
      camera,
      lenseModel,
      additionalExif,
      fileName,
    ];
  }

  Future<String> _getPhotographer(String? photographerUuid) async {
    if (photographerUuid == null || photographerUuid.isEmpty) {
      return '';
    }
    PersonnelData photographer =
        await PersonnelServices(ref: ref).getPersonnelByUuid(photographerUuid);
    return '${photographer.name}';
  }

  String _cleanAdditionalExif(String? addExif) {
    if (addExif == null) {
      return '';
    }
    String addExifClean = addExif.replaceAll(listTileSeparator, ' ');
    return addExifClean;
  }
}
