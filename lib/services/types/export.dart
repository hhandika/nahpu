import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

enum ArchiveFmt { zip }

Map<PdfPageFormat, String> pdfExportPageFormat = {
  PdfPageFormat.a3: 'A3 (29.7 x 42.0 cm)',
  PdfPageFormat.a4: 'A4 (21.0 x 29.7 cm)',
  PdfPageFormat.a5: 'A5 (14.8 x 21.0 cm)',
  PdfPageFormat.a6: 'A6 (10.5 x 14.8 cm)',
  PdfPageFormat.letter: 'Letter (8.5 x 11.0 in)',
  PdfPageFormat.legal: 'Legal (8.5 x 14.0 in)',
};

Map<PageOrientation, String> pdfExportOrientation = {
  PageOrientation.landscape: 'Landscape',
  PageOrientation.portrait: 'Portrait',
};

enum SpecimenRecordType {
  birds,
  generalMammals,
  bats,
  allMammals,
}

enum TaxonRecordType {
  birds,
  mammals,
}

const List<String> taxonRecordTypeList = [
  'Birds',
  'Mammals',
];

enum MammalRecordType {
  excludeBats,
  onlyBats,
  allMammals,
}

const List<String> mammalGroupList = [
  'Exclude bats',
  'Only bats',
  'All mammals',
];

enum ExportRecordType { narrative, site, collEvent, specimenRecord }

const List<String> recordTypeList = [
  'Narrative',
  'Site',
  'Collecting event',
  'Specimen records',
];

const collRecordExportList = [
  'specimenUUID',
  'cataloger',
  'fieldID',
  'preparator',
];

const specimenExportList = [
  'order',
  'family',
  'genus',
  'specificEpithet',
  'preparation',
  'condition',
  'specimenCoordinates',
];

const siteExportList = [
  'site',
  'habitatType',
  'country',
  'stateProvince',
  'county',
  'municipality',
  'specificLocality',
  'siteNotes',
  'verbatimLocality',
  'coordinates',
];

const mammalMeasurementExportList = [
  'totalLength',
  'tailLength',
  'hindFootLength',
  'earLength',
  'weight',
  'accuracy',
  'age',
  'sex',
  'testisPos',
  'testisSize',
  'ovaryOpening',
  'mammaeCondition',
  'mammaeFormula',
];

const batMeasurementExportList = [
  'totalLength',
  'tailLength',
  'hindFootLength',
  'earLength',
  'weight',
  'accuracy',
  'forearmLength',
  'age',
  'sex',
  'testisPos',
  'testisSize',
  'ovaryOpening',
  'mammaeCondition',
  'mammaeFormula',
];

const avianMeasurementExportList = [
  'weight',
  'wingspan',
  'irisColor',
  'billColor',
  'footColor',
  'tarsusColor',
  'sex',
  // Male gonad
  'testisSize',
  'testisRemark',
  // Female gonad
  'ovarySize',
  'ovaryAppearance',
  'oviductWidth',
  'ovaSize',
  'oviductAppearance',
  'ovaryRemark',
  // End gonad data
  'broodPatch',
  'percentSkullOssification',
  'bursaLength',
  'fat',
  'stomachContent',
  // Molt
  'wingIsMolt',
  'wingMolt',
  'tailIsMolt',
  'tailMolt',
  'bodyMolt',
  'moltRemark',
  // Notes
  'specimenRemark',
  'habitatRemark',
];

const narrativeExportList = [
  'date',
  'verbatimLocality',
  'narrative',
  'media',
];

const collEventExportList = [
  'collEventID',
  'Activity',
  'startDate',
  'endDate',
  'startTime',
  'endTime',
  'methods',
  'personnel',
];

const allMediaExportList = [
  'category',
  'linkedData',
  'caption',
  'photographer',
  'tag',
  'dateTaken',
  'camera',
  'lenseModel',
  'additionalExifData',
  'fileName',
];
