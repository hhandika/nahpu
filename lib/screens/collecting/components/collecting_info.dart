import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;

class CollectingInfoFields extends ConsumerStatefulWidget {
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
  CollectingInfoFieldsState createState() => CollectingInfoFieldsState();
}

class CollectingInfoFieldsState extends ConsumerState<CollectingInfoFields> {
  List<SiteData> data = [];
  String? siteID;

  final DateTime initialStartDate =
      DateTime.now().subtract(const Duration(days: 1));
  final DateTime initialEndDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final siteEntry = ref.watch(siteEntryProvider);
    siteEntry.whenData(
      (siteEntry) => {
        data = siteEntry,
      },
    );
    return FormCard(
      title: 'Collecting Info',
      isPrimary: true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
            child: CollEventIdTile(
              collEventId: widget.collEventId,
              collEventCtr: widget.collEventCtr,
            ),
          ),
          Padding(
            // Match adaptive layout padding
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: SiteIdField(
              value: widget.collEventCtr.siteIDCtr,
              siteData: data,
              onChanges: (int? value) async {
                setState(() {
                  widget.collEventCtr.siteIDCtr = value;
                  _getEventID();
                  CollEventServices(ref).updateCollEvent(
                      widget.collEventId,
                      CollEventCompanion(
                        siteID: db.Value(value),
                        eventID: db.Value(
                          widget.collEventCtr.eventIDCtr.text,
                        ),
                      ));
                });
              },
            ),
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Start Date',
                  hintText: 'Enter date',
                ),
                controller: widget.collEventCtr.startDateCtr,
                onTap: () async {
                  DateTime? date = await showDate(context, initialStartDate);
                  if (date != null) {
                    setState(
                      () {
                        widget.collEventCtr.startDateCtr.text =
                            DateFormat.yMMMd().format(date);
                        _getEventID();
                        CollEventServices(ref).updateCollEvent(
                          widget.collEventId,
                          CollEventCompanion(
                            startDate:
                                db.Value(widget.collEventCtr.startDateCtr.text),
                            eventID: db.Value(
                              widget.collEventCtr.eventIDCtr.text,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  hintText: 'Enter date',
                ),
                controller: widget.collEventCtr.endDateCtr,
                onTap: () async {
                  DateTime? date = await showDate(context, initialEndDate);
                  if (date != null) {
                    widget.collEventCtr.endDateCtr.text =
                        DateFormat.yMMMd().format(date);
                    CollEventServices(ref).updateCollEvent(
                      widget.collEventId,
                      CollEventCompanion(
                        endDate: db.Value(widget.collEventCtr.endDateCtr.text),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          EventTimeField(
            collEventId: widget.collEventId,
            collEventCtr: widget.collEventCtr,
            useHorizontalLayout: widget.useHorizontalLayout,
          ),
        ],
      ),
    );
  }

  void _getEventID() {
    try {
      siteID = data
          .firstWhere(
            (e) => widget.collEventCtr.siteIDCtr == e.id,
          )
          .siteID;
      String date;
      if (widget.collEventCtr.startDateCtr.text.isNotEmpty) {
        date = widget.collEventCtr.startDateCtr.text;
      } else {
        date = DateFormat.yMMMd().format(initialStartDate);
      }

      widget.collEventCtr.eventIDCtr.text = '$siteID-$date';
    } catch (e) {
      siteID = '';
    }
  }

  Future<DateTime?> showDate(BuildContext context, DateTime initialStartDate) {
    return showDatePicker(
        context: context,
        initialDate: initialStartDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now()); // Prevent user from selecting future dates
  }
}

class CollEventIdTile extends ConsumerWidget {
  const CollEventIdTile({
    super.key,
    required this.collEventId,
    required this.collEventCtr,
  });

  final int collEventId;
  final CollEventFormCtrModel collEventCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSurface,
          width: 0.5,
        ),
      ),
      title: RichText(
        text: TextSpan(
          text: 'Coll. Event ID: ',
          style: Theme.of(context).textTheme.titleMedium,
          children: [
            TextSpan(
              text: collEventCtr.eventIDCtr.text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.edit_rounded,
          size: 20,
        ),
        onPressed: collEventCtr.eventIDCtr.text.isEmpty
            ? null
            : () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Edit Collecting Event ID'),
                      content: TextFormField(
                        controller: collEventCtr.eventIDCtr,
                        decoration: const InputDecoration(
                          labelText: 'Collecting Event ID',
                          hintText: 'Enter collecting event ID',
                        ),
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
                            CollEventServices(ref).updateCollEvent(
                              collEventId,
                              CollEventCompanion(
                                eventID: db.Value(collEventCtr.eventIDCtr.text),
                              ),
                            );
                            ref.invalidate(siteEntryProvider);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
      ),
    );
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
              CollEventServices(ref).updateCollEvent(
                widget.collEventId,
                CollEventCompanion(
                  startTime: db.Value(widget.collEventCtr.startTimeCtr.text),
                ),
              );
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
              CollEventServices(ref).updateCollEvent(
                widget.collEventId,
                CollEventCompanion(
                  endTime: db.Value(widget.collEventCtr.endTimeCtr.text),
                ),
              );
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
