import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nahpu/services/export/coll_event_writer.dart';
import 'package:nahpu/services/export/narrative_writer.dart';
import 'package:nahpu/services/export/record_writer.dart';
import 'package:nahpu/services/export/report_writer.dart';
import 'package:nahpu/services/export/site_writer.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:archive/archive_io.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/types/export.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:path/path.dart' as path;

class ArchiveServices extends DbAccess {
  const ArchiveServices({
    required super.ref,
    required this.outputFile,
  });

  final File outputFile;
  final isCsv = true;

  /// Compressed every file in the project directory
  /// into a single archive
  Future<void> createArchive() async {
    final projectDir = await FileServices(ref: ref).currentProjectDir;
    projectDir.createSync(recursive: true);
    try {
      await _writeReport();
      await _writeNarrativeRecord();
      await _writeSiteRecord();
      await _writeCollEventRecord();
      await _writeSpecimenRecords();

      // Create the archive
      ZipFileEncoder encoder = ZipFileEncoder();
      encoder.zipDirectory(
        projectDir,
        filename: outputFile.path,
      );
    } catch (e) {
      throw Exception('Error creating archive: $e');
    }
  }

  Future<void> _writeReport() async {
    final filePath = await _getSpeciesReportSavePath();
    if (filePath.existsSync()) {
      await filePath.delete();
    }

    return await ReportServices(ref: ref)
        .writeReport(filePath, ReportType.speciesCount);
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

  Future<void> _writeCollEventRecord() async {
    final filePath = await _getCollEventSavePath();
    bool isCsv = true;
    if (filePath.existsSync()) {
      await filePath.delete();
    }
    await CollEventRecordWriter(ref: ref, isCsv: isCsv).writeCollEventDelimited(
      filePath,
    );
  }

  Future<void> _writeSpecimenRecords() async {
    final recordType = await _getSpecimenRecordType();
    if (recordType.contains(SpecimenRecordType.birds)) {
      final File birdDir = await _getBirdSpecimenSavePath();
      await SpecimenRecordWriter(ref: ref, recordType: SpecimenRecordType.birds)
          .writeRecordDelimited(birdDir, isCsv);
    }
    SpecimenRecordType? mammalRecord = _getMammalRecordType(recordType);
    if (mammalRecord != null) {
      await _writeMammalSpecimenRecord(mammalRecord);
    }
    if (kDebugMode) print(recordType);
  }

  Future<void> _writeMammalSpecimenRecord(
      SpecimenRecordType mammalRecordType) async {
    final File mammalDir = await _getMammalSpecimenSavePath();

    await SpecimenRecordWriter(ref: ref, recordType: mammalRecordType)
        .writeRecordDelimited(mammalDir, isCsv);
  }

  SpecimenRecordType? _getMammalRecordType(
      List<SpecimenRecordType> recordType) {
    if (recordType.contains(SpecimenRecordType.generalMammals) &&
        recordType.contains(SpecimenRecordType.bats)) {
      return SpecimenRecordType.allMammals;
    } else if (recordType.contains(SpecimenRecordType.generalMammals)) {
      return SpecimenRecordType.generalMammals;
    } else if (recordType.contains(SpecimenRecordType.bats)) {
      return SpecimenRecordType.bats;
    } else {
      return null;
    }
  }

  Future<List<SpecimenRecordType>> _getSpecimenRecordType() async {
    List<String> taxonList =
        await SpecimenServices(ref: ref).getRecordedGroupList();
    List<SpecimenRecordType> specimenRecordTypeList = [];
    for (String taxon in taxonList) {
      final specimenRecordType = matchTaxonGroupToRecordType(taxon);
      specimenRecordTypeList.add(specimenRecordType);
    }
    return specimenRecordTypeList;
  }

  Future<File> _getMammalSpecimenSavePath() async {
    final dir = await _recordDir;
    final specimenFile =
        File(path.join(dir.path, 'mammal_specimen_records.csv'));
    return specimenFile;
  }

  Future<File> _getBirdSpecimenSavePath() async {
    final dir = await _recordDir;
    final specimenFile = File(path.join(dir.path, 'bird_specimen_records.csv'));
    return specimenFile;
  }

  Future<File> _getCollEventSavePath() async {
    final dir = await _recordDir;
    final collEventFile = File(path.join(dir.path, 'coll_event_records.csv'));
    return collEventFile;
  }

  Future<File> _getSiteSavePath() async {
    final dir = await _recordDir;
    final siteFile = File(path.join(dir.path, 'site_records.csv'));
    return siteFile;
  }

  Future<File> _getNarrativeSavePath() async {
    final dir = await _recordDir;
    final narrativeFile = File(path.join(dir.path, 'narrative_records.csv'));
    return narrativeFile;
  }

  Future<File> _getSpeciesReportSavePath() async {
    final dir = await _reportDir;
    final speciesFile = File(path.join(dir.path, 'species_records.csv'));
    return speciesFile;
  }

  Future<Directory> get _recordDir async {
    final projectDir = await FileServices(ref: ref).currentProjectDir;
    final recordDir = Directory(path.join(projectDir.path, 'records'));
    await recordDir.create(recursive: true);
    return recordDir;
  }

  Future<Directory> get _reportDir async {
    final projectDir = await FileServices(ref: ref).currentProjectDir;
    final reportDir = Directory(path.join(projectDir.path, 'reports'));
    await reportDir.create(recursive: true);
    return reportDir;
  }
}
