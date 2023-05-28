import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:nahpu/providers/taxa.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/types/taxon_entry.dart';
import 'package:drift/drift.dart' as db;

class TaxonEntryReader extends DbAccess {
  TaxonEntryReader(super.ref);

  Future<CsvData> parseCsv(File inputFile) async {
    try {
      final reader = inputFile.openRead();
      List<List<dynamic>> parsedCsv = await reader
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();

      /// We expect at least one line
      /// of data in the file
      if (parsedCsv.length < 2) {
        throw Exception('No data found in file');
      }

      CsvData data = CsvData.empty();
      data.parseTaxonEntryFromList(parsedCsv);

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

  Future<void> parseData(CsvData data) async {
    try {
      TaxonParser parser = TaxonParser(
        headerMap: data.headerMap,
        data: data.data,
      );
      List<TaxonEntryData> parsedData = parser.parseData();
      for (var data in parsedData) {
        bool hasSpecies = await _checkSpeciesExist(data);
        if (hasSpecies) {
          throw Exception('Species already exists');
        }
        TaxonomyCompanion dbForm = _getDbForm(data);
        TaxonomyService(ref).createTaxon(dbForm);
      }
      ref.invalidate(taxonRegistryProvider);
    } catch (e) {
      throw Exception('Error parsing data: $e');
    }
  }

  TaxonomyCompanion _getDbForm(TaxonEntryData data) {
    return TaxonomyCompanion(
      taxonClass: db.Value(data.taxonClass),
      taxonOrder: db.Value(data.taxonOrder),
      taxonFamily: db.Value(data.taxonFamily),
      genus: db.Value(data.genus),
      specificEpithet: db.Value(data.specificEpithet),
      commonName: db.Value(data.commonName ?? ''),
      notes: db.Value(data.notes ?? ''),
    );
  }

  Future<bool> _checkSpeciesExist(TaxonEntryData data) async {
    try {
      TaxonomyData? species = await TaxonomyService(ref)
          .getTaxonBySpecies(data.genus ?? '', data.specificEpithet ?? '');
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
