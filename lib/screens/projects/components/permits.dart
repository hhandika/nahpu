import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';

class PermitViewer extends ConsumerStatefulWidget {
  const PermitViewer({Key? key}) : super(key: key);

  @override
  PermitViewerState createState() => PermitViewerState();
}

class PermitViewerState extends ConsumerState<PermitViewer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleForm(text: 'Permits'),
        const SizedBox(height: 100),
        PrimaryButton(
          text: 'Add permit',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const PermitForm(),
            );
          },
        ),
      ],
    );
  }
}

class PermitForm extends ConsumerWidget {
  const PermitForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Add permit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter a name',
            ),
          ),
          TextFormField(
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
              keyboardType: TextInputType.emailAddress),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Phone',
              hintText: 'Enter phone',
            ),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
