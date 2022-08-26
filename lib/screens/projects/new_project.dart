import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/project.dart';
import 'package:uuid/uuid.dart';

import 'project_home.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/validation.dart';

class CreateProjectForm extends ConsumerStatefulWidget {
  const CreateProjectForm({Key? key}) : super(key: key);

  @override
  NewProjectFormState createState() => NewProjectFormState();
}

class NewProjectFormState extends ConsumerState<CreateProjectForm> {
  final _formKey = GlobalKey<FormState>();
  final _uuidKey = const Uuid().v4();
  final projectNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final collectorController = TextEditingController();
  final collectorInitialController = TextEditingController();
  final collectorEmailController = TextEditingController();
  final collNumController = TextEditingController();
  final piController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                              maxLength: 25,
                              labelText: 'Project name*',
                              hintText:
                                  'Enter the name of the project (required)',
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
                                    .checkProjectNameExists(ref, value?.trim());
                              },
                              errorText: ref
                                  .watch(projectFormNotifier)
                                  .form
                                  .projectName
                                  .errMsg,
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
                            onChanged: ref
                                .watch(projectFormNotifier.notifier)
                                .validateCollName,
                            errorText: ref
                                .watch(projectFormNotifier)
                                .form
                                .collName
                                .errMsg,
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
                              ref
                                  .watch(projectFormNotifier.notifier)
                                  .validateEmail(
                                    value,
                                  );
                              collectorEmailController.value = TextEditingValue(
                                  text: value!.toLowerCase(),
                                  selection:
                                      collectorEmailController.selection);
                            },
                            errorText: ref
                                .watch(projectFormNotifier)
                                .form
                                .email
                                .errMsg,
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
                            onChanged: ref
                                .watch(projectFormNotifier.notifier)
                                .validateCollNum,
                            errorText: ref
                                .watch(projectFormNotifier)
                                .form
                                .collNum
                                .errMsg,
                          ),
                          Wrap(spacing: 10, children: [
                            ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CustomElevButton(
                                onPressed: () {
                                  _createProject();
                                  _goToProjectHome();
                                  // Reset states to default
                                  ref.refresh(projectListProvider);
                                  ref.refresh(projectFormNotifier.notifier);
                                },
                                text: 'Create',
                                enabled:
                                    ref.read(projectFormNotifier).form.isValid)
                          ])
                        ],
                      )))),
        ));
  }

  Future<void> _createProject() async {
    await ref.read(databaseProvider).createProject(ProjectCompanion(
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
    ref.read(projectUuidProvider.state).state = _uuidKey;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProjectHome()),
    );
  }
}

class CustomElevButton extends StatelessWidget {
  const CustomElevButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.enabled,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (enabled) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Theme.of(context).colorScheme.onPrimaryContainer,
          primary: Theme.of(context).colorScheme.primaryContainer,
        ),
        onPressed: onPressed,
        child: Text(text),
      );
    } else {
      return ElevatedButton(
        onPressed: null,
        child: Text(text),
      );
    }
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
