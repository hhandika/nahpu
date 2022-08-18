import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';
// import 'package:nahpu/providers/project.dart';
// import 'package:nahpu/providers/validation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:provider/provider.dart';

import 'package:nahpu/configs/themes.dart';
// import 'package:nahpu/database/database.dart';
import 'package:nahpu/screens/home.dart';

void main() {
  runApp(const ProviderScope(child: NahpuApp()));
}

class NahpuApp extends StatelessWidget {
  const NahpuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: 'Nahpu',
        home: const Home(),
        theme: NahpuTheme.lightTheme(lightColorScheme),
        darkTheme: NahpuTheme.darkTheme(darkColorScheme),
      );
    });
  }
}
