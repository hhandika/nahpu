import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/models/form.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';

class SpecimenPartFields extends ConsumerWidget {
  const SpecimenPartFields({Key? key, required this.specimenCtr})
      : super(key: key);

  final SpecimenFormCtrModel specimenCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormCard(
      title: 'Specimen Parts',
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              elevation: 0,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PartForms(
                      specimenCtr: specimenCtr,
                    );
                  });
            },
            child: const Text(
              'Add a part',
            ),
          ),
          TextFormField(
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Part notes',
              hintText: 'Add notes',
            ),
          ),
        ],
      ),
    );
  }
}

class PartForms extends ConsumerWidget {
  const PartForms({Key? key, required this.specimenCtr}) : super(key: key);

  final SpecimenFormCtrModel specimenCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Add a part'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Preparation type',
              hintText: 'Enter prep type: e.g. "skin", "liver", etc."',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Counts',
              hintText: 'Enter part counts',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Treatment',
              hintText: 'Enter part counts',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Date taken',
              hintText: 'Enter date',
            ),
            controller: specimenCtr.prepDateCtr,
            onTap: () async {
              final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now());

              if (selectedDate != null) {
                specimenCtr.prepDateCtr.text =
                    DateFormat.yMMMd().format(selectedDate);
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Time taken',
              hintText: 'Enter time',
            ),
            controller: specimenCtr.prepTimeCtr,
            onTap: () {
              showTimePicker(context: context, initialTime: TimeOfDay.now())
                  .then((time) {
                if (time != null) {
                  specimenCtr.prepTimeCtr.text = time.format(context);
                }
              });
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          child: const Text('Add'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
