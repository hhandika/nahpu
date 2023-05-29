import 'dart:collection';

import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/types/types.dart';

class CsvData {
  CsvData({
    required this.header,
    required this.headerMap,
    required this.data,
  });

  List<String> header;
  Map<int, TaxonEntryHeader> headerMap;
  List<List<String>> data;

  factory CsvData.empty() {
    return CsvData(
      header: [],
      headerMap: {},
      data: [],
    );
  }

  void parseTaxonEntryFromList(List<List<dynamic>> parsedCsv) {
    header = parsedCsv[0].cast<String>();
    _mapHeader();
    data = parsedCsv.sublist(1).map((e) => e.cast<String>()).toList();
  }

  void _mapHeader() {
    for (String value in header) {
      TaxonEntryHeader headerKey =
          knownTaxonHeader[value.toLowerCase().replaceAll(' ', '')] ??
              TaxonEntryHeader.ignore;

      headerMap[header.indexOf(value)] = headerKey;
    }
  }
}

class ParsedCSVdata {
  ParsedCSVdata({
    required this.skippedSpecies,
    required this.importedSpeciesCount,
    required this.importedFamilyCount,
  });

  HashSet<String> skippedSpecies;
  int recordCount = 0;
  int importedSpeciesCount;
  int importedFamilyCount;

  factory ParsedCSVdata.empty() {
    return ParsedCSVdata(
      skippedSpecies: HashSet(),
      importedSpeciesCount: 0,
      importedFamilyCount: 0,
    );
  }

  void countAll(
    HashSet<String> species,
    HashSet<String> families,
  ) {
    importedSpeciesCount = species.length;
    importedFamilyCount = families.length;
  }
}

class TaxonParser {
  TaxonParser({
    required this.headerMap,
    required this.data,
  });

  final Map<int, TaxonEntryHeader> headerMap;
  final List<List<String>> data;

  List<TaxonEntryData> parseData() {
    List<TaxonEntryData> parsedData = data.map((e) => _parseData(e)).toList();

    return parsedData;
  }

  TaxonEntryData _parseData(List<String> values) {
    TaxonEntryData taxonEntryCsv = TaxonEntryData.empty();

    for (String value in values) {
      int index = values.indexOf(value);
      TaxonEntryHeader header = headerMap[index] ?? TaxonEntryHeader.ignore;
      switch (header) {
        case TaxonEntryHeader.taxonClass:
          taxonEntryCsv.taxonClass = value.toSentenceCase();
          break;
        case TaxonEntryHeader.taxonOrder:
          taxonEntryCsv.taxonOrder = value.toSentenceCase();
          break;
        case TaxonEntryHeader.taxonFamily:
          taxonEntryCsv.taxonFamily = value.toSentenceCase();
          break;
        case TaxonEntryHeader.genus:
          taxonEntryCsv.genus = value.toSentenceCase();
          break;
        case TaxonEntryHeader.specificEpithet:
          taxonEntryCsv.specificEpithet = value.toLowerCase();
          break;
        case TaxonEntryHeader.commonName:
          taxonEntryCsv.commonName = value.toSentenceCase();
          break;
        case TaxonEntryHeader.notes:
          taxonEntryCsv.notes = value;
          break;
        default:
          break;
      }
    }

    return taxonEntryCsv;
  }
}

class TaxonEntryData {
  TaxonEntryData({
    required this.taxonClass,
    required this.taxonOrder,
    required this.taxonFamily,
    required this.genus,
    required this.specificEpithet,
    this.commonName,
    this.notes,
  });

  String taxonClass;
  String taxonOrder;
  String taxonFamily;
  String genus;
  String specificEpithet;
  String? commonName;
  String? notes;

  factory TaxonEntryData.empty() {
    return TaxonEntryData(
      taxonClass: '',
      taxonOrder: '',
      taxonFamily: '',
      genus: '',
      specificEpithet: '',
      commonName: null,
      notes: null,
    );
  }
}