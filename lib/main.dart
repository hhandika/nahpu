import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/configs/themes.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/screens/home.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return Provider(
        create: (_) => Database(),
        child: MaterialApp(
          title: 'Nahpu',
          home: const Home(),
          theme: NahpuTheme.lightTheme(lightColorScheme),
          darkTheme: NahpuTheme.darkTheme(darkColorScheme),
        ),
        dispose: (_, Database database) => database.close(),
      );
    });
  }
}
