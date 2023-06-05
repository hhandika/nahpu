import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/mammals.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';

class MammalianMeasurements {
  MammalianMeasurements({
    required this.ref,
    required this.specimenUuid,
    required this.isBatRecord,
  });

  final WidgetRef ref;
  final String specimenUuid;
  final bool isBatRecord;
  late MammalMeasurementData data;

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
    String totalLength = '${data.totalLength ?? ''}';
    String tailLength = '${data.tailLength ?? ''}';
    String hindFootLength = '${data.hindFootLength ?? ''}';
    String earLength = '${data.earLength ?? ''}';
    String weight = '${data.weight ?? ''}';
    String accuracy = data.accuracy ?? '';
    return [
      totalLength,
      tailLength,
      hindFootLength,
      earLength,
      weight,
      accuracy,
    ];
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
