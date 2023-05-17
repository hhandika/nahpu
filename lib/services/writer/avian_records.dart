import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    String weight = getWeight();
    return weight;
  }

  String getWeight() {
    return '${data.weight ?? ''}';
  }
}
