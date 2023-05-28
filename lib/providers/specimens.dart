import 'package:nahpu/providers/database.dart';
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

const String specimenTypePrefKey = 'specimenTypes';
const String treatmentPrefKey = 'specimenTreatment';

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
    final typeList = prefs.getStringList(specimenTypePrefKey);

    List<String> currentTypes = typeList ?? defaultSpecimenType;

    if (typeList == null) {
      await prefs.setStringList(specimenTypePrefKey, currentTypes);
    }

    return currentTypes;
  }

  @override
  FutureOr<List<String>> build() async {
    return await _fetchSettings();
  }

  Future<void> add(String type) async {
    if (type.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      final typeList = prefs.getStringList(specimenTypePrefKey);
      if (typeList != null && isListContains(typeList, type)) {
        return typeList;
      }

      List<String> newList = [...typeList ?? [], type];
      await prefs.setStringList(specimenTypePrefKey, newList);
      return newList;
    });
  }

  Future<void> replaceAll(List<String> newSpecimenTypes) async {
    if (newSpecimenTypes.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      await prefs.setStringList(specimenTypePrefKey, newSpecimenTypes);
      return newSpecimenTypes;
    });
  }

  Future<void> remove(String type) async {
    if (type.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      final typeList = prefs.getStringList(specimenTypePrefKey);
      if (typeList == null || typeList.isEmpty) return [];

      if (!isListContains(typeList, type)) {
        return typeList;
      }

      List<String> newList = [...typeList]..remove(type);
      await prefs.setStringList(specimenTypePrefKey, newList);
      return newList;
    });
  }

  Future<void> clear() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      await prefs.remove(specimenTypePrefKey);
      return [];
    });
  }
}

@riverpod
class TreatmentOptions extends _$TreatmentOptions {
  Future<List<String>> _fetchSettings() async {
    final prefs = ref.watch(settingProvider);
    final treatmentList = prefs.getStringList(treatmentPrefKey);

    List<String> currentTreatments = treatmentList ?? defaultSpecimenTreatment;

    if (treatmentList == null) {
      await prefs.setStringList(treatmentPrefKey, currentTreatments);
    }

    return currentTreatments;
  }

  @override
  FutureOr<List<String>> build() async {
    return await _fetchSettings();
  }

  Future<void> add(String treatment) async {
    if (treatment.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      final treatmentList = prefs.getStringList(treatmentPrefKey);
      if (treatmentList != null && isListContains(treatmentList, treatment)) {
        return treatmentList;
      }

      List<String> newList = [...treatmentList ?? [], treatment];
      await prefs.setStringList(treatmentPrefKey, newList);
      return newList;
    });
  }

  Future<void> replaceAll(List<String> newTreatments) async {
    if (newTreatments.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      await prefs.setStringList(treatmentPrefKey, newTreatments);
      return newTreatments;
    });
  }

  Future<void> remove(String treatment) async {
    if (treatment.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      final treatmentList = prefs.getStringList(treatmentPrefKey);

      // We don't need to delete if the list is null
      // or doesn't contain the item
      if (treatmentList == null || treatmentList.isEmpty) return [];

      if (!isListContains(treatmentList, treatment)) {
        return treatmentList;
      }

      List<String> newList = [...treatmentList]..remove(treatment);
      await prefs.setStringList(treatmentPrefKey, newList);
      return newList;
    });
  }

  Future<void> clear() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      await prefs.remove(treatmentPrefKey);
      return [];
    });
  }
}

const String tissueIDPrefixKey = 'tissueIDPrefix';
const String tissueIDNumberKey = 'tissueIDNumber';

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
    final prefix = prefs.getString(tissueIDPrefixKey);
    final number = prefs.getInt(tissueIDNumberKey);
    String currentPrefix = prefix ?? '';
    int currentNumber = number ?? 0;
    if (prefix == null && number == null) {
      await prefs.setString(tissueIDPrefixKey, currentPrefix);
      await prefs.setInt(tissueIDNumberKey, currentNumber);
    }
    return TissueID(prefix: currentPrefix, number: currentNumber);
  }

  @override
  FutureOr<TissueID> build() async {
    return await _fetchSettings();
  }

  Future<void> setPrefix(String prefix) async {
    if (prefix.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (state.value == null) return TissueID(prefix: '', number: 0);
      final prefs = ref.read(settingProvider);
      await prefs.setString(tissueIDPrefixKey, prefix);
      return TissueID(prefix: prefix, number: state.value!.number);
    });
  }

  Future<void> setNumber(int number) async {
    if (number < 0) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (state.value == null) return TissueID(prefix: '', number: 0);
      final prefs = ref.read(settingProvider);
      await prefs.setInt(tissueIDNumberKey, number);
      return TissueID(prefix: state.value!.prefix, number: number);
    });
  }

  Future<void> incrementNumber() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (state.value == null) return TissueID(prefix: '', number: 0);
      final prefs = ref.read(settingProvider);
      final number = prefs.getInt(tissueIDNumberKey);
      if (number == null) return state.value!;

      await prefs.setInt(tissueIDNumberKey, number + 1);
      return TissueID(prefix: state.value!.prefix, number: number + 1);
    });
  }
}
