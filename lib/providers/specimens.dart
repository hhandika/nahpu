import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/types/specimens.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'specimens.g.dart';
part 'specimens.freezed.dart';

final specimenEntryProvider =
    FutureProvider.autoDispose<List<SpecimenData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final specimenEntries =
      SpecimenQuery(ref.read(databaseProvider)).getAllSpecimens(projectUuid);
  return specimenEntries;
});

final partBySpecimenProvider = FutureProvider.family
    .autoDispose<List<SpecimenPartData>, String>((ref, specimenUuid) =>
        SpecimenPartQuery(ref.read(databaseProvider))
            .getSpecimenParts(specimenUuid));

@riverpod
class SpecimenTypes extends _$SpecimenTypes {
  Future<List<String>> _fetchSettings() async {
    final prefs = ref.watch(settingProvider);
    final typeList = prefs.getStringList('specimenTypes');

    List<String> currentTypes = typeList ?? defaultSpecimenType;

    if (typeList == null) {
      await prefs.setStringList('specimenTypes', currentTypes);
    }

    return currentTypes;
  }

  @override
  FutureOr<List<String>> build() async {
    return await _fetchSettings();
  }
}

@riverpod
class TreatmentOptions extends _$TreatmentOptions {
  Future<List<String>> _fetchSettings() async {
    final prefs = ref.watch(settingProvider);
    final treatmentList = prefs.getStringList('specimenTreatment');

    List<String> currentTreatments = treatmentList ?? defaultSpecimenTreatment;

    if (treatmentList == null) {
      await prefs.setStringList('specimenTreatment', currentTreatments);
    }

    return currentTreatments;
  }

  @override
  FutureOr<List<String>> build() async {
    return await _fetchSettings();
  }
}

@freezed
class SpecimenType with _$SpecimenType {
  const factory SpecimenType({
    required List<String> typeList,
    required List<String> treatmentList,
  }) = _SpecimenType;

  factory SpecimenType.defaultType() => const SpecimenType(
        typeList: defaultSpecimenType,
        treatmentList: defaultSpecimenTreatment,
      );
}

@riverpod
class SpecimenTypeNotifier extends _$SpecimenTypeNotifier {
  Future<SpecimenType> _fetchSettings() async {
    final prefs = ref.watch(settingProvider);
    final typeList = prefs.getStringList('specimenTypes');
    final treatmentList = prefs.getStringList('specimenPreservation');

    List<String> currentTypes = typeList ?? SpecimenType.defaultType().typeList;
    List<String> currentTreatments =
        treatmentList ?? SpecimenType.defaultType().treatmentList;

    if (typeList == null) {
      await prefs.setStringList('specimenTypes', currentTypes);
    }

    if (treatmentList == null) {
      await prefs.setStringList('specimenPreservation', currentTreatments);
    }

    return SpecimenType(
      typeList: currentTypes,
      treatmentList: currentTreatments,
    );
  }

  @override
  FutureOr<SpecimenType> build() async {
    return _fetchSettings();
  }

  Future<void> addType(String type) async {
    if (type.isEmpty) {
      return;
    }

    final prefs = ref.watch(settingProvider);
    final typeList = prefs.getStringList('specimenTypes');
    if (typeList != null && isListContains(typeList, type)) {
      return;
    }
    List<String> newList = [...typeList ?? [], type];
    await prefs.setStringList('specimenTypes', newList);
  }

  Future<void> addTreatment(String treatment) async {
    if (treatment.isEmpty) return;

    final prefs = ref.watch(settingProvider);
    final treatmentList = prefs.getStringList('specimenPreservation');
    if (treatmentList != null && isListContains(treatmentList, treatment)) {
      return;
    }
    List<String> newList = [...treatmentList ?? [], treatment];
    await prefs.setStringList('specimenPreservation', newList);
  }

  Future<void> replaceAll(List<String> types, List<String> treatments) async {
    if (types.isEmpty || treatments.isEmpty) return;

    final prefs = ref.watch(settingProvider);
    await prefs.setStringList('specimenTypes', types);
    await prefs.setStringList('specimenPreservation', treatments);
  }

  Future<void> deleteType(String type) async {
    final prefs = ref.watch(settingProvider);
    final typeList = prefs.getStringList('specimenTypes');
    if (typeList != null && typeList.contains(type)) {
      typeList.remove(type);
      await prefs.setStringList('specimenTypes', typeList);
    }
  }

  Future<void> deleteTreatment(String type) async {
    final prefs = ref.watch(settingProvider);
    final treatmentList = prefs.getStringList('specimenPreservation');
    if (treatmentList != null && treatmentList.contains(type)) {
      treatmentList.remove(type);
      await prefs.setStringList('specimenPreservation', treatmentList);
    }
  }
}

@freezed
class TissueID with _$TissueID {
  factory TissueID({
    required String prefix,
    required int number,
  }) = _TissueID;
}

@riverpod
class TissueIDNotifier extends _$TissueIDNotifier {
  Future<TissueID> _fetchSettings() async {
    final prefs = ref.watch(settingProvider);
    final prefix = prefs.getString('tissueIDPrefix');
    final number = prefs.getInt('tissueIDNumber');
    if (prefix != null && number != null) {
      return TissueID(prefix: prefix, number: number);
    } else {
      return TissueID(prefix: '', number: 0);
    }
  }

  @override
  FutureOr<TissueID> build() async {
    return await _fetchSettings();
  }

  void setPrefix(String prefix) {
    final prefs = ref.watch(settingProvider);
    prefs.setString('tissueIDPrefix', prefix);
  }

  void setNumber(int number) {
    final prefs = ref.watch(settingProvider);
    prefs.setInt('tissueIDNumber', number);
  }

  void incrementNumber() {
    final prefs = ref.watch(settingProvider);
    final number = prefs.getInt('tissueIDNumber') ?? 0;
    prefs.setInt('tissueIDNumber', number + 1);
  }
}
