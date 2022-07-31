import 'package:flutter/material.dart';
import 'package:nahpu/database/database.dart';

import 'package:provider/provider.dart';

class ProjectModel {
  ProjectModel({required this.context}) : super();
  final BuildContext context;

  Future<void> createProject(ProjectCompanion project) async {
    return Provider.of<Database>(context, listen: false).createProject(project);
  }
}
