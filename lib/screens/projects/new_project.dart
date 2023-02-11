import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/screens/projects/components/project_form.dart';
import 'package:nahpu/services/project_services.dart';

class CreateProjectForm extends ConsumerStatefulWidget {
  const CreateProjectForm({Key? key}) : super(key: key);

  @override
  CreateProjectFormState createState() => CreateProjectFormState();
}

class CreateProjectFormState extends ConsumerState<CreateProjectForm> {
  final _uuidKey = uuid;
  final ProjectFormCtrModel projectCtr = ProjectFormCtrModel.empty();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    projectCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new project'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ProjectForm(
          projectCtr: projectCtr,
          projectUuid: _uuidKey,
        ),
      ),
    );
  }
}
