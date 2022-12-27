import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final themeSettingProvider =
    StateNotifierProvider<ThemeSettingNotifier, ThemeMode>((ref) {
  return ThemeSettingNotifier(ref.read(settingProvider));
});

class ThemeSettingNotifier extends StateNotifier<ThemeMode> {
  ThemeSettingNotifier(this.prefs) : super(ThemeMode.system) {
    initTheme();
  }

  final SharedPreferences prefs;

  void initTheme() {
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

  void saveThemeMode(WidgetRef ref) {
    final setting = ref.read(settingProvider);

    if (state == ThemeMode.light) {
      setting.setString('themeMode', 'light');
    } else if (state == ThemeMode.dark) {
      setting.setString('themeMode', 'dark');
    } else {
      setting.setString('themeMode', 'system');
    }
  }
}
