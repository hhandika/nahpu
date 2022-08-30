import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/setttings.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:settings_ui/settings_ui.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const SafeArea(child: GeneralSettings()),
    );
  }
}

class GeneralSettings extends ConsumerWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeSettingProvider);
    String themeValue = _getThemeValue(theme);
    return SettingsList(sections: [
      SettingsSection(title: const Text('General'), tiles: [
        SettingsTile.navigation(
          leading: const Icon(Icons.color_lens_rounded),
          title: const Text('Theme'),
          value: Text(themeValue),
          onPressed: (context) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThemeSetting(isSelected: themeValue),
            ),
          ),
        ),
      ])
    ]);
  }

  String _getThemeValue(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.system:
        return 'System';
    }
  }
}

class ThemeSetting extends ConsumerStatefulWidget {
  const ThemeSetting({Key? key, required this.isSelected}) : super(key: key);
  final String isSelected;
  @override
  ThemeSettingState createState() => ThemeSettingState();
}

class ThemeSettingState extends ConsumerState<ThemeSetting> {
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
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SettingsList(sections: [
        SettingsSection(
          title: const Text('Theme'),
          tiles: themes.map(
            (e) {
              return SettingsTile(
                  leading: Icon(icons[themes.indexOf(e)]),
                  title: Text(e),
                  trailing:
                      widget.isSelected == e ? const Icon(Icons.check) : null,
                  onPressed: (_) {
                    _setTheme(e);
                    Navigator.of(context).pop();
                  });
            },
          ).toList(),
        )
      ]),
    );
  }

  void _setTheme(String theme) {
    final setTheme = ref.read(themeSettingProvider.notifier);
    switch (theme) {
      case 'Dark':
        setTheme.setDarkMode();
        break;
      case 'Light':
        setTheme.setLightMode();
        break;
      case 'System':
        setTheme.setSystemMode();
        break;
    }
  }
}
