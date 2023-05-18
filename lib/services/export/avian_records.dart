import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/birds.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';

class AvianMeasurements {
  AvianMeasurements({
    required this.ref,
    required this.delimiter,
    required this.specimenUuid,
  });

  final WidgetRef ref;
  final String delimiter;
  final String specimenUuid;
  late AvianMeasurementData data;

  Future<String> getMeasurements() async {
    data = await SpecimenServices(ref).getAvianMeasurementData(specimenUuid);
    String mainMeasurement = _getMainMeasurement();
    String gonadData = _getGonadData();
    String broodPatch = _getBroodPatch();
    String skullOss = _getSkullOss();
    String bursa = _getBursaLength();
    String fat = _getFat();
    String stomachContent = _getStomachContent();
    String moltData = _getAllMolt();
    return '$mainMeasurement$delimiter$gonadData$delimiter'
        '$broodPatch$delimiter$skullOss$delimiter$bursa$delimiter'
        '$fat$delimiter$stomachContent$delimiter'
        '$moltData';
  }

  String _getMainMeasurement() {
    String weight = _getWeight();
    String wingSpan = _getWingSpan();
    String irisColor = _getIrisColor();
    String billColor = _getBillColor();
    String footColor = _getFootColor();
    String tarsusColor = _getTarsusColor();
    return '$weight$delimiter$wingSpan$delimiter$irisColor$delimiter'
        '$billColor$delimiter$footColor$delimiter$tarsusColor';
  }

  String _getBroodPatch() {
    if (data.broodPatch == null) {
      return '';
    } else {
      return data.broodPatch == 1 ? 'Yes' : 'No';
    }
  }

  String _getStomachContent() {
    return data.stomachContent ?? '';
  }

  String _getSkullOss() {
    return data.skullOssification != null
        ? data.skullOssification!.toString()
        : '';
  }

  String _getFat() {
    if (data.fat == null) {
      return '';
    } else {
      return fatCategoryList[data.fat!];
    }
  }

  String _getBursaLength() {
    return data.bursaLength != null ? data.bursaLength!.toString() : '';
  }

  String _getWeight() {
    return '${data.weight ?? ''}';
  }

  String _getWingSpan() {
    return '${data.wingspan ?? ''}';
  }

  String _getIrisColor() {
    return data.irisColor ?? '';
  }

  String _getBillColor() {
    return data.billColor ?? '';
  }

  String _getFootColor() {
    return data.footColor ?? '';
  }

  String _getTarsusColor() {
    return data.tarsusColor ?? '';
  }

  String _getGonadData() {
    SpecimenSex? sexEnum = getSpecimenSex(data.sex);
    String sex = data.sex != null ? specimenSexList[data.sex!] : '';
    String emptyMale = delimiter * 2;
    String emptyFemale = delimiter * 6;
    switch (sexEnum) {
      case SpecimenSex.male:
        String maleGonad = _getMaleGonad();
        return '$sex$delimiter$maleGonad$emptyFemale';
      case SpecimenSex.female:
        String femaleGonad = _getFemaleGonad();
        return '$sex$delimiter$emptyMale$femaleGonad';
      case SpecimenSex.unknown:
        return '$sex$delimiter$emptyMale$emptyFemale';
      default:
        return '$sex$delimiter$emptyMale$emptyFemale';
    }
  }

  String _getMaleGonad() {
    String testisLength =
        data.testisLength != null ? '${data.testisLength}' : '';
    String testisWidth = data.testisWidth != null ? '${data.testisWidth}' : '';
    String testisRemark = data.testisRemark ?? '';
    return '$testisLength x $testisWidth mm$delimiter$testisRemark';
  }

  String _getFemaleGonad() {
    String ovaryLength = data.ovaryLength != null ? '${data.ovaryLength}' : '';
    String ovaryWidth = data.ovaryWidth != null ? '${data.ovaryWidth}' : '';
    String ovarySize = '$ovaryLength x $ovaryWidth mm';
    String ovaryAppearance = _getOvaryAppearance();
    String oviductWidth =
        data.oviductWidth != null ? '${data.oviductWidth}' : '';
    String firstOvaSize =
        data.firstOvaSize != null ? '${data.firstOvaSize}' : '';
    String secondOvaSize =
        data.secondOvaSize != null ? '${data.secondOvaSize}' : '';
    String thirdOvaSize =
        data.thirdOvaSize != null ? '${data.thirdOvaSize}' : '';
    String ovaSize = '$firstOvaSize;$secondOvaSize;$thirdOvaSize mm';
    String oviductAppearance = _getOviductAppearance();
    String ovaryRemark = data.ovaryRemark ?? '';

    return '$ovarySize$delimiter$ovaryAppearance$delimiter$oviductWidth$delimiter'
        '$ovaSize$delimiter$oviductAppearance$delimiter$ovaryRemark';
  }

  String _getOvaryAppearance() {
    if (data.ovaryAppearance == null) {
      return '';
    } else {
      return ovaryAppearanceList[data.ovaryAppearance!];
    }
  }

  String _getOviductAppearance() {
    if (data.oviductAppearance == null) {
      return '';
    } else {
      return oviductAppearanceList[data.oviductAppearance!];
    }
  }

  String _getAllMolt() {
    String wingMolt = _getWingMolt();
    String tailMolt = _getTailMolt();
    String bodyMolt = _getBodyMolt();
    String moltRemark = data.moltRemark ?? '';
    return '$wingMolt$delimiter'
        '$tailMolt$delimiter'
        '$bodyMolt$delimiter'
        '$moltRemark';
  }

  String _getBodyMolt() {
    if (data.bodyMolt == null) {
      return '';
    } else {
      return bodyMoltList[data.bodyMolt!];
    }
  }

  String _getWingMolt() {
    if (data.wingIsMolt == null) {
      return '';
    } else {
      String wingIsMolt = data.wingIsMolt! == 1 ? 'Yes' : 'No';
      String wingMolt = data.wingMolt ?? '';
      return '$wingIsMolt$delimiter$wingMolt';
    }
  }

  String _getTailMolt() {
    if (data.tailIsMolt == null) {
      return '';
    } else {
      String tailIsMolt = data.tailIsMolt! == 1 ? 'Yes' : 'No';
      String tailMolt = data.tailMolt ?? '';
      return '$tailIsMolt$delimiter$tailMolt';
    }
  }
}