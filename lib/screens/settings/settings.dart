import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return SettingsList(sections: [
      SettingsSection(title: const Text('General'), tiles: [
        SettingsTile.navigation(
          leading: const Icon(Icons.color_lens_rounded),
          title: const Text('Apperance'),
          onPressed: (context) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Appearance(),
            ),
          ),
        ),
      ])
    ]);
  }
}

class Appearance extends ConsumerWidget {
  const Appearance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> themes = ['dark', 'light', 'system'];
    List<bool> isSelected = [false, false, false];
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
                  leading: isSelected[themes.indexOf(e)]
                      ? const Icon(Icons.check)
                      : null,
                  onPressed: (_) {
                    Navigator.of(context).pop();
                  });
            },
          ).toList(),
        )
      ]),
    );
  }
}
