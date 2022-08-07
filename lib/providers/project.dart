import 'package:flutter/cupertino.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/models/project.dart';

class ProjectListNotifier extends ChangeNotifier {
  List<ListProjectResult> _projectList = [];
  List<ListProjectResult> get projectList => _projectList;

  void getProjectList(BuildContext context) {
    ProjectModel(context: context).getProjectList().then((value) {
      _projectList = value.reversed.toList();
      notifyListeners();
    });
  }

  void deleteProject(BuildContext context, String projectUuid) {
    ProjectModel(context: context).deleteProject(projectUuid);
    notifyListeners();
  }
}
