import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/services/types/export.dart';

enum CatalogFmt { generalMammals, birds, bats }

// Database read through index.
// and stored as integer.
// DON'T CHANGE ORDER!
enum SpecimenSex { male, female, unknown }

enum SpecimenSearchOption {
  all,
  fieldNumber,
  cataloger,
  preparator,
  collector,
  condition,
  prepDate,
  prepTime,
  taxa,
  prepType
}

const List<String> specimenSexList = [
  'Male',
  'Female',
  'Unknown',
];

const List<String> conditionList = [
  'Freshly Euthanized',
  'Good',
  'Fair',
  'Poor',
  'Rotten',
  'Released',
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

const List<String> idConfidenceList = [
  'Low',
  'Medium',
  'High',
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

const Map<String, String> partIconPath = {
  'cecum': 'assets/icons/microbial-culture.svg',
  'liver': 'assets/icons/liver.svg',
  'lung': 'assets/icons/lungs.svg',
  'heart': 'assets/icons/heart.svg',
  'intestine': 'assets/icons/intestine.svg',
  'kidney': 'assets/icons/kidneys.svg',
  'muscle': 'assets/icons/muscles.svg',
  'stomach': 'assets/icons/stomach.svg',
  'swab': 'assets/icons/swab.svg',
  'feces': 'assets/icons/poo.svg',
  'parasite': 'assets/icons/mite.svg',
  'testis': 'assets/icons/testis.svg',
  'unknown': 'assets/icons/clue.svg',
};

String matchCatalogFmtToIconPath(CatalogFmt fmt) {
  switch (fmt) {
    case CatalogFmt.generalMammals:
      return 'assets/icons/mouse.svg';
    case CatalogFmt.bats:
      return 'assets/icons/bat.svg';
    case CatalogFmt.birds:
      return 'assets/icons/bird.svg';
    default:
      return 'assets/icons/mouse.svg';
  }
}

const List<String> specimenPartList = [
  'skin',
  'skull',
  'skeleton',
  'alcohol',
  'formalin',
  'whole-specimen'
];

class SpecimenPartIcon {
  const SpecimenPartIcon({required this.catalogFmt, required this.part});

  final String part;
  final CatalogFmt catalogFmt;

  String matchPartToIconPath() {
    final lowercased = _cleanPart();
    if (kDebugMode) print('Part: $part, Lowercased: $lowercased');
    bool isSpecimen = specimenPartList.contains(lowercased);
    if (isSpecimen) {
      return matchCatalogFmtToIconPath(catalogFmt);
    }

    return partIconPath[lowercased] ?? partIconPath['unknown']!;
  }

  String _cleanPart() {
    final lowercased = part.toLowerCase().trim();
    if (lowercased == 'testes' || lowercased == 'testis') {
      return 'testis';
    }
    if (lowercased.endsWith('s') || lowercased.endsWith('es')) {
      return lowercased.substring(0, part.length - 1).toLowerCase();
    }
    return lowercased.replaceAll(' ', '-');
  }
}
