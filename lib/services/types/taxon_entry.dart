enum TaxonEntryHeader {
  taxonClass,
  taxonOrder,
  taxonFamily,
  genus,
  specificEpithet,
  commonName,
  notes,
}

class TaxonEntry {
  TaxonEntry({
    required this.header,
    required this.headerMap,
    required this.data,
  });

  List<String> header;
  Map<TaxonEntryHeader, int> headerMap;
  List<List<dynamic>> data;

  List<TaxonEntryCsv> parseTaxonEntryFromList() {
    List<TaxonEntryCsv> parsedData =
        data.sublist(1).map((e) => _parseData(e.cast<String>())).toList();

    return parsedData;
  }

  TaxonEntryCsv _parseData(List<String> value) {
    TaxonEntryCsv taxonEntryCsv = TaxonEntryCsv.empty();
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

class TaxonEntryCsv {
  TaxonEntryCsv({
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

  factory TaxonEntryCsv.empty() {
    return TaxonEntryCsv(
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
