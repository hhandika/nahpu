import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/birds.dart';
import 'package:nahpu/services/types/specimens.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';

class AvianMeasurements {
  AvianMeasurements({required this.ref, required this.specimenUuid});

  final WidgetRef ref;
  final String specimenUuid;
  late AvianMeasurementData data;

  Future<List<String>> getMeasurements() async {
    data =
        await SpecimenServices(ref: ref).getAvianMeasurementData(specimenUuid);
    List<String> mainMeasurement = _getMainMeasurement();
    List<String> gonadData = _getGonadData();
    String broodPatch = _getBroodPatch();
    String skullOss = _getSkullOss();
    String bursa = _getBursaLength();
    String fat = _getFat();
    String stomachContent = _getStomachContent();
    List<String> moltData = _getAllMolt();
    return [
      ...mainMeasurement,
      ...gonadData,
      broodPatch,
      skullOss,
      bursa,
      fat,
      stomachContent,
      ...moltData,
    ];
  }

  List<String> _getMainMeasurement() {
    String weight = _getWeight();
    String wingSpan = _getWingSpan();
    String irisColor = _getIrisColor();
    String billColor = _getBillColor();
    String footColor = _getFootColor();
    String tarsusColor = _getTarsusColor();
    return [
      weight,
      wingSpan,
      irisColor,
      billColor,
      footColor,
      tarsusColor,
    ];
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

  List<String> _getGonadData() {
    SpecimenSex? sexEnum = getSpecimenSex(data.sex);
    String sex = data.sex != null ? specimenSexList[data.sex!] : '';
    List<String> emptyMale = List.filled(2, '');
    List<String> emptyFemale = List.filled(6, '');
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

  List<String> _getMaleGonad() {
    String testisLength =
        data.testisLength != null ? '${data.testisLength}' : '';
    String testisWidth =
        data.testisWidth != null ? ' x ${data.testisWidth} mm' : '';
    String testisRemark = data.testisRemark ?? '';
    String testisSize = '$testisLength$testisWidth';
    return [testisSize, testisRemark];
  }

  List<String> _getFemaleGonad() {
    String ovaryLength = data.ovaryLength != null ? '${data.ovaryLength}' : '';
    String ovaryWidth =
        data.ovaryWidth != null ? ' x ${data.ovaryWidth} mm' : '';
    String ovarySize = '$ovaryLength$ovaryWidth';
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

    return [
      ovarySize,
      ovaryAppearance,
      oviductWidth,
      ovaSize,
      oviductAppearance,
      ovaryRemark
    ];
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

  List<String> _getAllMolt() {
    List<String> wingMolt = _getWingMolt();
    List<String> tailMolt = _getTailMolt();
    String bodyMolt = _getBodyMolt();
    String moltRemark = data.moltRemark ?? '';
    return [...wingMolt, ...tailMolt, bodyMolt, moltRemark];
  }

  String _getBodyMolt() {
    if (data.bodyMolt == null) {
      return '';
    } else {
      return bodyMoltList[data.bodyMolt!];
    }
  }

  List<String> _getWingMolt() {
    if (data.wingIsMolt == null) {
      return ['', ''];
    } else {
      String wingIsMolt = data.wingIsMolt! == 1 ? 'Yes' : 'No';
      String wingMolt = data.wingMolt ?? '';
      return [wingIsMolt, wingMolt];
    }
  }

  List<String> _getTailMolt() {
    if (data.tailIsMolt == null) {
      return ['', ''];
    } else {
      String tailIsMolt = data.tailIsMolt! == 1 ? 'Yes' : 'No';
      String tailMolt = data.tailMolt ?? '';
      return [tailIsMolt, tailMolt];
    }
  }
}
