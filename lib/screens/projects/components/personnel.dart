import 'package:nahpu/services/database.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/indicators.dart';

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
              showDialog(
                  context: context, builder: (context) => _showPersonnelForm());
            },
            text: 'Add personnel',
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _showPersonnelForm() {
    final nameCtr = TextEditingController();
    final initialCtr = TextEditingController();
    final affilitationCtr = TextEditingController();
    return AlertDialog(
      title: const Text('Add personnel'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameCtr,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter a name',
            ),
          ),
          TextFormField(
            controller: initialCtr,
            decoration: const InputDecoration(
              labelText: 'Initials',
              hintText: 'Enter intials',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter email',
            ),
          ),
          TextFormField(
            controller: affilitationCtr,
            decoration: const InputDecoration(
              labelText: 'Affiliation',
              hintText: 'Enter Affiliation',
            ),
          ),
          DropdownButtonFormField(
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
            onChanged: (String? newValue) {},
          ),
          const CustomTextField(
              labelText: 'First collector Number', hintText: 'Enter number'),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () {
            createPersonnel(
                ref,
                PersonnelCompanion(
                  name: db.Value(nameCtr.text),
                  initial: db.Value(initialCtr.text),
                  affiliation: db.Value(affilitationCtr.text),
                ));
            Navigator.of(context).pop();
            // ref.refresh(personnelListProvider);
          },
        ),
      ],
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
            return ListTile(
              leading: const Icon(Icons.person_rounded),
              title: Text(data[index].name ?? ''),
              subtitle: Text(data[index].uuid ?? ''),
              trailing: const PersonnelListPopUpMenu(),
            );
          },
        );
      },
      loading: () => const CommmonProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}

class PersonnelListPopUpMenu extends ConsumerWidget {
  const PersonnelListPopUpMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: (context) => [
        const PopupMenuItem(
          child: Text('Edit'),
        ),
        const PopupMenuItem(
          child: Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
