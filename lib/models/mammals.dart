// Database read through index.
// and stored as integer.
// DON'T CHANGE ORDER!
enum SpecimenAge { adult, subadult, juvenile, unknown }

const List<String> specimenAgeList = [
  'Adult',
  'Subadult',
  'Juvenile',
  'Unknown',
];

SpecimenAge? getSpecimenAge(int? age) {
  if (age != null) {
    return SpecimenAge.values[age];
  }
  return null;
}

const List<String> conditionList = [
  'Freshly Euthanized',
  'Good',
  'Fair',
  'Poor',
  'Rotten',
  'Released',
];

enum TestisPosition { scrotal, abdominal }

const List<String> testisPositionList = [
  'Scrotal',
  'Abdominal',
];

TestisPosition? getTestisPosition(int? pos) {
  if (pos != null) {
    return TestisPosition.values[pos];
  }
  return null;
}

enum EpididymisAppearance { tubular, partial, notTubular }

const List<String> epididymisAppearanceList = [
  'Tubular',
  'Partial',
  'Not Tubular',
];

enum VaginaOpening { imperforate, perforate }

const List<String> vaginaOpeningList = [
  'Imperforate',
  'Perforate',
];

enum PubicSymphysis { close, smallOpen, open }

const List<String> pubicSymphysisList = [
  'Close',
  'Small Open',
  'Open',
];

enum ReproductiveStage { nulliparous, primiparous, multiparous }

const List<String> reproductiveStageList = [
  'Nulliparous',
  'Primiparous',
  'Multiparous',
];

enum MammaeCondition { small, large, lactating }

const List<String> mammaeConditionList = [
  'Small',
  'Large',
  'Lactating',
];

const List<String> accuracyList = [
  'Accurate',
  'Tail cropped',
  'Partially eaten',
  'Other reason'
];
