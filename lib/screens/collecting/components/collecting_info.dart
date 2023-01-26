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
    return FormCard(
      title: 'Collecting Info',
      isPrimary: true,
      child: Column(
        children: [
          Padding(
            // Match adaptive layout padding
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: SiteIdField(
              value: collEventCtr.siteIDCtr,
              onChanges: (int? value) {
                updateCollEvent(
                    collEventId,
                    CollEventCompanion(
                      siteID: db.Value(value),
                    ),
                    ref);
              },
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
              onChanged: (String? value) {
                updateCollEvent(
                    collEventId,
                    CollEventCompanion(
                      eventID: db.Value(value),
                    ),
                    ref);
              },
            ),
          ),
          EventDateField(
            collEventId: collEventId,
            collEventCtr: collEventCtr,
            useHorizontalLayout: useHorizontalLayout,
          ),
          EventTimeField(
            collEventId: collEventId,
            collEventCtr: collEventCtr,
            useHorizontalLayout: useHorizontalLayout,
          ),
        ],
      ),
    );
  }
}

class EventDateField extends ConsumerWidget {
  const EventDateField({
    super.key,
    required this.collEventId,
    required this.collEventCtr,
    required this.useHorizontalLayout,
  });

  final int collEventId;
  final CollEventFormCtrModel collEventCtr;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime initialStartDate =
        DateTime.now().subtract(const Duration(days: 1));
    final DateTime initialEndDate = DateTime.now();
    return AdaptiveLayout(
      useHorizontalLayout: useHorizontalLayout,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Start Date',
            hintText: 'Enter date',
          ),
          controller: collEventCtr.startDateCtr,
          onTap: () async {
            DateTime? date = await showDate(context, initialStartDate);
            if (date != null) {
              collEventCtr.startDateCtr.text = DateFormat.yMMMd().format(date);
              updateCollEvent(
                  collEventId,
                  CollEventCompanion(
                    startDate: db.Value(collEventCtr.startDateCtr.text),
                  ),
                  ref);
            }
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'End Date',
            hintText: 'Enter date',
          ),
          controller: collEventCtr.endDateCtr,
          onTap: () async {
            DateTime? date = await showDate(context, initialEndDate);
            if (date != null) {
              collEventCtr.endDateCtr.text = DateFormat.yMMMd().format(date);
              updateCollEvent(
                  collEventId,
                  CollEventCompanion(
                    endDate: db.Value(collEventCtr.endDateCtr.text),
                  ),
                  ref);
            }
          },
        ),
      ],
    );
  }

  Future<DateTime?> showDate(BuildContext context, DateTime initialStartDate) {
    return showDatePicker(
        context: context,
        initialDate: initialStartDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
  }
}

class EventTimeField extends ConsumerStatefulWidget {
  const EventTimeField({
    super.key,
    required this.collEventId,
    required this.collEventCtr,
    required this.useHorizontalLayout,
  });

  final int collEventId;
  final CollEventFormCtrModel collEventCtr;
  final bool useHorizontalLayout;

  @override
  EventTimeFieldState createState() => EventTimeFieldState();
}

class EventTimeFieldState extends ConsumerState<EventTimeField> {
  @override
  Widget build(BuildContext context) {
    final TimeOfDay initialStartTime = TimeOfDay.now();
    final TimeOfDay initialEndTime = TimeOfDay.now();
    return AdaptiveLayout(
      useHorizontalLayout: widget.useHorizontalLayout,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Start time',
            hintText: 'Enter date',
          ),
          controller: widget.collEventCtr.startTimeCtr,
          onTap: () async {
            TimeOfDay? time = await showTime(initialStartTime);
            if (time != null) {
              if (!mounted) return;

              widget.collEventCtr.startTimeCtr.text = time.format(context);
              updateCollEvent(
                  widget.collEventId,
                  CollEventCompanion(
                    startTime: db.Value(widget.collEventCtr.startTimeCtr.text),
                  ),
                  ref);
            }
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'End time',
            hintText: 'Enter date',
          ),
          controller: widget.collEventCtr.endTimeCtr,
          onTap: () async {
            TimeOfDay? time = await showTime(initialEndTime);
            if (time != null) {
              if (!mounted) return;

              widget.collEventCtr.endTimeCtr.text = time.format(context);
              updateCollEvent(
                  widget.collEventId,
                  CollEventCompanion(
                    endTime: db.Value(widget.collEventCtr.endTimeCtr.text),
                  ),
                  ref);
            }
          },
        ),
      ],
    );
  }

  Future<TimeOfDay?> showTime(TimeOfDay initialStartTime) {
    return showTimePicker(context: context, initialTime: initialStartTime);
  }
}
