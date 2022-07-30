import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:drift/drift.dart' as db;
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import '../projects/project_menu.dart';
import 'package:nahpu/database/database.dart';

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
  final collectorEmailController = TextEditingController();
  final catNumController = TextEditingController();
  final teamLaederController = TextEditingController();

  get child => null;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a new project'),
          backgroundColor: const Color(0xFF2457C5),
        ),
        body: Center(
            child: Form(
          key: _formKey,
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          children: [
                            ProjectFormField(
                              controller: projectNameController,
                              labelText: 'Project name*',
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9-_]+|\s'),
                                ),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Project name is required';
                                }
                                return null;
                              },
                            ),
                            ProjectFormField(
                              controller: descriptionController,
                              labelText: 'Project description*',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Project description is required';
                                }
                                return null;
                              },
                            ),
                            ProjectFormField(
                              controller: collectorController,
                              labelText: 'Collector*',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Collector name is required';
                                }
                                return null;
                              },
                            ),
                            ProjectFormField(
                              controller: collectorEmailController,
                              labelText: 'Collector email*',
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
                            ProjectFormField(
                              controller: teamLaederController,
                              labelText: 'Team leader',
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
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _createProject();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProjectMenu()),
                                    );
                                  }
                                },
                                child: const Text('Create'),
                              )
                            ])
                          ],
                        )))
              ]),
        )));
  }

  Future<void> _createProject() async {
    final database = Provider.of<Database>(context, listen: false);
    database.createProject(ProjectCompanion(
      projectId: db.Value(_uuidKey),
      projectName: db.Value(projectNameController.text),
      projectDescription: db.Value(descriptionController.text),
      collector: db.Value(collectorController.text),
      collectorEmail: db.Value(collectorEmailController.text),
      catNumStart: db.Value(int.parse(catNumController.text)),
      teamLeader: db.Value(teamLaederController.text),
    ));
  }
}

class ProjectFormField extends StatelessWidget {
  const ProjectFormField(
      {Key? key,
      required this.labelText,
      required this.controller,
      this.keyboardType,
      this.inputFormatters,
      this.validator})
      : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: labelText,
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
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
