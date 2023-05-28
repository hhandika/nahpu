import 'package:nahpu/services/types/import.dart';

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
          taxonEntryCsv.taxonClass = value;
          break;
        case TaxonEntryHeader.taxonOrder:
          taxonEntryCsv.taxonOrder = value;
          break;
        case TaxonEntryHeader.taxonFamily:
          taxonEntryCsv.taxonFamily = value;
          break;
        case TaxonEntryHeader.genus:
          taxonEntryCsv.genus = value;
          break;
        case TaxonEntryHeader.specificEpithet:
          taxonEntryCsv.specificEpithet = value;
          break;
        case TaxonEntryHeader.commonName:
          taxonEntryCsv.commonName = value;
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
