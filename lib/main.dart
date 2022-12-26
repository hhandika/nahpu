import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/configs/themes.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // ref.watch(themeSettingProvider.notifier).initTheme(ref);
  runApp(ProviderScope(
      overrides: [settingProvider.overrideWithValue(prefs)],
      child: const NahpuApp()));
}

class NahpuApp extends ConsumerWidget {
  const NahpuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: 'Nahpu',
        home: const Home(),
        theme: NahpuTheme.lightTheme(lightColorScheme),
        darkTheme: NahpuTheme.darkTheme(darkColorScheme),
        themeMode: ref.watch(themeSettingProvider),
      );
    });
  }
}
