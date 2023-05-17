enum MammalianRecordType {
  narrative,
  collEvent,
  avianSpecimen,
  mammalianSpecimen
}

const List<String> mammalianRecordTypeList = [
  'Narrative',
  'Collecting event',
  'Avian specimen records',
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
