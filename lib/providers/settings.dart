import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/types.dart';
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

final catalogFmtNotifier =
    StateNotifierProvider<CatalogFmtNotifier, CatalogFmt>(
        (ref) => CatalogFmtNotifier());

class CatalogFmtNotifier extends StateNotifier<CatalogFmt> {
  CatalogFmtNotifier() : super(CatalogFmt.generalMammals);

  void setCatalogFmt(CatalogFmt catalogFmt) {
    state = catalogFmt;
  }
}

// // We need to save the catalog number to the shared preferences
// // so that we can retrieve it when the app is restarted.
// // and also we can use it to generate the catalog number for the
// // next project.
// final catalogNumberNotifier =
//     StateNotifierProvider<CatalogNumberNotifier, int>((ref) {
//   return CatalogNumberNotifier();
// });

// class CatalogNumberNotifier extends StateNotifier<int> {
//   CatalogNumberNotifier() : super(0);

//   void initCatNum(WidgetRef ref) {
//     final prefs = ref.read(settingProvider);
//     final lastCatNum = prefs.getInt('catNum');
//     if (lastCatNum != null) {
//       state = lastCatNum;
//     }
//   }

//   void increaseCatNum() {
//     state++;
//   }

//   void decreaseCatNum() {
//     state--;
//   }

//   void saveCatNum(WidgetRef ref) {
//     final prefs = ref.read(settingProvider);
//     prefs.setInt('catNum', state);
//   }
// }
