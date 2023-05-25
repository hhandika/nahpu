import 'dart:async';

import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/types/collecting.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collevents.g.dart';

final collEventEntryProvider =
    FutureProvider.autoDispose<List<CollEventData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final collEvents =
      CollEventQuery(ref.read(databaseProvider)).getAllCollEvents(projectUuid);
  return collEvents;
});

final collEventIDprovider =
    FutureProvider.family.autoDispose<CollEventData, int>((ref, id) async {
  final collEventID =
      CollEventQuery(ref.read(databaseProvider)).getCollEventById(id);
  return collEventID;
});

final collEffortByEventProvider = FutureProvider.family
    .autoDispose<List<CollEffortData>, int>((ref, collEventId) =>
        CollEffortQuery(ref.read(databaseProvider))
            .getCollEffortByEventId(collEventId));

final collPersonnelProvider = FutureProvider.family
    .autoDispose<List<CollPersonnelData>, int>((ref, collEventId) =>
        CollPersonnelQuery(ref.read(databaseProvider))
            .getCollPersonnelByEventId(collEventId));

final weatherDataProvider = FutureProvider.family.autoDispose<WeatherData, int>(
    (ref, collEventId) => WeatherDataQuery(ref.read(databaseProvider))
        .getWeatherDataByEventId(collEventId));

@riverpod
class CollEventMethod extends _$CollEventMethod {
  Future<List<String>> _fetchSettings() async {
    final prefs = ref.watch(settingProvider);
    final methodList = prefs.getStringList('collEventMethods');

    List<String> currentMethods = methodList ?? defaultCollMethodTypes;

    if (methodList == null) {
      await prefs.setStringList('collEventMethods', currentMethods);
    }

    return currentMethods;
  }

  @override
  FutureOr<List<String>> build() async {
    return await _fetchSettings();
  }

  Future<void> add(List<String> newMethod) async {
    if (newMethod.isEmpty) return;
    final prefs = ref.watch(settingProvider);
    await prefs.setStringList('collEventMethods', newMethod);
  }

  Future<void> remove(String method) async {
    final prefs = ref.watch(settingProvider);
    final methodList = prefs.getStringList('collEventMethods');
    if (methodList == null && methodList!.contains(method)) return;
    final newMethodList = methodList..remove(method);
    await prefs.setStringList('collEventMethods', newMethodList);
  }
}

@riverpod
class CollPersonnelRole extends _$CollPersonnelRole {
  Future<List<String>> _fetchSettings() async {
    final prefs = ref.watch(settingProvider);
    final roleList = prefs.getStringList('collPersonnelRoles');

    List<String> currentRoles = roleList ?? defaultCollPersonnelRoles;

    if (roleList == null) {
      await prefs.setStringList('collPersonnelRoles', currentRoles);
    }

    return currentRoles;
  }

  @override
  FutureOr<List<String>> build() async {
    return await _fetchSettings();
  }

  Future<void> add(String newRole) async {
    if (newRole.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      final roleList = prefs.getStringList('collPersonnelRoles');

      if (roleList == null) {
        await prefs.setStringList('collPersonnelRoles', [newRole]);
        return [newRole];
      }

      if (isListContains(roleList, newRole)) return roleList;
      List<String> newList = [...roleList, newRole];
      await prefs.setStringList('collPersonnelRoles', newList);
      return newList;
    });
  }

  Future<void> replaceAll(List<String> newRoles) async {
    if (newRoles.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      await prefs.setStringList('collPersonnelRoles', newRoles);
      return newRoles;
    });
  }

  Future<void> delete(String role) async {
    if (role.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      final roleList = prefs.getStringList('collPersonnelRoles');

      if (!roleList!.contains(role)) return roleList;
      List<String> newList = [...roleList]..remove(role);
      await prefs.setStringList('collPersonnelRoles', newList);
      return newList;
    });
  }
}
