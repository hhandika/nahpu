import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:drift/drift.dart' as db;
import 'package:uuid/uuid.dart';

import 'project_home.dart';
import 'package:nahpu/database/database.dart';
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
  final catNumController = TextEditingController();
  final piController = TextEditingController();
  bool isInvalid = false;
  dynamic _validationMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Create a new project'),
          backgroundColor: const Color(0xFF2457C5),
        ),
        body: Center(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,

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
                              validator: (value) => _validationMsg,
                            ),
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                _checkProjectName();
                              }
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Collector name is required';
                              }
                              return null;
                            },
                          ),
                          ProjectFormField(
                            controller: collectorInitialController,
                            hintText:
                                'Enter the collector name initial (required)',
                            labelText: 'Collector initial*',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Collector initial is required';
                              }
                              return null;
                            },
                          ),
                          ProjectFormField(
                            controller: collectorEmailController,
                            labelText: 'Collector email*',
                            hintText:
                                'Enter the email of the collector (required)',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Collector email is required';
                              }
                              return null;
                            },
                          ),
                          ProjectFormField(
                            controller: catNumController,
                            labelText: 'Catalog number start*',
                            hintText:
                                'Enter the starting catalog number (required)',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+'),
                              ),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Catalog number start is required';
                              } else if (!value.isValidCatNum) {
                                return 'Catalog number must be a number';
                              }
                              return null;
                            },
                          ),
                          Wrap(spacing: 10, children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey),
                              ),
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF2457C5)),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _createProject();
                                  _goToProjectHome();
                                }
                              },
                              child: const Text('Create'),
                            )
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
      catNumStart: db.Value(int.parse(catNumController.text)),
      principalInvestigator: db.Value(piController.text),
    ));
  }

  Future _checkProjectName() async {
    _validationMsg = null;
    setState(() {});

    // Non async validation
    if (projectNameController.text.isEmpty) {
      _validationMsg = 'Project name is required';
      setState(() {});
    }

    bool isExist = await ProjectModel(context: context)
        .isProjectExists(projectNameController.text);

    if (isExist) {
      _validationMsg = 'Project name already exists';
      setState(() {});
    }

    setState(() {});
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
  const ProjectFormField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      this.keyboardType,
      this.inputFormatters,
      this.onSaved,
      this.validator})
      : super(key: key);

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          onSaved: onSaved,
        ));
  }
}

extension StringValidator on String {
  bool get isValidCatNum {
    final catNumRegex = RegExp(r'[0-9]');
    return catNumRegex.hasMatch(this);
  }

  bool get isValidEmail {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return emailRegex.hasMatch(this);
  }
}
