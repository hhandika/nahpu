import 'package:flutter/cupertino.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/models/project.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final projectListNotifier = ChangeNotifierProvider<ProjectListNotifier>(
    (ref) => ProjectListNotifier(ref));

class ProjectListNotifier extends ChangeNotifier {
  ProjectListNotifier(this.ref);
  List<ListProjectResult> _projectList = [];
  List<ListProjectResult> get projectList => _projectList;

  final Ref ref;

  void getProjectList() {
    ProjectModel(ref).getProjectList().then((value) {
      _projectList = value.reversed.toList();
      notifyListeners();
    });
  }

  void deleteProject(String projectUuid) {
    ProjectModel(ref).deleteProject(projectUuid);
    notifyListeners();
  }
}
