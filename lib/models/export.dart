enum SpecimenRecordType {
  avian,
  chiropteran,
  mammalian,
  allMammals,
}

const List<String> specimenRecordTypeList = [
  'Birds',
  'Bats',
  'Non-bat mammals',
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
