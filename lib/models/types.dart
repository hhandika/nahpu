import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/services/database/database.dart';

enum CatalogFmt { generalMammals, birds, bats }

enum CommonPopUpMenuItems { edit, delete }

enum SpecimenSex { male, female, unknown }

const List<String> supportedTaxonClass = [
  'Aves',
  'Mammalia',
];

// We encode to int to save space in the database
int matchSpecimenSex(SpecimenSex sex) {
  switch (sex) {
    case SpecimenSex.male:
      return 0;
    case SpecimenSex.female:
      return 1;
    default:
      return 2; // Unknown
  }
}

SpecimenSex matchEncodingToSex(int sexCode) {
  switch (sexCode) {
    case 0:
      return SpecimenSex.male;
    case 1:
      return SpecimenSex.female;
    default:
      return SpecimenSex.unknown;
  }
}

int matchSpecimenAge(String? age) {
  switch (age) {
    case 'Adult':
      return 0;
    case 'Subadult':
      return 1;
    case 'Juvenile':
      return 2;
    default:
      return 3;
  }
}

String matchEncodingToAge(int ageCode) {
  switch (ageCode) {
    case 0:
      return 'Adult';
    case 1:
      return 'Subadult';
    case 2:
      return 'Juvenile';
    default:
      return 'Unknown';
  }
}

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
