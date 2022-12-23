import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/project.dart';

class FormCard extends StatelessWidget {
  const FormCard(
      {Key? key,
      required this.title,
      required this.child,
      this.isPrimary = false})
      : super(key: key);

  final Widget child;
  final String title;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isPrimary
          ? Theme.of(context).colorScheme.secondaryContainer
          : Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class DeleteAlerts extends ConsumerWidget {
  const DeleteAlerts({
    Key? key,
    required this.projectUuid,
    required this.onDelete,
  }) : super(key: key);

  final String projectUuid;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Delete'),
      content: const Text('Are you sure you want to delete this project?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            deleteProject(ref, projectUuid);
            onDelete();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
