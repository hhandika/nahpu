import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
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
  bool isRelativeTime = false;
  bool isMultipleCollectors = false;

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
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              CheckboxListTile(
                value: isRelativeTime,
                onChanged: (value) {
                  setState(() {
                    isRelativeTime = value!;
                  });
                },
                title: const Text('Relative time'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                  value: isMultipleCollectors,
                  onChanged: (value) {
                    setState(() {
                      isMultipleCollectors = value!;
                    });
                  },
                  title: const Text('Multiple collectors'),
                  controlAffinity: ListTileControlAffinity.leading),
            ],
          ),
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
              CaptureTime(
                specimenUuid: widget.specimenUuid,
                specimenCtr: widget.specimenCtr,
                isRelativeTime: isRelativeTime,
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
                        ? ref
                            .watch(collPersonnelProvider(
                                widget.specimenCtr.collEventIDCtr!))
                            .when(
                              data: (data) {
                                return data.map((person) {
                                  return DropdownMenuItem(
                                      value: person.id,
                                      child: PersonnelName(
                                        personnelUuid: person.personnelId,
                                      ));
                                }).toList();
                              },
                              loading: () => const [],
                              error: (e, s) => const [],
                            )
                        : [],
                    onChanged: (int? newValue) {
                      setState(() {
                        widget.specimenCtr.collPersonnelCtr = newValue;
                        SpecimenServices(ref).updateSpecimen(
                          widget.specimenUuid,
                          SpecimenCompanion(
                            collPersonnelID: db.Value(newValue),
                          ),
                        );
                      });
                    }),
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

class PersonnelName extends ConsumerWidget {
  const PersonnelName({
    Key? key,
    required this.personnelUuid,
  }) : super(key: key);

  final String? personnelUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    try {
      return ref.watch(personnelNameProvider(personnelUuid!)).when(
            data: (data) {
              return Text(data.name ?? '');
            },
            loading: () => const Text('Loading...'),
            error: (error, stack) => const Text('Error'),
          );
    } catch (e) {
      return const Text('Error');
    }
  }
}

class CaptureTime extends ConsumerStatefulWidget {
  const CaptureTime(
      {super.key,
      required this.specimenUuid,
      required this.specimenCtr,
      required this.isRelativeTime});

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;
  final bool isRelativeTime;

  @override
  CaptureTimeState createState() => CaptureTimeState();
}

class CaptureTimeState extends ConsumerState<CaptureTime> {
  @override
  Widget build(BuildContext context) {
    return widget.isRelativeTime
        ? DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Capture time',
              hintText: 'Enter time',
            ),
            items: relativeTimeList
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                widget.specimenCtr.captureTimeCtr.text = newValue ?? '';
                SpecimenServices(ref).updateSpecimen(
                  widget.specimenUuid,
                  SpecimenCompanion(
                    captureTime:
                        db.Value(widget.specimenCtr.captureTimeCtr.text),
                  ),
                );
              });
            },
          )
        : TextField(
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
          );
  }
}
