import 'package:flutter/material.dart';

import '../projects/project_menu.dart';

class NewProjectForm extends StatefulWidget {
  const NewProjectForm({Key? key}) : super(key: key);

  @override
  State<NewProjectForm> createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<NewProjectForm> {
  get child => null;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a new project'),
          backgroundColor: const Color(0xFF2457C5),
        ),
        body: Align(
          alignment: const Alignment(0.9, 0.95),
          child: Wrap(spacing: 10, children: [
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProjectMenu()),
                );
              },
            )
          ]),
        ));
  }
}
