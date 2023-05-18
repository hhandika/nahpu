import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/fields.dart';
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
  @override
  Widget build(BuildContext context) {
    List<CollEventData> eventEntry = [];
    ref.watch(collEventEntryProvider).whenData(
          (value) => eventEntry = value,
        );
    return FormCard(
      title: 'Capture Records',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonPadding(
            child: DropdownButtonFormField(
              value: widget.specimenCtr.collEventIDCtr,
              decoration: const InputDecoration(
                labelText: 'Collecting Event ID',
                hintText: 'Choose a collecting event ID',
              ),
              items: eventEntry.reversed
                  .map((event) => DropdownMenuItem(
                        value: event.id,
                        child: Text(event.eventID ?? ''),
                      ))
                  .toList(),
              onChanged: (int? newValue) {
                setState(() {
                  widget.specimenCtr.collEventIDCtr = newValue;
                  widget.specimenCtr.collMethodCtr = null;
                  widget.specimenCtr.coordinateCtr = null;
                  _updateSpecimen(
                    SpecimenCompanion(collEventID: db.Value(newValue)),
                  );
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
                      _updateSpecimen(
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
              ),
            ],
          ),
          CommonPadding(
            child: SwitchField(
              label: 'Relative time',
              value: _getCheckBoxValue(widget.specimenCtr.relativeTimeCtr),
              onPressed: (bool value) {
                setState(() {
                  int newValue = value ? 1 : 0;
                  widget.specimenCtr.relativeTimeCtr = newValue;
                  _updateSpecimen(
                    SpecimenCompanion(isRelativeTime: db.Value(newValue)),
                  );
                });
              },
            ),
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              DropdownButtonFormField<int?>(
                  value: widget.specimenCtr.collMethodCtr,
                  decoration: const InputDecoration(
                    labelText: 'Collecting Method',
                    hintText: 'Choose a method type',
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
                      widget.specimenCtr.collMethodCtr = newValue;
                      _updateSpecimen(
                        SpecimenCompanion(
                          collMethodID:
                              db.Value(widget.specimenCtr.collMethodCtr),
                        ),
                      );
                    });
                  }),
              CommonTextField(
                controller: widget.specimenCtr.trapIDCtr,
                labelText: 'Trap ID',
                hintText: 'Enter trap ID',
                isLastField: true,
                onChanged: (String? value) {
                  _updateSpecimen(
                    SpecimenCompanion(trapID: db.Value(value)),
                  );
                },
              )
            ],
          ),
          CoordinateField(
            specimenUuid: widget.specimenUuid,
            specimenCtr: widget.specimenCtr,
          ),
        ],
      ),
    );
  }

  void _updateSpecimen(SpecimenCompanion form) {
    SpecimenServices(ref).updateSpecimen(widget.specimenUuid, form);
  }

  bool _getCheckBoxValue(int? value) {
    if (value == null) {
      return false;
    } else {
      return value == 0 ? false : true;
    }
  }
}

class CoordinateField extends ConsumerStatefulWidget {
  const CoordinateField({
    Key? key,
    required this.specimenUuid,
    required this.specimenCtr,
  }) : super(key: key);

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  CoordinateFieldState createState() => CoordinateFieldState();
}

class CoordinateFieldState extends ConsumerState<CoordinateField> {
  @override
  Widget build(BuildContext context) {
    return CommonPadding(
      child: DropdownButtonFormField<int?>(
        value: widget.specimenCtr.coordinateCtr,
        decoration: const InputDecoration(
          labelText: 'Coordinate ID',
          hintText: 'Choose a method type',
        ),
        items: widget.specimenCtr.collEventIDCtr != null
            ? ref
                .watch(coordinateByEventProvider(
                    widget.specimenCtr.collEventIDCtr!))
                .when(
                  data: (data) {
                    return data.map((coordinate) {
                      return DropdownMenuItem(
                        value: coordinate.id,
                        child: Text(coordinate.nameId ?? ''),
                      );
                    }).toList();
                  },
                  loading: () => const [],
                  error: (error, stack) => const [],
                )
            : [],
        onChanged: (int? newValue) {
          setState(() {
            widget.specimenCtr.coordinateCtr = newValue;
            SpecimenServices(ref).updateSpecimen(widget.specimenUuid,
                SpecimenCompanion(coordinateID: db.Value(newValue)));
          });
        },
      ),
    );
  }
}

class CaptureTime extends ConsumerStatefulWidget {
  const CaptureTime({
    super.key,
    required this.specimenUuid,
    required this.specimenCtr,
  });

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  CaptureTimeState createState() => CaptureTimeState();
}

class CaptureTimeState extends ConsumerState<CaptureTime> {
  @override
  Widget build(BuildContext context) {
    return widget.specimenCtr.relativeTimeCtr == 1
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
