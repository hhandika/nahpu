import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/services/database/database.dart';

enum CatalogFmt { generalMammals, birds, bats }

enum CommonPopUpMenuItems { edit, delete }

enum CoordinatePopUpMenuItems { edit, copy, open, delete }

enum ExportFmt { excel, csv, tsv, json }

enum RecordType { specimen }

enum SiteMenuSelection {
  newSite,
  duplicate,
  pdfExport,
  deleteRecords,
  deleteAllRecords
}

const List<String> recordTypeList = ['Specimen records'];

const List<String> exportFormats = [
  'Excel (.xlsx)',
  'Comma-separated (.csv)',
  'Tab-separated (.tsv)',
  'JSON (.json)',
];

enum DbExportFmt { sqlite3 }

const List<String> dbExportFmtList = [
  'Database (.sqlite3)',
];

enum ReportFmt { excel, csv }

const List<String> reportFmtList = [
  'Excel (.xlsx)',
  'Comma-separated (.csv)',
];

enum ReportType { speciesCount }

const List<String> reportTypeList = [
  'Species count ',
];

// Database read through index.
// and stored as integer.
// DON'T CHANGE ORDER!
enum SpecimenSex { male, female, unknown }

const List<String> specimenSexList = [
  'Male',
  'Female',
  'Unknown',
];

SpecimenSex? getSpecimenSex(int? sex) {
  if (sex != null) {
    return SpecimenSex.values[sex];
  }
  return null;
}

const List<String> supportedTaxonClass = [
  'Aves',
  'Mammalia',
];

const List<String> siteTypeList = [
  'City',
  'Hotel',
  'Village',
  'Camp',
  'Trail',
  'Trapline',
  'Netline'
];

const List<String> relativeTimeList = [
  'Dawn',
  'Morning',
  'Afternoon',
  'Dusk',
  'Night',
];

CatalogFmt matchTaxonGroupToCatFmt(String? taxonGroup) {
  switch (taxonGroup) {
    case 'Birds':
      return CatalogFmt.birds;
    case 'General Mammals':
      return CatalogFmt.generalMammals;
    case 'Bats':
      return CatalogFmt.bats;
    default:
      return CatalogFmt.generalMammals;
  }
}

String matchCatFmtToTaxonGroup(CatalogFmt catalogFmt) {
  switch (catalogFmt) {
    case CatalogFmt.birds:
      return 'Birds';
    case CatalogFmt.generalMammals:
      return 'General Mammals';
    case CatalogFmt.bats:
      return 'Bats';
    default:
      return 'General Mammals';
  }
}

IconData matchCatFmtToPartIcon(CatalogFmt catalogFmt) {
  switch (catalogFmt) {
    case CatalogFmt.birds:
      return MdiIcons.owl;
    case CatalogFmt.generalMammals:
      return MdiIcons.pawOutline;
    case CatalogFmt.bats:
      return MdiIcons.pawOutline;
    default:
      return MdiIcons.paw;
  }
}

IconData matchCatFmtToIcon(CatalogFmt catalogFmt) {
  switch (catalogFmt) {
    case CatalogFmt.birds:
      return MdiIcons.feather;
    case CatalogFmt.generalMammals:
      return MdiIcons.paw;
    case CatalogFmt.bats:
      return MdiIcons.bat;
    default:
      return MdiIcons.paw;
  }
}

class TaxonData {
  TaxonData({
    this.taxonClass,
    this.taxonOrder,
    this.taxonFamily,
    this.genus,
    this.specificEpithet,
  });

  String? taxonClass;
  String? taxonOrder;
  String? taxonFamily;
  String? genus;
  String? specificEpithet;

  factory TaxonData.fromTaxonomyData(TaxonomyData taxonomyData) {
    return TaxonData(
      taxonClass: taxonomyData.taxonClass,
      taxonOrder: taxonomyData.taxonOrder,
      taxonFamily: taxonomyData.taxonFamily,
      genus: taxonomyData.genus,
      specificEpithet: taxonomyData.specificEpithet,
    );
  }

  String get speciesName {
    if (genus != null && specificEpithet != null) {
      return '$genus $specificEpithet';
    } else {
      return '';
    }
  }
}

extension StringExtension on String {
  String toSentenceCase() {
    try {
      return '${this[0].toUpperCase()}${substring(1)}';
    } catch (e) {
      return '';
    }
  }
}
