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

  // void addProject(String projectName) {
  //   _projectList.add(projectName);
  //   notifyListeners();
  // }

  // void removeProject(String projectName) {
  //   _projectList.remove(projectName);
  //   notifyListeners();
  // }
}
