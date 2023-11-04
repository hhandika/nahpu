import 'dart:collection';

import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/utility_services.dart';

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
    for (var row in parsedCsv.sublist(1)) {
      List<String> rowData = [];
      for (var value in row) {
        // Cast all the values to string
        rowData.add(value.toString());
      }
      data.add(rowData);
    }
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
        case TaxonEntryHeader.authors:
          taxonEntryCsv.authors = value.toLowerCase();
          break;
        case TaxonEntryHeader.commonName:
          taxonEntryCsv.commonName = value.toSentenceCase();
          break;
        case TaxonEntryHeader.redListCategory:
          taxonEntryCsv.redListCategory = value.toSentenceCase();
          break;
        case TaxonEntryHeader.citesStatus:
          taxonEntryCsv.citesStatus = value.toSentenceCase();
          break;
        case TaxonEntryHeader.countryStatus:
          taxonEntryCsv.countryStatus = value.toSentenceCase();
          break;
        case TaxonEntryHeader.sortingOrder:
          taxonEntryCsv.sortingOrder = value;
          break;
        case TaxonEntryHeader.notes:
          taxonEntryCsv.notes = value;
          break;
        case TaxonEntryHeader.ignore:
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
    this.authors,
    this.commonName,
    this.redListCategory,
    this.citesStatus,
    this.countryStatus,
    this.sortingOrder,
    this.notes,
  });

  String taxonClass;
  String taxonOrder;
  String taxonFamily;
  String genus;
  String specificEpithet;
  String? authors;
  String? commonName;
  String? redListCategory;
  String? citesStatus;
  String? countryStatus;
  String? sortingOrder;
  String? notes;

  factory TaxonEntryData.empty() {
    return TaxonEntryData(
      taxonClass: '',
      taxonOrder: '',
      taxonFamily: '',
      genus: '',
      specificEpithet: '',
      authors: null,
      commonName: null,
      redListCategory: null,
      citesStatus: null,
      countryStatus: null,
      sortingOrder: null,
      notes: null,
    );
  }
}
