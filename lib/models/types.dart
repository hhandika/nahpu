import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/services/database.dart';

enum CatalogFmt { generalMammals, birds, bats }

enum SpecimenSex { male, female, unknown }

enum SpecimenAge { adult, subadult, juvenile, unknown }

enum CommonPopUpMenuItems { edit, delete }

SpecimenSex matchSpecimenSex(String? sex) {
  switch (sex) {
    case 'Male':
      return SpecimenSex.male;
    case 'Female':
      return SpecimenSex.female;
    default:
      return SpecimenSex.unknown;
  }
}

SpecimenAge matchSpecimenAge(String? age) {
  switch (age) {
    case 'Adult':
      return SpecimenAge.adult;
    case 'Subadult':
      return SpecimenAge.subadult;
    case 'Juvenile':
      return SpecimenAge.juvenile;
    default:
      return SpecimenAge.unknown;
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

Icon matchCatFmtToIcon(CatalogFmt catalogFmt) {
  switch (catalogFmt) {
    case CatalogFmt.birds:
      return const Icon(MdiIcons.feather);
    case CatalogFmt.generalMammals:
      return const Icon(MdiIcons.paw);
    case CatalogFmt.bats:
      return const Icon(MdiIcons.bat);
    default:
      return const Icon(MdiIcons.paw);
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
