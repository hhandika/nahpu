import 'package:flutter/material.dart';

import 'package:drift/drift.dart' as db;

import '../projects/project_menu.dart';
import 'package:nahpu/database/database.dart';

Database? _database;

class NewProjectForm extends StatefulWidget {
  const NewProjectForm({Key? key}) : super(key: key);

  @override
  State<NewProjectForm> createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<NewProjectForm> {
  final _formKey = UniqueKey().hashCode;
  final nameController = TextEditingController();
  final collectorController = TextEditingController();

  get child => null;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new project'),
        backgroundColor: const Color(0xFF2457C5),
      ),
      body: Column(children: [
        Expanded(
            child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Project name',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: collectorController,
              decoration: const InputDecoration(
                labelText: 'Collector name',
                border: OutlineInputBorder(),
              ),
            ),
            Wrap(spacing: 10, children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF2457C5)),
                ),
                child: const Text('Create'),
                onPressed: () {
                  _createProject();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectMenu()),
                  );
                },
              )
            ])
          ],
        ))
      ]),
    );
  }

  Future<void> _createProject() async {
    _database?.createProject(ProjectCompanion(
        id: db.Value(_formKey),
        name: db.Value(nameController.text),
        collector: db.Value(collectorController.text)));
  }
}
