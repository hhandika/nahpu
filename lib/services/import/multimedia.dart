import 'dart:io';

import 'package:exif/exif.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:path/path.dart' as path;

const String mediaDir = 'media';

class ImageServices extends DbAccess {
  const ImageServices({required super.ref, required this.category});

  final MediaCategory category;

  Future<File> getMediaPath(String filePath) async {
    Directory projectDir = await FileServices(ref: ref).currentProjectDir;
    Directory mediaDir = _getMediaDir();
    String fullPath = path.join(projectDir.path, mediaDir.path, filePath);
    return File(fullPath);
  }

  Future<List<String>> pickImages() async {
    switch (systemPlatform) {
      case PlatformType.mobile:
        return await pickFromGallery();
      case PlatformType.desktop:
        return await pickFromFiles();
      case PlatformType.unknown:
        throw Exception('Unsupported platform');
      default:
        return [];
    }
  }

  Future<String> pickImageSingle() async {
    switch (systemPlatform) {
      case PlatformType.mobile:
        return await pickFromGallerySingle();
      case PlatformType.desktop:
        return await pickFromFileSingle();
      case PlatformType.unknown:
        throw Exception('Unsupported platform');
      default:
        return '';
    }
  }

  Future<String?> accessCamera() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.camera);
    File? files = result == null ? null : await _copySingleFile(result.path);
    return files?.path;
  }

  Future<String> pickFromGallerySingle() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);
    File? file = result == null ? null : await _copySingleFile(result.path);
    return file?.path ?? '';
  }

  Future<List<String>> pickFromGallery() async {
    final picker = ImagePicker();
    final result = await picker.pickMultiImage();
    List<File> files = await _copyFiles(result.map((e) => e.path).toList());
    return files.map((e) => e.path).toList();
  }

  Future<List<String>> pickFromFiles() async {
    List<File> result = await FilePickerServices()
        .pickMultiFiles(['jpg', 'png', 'jpeg', 'heic']);
    List<File> files = await _copyFiles(result.map((e) => e.path).toList());
    return files.map((e) => e.path).toList();
  }

  Future<String> pickFromFileSingle() async {
    File? result =
        await FilePickerServices().selectFile(['jpg', 'png', 'jpeg']);
    File? file = result == null ? null : await _copySingleFile(result.path);
    return file?.path ?? '';
  }

  Future<List<File>> _copyFiles(List<String> paths) async {
    List<File> files = [];
    for (String path in paths) {
      File newPath = await _copySingleFile(path);
      files.add(newPath);
    }
    return files;
  }

  Future<File> _copySingleFile(String path) async {
    File file = File(path);
    File newPath =
        await FileServices(ref: ref).copyFileToProjectDir(file, _getMediaDir());
    return newPath;
  }

  Directory _getMediaDir() {
    switch (category) {
      case MediaCategory.site:
        return Directory('$mediaDir/site');
      case MediaCategory.specimen:
        return Directory('$mediaDir/specimen');
      case MediaCategory.narrative:
        return Directory('$mediaDir/narrative');
      case MediaCategory.personnel:
        return Directory('$mediaDir/personnel');
      default:
        throw Exception('Unsupported media category');
    }
  }
}

class ExifData {
  ExifData({
    required this.dateTaken,
    required this.camera,
    required this.lenseModel,
    required this.additionalExif,
  });

  String dateTaken;
  String camera;
  String lenseModel;
  String additionalExif;

  factory ExifData.empty() {
    return ExifData(
      dateTaken: '',
      camera: '',
      lenseModel: '',
      additionalExif: '',
    );
  }

  Future<void> readExif(File file) async {
    try {
      final Map<String, IfdTag> exif =
          await readExifFromBytes(await file.readAsBytes());
      _getExifDate(exif);
      _getExifCameraModel(exif);
      _getExifLenseModel(exif);
      String focalLength = _getExifFocalLength(exif);
      String aperture = _getExifAperture(exif);
      String exposure = _getExifExposureTime(exif);
      String iso = _getExifIso(exif);
      List<String> exifList = [focalLength, aperture, exposure, iso];
      additionalExif = exifList.join(listTileSeparator);
    } catch (e) {
      return;
    }
  }

  void _getExifDate(Map<String, IfdTag> exif) {
    final IfdTag? dateTag = exif['Image DateTime'];
    if (dateTag != null) {
      dateTaken = dateTag.toString();
    }
  }

  void _getExifCameraModel(Map<String, IfdTag> exif) {
    final IfdTag? cameraMakerTag = exif['Image Make'];
    final IfdTag? cameraModelTag = exif['Image Model'];
    String cameraMaker = cameraMakerTag?.toString() ?? 'Unknown maker';
    String cameraModel = cameraModelTag?.toString() ?? 'Unknown model';

    camera = '$cameraMaker $cameraModel';
  }

  void _getExifLenseModel(Map<String, IfdTag> exif) {
    final IfdTag? lenseModelTag = exif['EXIF LensModel'];
    lenseModel = lenseModelTag?.toString() ?? 'Unknown lenses';
  }

  String _getExifFocalLength(Map<String, IfdTag> exif) {
    final IfdTag? focalLengthTag = exif['EXIF FocalLength'];
    return '${focalLengthTag?.toString() ?? '?'} mm';
  }

  String _getExifExposureTime(Map<String, IfdTag> exif) {
    final IfdTag? exposureTimeTag = exif['EXIF ExposureTime'];
    return '${exposureTimeTag?.toString() ?? '?'}s';
  }

  String _getExifAperture(Map<String, IfdTag> exif) {
    final IfdTag? apertureTag = exif['EXIF FNumber'];
    if (apertureTag == null) {
      return 'F?';
    }

    return 'F${_calculateAperture(apertureTag.toString())}';
  }

  double _calculateAperture(String aperture) {
    if (aperture.contains('/')) {
      List<String> apertureList = aperture.split('/');
      double numerator = double.parse(apertureList[0]);
      double denominator = double.parse(apertureList[1]);
      return numerator / denominator;
    }
    return double.tryParse(aperture) ?? 0.0;
  }

  String _getExifIso(Map<String, IfdTag> exif) {
    final IfdTag? isoTag = exif['EXIF ISOSpeedRatings'];
    return 'ISO${isoTag?.toString() ?? '?'}';
  }
}

List<String> parseMediaDateTime(String value) {
  if (value.isEmpty || !value.contains(' ')) {
    return ['', ''];
  }
  List<String> dateTime = value.split(' ');
  DateTime date = DateTime.parse(dateTime[0].replaceAll(':', '-'));
  String time = DateFormat.jm().format(date);
  String parsedDate = DateFormat.yMMMMd().format(date);
  return [parsedDate, time];
}
