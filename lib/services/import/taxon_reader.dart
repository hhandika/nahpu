import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/types/taxon_entry.dart';

class TaxonEntryReader extends DbAccess {
  TaxonEntryReader(super.ref);

  Future<CsvData> parseCsv(File inputFile) async {
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
  }

  List<String> findProblems(Map<int, TaxonEntryHeader> headerMap) {
    // Find duplicates and list only the first instance
    List<String> problemHeaders =
        _findDuplicateValues(headerMap).toSet().toList();
    for (var header in requiredTaxonImportHeaders) {
      if (!headerMap.containsValue(header)) {
        [...problemHeaders, 'Missing ${matchTaxonEntryHeader(header)}'];
      }
    }

    return problemHeaders;
  }

  List<String> _findDuplicateValues(Map<int, TaxonEntryHeader> headerMap) {
    List<String> problemHeaders = [];
    List<TaxonEntryHeader> values = headerMap.values.toList();
    for (var header in values) {
      if (values.where((element) => element == header).length > 1) {
        problemHeaders.add('Duplicate ${matchTaxonEntryHeader(header)}');
      }
    }
    return problemHeaders;
  }
}
