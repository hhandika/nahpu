import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/setttings.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'dashboard.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/validation.dart';
import 'package:nahpu/services/project_services.dart';

class CreateProjectForm extends ConsumerStatefulWidget {
  const CreateProjectForm({Key? key}) : super(key: key);

  @override
  NewProjectFormState createState() => NewProjectFormState();
}

class NewProjectFormState extends ConsumerState<CreateProjectForm> {
  final _formKey = GlobalKey<FormState>();
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
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    ProjectFormField(
                      controller: projectCtr.projectNameCtr,
                      maxLength: 25,
                      labelText: 'Project name*',
                      hintText: 'Enter the name of the project (required)',
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(25),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9-_]+|\s'),
                        ),
                      ],
                      onChanged: (value) {
                        ref
                            .watch(projectFormNotifier.notifier)
                            .validateProjectName(value);
                        ref
                            .watch(projectFormNotifier.notifier)
                            .checkProjectNameExists(ref, value?.trim() ?? '');
                      },
                      errorText: ref
                          .watch(projectFormNotifier)
                          .form
                          .projectName
                          .errMsg,
                    ),
                    ProjectFormField(
                      controller: projectCtr.descriptionCtr,
                      labelText: 'Project description',
                      hintText: 'Enter a description of the project (optional)',
                    ),
                    ProjectFormField(
                      controller: projectCtr.pICtr,
                      labelText: 'Principal Investigator',
                      hintText: 'Enter PI name of the project (optional)',
                    ),
                    ProjectFormField(
                      controller: projectCtr.pICtr,
                      labelText: 'Location',
                      hintText: 'Enter location of the project (optional)',
                    ),
                    ProjectFormField(
                      controller: projectCtr.pICtr,
                      labelText: 'Project start date',
                      hintText: 'Enter start date of the project (optional)',
                    ),
                    ProjectFormField(
                      controller: projectCtr.pICtr,
                      labelText: 'Project end date',
                      hintText: 'Enter end date of the project (optional)',
                    ),
                    const TaxonGroupFields(),
                    const SizedBox(height: 20),
                    Wrap(spacing: 10, children: [
                      SecondaryButton(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FormElevButton(
                          onPressed: () {
                            _createProject();
                            _updateProjectUuid();
                            _goToDashboard();
                            // Reset states to default
                            ref.invalidate(projectListProvider);
                            ref.invalidate(projectFormNotifier);
                          },
                          text: 'Create',
                          enabled: ref.read(projectFormNotifier).form.isValid)
                    ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createProject() async {
    final projectData = ProjectCompanion(
      uuid: db.Value(_uuidKey),
      name: db.Value(projectCtr.projectNameCtr.text),
      description: db.Value(projectCtr.descriptionCtr.text),
      principalInvestigator: db.Value(projectCtr.pICtr.text),
      created: db.Value(getSystemDateTime()),
      lastModified: db.Value(getSystemDateTime()),
    );

    await ref.read(databaseProvider).createProject(projectData);
  }

  void _updateProjectUuid() {
    ref.read(projectUuidProvider.notifier).state = _uuidKey;
  }

  Future<void> _goToDashboard() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }
}

class ProjectFormField extends StatelessWidget {
  const ProjectFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.errorText,
    this.onSaved,
    this.onChanged,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final String? Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
          labelText: labelText, hintText: hintText, errorText: errorText),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onSaved: onSaved,
      onChanged: onChanged,
    );
  }
}
