import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

void getSavedTheme(WidgetRef ref) {
  final setting = ref.read(settingProvider);
  final theme = ref.read(themeSettingProvider.notifier);
  setting.maybeWhen(
      data: (prefs) {
        final themeMode = prefs.getString('themeMode');
        if (themeMode == 'light') {
          theme.setLightMode();
        } else if (themeMode == 'dark') {
          theme.setDarkMode();
        } else {
          theme.setSystemMode();
        }
      },
      orElse: () => ({}));
}

final themeSettingProvider =
    StateNotifierProvider<ThemeSettingNotifier, ThemeMode>((ref) {
  return ThemeSettingNotifier();
});

class ThemeSettingNotifier extends StateNotifier<ThemeMode> {
  ThemeSettingNotifier() : super(ThemeMode.system);

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
    setting.when(
        data: (setting) {
          if (state == ThemeMode.light) {
            setting.setString('themeMode', 'light');
          } else if (state == ThemeMode.dark) {
            setting.setString('themeMode', 'dark');
          } else {
            setting.setString('themeMode', 'system');
          }
        },
        loading: () {},
        error: (error, stackTrace) {});
  }
}
