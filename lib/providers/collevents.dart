import 'dart:async';

import 'package:nahpu/providers/database.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/types/collecting.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collevents.g.dart';

const String collEventMethodPrefKey = 'collEventMethods';
const String collPersonnelRolePrefKey = 'collPersonnelRoles';

// final collEventEntryProvider =
//     FutureProvider.autoDispose<List<CollEventData>>((ref) {
//   final projectUuid = ref.watch(projectUuidProvider);
//   final collEvents =
//       CollEventQuery(ref.read(databaseProvider)).getAllCollEvents(projectUuid);
//   return collEvents;
// });

@riverpod
class CollEventEntry extends _$CollEventEntry {
  Future<List<CollEventData>> _fetchCollEventEntry() async {
    final projectUuid = ref.watch(projectUuidProvider);

    final collEvents = CollEventQuery(ref.read(databaseProvider))
        .getAllCollEvents(projectUuid);

    return collEvents;
  }

  @override
  FutureOr<List<CollEventData>> build() async {
    return await _fetchCollEventEntry();
  }

  Future<void> search(String? query) async {
    if (query == null || query.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (state.value == null) return [];
      final collEvents = await _fetchCollEventEntry();
      final filteredCollEvents = CollEventSearchServices(collEvents: collEvents)
          .search(query.toLowerCase());
      return filteredCollEvents;
    });
  }
}

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
    final methodList = prefs.getStringList(collEventMethodPrefKey);

    List<String> currentMethods = methodList ?? defaultCollMethods;

    if (methodList == null) {
      await prefs.setStringList(collEventMethodPrefKey, currentMethods);
    }

    return currentMethods;
  }

  @override
  FutureOr<List<String>> build() async {
    return await _fetchSettings();
  }

  Future<void> add(String newMethod) async {
    if (newMethod.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      final methodList = prefs.getStringList(collEventMethodPrefKey);
      if (methodList != null && isListContains(methodList, newMethod)) {
        return methodList;
      }
      // Add new method to list or create new list if null
      // and then add a new method to the list
      List<String> newList = [...methodList ?? [], newMethod];
      await prefs.setStringList(collEventMethodPrefKey, newList);
      return newList;
    });
  }

  Future<void> replaceAll(List<String> newMethods) async {
    if (newMethods.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      await prefs.setStringList(collEventMethodPrefKey, newMethods);
      return newMethods;
    });
  }

  Future<void> remove(String method) async {
    if (method.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      final methodList = prefs.getStringList(collEventMethodPrefKey);
      if (methodList == null || methodList.isEmpty) return [];

      // Remove method from list
      List<String> newList = [...methodList]..remove(method);
      await prefs.setStringList(collEventMethodPrefKey, newList);
      return newList;
    });
  }

  Future<void> clear() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      await prefs.remove(collEventMethodPrefKey);
      return [];
    });
  }
}

@riverpod
class CollPersonnelRole extends _$CollPersonnelRole {
  Future<List<String>> _fetchSettings() async {
    final prefs = ref.watch(settingProvider);
    final roleList = prefs.getStringList(collPersonnelRolePrefKey);

    List<String> currentRoles = roleList ?? defaultCollPersonnelRoles;

    if (roleList == null) {
      await prefs.setStringList(collPersonnelRolePrefKey, currentRoles);
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
      final roleList = prefs.getStringList(collPersonnelRolePrefKey);
      if (roleList != null && isListContains(roleList, newRole)) {
        return roleList;
      }
      // Add new role to list or create new list if null
      // and then add a new role to the list
      List<String> newList = [...roleList ?? [], newRole];
      await prefs.setStringList(collPersonnelRolePrefKey, newList);
      return newList;
    });
  }

  Future<void> replaceAll(List<String> newRoles) async {
    if (newRoles.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      await prefs.setStringList(collPersonnelRolePrefKey, newRoles);
      return newRoles;
    });
  }

  Future<void> remove(String role) async {
    if (role.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      final roleList = prefs.getStringList(collPersonnelRolePrefKey);

      if (!roleList!.contains(role)) return roleList;
      List<String> newList = [...roleList]..remove(role);
      await prefs.setStringList(collPersonnelRolePrefKey, newList);
      return newList;
    });
  }

  Future<void> clear() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(settingProvider);
      await prefs.remove(collPersonnelRolePrefKey);
      return [];
    });
  }
}
