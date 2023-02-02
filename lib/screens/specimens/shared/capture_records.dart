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

class CaptureRecordFields extends ConsumerStatefulWidget {
  const CaptureRecordFields({
    super.key,
    required this.specimenUuid,
    required this.useHorizontalLayout,
    required this.specimenCtr,
  });

  final bool useHorizontalLayout;
  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  CaptureRecordFieldsState createState() => CaptureRecordFieldsState();
}

class CaptureRecordFieldsState extends ConsumerState<CaptureRecordFields> {
  @override
  Widget build(BuildContext context) {
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
              value: widget.specimenCtr.collEventIDCtr,
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
                setState(() {
                  widget.specimenCtr.collEventIDCtr = newValue;
                  SpecimenServices(ref).updateSpecimen(widget.specimenUuid,
                      SpecimenCompanion(collEventID: db.Value(newValue)));
                });
              },
            ),
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Capture date',
                  hintText: 'Enter date',
                ),
                controller: widget.specimenCtr.captureDateCtr,
                onTap: () async {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now())
                      .then((date) {
                    if (date != null) {
                      widget.specimenCtr.captureDateCtr.text =
                          DateFormat.yMMMd().format(date);
                      SpecimenServices(ref).updateSpecimen(
                        widget.specimenUuid,
                        SpecimenCompanion(
                          captureDate:
                              db.Value(widget.specimenCtr.captureDateCtr.text),
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
                controller: widget.specimenCtr.captureTimeCtr,
                onTap: () async {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((time) {
                    if (time != null) {
                      widget.specimenCtr.captureTimeCtr.text =
                          time.format(context).toString();
                      SpecimenServices(ref).updateSpecimen(
                        widget.specimenUuid,
                        SpecimenCompanion(
                          captureTime:
                              db.Value(widget.specimenCtr.captureTimeCtr.text),
                        ),
                      );
                    }
                  });
                },
              ),
            ],
          ),
          AdaptiveLayout(
              useHorizontalLayout: widget.useHorizontalLayout,
              children: [
                DropdownButtonFormField<int>(
                    value: widget.specimenCtr.collPersonnelCtr,
                    decoration: const InputDecoration(
                      labelText: 'Collected by',
                      hintText: 'Choose a person',
                    ),
                    items: widget.specimenCtr.collEventIDCtr != null
                        ? ref.watch(collEventEntryProvider).when(
                              data: (data) {
                                return data.map((person) {
                                  return DropdownMenuItem(
                                    value: person.id,
                                    child: Text(person.eventID ?? ''),
                                  );
                                }).toList();
                              },
                              loading: () => const [],
                              error: (e, s) => const [],
                            )
                        : [],
                    onChanged: (int? newValue) {}),
                DropdownButtonFormField<int?>(
                    value: widget.specimenCtr.captureMethodCtr,
                    decoration: const InputDecoration(
                      labelText: 'Capture Method',
                      hintText: 'Choose a trap type',
                    ),
                    items: widget.specimenCtr.collEventIDCtr != null
                        ? ref
                            .watch(collEffortByEventProvider(
                                widget.specimenCtr.collEventIDCtr!))
                            .when(
                                data: (data) {
                                  return data.map((effort) {
                                    return DropdownMenuItem(
                                      value: effort.id,
                                      child: Text(effort.type ?? ''),
                                    );
                                  }).toList();
                                },
                                loading: () => const [],
                                error: (error, stack) => const [])
                        : const [],
                    onChanged: (int? newValue) {
                      setState(() {
                        widget.specimenCtr.captureMethodCtr = newValue;
                        SpecimenServices(ref).updateSpecimen(
                          widget.specimenUuid,
                          SpecimenCompanion(
                            collMethodID:
                                db.Value(widget.specimenCtr.captureMethodCtr),
                          ),
                        );
                      });
                    }),
              ])
        ],
      ),
    );
  }
}
