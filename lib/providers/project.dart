import 'package:flutter/cupertino.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/models/project.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final databaseProvider = Provider<Database>((ref) {
  return Database();
});

final projectListProvider = Provider<List<ListProjectResult>>((ref) {
  final db = ref.watch(databaseProvider);

  List<ListProjectResult> projectList = [];
  db.getProjectList().then((value) {
    projectList = value.reversed.toList();
  });
  return projectList;
});

final projectInfoProvider = Provider<ProjectData?>((ref, uuid) {
  final db = ref.watch(databaseProvider);
  final projectUuid = ref.watch(databaseProvider).getProjectByUuid(uuid);

  ProjectData? projectInfo;
  db.getProjectByUuid(projectUuid).then((value) {
    projectInfo = value;
  });
  return projectInfo;
});



// final projectListNotifier = StreamProvider<List<ListProjectResult>>((ref) => ref
//     .watch(databaseProvider)
//     .getProjectList()
//     .asStream()
//     .map((event) => event.reversed.toList()));

// class ProjectListNotifier extends StateNotifier<List<ListProjectResult>> {

//   List<ListProjectResult> _projectList = [];
//   get projectList => _projectList;

//   final Ref ref;

//   void getProjectList() {
//     ProjectModel(ref).getProjectList().then((value) {
//       _projectList = value.reversed.toList();
//       notifyListeners();
//     });
//   }

//   void deleteProject(String projectUuid) {
//     ProjectModel(ref).deleteProject(projectUuid);
//     notifyListeners();
//   }
// }
