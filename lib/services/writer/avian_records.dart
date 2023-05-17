import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    String weight = _getWeight();
    String wingSpan = _getWingSpan();
    String irisColor = _getIrisColor();
    String billColor = _getBillColor();
    String footColor = _getFootColor();
    String tarsusColor = _getTarsusColor();
    String sexData = _getSexData();
    return '$sexData$weight$delimiter$wingSpan$delimiter$irisColor$delimiter'
        '$billColor$delimiter$footColor$delimiter$tarsusColor';
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

  String _getSexData() {
    SpecimenSex? sexEnum = getSpecimenSex(data.sex);
    String sex = data.sex != null ? specimenSexList[data.sex!] : '';
    String emptyMale = delimiter;
    String emptyFemale = delimiter * 2;
    return '$sex$delimiter$emptyMale$emptyFemale';
  }
}
