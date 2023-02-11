import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
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
              labelText: 'Primary activity',
              hintText: 'Add activity',
            ),
            items: const [
              DropdownMenuItem(
                value: 'Collecting',
                child: Text('Collecting'),
              ),
              DropdownMenuItem(
                value: 'Recording',
                child: Text('Recording'),
              ),
              DropdownMenuItem(
                value: 'Observing',
                child: Text('Observing'),
              ),
              DropdownMenuItem(
                value: 'Other',
                child: Text('Other'),
              ),
            ],
            onChanged: (String? newValue) {
              CollEventServices(ref).updateCollEvent(
                collEventId,
                CollEventCompanion(primaryCollMethod: db.Value(newValue)),
              );
            },
          ),
          TextField(
            maxLines: 5,
            controller: collEventCtr.noteCtr,
            decoration: const InputDecoration(
              labelText: 'Notes',
              hintText: 'Enter notes about the activity',
            ),
            onChanged: (String? newValue) {
              CollEventServices(ref).updateCollEvent(
                collEventId,
                CollEventCompanion(collMethodNotes: db.Value(newValue)),
              );
            },
          ),
        ],
      ),
    );
  }
}
