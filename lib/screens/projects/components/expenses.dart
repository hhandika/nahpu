import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/buttons.dart';

class ReceiptViewer extends ConsumerStatefulWidget {
  const ReceiptViewer({Key? key}) : super(key: key);

  @override
  ReceiptViewerState createState() => ReceiptViewerState();
}

class ReceiptViewerState extends ConsumerState<ReceiptViewer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Expenses',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 100),
        CommonButton(
          text: 'Add expense',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const ExpenseForm(),
            );
          },
        ),
      ],
    );
  }
}

class ExpenseForm extends ConsumerWidget {
  const ExpenseForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Add expense'),
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
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Phone',
              hintText: 'Enter phone',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Affiliation',
              hintText: 'Enter affiliation',
            ),
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
          child: const Text('Save'),
        ),
      ],
    );
  }
}
