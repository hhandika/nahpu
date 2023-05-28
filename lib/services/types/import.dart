enum TaxonEntryHeader {
  taxonClass,
  taxonOrder,
  taxonFamily,
  genus,
  specificEpithet,
  commonName,
  notes,
  ignore,
}

const List<String> headerList = [
  'Class',
  'Order',
  'Family',
  'Genus',
  'Specific epithet',
  'Common name',
  'Notes',
  'Ignore',
];

String matchTaxonEntryHeader(TaxonEntryHeader headerEnum) {
  switch (headerEnum) {
    case TaxonEntryHeader.taxonClass:
      return 'Class';
    case TaxonEntryHeader.taxonOrder:
      return 'Order';
    case TaxonEntryHeader.taxonFamily:
      return 'Family';
    case TaxonEntryHeader.genus:
      return 'Genus';
    case TaxonEntryHeader.specificEpithet:
      return 'Specific epithet';
    case TaxonEntryHeader.commonName:
      return 'Common name';
    case TaxonEntryHeader.notes:
      return 'Notes';
    case TaxonEntryHeader.ignore:
      return 'Ignore';
    default:
      return 'Ignore';
  }
}

const Map<String, TaxonEntryHeader> knownTaxonHeader = {
  'taxonclass': TaxonEntryHeader.taxonClass,
  'class': TaxonEntryHeader.taxonClass,
  'taxonorder': TaxonEntryHeader.taxonOrder,
  'order': TaxonEntryHeader.taxonOrder,
  'taxonfamily': TaxonEntryHeader.taxonFamily,
  'family': TaxonEntryHeader.taxonFamily,
  'genus': TaxonEntryHeader.genus,
  'specificepithet': TaxonEntryHeader.specificEpithet,
  'epithet': TaxonEntryHeader.specificEpithet,
  'species': TaxonEntryHeader.specificEpithet,
  'commonname': TaxonEntryHeader.commonName,
  'englishname': TaxonEntryHeader.commonName,
  'notes': TaxonEntryHeader.notes,
  'note': TaxonEntryHeader.notes,
};

const List<TaxonEntryHeader> requiredTaxonImportHeaders = [
  TaxonEntryHeader.taxonClass,
  TaxonEntryHeader.taxonOrder,
  TaxonEntryHeader.taxonFamily,
  TaxonEntryHeader.genus,
  TaxonEntryHeader.specificEpithet,
];
