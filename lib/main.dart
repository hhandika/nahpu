import 'package:flutter/material.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:provider/provider.dart';

import './ui/screens/main_menu.dart';
import 'package:nahpu/bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Bloc(),
      child: const MaterialApp(title: 'Nahpu', home: MainMenu()),
    );
  }
}

void setTargetPlatforms() {
  open.overrideFor(OperatingSystem.windows, () => _openOnWindows());
}

DynamicLibrary _openOnWindows() {
  final script = File(Platform.script.toFilePath());
  final libraryPath = File('${script.path}/sqlite3.dll').path;
  return DynamicLibrary.open(libraryPath);
}
