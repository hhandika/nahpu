import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/specimen_services.dart';

class CaptureRecordFields extends ConsumerWidget {
  const CaptureRecordFields({
    Key? key,
    required this.specimenUuid,
    required this.useHorizontalLayout,
    required this.specimenCtr,
  }) : super(key: key);

  final bool useHorizontalLayout;
  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<CollEventData> eventEntry = [];
    ref.watch(collEventEntryProvider).whenData(
          (value) => eventEntry = value,
        );
    return FormCard(
      title: 'Capture Records',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButtonFormField(
              value: specimenCtr.collEventIDCtr,
              decoration: const InputDecoration(
                labelText: 'Collecting Event ID',
                hintText: 'Choose a collecting event ID',
              ),
              items: eventEntry
                  .map((event) => DropdownMenuItem(
                        value: event.id,
                        child: Text(event.eventID ?? ''),
                      ))
                  .toList(),
              onChanged: (int? newValue) {
                SpecimenServices(ref).updateSpecimen(specimenUuid,
                    SpecimenCompanion(collEventID: db.Value(newValue)));
              },
            ),
          ),
          AdaptiveLayout(
            useHorizontalLayout: useHorizontalLayout,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Capture date',
                  hintText: 'Enter date',
                ),
                controller: specimenCtr.captureDateCtr,
                onTap: () async {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now())
                      .then((date) {
                    if (date != null) {
                      specimenCtr.captureDateCtr.text =
                          DateFormat.yMMMd().format(date);
                      SpecimenServices(ref).updateSpecimen(
                        specimenUuid,
                        SpecimenCompanion(
                          captureDate:
                              db.Value(specimenCtr.captureDateCtr.text),
                        ),
                      );
                    }
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Capture time',
                  hintText: 'Enter time',
                ),
                controller: specimenCtr.captureTimeCtr,
                onTap: () async {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((time) {
                    if (time != null) {
                      specimenCtr.captureTimeCtr.text =
                          time.format(context).toString();
                      SpecimenServices(ref).updateSpecimen(
                        specimenUuid,
                        SpecimenCompanion(
                          captureTime:
                              db.Value(specimenCtr.captureTimeCtr.text),
                        ),
                      );
                    }
                  });
                },
              ),
            ],
          ),
          AdaptiveLayout(useHorizontalLayout: useHorizontalLayout, children: [
            DropdownButtonFormField<int>(
                value: specimenCtr.captureMethodCtr,
                decoration: const InputDecoration(
                  labelText: 'Collected by',
                  hintText: 'Choose a person',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('One'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Two'),
                  ),
                ],
                onChanged: (int? newValue) {}),
            DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Capture Method',
                  hintText: 'Choose a trap type',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'One',
                    child: Text('One'),
                  ),
                  DropdownMenuItem(
                    value: 'Two',
                    child: Text('Two'),
                  ),
                ],
                onChanged: (String? newValue) {}),
          ])
        ],
      ),
    );
  }
}
