import 'package:flutter/material.dart';
import 'package:nahpu/database/database.dart';

import 'package:provider/provider.dart';

import 'package:nahpu/screens/main_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Database(),
      child: MaterialApp(
        title: 'Nahpu',
        home: const MainMenu(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
      dispose: (_, Database database) => database.close(),
    );
  }
}
