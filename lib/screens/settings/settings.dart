import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      body: const SafeArea(child: MainSettings()),
    );
  }
}

class MainSettings extends ConsumerWidget {
  const MainSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeSettingProvider);
    String themeValue = _getThemeValue(theme);
    return SettingsList(sections: [
      SettingsSection(title: const Text('General'), tiles: [
        SettingsTile.navigation(
          leading: const Icon(Icons.color_lens_rounded),
          title: const Text('Apperance'),
          value: Text(themeValue),
          onPressed: (context) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Appearance(isSelected: themeValue),
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

class Appearance extends ConsumerStatefulWidget {
  const Appearance({Key? key, required this.isSelected}) : super(key: key);
  final String isSelected;
  @override
  AppearanceState createState() => AppearanceState();
}

class AppearanceState extends ConsumerState<Appearance> {
  final List<String> themes = ['dark', 'light', 'system'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SettingsList(sections: [
        SettingsSection(
          title: const Text('Themes'),
          tiles: themes.map(
            (e) {
              return SettingsTile(
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
      case 'dark':
        setTheme.setDarkMode();
        break;
      case 'light':
        setTheme.setLightMode();
        break;
      case 'system':
        setTheme.setSystemMode();
        break;
    }
  }
}
