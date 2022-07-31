import 'package:flutter/material.dart';
import 'package:nahpu/database/database.dart';

class Bloc {
  Bloc({required this.context, this.db});
  final BuildContext context;
  final db;

  void createProject(ProjectCompanion name) {
    db.createProject(name);
  }

  void close() {
    db.close();
  }
}
