enum OvaryAppearance { smooth, small, large }

const List<String> ovaryAppearanceList = [
  'Smooth',
  'Small',
  'At least one ovum >1 mm', // Large in enum
];

enum FatCategory { noFat, trace, light, moderate, heavy, extremelyHeavy }

const List<String> fatCategoryList = [
  'No Fat',
  'Trace',
  'Light',
  'Moderate',
  'Heavy',
  'Extremely Heavy',
];

enum OviductAppearance { straight, convoluted }

const List<String> oviductAppearanceList = [
  'Straight',
  'Convoluted',
];

enum BodyMolt { none, trace, light, moderate, heavy }

const List<String> bodyMoltList = [
  'None',
  'Trace',
  'Light',
  'Moderate',
  'Heavy',
];

// This number is not in consistent order.
// We just hardcode it here.
const List<int> skullOssificationList = [100, 95, 90, 75, 50, 25, 10, 5, 0];
