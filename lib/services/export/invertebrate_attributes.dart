import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/common/utility_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimens/specimen_services.dart';
import 'package:nahpu/services/types/specimens.dart';
import 'package:nahpu/services/types/invertebrates.dart';

/// Formats invertebrate attribute records for specimen exports.
class InvertebrateAttributes {
  InvertebrateAttributes({required this.ref, required this.specimenUuid});

  final WidgetRef ref;
  final String specimenUuid;

  Future<List<String>> getAttributes() async {
    final InvertebrateAttributeData data = await SpecimenServices(
      ref: ref,
    ).getInvertebrateAttributeData(specimenUuid);

    return [
      _number(data.headWidth),
      _number(data.bodyLength),
      _number(data.wingspanUpper),
      _number(data.wingspanLower),
      getSpecimenSexLabel(data.sex) ?? '',
      data.lifeStage ?? '',
      data.caste == null ||
              data.caste! < 0 ||
              data.caste! >= invertebrateCasteList.length
          ? ''
          : invertebrateCasteList[data.caste!],
      data.hostOrganism ?? '',
      data.hostPart ?? '',
      data.remark ?? '',
    ];
  }

  String _number(double? value) => value?.truncateZero() ?? '';
}
