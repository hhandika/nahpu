import 'package:flutter/material.dart';
import 'package:nahpu/database/database.dart';

import 'package:provider/provider.dart';

class ProjectModel {
  final BuildContext context;
  final Database db;

  ProjectModel({required this.context})
      : db = Provider.of<Database>(context, listen: false);

  Future<void> createProject(ProjectCompanion project) async {
    return db.createProject(project);
  }

  Future<List<ProjectData>> getAllProjects() async {
    return db.getAllProjects();
  }

  Future<ProjectData> getProjectByUuid(String uuid) async {
    return db.getProjectByUuid(uuid);
  }

  Future<String?> getProjectByName(String? projectName) async {
    final String? query = await db
        .getProjectByName(projectName)
        .then((value) => value?.projectName);
    return query;
  }

  Future<bool> isProjectExists(String? projectName) {
    return getProjectByName(projectName).then((value) => value != null);
  }

  Future<void> deleteProject(String projectUuid) async {
    return await db.deleteProject(projectUuid);
  }
}
