import 'package:flutter/material.dart';

class ProjectSettings extends StatefulWidget {
  const ProjectSettings({Key? key}) : super(key: key);

  @override
  State<ProjectSettings> createState() => _ProjectSettingsState();
}

class _ProjectSettingsState extends State<ProjectSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Center(
        child: Text('Project Settings'),
      ),
    );
  }
}
