enum ArchiveFmt { zip }

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
