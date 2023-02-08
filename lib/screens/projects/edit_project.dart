import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/screens/projects/components/project_form.dart';
import 'package:nahpu/services/project_services.dart';

class EditProject extends ConsumerStatefulWidget {
  const EditProject({super.key});

  @override
  EditProjectState createState() => EditProjectState();
}

class EditProjectState extends ConsumerState<EditProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit project'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ProjectForm(
          projectCtr: _getProjectCtr(),
          projectUuid: ProjectServices(ref).getProjectUuid(),
        ),
      ),
    );
  }

  ProjectFormCtrModel _getProjectCtr() {
    return ProjectFormCtrModel.empty();
  }
}
