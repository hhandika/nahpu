// import 'package:flutter/material.dart';
// import 'package:nahpu/database/database.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:provider/provider.dart

// class ProjectModel {
//   ProjectModel(this.ref) : db = ref.read(databaseProvider);

//   final Ref ref;
//   final Database db;

//   Future<void> createProject(ProjectCompanion project) async {
//     return db.createProject(project);
//   }

//   Future<List<ProjectData>> getAllProjects() async {
//     return db.getAllProjects();
//   }

//   Future<List<ListProjectResult>> getProjectList() async {
//     return db.getProjectList();
//   }

//   Future<ProjectData> getProjectByUuid(String uuid) async {
//     return db.getProjectByUuid(uuid);
//   }

//   Future<String?> getProjectByName(String? projectName) async {
//     return await db
//         .getProjectByName(projectName)
//         .then((value) => value?.projectName);
//   }

  // Future<bool> isProjectExists(String? projectName) {
  //   return getProjectByName(projectName).then((value) => value != null);
  // }

//   Future<void> deleteProject(String projectUuid) async {
//     return await db.deleteProject(projectUuid);
//   }
// }
