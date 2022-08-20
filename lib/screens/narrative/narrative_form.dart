import 'package:flutter/material.dart';

import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';

class NarrativeForm extends ConsumerWidget {
  const NarrativeForm(
      {Key? key,
      required this.narrativeId,
      required this.narrativeController,
      required this.dateController})
      : super(key: key);

  final TextEditingController dateController;
  final TextEditingController narrativeController;
  final int narrativeId;

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
          controller: dateController,
          onTap: () async {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now())
                .then((date) {
              if (date != null) {
                dateController.text = DateFormat.yMMMd().format(date);
                narrative.updateNarrativeEntry(narrativeId,
                    NarrativeCompanion(date: db.Value(dateController.text)));
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
                narrativeId, NarrativeCompanion(siteID: db.Value(value)));
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
