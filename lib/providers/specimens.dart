import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/types/specimens.dart';
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

@freezed
class SpecimenType with _$SpecimenType {
  const factory SpecimenType({
    required List<String> typeList,
    required List<String> preservationList,
  }) = _SpecimenType;

  factory SpecimenType.defaultType() => const SpecimenType(
        typeList: defaultSpecimenType,
        preservationList: defaultSpecimenPreservation,
      );
}

@riverpod
class SpecimenTypeNotifier extends _$SpecimenTypeNotifier {
  Future<SpecimenType> _fetchSettings() async {
    final prefs = ref.watch(settingProvider);
    final typeList = prefs.getStringList('specimenTypes');
    final preservationList = prefs.getStringList('specimenPreservation');
    if (typeList == null) {
      return SpecimenType.defaultType();
    }
    return SpecimenType(
      typeList: typeList,
      preservationList: preservationList ?? defaultSpecimenPreservation,
    );
  }

  @override
  FutureOr<SpecimenType> build() async {
    return _fetchSettings();
  }

  Future<void> addType(String type) async {
    final prefs = ref.read(settingProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      final List<String> typeList = [...state.value?.typeList ?? [], type];
      prefs.setStringList('specimenTypes', typeList);
      return _fetchSettings();
    });
  }

  Future<void> addPreservation(String preservation) async {
    final prefs = ref.read(settingProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      final List<String> preservationList = [
        ...state.value?.preservationList ?? [],
        preservation
      ];
      prefs.setStringList('specimenPreservation', preservationList);
      return _fetchSettings();
    });
  }

  Future<void> deleteType(String type) async {
    final prefs = ref.read(settingProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      final List<String> typeList = [...state.value?.typeList ?? []];
      typeList.remove(type);
      prefs.setStringList('specimenTypes', typeList);
      return _fetchSettings();
    });
  }

  Future<void> deletePreservation(String preservation) async {
    final prefs = ref.read(settingProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      final List<String> preservationList = [
        ...state.value?.preservationList ?? []
      ];
      preservationList.remove(preservation);
      prefs.setStringList('specimenPreservation', preservationList);
      return _fetchSettings();
    });
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

  Future<void> setPrefix(String prefix) async {
    final prefs = ref.read(settingProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      prefs.setString('tissueIDPrefix', prefix);
      return _fetchSettings();
    });
  }

  Future<void> setNumber(int number) async {
    final prefs = ref.read(settingProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      prefs.setInt('tissueIDNumber', number);
      return _fetchSettings();
    });
  }

  Future<void> incrementNumber() async {
    final prefs = ref.watch(settingProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      final number = prefs.getInt('tissueIDNumber') ?? 0;
      prefs.setInt('tissueIDNumber', number + 1);
      return _fetchSettings();
    });
  }
}
