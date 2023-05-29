import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/providers/validation.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/project_services.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/types/types.dart';

enum PersonnelMenuAction { edit, delete }

class PersonnelViewer extends ConsumerStatefulWidget {
  const PersonnelViewer({Key? key}) : super(key: key);

  @override
  PersonnelViewerState createState() => PersonnelViewerState();
}

class PersonnelViewerState extends ConsumerState<PersonnelViewer> {
  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Personnel',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 300,
            child: PersonnelList(),
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewPersonnel(),
                ),
              );
            },
            text: 'Add personnel',
          ),
        ],
      ),
    );
  }
}

class PersonnelList extends ConsumerStatefulWidget {
  const PersonnelList({super.key});

  @override
  PersonnelListState createState() => PersonnelListState();
}

class PersonnelListState extends ConsumerState<PersonnelList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final personnel = ref.watch(personnelListProvider);
    return personnel.when(
      data: (data) {
        return data.isEmpty
            ? const Center(
                child: Text(
                  'No personnel found!\n'
                  'Add at least a cataloger to use the app.',
                  textAlign: TextAlign.center,
                ),
              )
            : CommonScrollbar(
                scrollController: _scrollController,
                child: ListView.builder(
                  itemCount: data.length,
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PersonalListTile(
                      personnelData: data[index],
                      trailing: PersonnelMenu(
                        data: data[index],
                      ),
                    );
                  },
                ),
              );
      },
      loading: () => const CommonProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}

class PersonalListTile extends StatelessWidget {
  const PersonalListTile({
    super.key,
    required this.personnelData,
    required this.trailing,
  });

  final PersonnelData personnelData;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        _getTitle(personnelData.name, personnelData.initial),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: PersonnelSubtitle(
        role: personnelData.role,
        affiliation: personnelData.affiliation,
        currentFieldNumber: personnelData.currentFieldNumber,
      ),
      trailing: trailing,
    );
  }

  String _getTitle(String? name, String? personInitial) {
    if (name != null && personInitial != null) {
      return personInitial.isEmpty ? name : '$name ($personInitial)';
    } else if (name != null) {
      return name;
    } else if (personInitial != null) {
      return personInitial;
    } else {
      return '';
    }
  }
}

class PersonnelSubtitle extends StatelessWidget {
  const PersonnelSubtitle({
    super.key,
    required this.role,
    required this.affiliation,
    required this.currentFieldNumber,
  });

  final String? role;
  final String? affiliation;
  final int? currentFieldNumber;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      role != null
          ? TextSpan(children: [
              const WidgetSpan(
                  child: TileIcon(icon: Icons.account_circle_outlined),
                  alignment: PlaceholderAlignment.middle),
              TextSpan(
                text: '$role ',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ])
          : const TextSpan(),
      affiliation != null
          ? TextSpan(
              children: [
                const WidgetSpan(
                    child: TileIcon(icon: Icons.business_rounded),
                    alignment: PlaceholderAlignment.middle),
                TextSpan(
                  text: '$affiliation ',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            )
          : const TextSpan(),
      currentFieldNumber != null
          ? TextSpan(
              children: [
                const WidgetSpan(
                    child: TileIcon(icon: MdiIcons.counter),
                    alignment: PlaceholderAlignment.middle),
                TextSpan(
                  text: '$currentFieldNumber',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            )
          : const TextSpan(),
    ]));
  }
}

class PersonnelMenu extends ConsumerStatefulWidget {
  const PersonnelMenu({super.key, required this.data});

  final PersonnelData data;

  @override
  PersonnelMenuState createState() => PersonnelMenuState();
}

class PersonnelMenuState extends ConsumerState<PersonnelMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PersonnelMenuAction>(
      onSelected: _onPopUpMenuSelected,
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: PersonnelMenuAction.edit,
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
            value: PersonnelMenuAction.delete,
            child: ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            )),
      ],
    );
  }

  void _onPopUpMenuSelected(PersonnelMenuAction item) {
    switch (item) {
      case PersonnelMenuAction.edit:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditPersonnelForm(
              personnelData: widget.data,
            ),
          ),
        );
        break;
      case PersonnelMenuAction.delete:
        PersonnelServices(ref).deletePersonnel(widget.data.uuid);
        break;
    }
  }
}

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
      photoIdCtr: personnelData.photoID,
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
    PersonnelServices(ref).updatePersonnelEntry(
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
      ),
    );
  }

  Future<void> _addPersonnel() async {
    PersonnelServices personnelServices = PersonnelServices(ref);
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
