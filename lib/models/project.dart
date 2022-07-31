import 'package:flutter/material.dart';
import 'package:nahpu/database/database.dart';

import 'package:provider/provider.dart';

class ProjectModel {
  ProjectModel({required this.context}) : db = Provider.of<Database>(context);
  final BuildContext context;
  final Database db;

  Future<void> createProject(ProjectCompanion project) async {
    return db.createProject(project);
  }

  Future<List<ProjectData>> getAllProjects() async {
    return db.getAllProjects();
  }
}
