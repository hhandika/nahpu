import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

SettingsThemeData getSettingData(BuildContext context) {
  return SettingsThemeData(
    leadingIconsColor: Theme.of(context).colorScheme.primary,
    settingsListBackground: Theme.of(context).colorScheme.background,
    settingsSectionBackground:
        Theme.of(context).colorScheme.surfaceVariant.withAlpha(100),
    settingsTileTextColor: Theme.of(context).colorScheme.onBackground,
  );
}
