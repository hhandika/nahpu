import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:drift/drift.dart' as db;
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import 'project_home.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/models/validation.dart';
import 'package:nahpu/models/project.dart';

class CreateProjectForm extends StatefulWidget {
  const CreateProjectForm({Key? key}) : super(key: key);

  @override
  State<CreateProjectForm> createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<CreateProjectForm> {
  final _formKey = GlobalKey<FormState>();
  final _uuidKey = const Uuid().v4();
  final projectNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final collectorController = TextEditingController();
  final collectorInitialController = TextEditingController();
  final collectorEmailController = TextEditingController();
  final collNumController = TextEditingController();
  final piController = TextEditingController();
  bool isInvalid = false;
  // dynamic _validationMsg;
  late NewProjectProvider _newProjectProvider;

  @override
  Widget build(BuildContext context) {
    _newProjectProvider = Provider.of<NewProjectProvider>(context);
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Create a new project'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Center(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        children: [
                          Focus(
                            child: ProjectFormField(
                              controller: projectNameController,
                              labelText: 'Project name*',
                              hintText:
                                  'Enter the name of the project (required)',
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9-_]+|\s'),
                                ),
                              ],
                              onChanged: (value) {
                                _newProjectProvider.validateProjectName(value);
                                _newProjectProvider.checkProjectNameExists(
                                    context, value);
                              },
                              errorText: _newProjectProvider.projectName.error,
                            ),
                          ),
                          ProjectFormField(
                            controller: descriptionController,
                            labelText: 'Project description',
                            hintText:
                                'Enter a description of the project (optional)',
                          ),
                          ProjectFormField(
                            controller: piController,
                            labelText: 'Principal Investigator',
                            hintText: 'Enter PI name of the project (optional)',
                          ),
                          ProjectFormField(
                            controller: collectorController,
                            hintText:
                                'Enter the name of the collector (required)',
                            labelText: 'Collector*',
                            onChanged: _newProjectProvider.validateCollName,
                            errorText: _newProjectProvider.collName.error,
                          ),
                          ProjectFormField(
                            controller: collectorInitialController,
                            maxLength: 5,
                            hintText:
                                'Enter the collector name initial (required)',
                            labelText: 'Collector initial*',
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z]+|\s'),
                              ),
                            ],
                            onChanged: (value) {
                              collectorInitialController.value =
                                  TextEditingValue(
                                      text: value!.toUpperCase(),
                                      selection:
                                          collectorInitialController.selection);
                            },
                          ),
                          ProjectFormField(
                            controller: collectorEmailController,
                            labelText: 'Collector email*',
                            hintText:
                                'Enter the email of the collector (required)',
                            onChanged: (value) {
                              _newProjectProvider.validateEmail(value);
                              collectorEmailController.value = TextEditingValue(
                                  text: value!.toLowerCase(),
                                  selection:
                                      collectorEmailController.selection);
                            },
                            errorText: _newProjectProvider.email.error,
                          ),
                          ProjectFormField(
                            controller: collNumController,
                            labelText: 'Collector number start*',
                            hintText:
                                'Enter the starting collectors number (required)',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+'),
                              ),
                            ],
                            onChanged: _newProjectProvider.validateCollNum,
                            errorText: _newProjectProvider.collNum.error,
                          ),
                          Wrap(spacing: 10, children: [
                            ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Consumer<NewProjectProvider>(
                                builder: (context, model, child) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                  primary: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                ),
                                onPressed: () {
                                  if (model.validate) {
                                    _formKey.currentState!.save();
                                    _createProject();
                                    _goToProjectHome();
                                  }
                                },
                                child: const Text(
                                  'Create',
                                ),
                              );
                            })
                          ])
                        ],
                      )))),
        ));
  }

  Future<void> _createProject() async {
    await ProjectModel(context: context).createProject(ProjectCompanion(
      projectUuid: db.Value(_uuidKey),
      projectName: db.Value(projectNameController.text),
      projectDescription: db.Value(descriptionController.text),
      collector: db.Value(collectorController.text),
      collectorInitial: db.Value(collectorInitialController.text),
      collectorEmail: db.Value(collectorEmailController.text),
      catNumStart: db.Value(int.parse(collNumController.text)),
      principalInvestigator: db.Value(piController.text),
    ));
  }

  Future<void> _goToProjectHome() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProjectHome(projectUuid: _uuidKey)),
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
    // this.validator
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  // final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          maxLength: maxLength,
          decoration: InputDecoration(
              labelText: labelText, hintText: hintText, errorText: errorText),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          // validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
        ));
  }
}
