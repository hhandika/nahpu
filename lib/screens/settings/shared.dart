import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/screens/settings/db_settings.dart';
import 'package:nahpu/services/platform_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:nahpu/styles/settings.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/providers/settings.dart';

class AppearanceSettings {
  AppearanceSettings({required this.ref});

  final WidgetRef ref;

  SettingsSection getSetting() {
    final theme = ref.watch(themeSettingProvider);
    return SettingsSection(
      title: const SettingTitle(title: 'Applications'),
      tiles: [
        theme.when(
          data: (themeValue) => SettingsTile.navigation(
            leading: const Icon(Icons.color_lens_outlined),
            title: const Text('Theme'),
            value: Text(themeValue.name.toSentenceCase()),
            onPressed: (context) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ThemeSettings(isSelected: themeValue.name.toSentenceCase()),
              ),
            ),
          ),
          loading: () => _getThemeSettingTile(ThemeMode.system),
          error: (error, stackTrace) => _getThemeSettingTile(ThemeMode.system),
        ),
        SettingsTile.navigation(
          leading: Icon(MdiIcons.databaseOutline),
          title: const Text('Database'),
          onPressed: (context) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DatabaseSettings(),
            ),
          ),
        ),
      ],
    );
  }

  SettingsTile _getThemeSettingTile(ThemeMode themeValue) {
    return SettingsTile.navigation(
      leading: const Icon(Icons.color_lens_outlined),
      title: const Text('Theme'),
      value: Text(themeValue.name.toSentenceCase()),
      onPressed: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ThemeSettings(isSelected: themeValue.name.toSentenceCase()),
        ),
      ),
    );
  }
}

class ThemeSettings extends ConsumerStatefulWidget {
  const ThemeSettings({Key? key, required this.isSelected}) : super(key: key);
  final String isSelected;
  @override
  ThemeSettingState createState() => ThemeSettingState();
}

class ThemeSettingState extends ConsumerState<ThemeSettings> {
  final List<String> themes = ['Dark', 'Light', 'System'];
  final List<IconData> icons = [
    Icons.brightness_3_rounded,
    Icons.wb_sunny_rounded,
    systemIcon
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
      ),
      body: SettingsList(
        lightTheme: getSettingData(context),
        darkTheme: getSettingData(context),
        sections: [
          SettingsSection(
            title: const SettingTitle(title: 'Theme'),
            tiles: themes.map(
              (e) {
                return SettingsTile(
                    leading: Icon(icons[themes.indexOf(e)]),
                    title: Text(e),
                    trailing:
                        widget.isSelected == e ? const Icon(Icons.check) : null,
                    onPressed: (_) {
                      ref.read(themeSettingProvider.notifier).setTheme(e);
                      Navigator.of(context).pop();
                    });
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
