import 'package:flutter/material.dart';

import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';

class NarrativeForm extends ConsumerWidget {
  const NarrativeForm(
      {Key? key,
      required this.narrativeController,
      required this.dateController})
      : super(key: key);

  final TextEditingController dateController;
  final TextEditingController narrativeController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final narrative = ref.watch(databaseProvider);
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Date',
            hintText: 'Enter date',
          ),
          onTap: () async {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now())
                .then((date) {
              if (date != null) {
                narrative.updateNarrativeEntry(
                    1, NarrativeCompanion(date: db.Value(date.toString())));
              }
            });
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Site ID',
            hintText: 'Enter a site',
          ),
          onChanged: (value) {
            narrative.updateNarrativeEntry(
                1, NarrativeCompanion(siteID: db.Value(value)));
          },
        ),
        TextFormField(
          maxLines: 10,
          decoration: const InputDecoration(
            labelText: 'Narrative',
            hintText: 'Enter narrative',
          ),
          onChanged: (value) {
            narrative.updateNarrativeEntry(
                1, NarrativeCompanion(narrative: db.Value(value)));
          },
        ),
      ],
    );
  }
}
