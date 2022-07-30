import 'package:flutter/material.dart';

import 'package:drift/drift.dart' as db;
import 'package:uuid/uuid.dart';

import '../projects/project_menu.dart';
import 'package:nahpu/database/database.dart';

class NewProjectForm extends StatefulWidget {
  const NewProjectForm({Key? key}) : super(key: key);

  @override
  State<NewProjectForm> createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<NewProjectForm> {
  final _formKey = const Uuid().v4();
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
      body: Column(children: [
        Expanded(
            child: Column(
          children: [
            TextFormField(
              controller: projectNameController,
              decoration: const InputDecoration(
                labelText: 'Project name',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Project description',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: collectorController,
              decoration: const InputDecoration(
                labelText: 'Collector',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: collectorEmailController,
              decoration: const InputDecoration(
                labelText: 'Collector email',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: catNumController,
              decoration: const InputDecoration(
                labelText: 'Catalog number start',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: teamLaederController,
              decoration: const InputDecoration(
                labelText: 'Team leader',
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
    final database = Database();
    database.createProject(ProjectCompanion(
      projectId: db.Value(_formKey),
      projectName: db.Value(projectNameController.text),
      projectDescription: db.Value(descriptionController.text),
      collector: db.Value(collectorController.text),
      collectorEmail: db.Value(collectorEmailController.text),
      catNumStart: db.Value(int.parse(catNumController.text)),
      teamLeader: db.Value(teamLaederController.text),
    ));
  }
}
