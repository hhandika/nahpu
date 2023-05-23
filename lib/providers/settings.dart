import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.g.dart';
part 'settings.freezed.dart';

@riverpod
SharedPreferences setting(SettingRef ref) {
  return throw UnimplementedError();
}

final themeSettingProvider =
    StateNotifierProvider<ThemeSettingNotifier, ThemeMode>((ref) {
  return ThemeSettingNotifier(ref.read(settingProvider));
});

class ThemeSettingNotifier extends StateNotifier<ThemeMode> {
  ThemeSettingNotifier(this.prefs) : super(ThemeMode.system) {
    _initTheme();
  }

  final SharedPreferences prefs;

  void _initTheme() {
    final theme = prefs.getString('themeMode');
    if (theme != null) {
      switch (theme) {
        case 'dark':
          state = ThemeMode.dark;
          break;
        case 'light':
          state = ThemeMode.light;
          break;
        case 'system':
          state = ThemeMode.system;
          break;
      }
    }
  }

  void setDarkMode() {
    state = ThemeMode.dark;
  }

  void setLightMode() {
    state = ThemeMode.light;
  }

  void setSystemMode() {
    state = ThemeMode.system;
  }

  void saveThemeMode() {
    if (state == ThemeMode.light) {
      prefs.setString('themeMode', 'light');
    } else if (state == ThemeMode.dark) {
      prefs.setString('themeMode', 'dark');
    } else {
      prefs.setString('themeMode', 'system');
    }
  }
}

final catalogFmtNotifier =
    StateNotifierProvider<CatalogFmtNotifier, CatalogFmt>(
        (ref) => CatalogFmtNotifier());

class CatalogFmtNotifier extends StateNotifier<CatalogFmt> {
  CatalogFmtNotifier() : super(CatalogFmt.generalMammals);

  void setCatalogFmt(CatalogFmt catalogFmt) {
    state = catalogFmt;
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
