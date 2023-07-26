import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/services/types/export.dart';

enum CatalogFmt { generalMammals, birds, bats }

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

const List<String> defaultSpecimenType = [
  'Skin',
  'Skull',
  'Skeleton',
  'Liver',
  'Lung',
  'Heart',
  'Kidney',
];

const List<String> defaultSpecimenTreatment = [
  'None',
  'ETOH',
  'Formalin',
  'LN2',
  'DMSO',
];

const List<String> priorityType = [
  'Alcohol',
  'Formalin',
  'Fluid',
  'Skin',
  'Skull',
  'Skeleton',
];

const List<String> priorityTreatment = [
  'None',
  'Formalin',
  'ETOH',
  'LN2',
  'DMSO',
];

const List<String> relativeTimeList = [
  'Dawn',
  'Morning',
  'Afternoon',
  'Dusk',
  'Night',
];

const List<String> taxonGroupList = [
  'Birds',
  'General Mammals',
  'Bats',
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

SpecimenRecordType matchCatalogFmtToRecordType(CatalogFmt catalogFmt) {
  switch (catalogFmt) {
    case CatalogFmt.birds:
      return SpecimenRecordType.birds;
    case CatalogFmt.generalMammals:
      return SpecimenRecordType.generalMammals;
    case CatalogFmt.bats:
      return SpecimenRecordType.bats;
    default:
      return SpecimenRecordType.generalMammals;
  }
}

String matchRecordTypeToTaxonGroup(SpecimenRecordType recordType) {
  switch (recordType) {
    case SpecimenRecordType.birds:
      return 'Birds';
    case SpecimenRecordType.generalMammals:
      return 'General Mammals';
    case SpecimenRecordType.bats:
      return 'Bats';
    default:
      throw Exception('Invalid record type');
  }
}

SpecimenRecordType matchTaxonGroupToRecordType(String taxonGroup) {
  switch (taxonGroup) {
    case 'Birds':
      return SpecimenRecordType.birds;
    case 'General Mammals':
      return SpecimenRecordType.generalMammals;
    case 'Bats':
      return SpecimenRecordType.bats;
    default:
      return SpecimenRecordType.generalMammals;
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

IconData matchCatFmtToIcon(CatalogFmt catalogFmt, bool isSelected) {
  switch (catalogFmt) {
    case CatalogFmt.birds:
      return MdiIcons.owl;
    case CatalogFmt.generalMammals:
      return isSelected ? MdiIcons.paw : MdiIcons.pawOutline;
    case CatalogFmt.bats:
      return MdiIcons.bat;
    default:
      return MdiIcons.paw;
  }
}
