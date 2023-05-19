import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/project_services.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/validation.dart';

class ProjectForm extends ConsumerStatefulWidget {
  const ProjectForm({
    super.key,
    required this.projectCtr,
    required this.projectUuid,
    this.isEditing = false,
  });

  final ProjectFormCtrModel projectCtr;
  final String projectUuid;
  final bool isEditing;

  @override
  ProjectFormState createState() => ProjectFormState();
}

class ProjectFormState extends ConsumerState<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                ProjectFormField(
                  controller: widget.projectCtr.projectNameCtr,
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
                        .watch(projectFormValidation.notifier)
                        .validateProjectName(value);
                    ref
                        .watch(projectFormValidation.notifier)
                        .checkProjectNameExists(ref, value?.trim() ?? '');
                  },
                  errorText:
                      ref.watch(projectFormValidation).form.projectName.errMsg,
                ),
                ProjectFormField(
                  controller: widget.projectCtr.descriptionCtr,
                  labelText: 'Project description',
                  hintText: 'Enter a description of the project (optional)',
                ),
                Visibility(
                  visible: widget.isEditing,
                  child: ProjectFormField(
                    controller: widget.projectCtr.pICtr,
                    labelText: 'Principal Investigator',
                    hintText: 'Enter PI name of the project (optional)',
                  ),
                ),
                const TaxonGroupFields(),
                Visibility(
                  visible: widget.isEditing,
                  child: ProjectFormField(
                    controller: widget.projectCtr.locationCtr,
                    labelText: 'Location',
                    hintText: 'Enter location of the project (optional)',
                  ),
                ),
                Visibility(
                  visible: widget.isEditing,
                  child: TextField(
                    controller: widget.projectCtr.startDateCtr,
                    decoration: const InputDecoration(
                      labelText: 'Start date',
                      hintText: 'Enter the project start date',
                    ),
                    onTap: () async {
                      DateTime? selectedDate = await _showDate(
                        context,
                      );
                      if (selectedDate != null) {
                        widget.projectCtr.startDateCtr.text =
                            DateFormat.yMMMd().format(selectedDate);
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: widget.isEditing,
                  child: TextField(
                    controller: widget.projectCtr.endDateCtr,
                    decoration: const InputDecoration(
                      labelText: 'End date',
                      hintText: 'Enter the project end date',
                    ),
                    onTap: () async {
                      DateTime? selectedDate = await _showDate(
                        context,
                      );
                      if (selectedDate != null) {
                        widget.projectCtr.endDateCtr.text =
                            DateFormat.yMMMd().format(selectedDate);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(spacing: 10, children: [
                  SecondaryButton(
                    text: 'Cancel',
                    onPressed: () {
                      ref.invalidate(projectFormValidation);
                      Navigator.pop(context);
                    },
                  ),
                  FormElevButton(
                    onPressed: () {
                      widget.isEditing ? _updateProject() : _createProject();
                      _goToDashboard();
                    },
                    text: widget.isEditing ? 'Update' : 'Create',
                    enabled: widget.isEditing
                        ? true // Temporary fix to allow editing
                        : ref.read(projectFormValidation).form.isValid,
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _showDate(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030)); // Prevent user from selecting future dates
  }

  void _createProject() {
    final projectData = ProjectCompanion(
      uuid: db.Value(widget.projectUuid),
      name: db.Value(widget.projectCtr.projectNameCtr.text),
      description: db.Value(widget.projectCtr.descriptionCtr.text),
      created: db.Value(getSystemDateTime()),
      lastAccessed: db.Value(getSystemDateTime()),
    );

    ProjectServices(ref).createProject(projectData);
  }

  void _updateProject() {
    final projectData = ProjectCompanion(
      name: db.Value(widget.projectCtr.projectNameCtr.text),
      description: db.Value(widget.projectCtr.descriptionCtr.text),
      principalInvestigator: db.Value(widget.projectCtr.pICtr.text),
      location: db.Value(widget.projectCtr.locationCtr.text),
      startDate: db.Value(widget.projectCtr.startDateCtr.text),
      endDate: db.Value(widget.projectCtr.endDateCtr.text),
      created: db.Value(getSystemDateTime()),
      lastAccessed: db.Value(getSystemDateTime()),
    );

    ProjectServices(ref).updateProject(widget.projectUuid, projectData);
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
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.errorText,
    this.onSaved,
    this.onChanged,
  });

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
