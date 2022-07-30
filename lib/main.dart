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
      child: const MaterialApp(title: 'Nahpu', home: MainMenu()),
      dispose: (_, Database database) => database.close(),
    );
  }
}
