import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/controller/updaters.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/database.dart';
import 'package:drift/drift.dart' as db;

class CollActivityFields extends ConsumerWidget {
  const CollActivityFields(
      {super.key, required this.collEventId, required this.collEventCtr});

  final int collEventId;
  final CollEventFormCtrModel collEventCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormCard(
      title: 'Collecting Activity',
      child: Column(
        children: [
          DropdownButtonFormField(
            value: collEventCtr.primaryCollMethodCtr,
            decoration: const InputDecoration(
              labelText: 'Primary collection method',
              hintText: 'Choose a method',
            ),
            items: const [
              DropdownMenuItem(
                value: 'Trapping',
                child: Text('Trapping'),
              ),
              DropdownMenuItem(
                value: 'Recording',
                child: Text('Recording'),
              ),
            ],
            onChanged: (String? newValue) {
              updateCollEvent(
                  collEventId,
                  CollEventCompanion(primaryCollMethod: db.Value(newValue)),
                  ref);
            },
          ),
          TextField(
            maxLines: 5,
            controller: collEventCtr.noteCtr,
            decoration: const InputDecoration(
              labelText: 'Collecting method notes',
              hintText: 'Enter notes',
            ),
            onChanged: (String? newValue) {
              updateCollEvent(collEventId,
                  CollEventCompanion(collMethodNotes: db.Value(newValue)), ref);
            },
          ),
        ],
      ),
    );
  }
}
