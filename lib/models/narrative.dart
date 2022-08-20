import 'package:freezed_annotation/freezed_annotation.dart';

part 'narrative.freezed.dart';

@freezed
class NarrativeModel with _$NarrativeModel {
  const factory NarrativeModel({
    required int id,
    required String date,
    required String site,
    required String narrative,
  }) = _NarrativeModel;
}
