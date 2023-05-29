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
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/providers/settings.dart';

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
  String? initialProjectName;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _getInitialProjectName();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final validator = ref.watch(projectFormValidatorProvider);
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
                    ],
                    onChanged: (value) async {
                      ref
                          .watch(projectFormValidatorProvider.notifier)
                          .validateProjectName(value);
                      if (widget.isEditing) {
                        if (value != initialProjectName) {
                          await ref
                              .watch(projectFormValidatorProvider.notifier)
                              .checkProjectNameExists(value);
                        }
                      } else {
                        await ref
                            .watch(projectFormValidatorProvider.notifier)
                            .checkProjectNameExists(value);
                      }
                    },
                    errorText: validator.when(
                      data: (data) => data.projectName.errMsg,
                      loading: () => null,
                      error: (err, stack) => null,
                    )),
                ProjectFormField(
                  controller: widget.projectCtr.descriptionCtr,
                  labelText: 'Project description',
                  hintText: 'Enter a description of the project (optional)',
                  onChanged: (_) {
                    _validateEditing();
                  },
                ),
                Visibility(
                  visible: widget.isEditing,
                  child: ProjectFormField(
                    controller: widget.projectCtr.pICtr,
                    labelText: 'Principal Investigator',
                    hintText: 'Enter PI name of the project (optional)',
                    onChanged: (_) {
                      _validateEditing();
                    },
                  ),
                ),
                !widget.isEditing
                    ? const TaxonGroupFields()
                    : const SizedBox.shrink(),
                Visibility(
                  visible: widget.isEditing,
                  child: ProjectFormField(
                    controller: widget.projectCtr.locationCtr,
                    labelText: 'Location',
                    hintText: 'Enter location of the project (optional)',
                    onChanged: (_) {
                      _validateEditing();
                    },
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
                      _validateEditing();
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
                      _validateEditing();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(spacing: 10, children: [
                  SecondaryButton(
                    text: 'Cancel',
                    onPressed: () {
                      ref.invalidate(projectFormValidatorProvider);
                      Navigator.pop(context);
                    },
                  ),
                  FormElevButton(
                    onPressed: () {
                      widget.isEditing ? _updateProject() : _createProject();
                      _goToDashboard();
                    },
                    text: widget.isEditing ? 'Update' : 'Create',
                    enabled: _isValid(),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isValid() {
    final validator = ref.read(projectFormValidatorProvider);
    return validator.when(
      data: (data) => data.projectName.isValid,
      loading: () => false,
      error: (err, stack) => false,
    );
  }

  Future<void> _validateEditing() async {
    if (widget.isEditing) {
      ref
          .watch(projectFormValidatorProvider.notifier)
          .validateProjectName(widget.projectCtr.projectNameCtr.text);
    }
  }

  Future<void> _getInitialProjectName() async {
    final name = await ProjectServices(ref).getProjectName(widget.projectUuid);
    setState(() {
      initialProjectName = name;
    });
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

class TaxonGroupFields extends ConsumerWidget {
  const TaxonGroupFields({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CatalogFmt catalogFmt = ref.watch(catalogFmtNotifier);
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Main Taxon Group',
        hintText: 'Choose a taxon group',
      ),
      items: taxonGroupList
          .map((taxonGroup) => DropdownMenuItem(
                value: taxonGroup,
                child: CommonDropdownText(text: taxonGroup),
              ))
          .toList(),
      value: matchCatFmtToTaxonGroup(catalogFmt),
      onChanged: (String? newValue) {
        catalogFmt = matchTaxonGroupToCatFmt(newValue!);
        ref.read(catalogFmtNotifier.notifier).setCatalogFmt(catalogFmt);
      },
    );
  }
}
