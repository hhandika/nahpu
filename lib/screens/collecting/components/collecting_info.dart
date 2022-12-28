import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/controller/updaters.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/services/database.dart';
import 'package:drift/drift.dart' as db;

class CollectingInfoFields extends ConsumerWidget {
  const CollectingInfoFields({
    super.key,
    required this.collEventId,
    required this.useHorizontalLayout,
    required this.collEventCtr,
  });

  final int collEventId;
  final bool useHorizontalLayout;
  final CollEventFormCtrModel collEventCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime initialStartDate =
        DateTime.now().subtract(const Duration(days: 1));
    final DateTime initialEndDate = DateTime.now();
    const TimeOfDay initialStartTime = TimeOfDay(hour: 8, minute: 0);
    return FormCard(
      title: 'Collecting Info',
      isPrimary: true,
      child: Column(
        children: [
          Padding(
            // Match adaptive layout padding
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Site ID',
                hintText: 'Enter a new event',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: TextFormField(
              controller: collEventCtr.eventIDCtr,
              decoration: const InputDecoration(
                labelText: 'Collecting Event ID',
                hintText: 'Autofill',
              ),
            ),
          ),
          AdaptiveLayout(
            useHorizontalLayout: useHorizontalLayout,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Start Date',
                  hintText: 'Enter date',
                ),
                controller: collEventCtr.startDateCtr,
                onTap: () async {
                  showDatePicker(
                          context: context,
                          initialDate: initialStartDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now())
                      .then(
                    (date) {
                      if (date != null) {
                        collEventCtr.startDateCtr.text =
                            DateFormat.yMMMd().format(date);
                        updateCollEvent(
                            collEventId,
                            CollEventCompanion(
                              startDate:
                                  db.Value(collEventCtr.startDateCtr.text),
                            ),
                            ref);
                      }
                    },
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Start time',
                  hintText: 'Enter date',
                ),
                controller: collEventCtr.startTimeCtr,
                onTap: () async {
                  showTimePicker(
                          context: context, initialTime: initialStartTime)
                      .then(
                    (time) {
                      if (time != null) {
                        collEventCtr.startTimeCtr.text = time.format(context);
                        updateCollEvent(
                            collEventId,
                            CollEventCompanion(
                              startTime:
                                  db.Value(collEventCtr.startTimeCtr.text),
                            ),
                            ref);
                      }
                    },
                  );
                },
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: useHorizontalLayout,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  hintText: 'Enter date',
                ),
                controller: collEventCtr.endDateCtr,
                onTap: () async {
                  showDatePicker(
                          context: context,
                          initialDate: initialEndDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now())
                      .then(
                    (date) {
                      if (date != null) {
                        collEventCtr.endDateCtr.text =
                            DateFormat.yMMMd().format(date);
                        updateCollEvent(
                            collEventId,
                            CollEventCompanion(
                              endDate: db.Value(collEventCtr.endDateCtr.text),
                            ),
                            ref);
                      }
                    },
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'End time',
                  hintText: 'Enter date',
                ),
                controller: collEventCtr.endTimeCtr,
                onTap: () async {
                  showTimePicker(
                          context: context, initialTime: initialStartTime)
                      .then((time) {
                    if (time != null) {
                      collEventCtr.endTimeCtr.text = time.format(context);
                      updateCollEvent(
                          collEventId,
                          CollEventCompanion(
                            endTime: db.Value(collEventCtr.endTimeCtr.text),
                          ),
                          ref);
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
