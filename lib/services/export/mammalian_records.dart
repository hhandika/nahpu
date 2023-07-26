import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/mammals.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/utility_services.dart';

class MammalianMeasurements extends DbAccess {
  MammalianMeasurements({
    required super.ref,
    required this.specimenUuid,
    required this.isBatRecord,
    required this.isInaccurateInBrackets,
  });

  final String specimenUuid;
  final bool isBatRecord;
  late MammalMeasurementData data;
  final bool isInaccurateInBrackets;

  Future<List<String>> getMeasurements() async {
    data =
        await SpecimenServices(ref: ref).getMammalMeasurementData(specimenUuid);
    List<String> standardMeasurement = _getStdMeasurement();
    List<String> measurement = isBatRecord
        ? [...standardMeasurement, _getForearm()]
        : standardMeasurement;
    String age = data.age != null ? specimenAgeList[data.age!] : '';
    List<String> sexData = _getSexData();
    return [...measurement, age, ...sexData];
  }

  String _getForearm() {
    return data.forearm != null ? data.forearm.toString() : '';
  }

  List<String> _getStdMeasurement() {
    String accuracy = data.accuracy ?? '';
    MeasurementAccuracy accuracyEnum = matchAccuracy(accuracy);
    String totalLength = _getTotalLength(data.totalLength, accuracyEnum);
    String tailLength = _getTailLength(data.tailLength, accuracyEnum);
    String hindFootLength =
        _getHindFootLength(data.hindFootLength, accuracyEnum);
    String earLength = _getEarLength(data.earLength, accuracyEnum);
    String weight = _getWeight(data.weight, accuracyEnum);

    List<String> measurements = [
      totalLength,
      tailLength,
      hindFootLength,
      earLength,
      weight,
      accuracy,
    ];

    return measurements;
  }

  String _getTotalLength(double? length, MeasurementAccuracy accuracy) {
    if (length == null) return '';

    String lengthStr = length.truncateZero();

    if (!isInaccurateInBrackets) {
      return lengthStr;
    }

    switch (accuracy) {
      case MeasurementAccuracy.partiallyEaten:
        return '[$lengthStr]';
      case MeasurementAccuracy.tailCropped:
        return '[$lengthStr]';
      case MeasurementAccuracy.allMeasurementsInaccurate:
        return '[$lengthStr]';
      default:
        return lengthStr;
    }
  }

  String _getTailLength(double? length, MeasurementAccuracy accuracy) {
    if (length == null) return '';

    String lengthStr = length.truncateZero();

    if (!isInaccurateInBrackets) {
      return lengthStr;
    }

    switch (accuracy) {
      case MeasurementAccuracy.partiallyEaten:
        return '[$lengthStr]';
      case MeasurementAccuracy.tailCropped:
        return '[$lengthStr]';
      case MeasurementAccuracy.allMeasurementsInaccurate:
        return '[$lengthStr]';
      default:
        return lengthStr;
    }
  }

  String _getHindFootLength(double? length, MeasurementAccuracy accuracy) {
    if (length == null) return '';

    String lengthStr = length.truncateZero();

    if (!isInaccurateInBrackets) {
      return lengthStr;
    }

    switch (accuracy) {
      case MeasurementAccuracy.partiallyEaten:
        return '[$lengthStr]';
      case MeasurementAccuracy.hindLengthInaccurate:
        return '[$lengthStr]';
      case MeasurementAccuracy.allMeasurementsInaccurate:
        return '[$lengthStr]';
      default:
        return lengthStr;
    }
  }

  String _getEarLength(double? length, MeasurementAccuracy accuracy) {
    if (length == null) return '';

    String lengthStr = length.truncateZero();

    if (!isInaccurateInBrackets) {
      return lengthStr;
    }

    switch (accuracy) {
      case MeasurementAccuracy.partiallyEaten:
        return '[$lengthStr]';
      case MeasurementAccuracy.earLengthInaccurate:
        return '[$lengthStr]';
      case MeasurementAccuracy.allMeasurementsInaccurate:
        return '[$lengthStr]';
      default:
        return lengthStr;
    }
  }

  String _getWeight(double? weight, MeasurementAccuracy accuracy) {
    if (weight == null) return '';

    String weightStr = weight.truncateZero();

    if (!isInaccurateInBrackets) {
      return weightStr;
    }

    switch (accuracy) {
      case MeasurementAccuracy.partiallyEaten:
        return '[$weightStr]';
      case MeasurementAccuracy.allMeasurementsInaccurate:
        return '[$weightStr]';
      default:
        return weightStr;
    }
  }

  /// Sex data contains:
  /// 1. Sex
  /// 2. Male gonads
  /// 3. Female gonads
  List<String> _getSexData() {
    SpecimenSex? sexEnum = getSpecimenSex(data.sex);
    String sex = data.sex != null ? specimenSexList[data.sex!] : '';
    List<String> emptyMale = List.filled(2, '');
    List<String> emptyFemale = List.filled(3, '');
    switch (sexEnum) {
      case SpecimenSex.male:
        List<String> maleGonad = _getMaleGonad();
        return [sex, ...maleGonad, ...emptyFemale];
      case SpecimenSex.female:
        List<String> femaleGonad = _getFemaleGonad();
        return [sex, ...emptyMale, ...femaleGonad];
      case SpecimenSex.unknown:
        return [sex, ...emptyMale, ...emptyFemale];
      default:
        return [sex, ...emptyMale, ...emptyFemale];
    }
  }

  List<String> _getFemaleGonad() {
    String vaginaOpening = data.vaginaOpening != null
        ? vaginaOpeningList[data.vaginaOpening!]
        : '';
    if (data.mammaeCondition != null) {
      String mammaeCondition = mammaeConditionList[data.mammaeCondition!];
      String mammaeFormula = _getMammaeFormula();
      return [vaginaOpening, mammaeCondition, mammaeFormula];
    } else {
      List<String> empty = List.filled(2, '');
      return [vaginaOpening, ...empty];
    }
  }

  String _getMammaeFormula() {
    String ingCount = data.mammaeInguinalCount != null
        ? '${data.mammaeInguinalCount} ing;'
        : '';
    String abdCount = data.mammaeAbdominalCount != null
        ? '${data.mammaeAbdominalCount} abd;'
        : '';
    String axCount = data.mammaeAxillaryCount != null
        ? '${data.mammaeAxillaryCount} ax'
        : '';

    return '$ingCount$abdCount$axCount';
  }

  List<String> _getMaleGonad() {
    TestisPosition? posEnum = getTestisPosition(data.testisPosition);

    if (posEnum == TestisPosition.scrotal) {
      String testisPos = _matchTestisPos(data.testisPosition);
      String testisLength =
          data.testisLength != null ? '${data.testisLength}' : '';
      String testisWidth =
          data.testisWidth != null ? 'x${data.testisWidth}mm' : '';
      String testisSize = '$testisLength$testisWidth';
      return [testisPos, testisSize];
    } else {
      return ['', ''];
    }
  }

  String _matchTestisPos(int? testisPos) {
    if (testisPos == null) {
      return '';
    } else {
      return testisPositionList[testisPos];
    }
  }
}
