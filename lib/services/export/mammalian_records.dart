import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/mammals.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';

class MammalianMeasurements {
  MammalianMeasurements({
    required this.ref,
    required this.delimiter,
    required this.specimenUuid,
    required this.isBatRecord,
  });

  final WidgetRef ref;
  final String delimiter;
  final String specimenUuid;
  final bool isBatRecord;
  late MammalMeasurementData data;

  Future<String> getMeasurements() async {
    data =
        await SpecimenServices(ref: ref).getMammalMeasurementData(specimenUuid);
    String standardMeasurement =
        '${data.totalLength ?? ''}$delimiter${data.tailLength ?? ''}$delimiter'
        '${data.hindFootLength ?? ''}$delimiter${data.earLength ?? ''}$delimiter'
        '${data.weight ?? ''}$delimiter${data.accuracy ?? ''}';
    String measurement = isBatRecord
        ? '$standardMeasurement$delimiter${data.forearm ?? ''}'
        : standardMeasurement;
    String age = data.age != null ? specimenAgeList[data.age!] : '';
    String sexData = _getSexData();
    return '$measurement$delimiter$age$delimiter$sexData';
  }

  String _getSexData() {
    SpecimenSex? sexEnum = getSpecimenSex(data.sex);
    String sex = data.sex != null ? specimenSexList[data.sex!] : '';
    String emptyMale = delimiter;
    String emptyFemale = delimiter * 2;
    switch (sexEnum) {
      case SpecimenSex.male:
        String maleGonad = _getMaleGonad();
        return '$sex$delimiter$maleGonad$emptyFemale';
      case SpecimenSex.female:
        String femaleGonad = _getFemaleGonad();
        return '$sex$delimiter$emptyMale$delimiter$femaleGonad';
      case SpecimenSex.unknown:
        return '$sex$delimiter$emptyMale$emptyFemale';
      default:
        return '$sex$delimiter$emptyMale$emptyFemale';
    }
  }

  String _getFemaleGonad() {
    String vaginaOpening = data.vaginaOpening != null
        ? vaginaOpeningList[data.vaginaOpening!]
        : '';
    if (data.mammaeCondition != null) {
      String mammaeCondition = mammaeConditionList[data.mammaeCondition!];
      String ingCount = data.mammaeInguinalCount != null
          ? '${data.mammaeInguinalCount} ing;'
          : '';
      String abdCount = data.mammaeAbdominalCount != null
          ? '${data.mammaeAbdominalCount} abd;'
          : '';
      String axCount = data.mammaeAxillaryCount != null
          ? '${data.mammaeAxillaryCount} ax'
          : '';
      String mammaeCount = '$ingCount$abdCount$axCount';
      return '$vaginaOpening$delimiter$mammaeCondition$delimiter$mammaeCount';
    } else {
      String empty = delimiter * 2;
      return '$vaginaOpening$empty';
    }
  }

  String _matchTestisPos(int? testisPos) {
    if (testisPos == null) {
      return '';
    } else {
      return testisPositionList[testisPos];
    }
  }

  String _getMaleGonad() {
    TestisPosition? posEnum = getTestisPosition(data.testisPosition);

    if (posEnum == TestisPosition.scrotal) {
      String testisPos = _matchTestisPos(data.testisPosition);
      String testisLength =
          data.testisLength != null ? '${data.testisLength}' : '';
      String testisWidth =
          data.testisWidth != null ? 'x${data.testisWidth}mm' : '';
      return '$testisPos$delimiter$testisLength$testisWidth';
    } else {
      return delimiter;
    }
  }
}
