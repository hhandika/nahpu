import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:nahpu/providers/taxa.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/import/taxon_entry.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/utility_services.dart';

class TaxonEntryReader extends AppServices {
  const TaxonEntryReader({required super.ref});

  Future<CsvData> parseCsv(File inputFile) async {
    try {
      final reader = inputFile.openRead();
      const eolDetector = FirstOccurrenceSettingsDetector(
        eols: ['\r\n', '\n'],
      );
      final lines = await reader
          .transform(utf8.decoder)
          .transform(const CsvToListConverter(csvSettingsDetector: eolDetector))
          .toList();

      /// We expect at least one line
      /// of data in the file
      if (lines.length < 2) {
        throw Exception('No data found in file');
      }

      CsvData data = CsvData.empty();
      data.parseTaxonEntryFromList(lines);

      return data;
    } catch (e) {
      throw Exception('Error parsing CSV file: $e');
    }
  }

  List<String> findProblems(Map<int, TaxonEntryHeader> headerMap) {
    List<String> problemHeaders = _findDuplicateValues(headerMap);

    for (var header in requiredTaxonImportHeaders) {
      if (!headerMap.containsValue(header)) {
        problemHeaders.add('Missing ${matchTaxonEntryHeader(header)}');
      }
    }

    return problemHeaders;
  }

  Future<ParsedCSVdata> parseData(CsvData data) async {
    ParsedCSVdata importData = ParsedCSVdata.empty();
    HashSet<String> importedFamilies = HashSet();
    HashSet<String> importedSpecies = HashSet();

    List<TaxonEntryData> parsedData = _parseData(data);

    for (var data in parsedData) {
      bool hasSpecies = await _checkSpeciesExist(data);
      String species = '${data.genus} ${data.specificEpithet}';
      if (hasSpecies) {
        importData.skippedSpecies.add(species);
        continue;
      }
      TaxonomyCompanion dbForm = _getDbForm(data);
      TaxonomyServices(ref: ref).createTaxon(dbForm);
      importData.recordCount++;

      if (!importedFamilies.contains(data.taxonFamily)) {
        importedFamilies.add(data.taxonFamily);
      }

      if (!importedSpecies.contains(species)) {
        importedSpecies.add(species);
      }
    }
    importData.countAll(importedSpecies, importedFamilies);
    ref.invalidate(taxonRegistryProvider);
    return importData;
  }

  List<TaxonEntryData> _parseData(CsvData data) {
    try {
      TaxonParser parser = TaxonParser(
        headerMap: data.headerMap,
        data: data.data,
      );
      return parser.parseData();
    } catch (e) {
      throw Exception("Error parsing data: $e");
    }
  }

  TaxonomyCompanion _getDbForm(TaxonEntryData data) {
    return TaxonomyCompanion(
      taxonClass: db.Value(data.taxonClass.trim().toSentenceCase()),
      taxonOrder: db.Value(data.taxonOrder.trim().toSentenceCase()),
      taxonFamily: db.Value(data.taxonFamily.trim().toSentenceCase()),
      genus: db.Value(data.genus.trim().toSentenceCase()),
      specificEpithet: db.Value(data.specificEpithet.trim().toLowerCase()),
      authors: db.Value(data.authors?.trim()),
      commonName: db.Value(data.commonName?.trim().toLowerCase()),
      citesStatus: db.Value(data.citesStatus?.trim().toUpperCase()),
      redListCategory: db.Value(data.redListCategory?.trim().toUpperCase()),
      countryStatus: db.Value(data.countryStatus?.trim().toUpperCase()),
      sortingOrder: db.Value(data.sortingOrder),
      notes: db.Value(data.notes),
    );
  }

  Future<bool> _checkSpeciesExist(TaxonEntryData data) async {
    try {
      TaxonomyData? species = await TaxonomyServices(ref: ref)
          .getTaxonBySpecies(data.genus, data.specificEpithet);
      return species != null;
    } catch (e) {
      throw Exception('Error checking species: $e');
    }
  }

  List<String> _findDuplicateValues(Map<int, TaxonEntryHeader> headerMap) {
    List<String> problemHeaders = [];
    List<TaxonEntryHeader> values = headerMap.values.toList();
    for (var header in values) {
      if (header != TaxonEntryHeader.ignore) {
        if (values.where((element) => element == header).length > 1) {
          problemHeaders.add('Duplicate ${matchTaxonEntryHeader(header)}');
        }
      }
    }
    return problemHeaders.toSet().toList();
  }
}
