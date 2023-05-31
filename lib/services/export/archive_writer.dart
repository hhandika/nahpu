import 'dart:io';

import 'package:nahpu/services/export/narrative_writer.dart';
import 'package:nahpu/services/export/site_writer.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as path;

class ArchiveServices extends DbAccess {
  const ArchiveServices({
    required super.ref,
    required this.outputFile,
  });

  final File outputFile;

  /// Compressed every file in the project directory
  /// into a single archive
  Future<void> createArchive() async {
    final projectDir = await FileServices(ref: ref).currentProjectDir;
    projectDir.createSync(recursive: true);
    await _writeNarrativeRecord();
    await _writeSiteRecord();
    await _writeSpecimenRecords();
    // Create the archive
    ZipFileEncoder encoder = ZipFileEncoder();
    encoder.zipDirectory(
      projectDir,
      filename: outputFile.path,
    );
  }

  Future<void> _writeNarrativeRecord() async {
    final filePath = await _getNarrativeSavePath();
    bool isCsv = true;
    if (filePath.existsSync()) {
      await filePath.delete();
    }
    await NarrativeRecordWriter(ref: ref).writeNarrativeDelimited(
      filePath,
      isCsv,
    );
  }

  Future<void> _writeSiteRecord() async {
    final filePath = await _getSiteSavePath();
    bool isCsv = true;
    if (filePath.existsSync()) {
      await filePath.delete();
    }
    await SiteWriterServices(ref: ref).writeSiteDelimited(
      filePath,
      isCsv,
    );
  }

  Future<void> _writeSpecimenRecords() async {
    _getBirdSpecimenSavePath();
    _getMammalSpecimenSavePath();
    // await _writeMammalSpecimenRecords();
    // await _writeBirdSpecimenRecords();
  }

  Future<File> _getMammalSpecimenSavePath() async {
    final specimenDir = await _getSpecimenDir();
    final specimenFile =
        File(path.join(specimenDir.path, 'mammal_specimen_records.csv'));
    return specimenFile;
  }

  Future<File> _getBirdSpecimenSavePath() async {
    final specimenDir = await _getSpecimenDir();
    final specimenFile =
        File(path.join(specimenDir.path, 'bird_specimen_records.csv'));
    return specimenFile;
  }

  Future<Directory> _getSpecimenDir() async {
    final projectDir = await FileServices(ref: ref).currentProjectDir;
    final specimenDir = Directory(path.join(projectDir.path, 'specimen'));
    await specimenDir.create(recursive: true);
    return specimenDir;
  }

  Future<File> _getSiteSavePath() async {
    final projectDir = await FileServices(ref: ref).currentProjectDir;
    final siteDir = Directory(path.join(projectDir.path, 'site'));
    await siteDir.create(recursive: true);
    final siteFile = File(path.join(siteDir.path, 'site_records.csv'));
    return siteFile;
  }

  Future<File> _getNarrativeSavePath() async {
    final projectDir = await FileServices(ref: ref).currentProjectDir;
    final narrativeDir = Directory(path.join(projectDir.path, 'narrative'));
    await narrativeDir.create(recursive: true);
    final narrativeFile =
        File(path.join(narrativeDir.path, 'narrative_records.csv'));
    return narrativeFile;
  }
}
