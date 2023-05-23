import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.g.dart';

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
