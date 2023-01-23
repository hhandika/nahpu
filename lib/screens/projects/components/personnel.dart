import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/services/database.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/indicators.dart';
import 'package:uuid/uuid.dart';

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
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const PersonnelList()),
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class PersonnelList extends ConsumerWidget {
  const PersonnelList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personnels = ref.watch(personnelListProvider);
    return personnels.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return PersonalListTile(
              personnelData: data[index],
              trailing: PersonnelMenu(
                data: data[index],
              ),
            );
          },
        );
      },
      loading: () => const CommmonProgressIndicator(),
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
      leading: const Icon(Icons.person_rounded),
      title: Text(_getTitle(personnelData.name, personnelData.initial)),
      subtitle:
          Text(_getSubtitle(personnelData.affiliation, personnelData.role)),
      trailing: trailing,
    );
  }

  String _getTitle(String? name, String? personInitial) {
    if (name != null && personInitial != null) {
      return '$name | $personInitial';
    } else if (name != null) {
      return name;
    } else if (personInitial != null) {
      return personInitial;
    } else {
      return '';
    }
  }

  String _getSubtitle(String? affiliation, String? role) {
    if (affiliation != null && role != null) {
      return '$affiliation | $role';
    } else if (affiliation != null) {
      return affiliation;
    } else if (role != null) {
      return role;
    } else {
      return '';
    }
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
    return PopupMenuButton(
      onSelected: _onPopUpMenuSelected,
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: PersonnelMenuAction.edit,
          child: Text('Edit'),
        ),
        const PopupMenuItem(
          value: PersonnelMenuAction.delete,
          child: Text('Delete', style: TextStyle(color: Colors.red)),
        ),
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
        break;
    }
  }
}

class NewPersonnel extends ConsumerStatefulWidget {
  const NewPersonnel({Key? key}) : super(key: key);

  @override
  NewPersonnelState createState() => NewPersonnelState();
}

class NewPersonnelState extends ConsumerState<NewPersonnel> {
  final PersonnelFormCtrModel ctr = PersonnelFormCtrModel.empty();
  final String _uuid = uuid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add personnel'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: PersonnelForm(
            ctr: ctr,
            personnelUuid: _uuid,
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
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PersonnelForm(
                ctr: ctr,
                personnelUuid: personnelData.uuid!,
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
      affiliationCtr: TextEditingController(text: personnelData.affiliation),
      emailCtr: TextEditingController(text: personnelData.email),
      roleCtr: personnelData.role,
      nextCollectorNumCtr:
          TextEditingController(text: '${personnelData.nextCollectorNumber}'),
      photoIdCtr:
          TextEditingController(text: '${personnelData.personnelPhoto}'),
      noteCtr: TextEditingController(text: ''),
    );
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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: widget.ctr.nameCtr,
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter a name',
          ),
        ),
        TextFormField(
          controller: widget.ctr.initialCtr,
          decoration: const InputDecoration(
            labelText: 'Initials',
            hintText: 'Enter intials',
          ),
        ),
        TextFormField(
          controller: widget.ctr.emailCtr,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'Enter email',
          ),
        ),
        TextFormField(
          controller: widget.ctr.affiliationCtr,
          decoration: const InputDecoration(
            labelText: 'Affiliation',
            hintText: 'Enter Affiliation',
          ),
        ),
        DropdownButtonFormField(
          value: widget.ctr.roleCtr,
          decoration: const InputDecoration(
            labelText: 'Role',
            hintText: 'Enter role',
          ),
          items: const [
            DropdownMenuItem(
              value: 'Collector',
              child: Text('Collector'),
            ),
            DropdownMenuItem(
              value: 'Local helper',
              child: Text('Local helper'),
            ),
            DropdownMenuItem(
              value: 'Preparator only',
              child: Text('Preparator only'),
            ),
            DropdownMenuItem(
              value: 'Photographer only',
              child: Text('Photographer only'),
            ),
          ],
          onChanged: (String? newValue) {
            setState(() {
              widget.ctr.roleCtr = newValue!;
            });
          },
        ),
        TextField(
          controller: widget.ctr.nextCollectorNumCtr,
          decoration: const InputDecoration(
            labelText: 'First collector Number',
            hintText: 'Enter number',
          ),
        ),
        TextField(
          controller: widget.ctr.noteCtr,
          decoration: const InputDecoration(
            labelText: 'Notes',
            hintText: 'Write notes',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 10,
          children: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(widget.isAddNew ? 'Add' : 'Update'),
              onPressed: () {
                widget.isAddNew ? _addPersonnel() : _updatePersonnel();
                ref.invalidate(personnelListProvider);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _updatePersonnel() {
    return ref.read(databaseProvider).updatePersonnelEntry(
          widget.personnelUuid,
          PersonnelCompanion(
            name: db.Value(widget.ctr.nameCtr.text),
            initial: db.Value(widget.ctr.initialCtr.text),
            affiliation: db.Value(widget.ctr.affiliationCtr.text),
            email: db.Value(widget.ctr.emailCtr.text),
            role: db.Value(widget.ctr.roleCtr),
            nextCollectorNumber:
                db.Value(int.parse(widget.ctr.nextCollectorNumCtr.text)),
          ),
        );
  }

  Future<void> _addPersonnel() {
    return createPersonnel(
      ref,
      PersonnelCompanion(
        uuid: db.Value(widget.personnelUuid),
        name: db.Value(widget.ctr.nameCtr.text),
        initial: db.Value(widget.ctr.initialCtr.text),
        affiliation: db.Value(widget.ctr.affiliationCtr.text),
        email: db.Value(widget.ctr.emailCtr.text),
        role: db.Value(widget.ctr.roleCtr),
        nextCollectorNumber:
            db.Value(int.parse(widget.ctr.nextCollectorNumCtr.text)),
      ),
    );
  }
}
