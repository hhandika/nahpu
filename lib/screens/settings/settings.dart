import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/settings/shared.dart';
import 'package:settings_ui/settings_ui.dart';

class AppSettings extends ConsumerStatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  AppSettingsState createState() => AppSettingsState();
}

class AppSettingsState extends ConsumerState<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SettingsList(
          sections: [
            AppearanceSettings(ref: ref).getSetting(),
          ],
        ),
      ),
    );
  }
}
