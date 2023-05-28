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
    data = parsedCsv.sublist(1).cast<List<String>>();
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

  final Map<TaxonEntryHeader, int> headerMap;
  final List<List<String>> data;

  List<TaxonEntryData> parseData() {
    List<TaxonEntryData> parsedData =
        data.sublist(1).map((e) => _parseData(e.cast<String>())).toList();

    return parsedData;
  }

  TaxonEntryData _parseData(List<String> value) {
    TaxonEntryData taxonEntryCsv = TaxonEntryData.empty();
    taxonEntryCsv.taxonClass = _getTaxonClass(value);
    taxonEntryCsv.taxonOrder = _getTaxonOrder(value);
    taxonEntryCsv.taxonFamily = _getTaxonFamily(value);
    taxonEntryCsv.genus = _getGenus(value);
    taxonEntryCsv.specificEpithet = _getSpecificEpithet(value);
    taxonEntryCsv.commonName = _getCommonName(value);
    taxonEntryCsv.notes = _getNotes(value);

    return taxonEntryCsv;
  }

  String? _getTaxonClass(List<String> value) {
    if (headerMap[TaxonEntryHeader.taxonClass] == null) {
      return null;
    }
    return value[headerMap[TaxonEntryHeader.taxonClass]!];
  }

  String? _getTaxonOrder(List<String> value) {
    if (headerMap[TaxonEntryHeader.taxonOrder] == null) {
      return null;
    }
    return value[headerMap[TaxonEntryHeader.taxonOrder]!];
  }

  String? _getTaxonFamily(List<String> value) {
    if (headerMap[TaxonEntryHeader.taxonFamily] == null) {
      return null;
    }
    return value[headerMap[TaxonEntryHeader.taxonFamily]!];
  }

  String? _getGenus(List<String> value) {
    if (headerMap[TaxonEntryHeader.genus] == null) {
      return null;
    }
    return value[headerMap[TaxonEntryHeader.genus]!];
  }

  String? _getSpecificEpithet(List<String> value) {
    if (headerMap[TaxonEntryHeader.specificEpithet] == null) {
      return null;
    }
    return value[headerMap[TaxonEntryHeader.specificEpithet]!];
  }

  String? _getCommonName(List<String> value) {
    if (headerMap[TaxonEntryHeader.commonName] == null) {
      return null;
    }
    return value[headerMap[TaxonEntryHeader.commonName]!];
  }

  String? _getNotes(List<String> value) {
    if (headerMap[TaxonEntryHeader.notes] == null) {
      return null;
    }
    return value[headerMap[TaxonEntryHeader.notes]!];
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

  String? taxonClass;
  String? taxonOrder;
  String? taxonFamily;
  String? genus;
  String? specificEpithet;
  String? commonName;
  String? notes;

  factory TaxonEntryData.empty() {
    return TaxonEntryData(
      taxonClass: null,
      taxonOrder: null,
      taxonFamily: null,
      genus: null,
      specificEpithet: null,
      commonName: null,
      notes: null,
    );
  }
}
