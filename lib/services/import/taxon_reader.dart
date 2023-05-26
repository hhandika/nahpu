import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/taxon_entry.dart';

class TaxonEntryReader extends DbAccess {
  TaxonEntryReader(super.ref, this.inputFile);

  final File inputFile;

  Future<List<TaxonEntryCsv>> parse() async {
    final reader = inputFile.openRead();
    List<List<dynamic>> csv = await reader
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();

    if (csv.length < 2) {
      throw Exception('No data found in file');
    }

    List<String> header = csv[0].cast<String>();

    Map<TaxonEntryHeader, int> headerMap = _getHeaderMap(header);
    if (!_isValidCsv(headerMap)) {
      throw Exception('Invalid CSV file');
    } else {
      if (kDebugMode) {
        print('Valid CSV file');
      }
    }
    List<List<dynamic>> data = csv.sublist(1);
    List<TaxonEntryCsv> parsedData = TaxonEntry(
      header: header,
      headerMap: headerMap,
      data: data,
    ).parseTaxonEntryFromList();

    if (kDebugMode) {
      print('TaxonEntryReader: ${inputFile.path}');
      for (TaxonEntryCsv entry in parsedData) {
        print('${entry.taxonClass}, ${entry.taxonOrder}, '
            '${entry.taxonFamily}, ${entry.genus}, ${entry.specificEpithet},'
            ' ${entry.commonName}, ${entry.notes}');
      }
    }

    return parsedData;
  }

  bool _isValidCsv(Map<TaxonEntryHeader, int> headerMap) {
    List<TaxonEntryHeader> requiredHeaders = [
      TaxonEntryHeader.taxonClass,
      TaxonEntryHeader.taxonOrder,
      TaxonEntryHeader.taxonFamily,
      TaxonEntryHeader.genus,
      TaxonEntryHeader.specificEpithet,
    ];
    for (var header in requiredHeaders) {
      if (!headerMap.containsKey(header)) {
        return false;
      }
    }

    return true;
  }

  Map<TaxonEntryHeader, int> _getHeaderMap(List<String> header) {
    Map<TaxonEntryHeader, int> headerMap = {};
    for (var value in header) {
      if (_matchedTaxonClass(value)) {
        headerMap[TaxonEntryHeader.taxonClass] = header.indexOf(value);
      } else if (_matchedTaxonOrder(value)) {
        headerMap[TaxonEntryHeader.taxonOrder] = header.indexOf(value);
      } else if (_matchedTaxonFamily(value)) {
        headerMap[TaxonEntryHeader.taxonFamily] = header.indexOf(value);
      } else if (_matchedGenus(value)) {
        headerMap[TaxonEntryHeader.genus] = header.indexOf(value);
      } else if (_matchedSpecificEpithet(value)) {
        headerMap[TaxonEntryHeader.specificEpithet] = header.indexOf(value);
      } else if (_matchedCommonName(value)) {
        headerMap[TaxonEntryHeader.commonName] = header.indexOf(value);
      } else if (_matchedNotes(value)) {
        headerMap[TaxonEntryHeader.notes] = header.indexOf(value);
      }
    }
    return headerMap;
  }

  bool _matchedTaxonClass(String value) {
    List<String> validKeywords = [
      'class',
      'taxon class',
      'taxonomic class',
      'taxonclass',
      'taxonomicclass',
    ];
    return validKeywords.contains(value.toLowerCase());
  }

  bool _matchedTaxonOrder(String value) {
    List<String> validKeywords = [
      'order',
      'taxon order',
      'taxonomic order',
      'taxonorder',
      'taxonomicorder',
    ];
    return validKeywords.contains(value.toLowerCase());
  }

  bool _matchedTaxonFamily(String value) {
    List<String> validKeywords = [
      'family',
      'families',
      'taxon family',
      'taxonomic family',
      'taxonfamily',
      'taxonomically',
    ];
    return validKeywords.contains(value.toLowerCase());
  }

  bool _matchedGenus(String value) {
    List<String> validKeywords = [
      'genus',
      'taxon genus',
      'taxonomic genus',
      'tangents',
      'taxonomicgenus',
    ];
    return validKeywords.contains(value.toLowerCase());
  }

  bool _matchedSpecificEpithet(String value) {
    List<String> validKeywords = [
      'epithet',
      'specific epithet',
      'taxon epithet',
      'taxonomic epithet',
      'specificepithet',
      'taxonepithet',
      'taxonomicepithet',
      'species',
    ];

    if (value.contains(' ')) {
      return false;
    }

    return validKeywords.contains(value.toLowerCase());
  }

  bool _matchedCommonName(String value) {
    List<String> validKeywords = [
      'common name',
      'commonname',
      'common',
      'common names',
      'commonnames',
      'english name',
      'englishname',
    ];
    return validKeywords.contains(value.toLowerCase());
  }

  bool _matchedNotes(String value) {
    List<String> validKeywords = [
      'notes',
      'note',
      'remarks',
      'remark',
      'comments',
      'comment',
    ];
    return validKeywords.contains(value.toLowerCase());
  }
}
