import 'package:flutter/material.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/screens/home.dart';

import 'package:provider/provider.dart';

// import 'package:nahpu/bloc.dart';

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
        home: const Home(),
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF2457C5),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
      dispose: (_, Database database) => database.close(),
    );
  }
}
