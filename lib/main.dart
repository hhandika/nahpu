import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:nahpu/models/validation.dart';
import 'package:provider/provider.dart';

import 'package:nahpu/configs/themes.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MultiProvider(
        providers: [
          Provider(
            create: (_) => Database(),
            dispose: (_, Database database) => database.close(),
          ),
          ChangeNotifierProvider(
            create: (_) => NewProjectProvider(),
          )
        ],
        child: MaterialApp(
          title: 'Nahpu',
          home: const Home(),
          theme: NahpuTheme.lightTheme(lightColorScheme),
          darkTheme: NahpuTheme.darkTheme(darkColorScheme),
        ),
      );
    });
  }
}
