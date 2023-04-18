import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';

class ExpenseViewer extends ConsumerStatefulWidget {
  const ExpenseViewer({Key? key}) : super(key: key);

  @override
  ExpenseViewerState createState() => ExpenseViewerState();
}

class ExpenseViewerState extends ConsumerState<ExpenseViewer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleForm(text: 'Expenses'),
        const SizedBox(height: 100),
        PrimaryButton(
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
              labelText: 'Item',
              hintText: 'Enter item2',
            ),
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Category',
              hintText: 'Enter category',
            ),
            items: expenseCategory
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {},
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Date',
              hintText: 'Enter date',
            ),
            onTap: () async {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2015, 8),
                lastDate: DateTime.now(),
              ).then((value) => {});
            },
          ),
          const CommonNumField(
            labelText: 'Amount',
            hintText: 'Enter amount',
            isLastField: false,
          ),
          const CommonTextField(
              maxLines: 5,
              labelText: 'Description',
              hintText: 'Enter description',
              isLastField: true),
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
