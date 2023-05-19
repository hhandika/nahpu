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

enum ExportRecordType { narrative, collEvent, specimenRecord }

const List<String> avianRecordTypeList = [
  'Narrative',
  'Collecting event',
  'Avian specimen records',
];

const List<String> mammalianRecordTypeList = [
  'Narrative',
  'Collecting event',
  'Mammalian specimen records',
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
];

const siteExportList = [
  'site',
  'habitatType',
  'locality',
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
  'locality',
  'narrative',
];

const collEventExportList = [
  'collEventID',
  'Locality',
  'Activity',
  'startDate',
  'endDate',
  'startTime',
  'endTime',
  'methods',
  'personnel',
];
