import 'package:flutter/material.dart';

import './src/screens/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nahpu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomBar(),
    );
  }
}
