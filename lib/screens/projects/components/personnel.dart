import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/providers/validation.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/project_services.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/personnel_services.dart';

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
        ref.read(personnelFormValidation.notifier).isEditing();
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
            isAddNew: true,
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
                isAddNew: false,
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
      nextCollectorNumCtr:
          TextEditingController(text: '${personnelData.currentFieldNumber}'),
      photoIdCtr: personnelData.photoID,
      noteCtr: TextEditingController(text: ''),
    );
  }
}

class PersonnelNameField extends ConsumerWidget {
  const PersonnelNameField({super.key, required this.ctr});

  final PersonnelFormCtrModel ctr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: ctr.nameCtr,
      decoration: InputDecoration(
        labelText: 'Name*',
        hintText: 'Enter a name (required)',
        errorText: ref.watch(personnelFormValidation).form.name.errMsg,
      ),
      onChanged: (value) {
        ref.watch(personnelFormValidation.notifier).validateName(value);
      },
    );
  }
}

class PersonnelInitialField extends ConsumerWidget {
  const PersonnelInitialField({super.key, required this.ctr});

  final PersonnelFormCtrModel ctr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: ctr.initialCtr,
      maxLength: 8,
      decoration: InputDecoration(
        labelText: 'Initials*',
        hintText: 'Enter initials (required for catalogers)',
        errorText: ref.watch(personnelFormValidation).form.initial.errMsg,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z]+|\s'),
        ),
      ],
      onChanged: (value) {
        ctr.initialCtr.value = TextEditingValue(
          text: value.toUpperCase(),
          selection: ctr.initialCtr.selection,
        );
        ref.watch(personnelFormValidation.notifier).validateInitial(
              value,
            );
      },
    );
  }
}

class CatalogerNumberField extends ConsumerWidget {
  const CatalogerNumberField({super.key, required this.ctr});

  final PersonnelFormCtrModel ctr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
        enabled: ctr.roleCtr == 'Cataloger',
        controller: ctr.nextCollectorNumCtr,
        decoration: InputDecoration(
          labelText: 'Collector Number*',
          hintText: 'Enter current number',
          errorText: ref.watch(personnelFormValidation).form.collNum.errMsg,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]+'),
          ),
        ],
        onChanged: (value) {
          ref.watch(personnelFormValidation.notifier).validateCollNum(value);
        });
  }
}

class PersonnelForm extends ConsumerStatefulWidget {
  const PersonnelForm({
    super.key,
    required this.ctr,
    required this.personnelUuid,
    required this.isAddNew,
  });

  final PersonnelFormCtrModel ctr;
  final String personnelUuid;
  final bool isAddNew;

  @override
  PersonnelFormState createState() => PersonnelFormState();
}

class PersonnelFormState extends ConsumerState<PersonnelForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _roleList = const [
    'Cataloger',
    'Field assistant',
    'Preparator only',
    'Local helper',
    'Photographer only',
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PersonnelNameField(ctr: widget.ctr),
          TextFormField(
            controller: widget.ctr.affiliationCtr,
            decoration: const InputDecoration(
              labelText: 'Affiliation',
              hintText: 'Enter Affiliation',
            ),
          ),
          TextFormField(
            controller: widget.ctr.emailCtr,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter email',
              errorText: ref.watch(personnelFormValidation).form.email.errMsg,
            ),
            onChanged: (value) {
              ref.watch(personnelFormValidation.notifier).validateEmail(
                    value,
                  );
              widget.ctr.emailCtr.value = TextEditingValue(
                  text: value.toLowerCase(),
                  selection: widget.ctr.emailCtr.selection);
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
          ),
          DropdownButtonFormField(
            value: widget.ctr.roleCtr,
            decoration: const InputDecoration(
              labelText: 'Role',
              hintText: 'Enter role',
            ),
            items: _roleList
                .map(
                  (role) => DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  ),
                )
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                widget.ctr.roleCtr = newValue;
              });
            },
          ),
          Visibility(
            visible: widget.ctr.roleCtr == 'Cataloger',
            child: Column(
              children: [
                PersonnelInitialField(ctr: widget.ctr),
                CatalogerNumberField(ctr: widget.ctr),
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
                  ref.invalidate(personnelFormValidation);
                  Navigator.of(context).pop();
                },
              ),
              FormElevButton(
                text: widget.isAddNew ? 'Add' : 'Update',
                enabled: widget.ctr.roleCtr == 'Cataloger'
                    ? ref.read(personnelFormValidation).form.isValidCataloger
                    : ref.read(personnelFormValidation).form.isValid,
                onPressed: () async {
                  widget.isAddNew ? await _addPersonnel() : _updatePersonnel();
                  ref.invalidate(personnelListProvider);
                  ref.invalidate(personnelFormValidation);
                  if (context.mounted) {
                    Navigator.of(context).push(
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
    if (widget.ctr.nextCollectorNumCtr.text == '') {
      return 0;
    } else {
      return int.parse(widget.ctr.nextCollectorNumCtr.text);
    }
  }
}
