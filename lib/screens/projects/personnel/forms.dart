import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/screens/projects/personnel/avatars.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/project_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/providers/validation.dart';
import 'package:flutter/services.dart';

class NewPersonnel extends ConsumerWidget {
  const NewPersonnel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PersonnelFormCtrModel ctr = PersonnelFormCtrModel.empty();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add personnel'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ScrollableLayout(
          child: PersonnelForm(
            ctr: ctr,
            personnelUuid: uuid,
            isEditing: false,
          ),
        ),
      ),
    );
  }
}

class EditPersonnelForm extends ConsumerWidget {
  const EditPersonnelForm({super.key, required this.personnelData});

  final PersonnelData personnelData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PersonnelFormCtrModel ctr = _getController(personnelData);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit personnel'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ScrollableLayout(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PersonnelForm(
                ctr: ctr,
                personnelUuid: personnelData.uuid,
                isEditing: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PersonnelFormCtrModel _getController(PersonnelData personnelData) {
    return PersonnelFormCtrModel(
      nameCtr: TextEditingController(text: personnelData.name),
      initialCtr: TextEditingController(text: personnelData.initial),
      phoneCtr: TextEditingController(text: personnelData.phone),
      affiliationCtr: TextEditingController(text: personnelData.affiliation),
      emailCtr: TextEditingController(text: personnelData.email),
      roleCtr: personnelData.role,
      collectorNumCtr:
          TextEditingController(text: '${personnelData.currentFieldNumber}'),
      photoPathCtr: TextEditingController(text: personnelData.photoPath),
      noteCtr: TextEditingController(text: ''),
    );
  }
}

class PersonnelForm extends ConsumerStatefulWidget {
  const PersonnelForm({
    super.key,
    required this.ctr,
    required this.personnelUuid,
    required this.isEditing,
  });

  final PersonnelFormCtrModel ctr;
  final String personnelUuid;
  final bool isEditing;

  @override
  PersonnelFormState createState() => PersonnelFormState();
}

class PersonnelFormState extends ConsumerState<PersonnelForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _getRole();
    super.initState();
  }

  @override
  void dispose() {
    widget.ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PersonnelAvatar(
            ctr: widget.ctr,
          ),
          const SizedBox(height: 18),
          PersonnelNameField(
              ctr: widget.ctr,
              onChanged: (value) {
                if (widget.isEditing) {
                  _validateEditing();
                } else {
                  ref
                      .watch(personnelFormValidatorProvider.notifier)
                      .validateName(value);
                }
              }),
          TextFormField(
            controller: widget.ctr.affiliationCtr,
            decoration: const InputDecoration(
              labelText: 'Affiliation',
              hintText: 'Enter Affiliation',
            ),
            onChanged: (value) {
              if (widget.isEditing) {
                _validateEditing();
              }
            },
          ),
          TextFormField(
            controller: widget.ctr.emailCtr,
            decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter email',
                errorText: ref.watch(personnelFormValidatorProvider).when(
                      data: (data) => data.email.errMsg,
                      loading: () => null,
                      error: (e, s) => null,
                    )),
            onChanged: (value) {
              if (widget.isEditing) {
                _validateEditing();
              } else {
                widget.ctr.emailCtr.value = TextEditingValue(
                    text: value.toLowerCase(),
                    selection: widget.ctr.emailCtr.selection);
                ref
                    .watch(personnelFormValidatorProvider.notifier)
                    .validateEmail(
                      value,
                    );
              }
            },
          ),
          TextFormField(
            controller: widget.ctr.phoneCtr,
            decoration: const InputDecoration(
              labelText: 'Phone',
              hintText: 'Enter phone',
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (widget.isEditing) {
                _validateEditing();
              }
            },
          ),
          DropdownButtonFormField(
            value: widget.ctr.roleCtr,
            decoration: const InputDecoration(
              labelText: 'Specimen care role',
              hintText: 'Enter role',
            ),
            items: personnelRoleList
                .map(
                  (role) => DropdownMenuItem(
                    value: role,
                    child: CommonDropdownText(text: role),
                  ),
                )
                .toList(),
            onChanged: _isDisabled()
                ? null
                : (String? newValue) {
                    setState(() {
                      widget.ctr.roleCtr = newValue;
                    });
                  },
          ),
          Visibility(
            visible: widget.ctr.roleCtr == 'Cataloger',
            child: Column(
              children: [
                PersonnelInitialField(
                  ctr: widget.ctr,
                  onChanged: (value) {
                    widget.ctr.initialCtr.value = TextEditingValue(
                      text: value.toUpperCase(),
                      selection: widget.ctr.initialCtr.selection,
                    );
                    if (widget.isEditing) {
                      _validateEditing();
                    } else {
                      ref
                          .watch(personnelFormValidatorProvider.notifier)
                          .validateInitial(value);
                    }
                  },
                ),
                CatalogerNumberField(
                  ctr: widget.ctr,
                  onChanged: (value) {
                    if (widget.isEditing) {
                      _validateEditing();
                    } else {
                      ref
                          .watch(personnelFormValidatorProvider.notifier)
                          .validateCollNum(value);
                    }
                  },
                ),
              ],
            ),
          ),
          TextField(
            controller: widget.ctr.noteCtr,
            decoration: const InputDecoration(
              labelText: 'Notes',
              hintText: 'Write notes',
            ),
            maxLines: 3,
            onChanged: (value) {
              if (widget.isEditing) {
                _validateEditing();
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 10,
            children: [
              SecondaryButton(
                text: 'Cancel',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FormElevButton(
                text: widget.isEditing ? 'Update' : 'Add',
                enabled: _validateForm(),
                onPressed: () async {
                  widget.isEditing ? _updatePersonnel() : _addPersonnel();
                  ref.invalidate(personnelListProvider);
                  ref.invalidate(personnelFormValidatorProvider);
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Dashboard(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isDisabled() {
    return widget.isEditing && widget.ctr.roleCtr == 'Cataloger';
  }

  void _getRole() {
    if (widget.ctr.roleCtr != null && widget.ctr.roleCtr!.isNotEmpty) {
      if (!personnelRoleList.contains(widget.ctr.roleCtr)) {
        widget.ctr.roleCtr = 'None';
        _updatePersonnel();
      }
    }
  }

  void _validateEditing() {
    ref.watch(personnelFormValidatorProvider.notifier).validateAll(widget.ctr);
  }

  bool _validateForm() {
    return widget.ctr.roleCtr == 'Cataloger'
        ? ref.read(personnelFormValidatorProvider).when(
              data: (data) => data.isValidCataloger,
              loading: () => false,
              error: (error, stackTrace) => false,
            )
        : ref.read(personnelFormValidatorProvider).when(
              data: (data) => data.isValidOther,
              loading: () => false,
              error: (error, stackTrace) => false,
            );
  }

  void _updatePersonnel() {
    PersonnelServices(ref: ref).updatePersonnelEntry(
      widget.personnelUuid,
      PersonnelCompanion(
        name: db.Value(widget.ctr.nameCtr.text),
        initial: db.Value(widget.ctr.initialCtr.text),
        affiliation: db.Value(widget.ctr.affiliationCtr.text),
        email: db.Value(widget.ctr.emailCtr.text),
        phone: db.Value(widget.ctr.phoneCtr.text),
        role: db.Value(widget.ctr.roleCtr),
        currentFieldNumber: db.Value(
          _getCollectorNumber(),
        ),
        photoPath: db.Value(widget.ctr.photoPathCtr.text),
        notes: db.Value(widget.ctr.noteCtr.text),
      ),
    );
  }

  Future<void> _addPersonnel() async {
    PersonnelServices personnelServices = PersonnelServices(ref: ref);
    String projectUuid = ref.read(projectUuidProvider);
    await personnelServices.createPersonnel(
      PersonnelCompanion(
        uuid: db.Value(widget.personnelUuid),
        name: db.Value(widget.ctr.nameCtr.text),
        initial: db.Value(widget.ctr.initialCtr.text),
        affiliation: db.Value(widget.ctr.affiliationCtr.text),
        email: db.Value(widget.ctr.emailCtr.text),
        phone: db.Value(widget.ctr.phoneCtr.text),
        role: db.Value(widget.ctr.roleCtr),
        currentFieldNumber: db.Value(
          _getCollectorNumber(),
        ),
        photoPath: db.Value(widget.ctr.photoPathCtr.text),
        notes: db.Value(widget.ctr.noteCtr.text),
      ),
    );
    await personnelServices.createProjectPersonnel(PersonnelListCompanion(
      personnelUuid: db.Value(widget.personnelUuid),
      projectUuid: db.Value(projectUuid),
    ));
  }

  int _getCollectorNumber() {
    if (widget.ctr.collectorNumCtr.text == '') {
      return 0;
    } else {
      return int.parse(widget.ctr.collectorNumCtr.text);
    }
  }
}

class PersonnelNameField extends ConsumerWidget {
  const PersonnelNameField({
    super.key,
    required this.ctr,
    required this.onChanged,
  });

  final PersonnelFormCtrModel ctr;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: ctr.nameCtr,
      decoration: InputDecoration(
        labelText: 'Name*',
        hintText: 'Enter a name (required)',
        errorText: ref.watch(personnelFormValidatorProvider).when(
              data: (data) => data.name.errMsg,
              loading: () => null,
              error: (e, s) => null,
            ),
      ),
      onChanged: onChanged,
    );
  }
}

class PersonnelInitialField extends ConsumerWidget {
  const PersonnelInitialField({
    super.key,
    required this.ctr,
    required this.onChanged,
  });

  final PersonnelFormCtrModel ctr;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: ctr.initialCtr,
      maxLength: 8,
      decoration: InputDecoration(
          labelText: 'Initials*',
          hintText: 'Enter initials (required for catalogers)',
          errorText: ref.watch(personnelFormValidatorProvider).when(
                data: (data) => data.initial.errMsg,
                loading: () => null,
                error: (e, s) => null,
              )),
      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
      ],
      onChanged: onChanged,
    );
  }
}

class CatalogerNumberField extends ConsumerWidget {
  const CatalogerNumberField({
    super.key,
    required this.ctr,
    required this.onChanged,
  });

  final PersonnelFormCtrModel ctr;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      enabled: ctr.roleCtr == 'Cataloger',
      controller: ctr.collectorNumCtr,
      decoration: InputDecoration(
          labelText: 'Collector Number*',
          hintText: 'Enter current number',
          errorText: ref.watch(personnelFormValidatorProvider).when(
                data: (data) => data.collNum.errMsg,
                loading: () => null,
                error: (e, s) => null,
              )),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]+'),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
