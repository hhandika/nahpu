import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/providers/projects.dart';
import 'package:nahpu/screens/projects/components/project_form.dart';
import 'package:nahpu/services/database/database.dart';

class EditProject extends ConsumerStatefulWidget {
  const EditProject({super.key, required this.projectUuid});

  final String projectUuid;

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
        child: ref.watch(projectInfoProvider(widget.projectUuid)).when(
            data: (data) => ProjectForm(
                  projectCtr: getProjectCtr(data),
                  projectUuid: widget.projectUuid,
                  isEditing: true,
                ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text(error.toString())),
      ),
    );
  }

  ProjectFormCtrModel getProjectCtr(ProjectData? data) {
    return ProjectFormCtrModel.fromData(data);
  }
}
