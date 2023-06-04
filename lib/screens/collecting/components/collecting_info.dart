import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/providers/sites.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
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
      title: 'Info',
      isPrimary: true,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
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
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: SiteIdField(
              value: widget.collEventCtr.siteIDCtr,
              siteData: data,
              onChanges: (int? value) async {
                if (value != null) {
                  setState(() {
                    widget.collEventCtr.siteIDCtr = value;
                    CollEventServices(ref: ref).updateCollEvent(
                        widget.collEventId,
                        CollEventCompanion(
                          siteID: db.Value(value),
                        ));
                  });
                }
              },
            ),
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              CommonDateField(
                  labelText: 'Start Date',
                  hintText: 'Enter date',
                  controller: widget.collEventCtr.startDateCtr,
                  initialDate: _getInitialStartDate(),
                  lastDate: DateTime.now(),
                  onTap: () {
                    setState(
                      () {
                        // _getEventID();
                        CollEventServices(ref: ref).updateCollEvent(
                          widget.collEventId,
                          CollEventCompanion(
                            startDate:
                                db.Value(widget.collEventCtr.startDateCtr.text),
                          ),
                        );
                      },
                    );
                  }),
              EndDateField(
                collEventId: widget.collEventId,
                collEventCtr: widget.collEventCtr,
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

  DateTime _getInitialStartDate() {
    return ref.read(catalogFmtNotifierProvider).when(
      data: (catalogFmt) {
        switch (catalogFmt) {
          case CatalogFmt.birds:
            return DateTime.now();
          case CatalogFmt.generalMammals:
            return DateTime.now().subtract(const Duration(days: 1));
          case CatalogFmt.bats:
            return DateTime.now().subtract(const Duration(days: 1));
          default:
            return DateTime.now();
        }
      },
      loading: () {
        return DateTime.now();
      },
      error: (e, s) {
        return DateTime.now();
      },
    );
  }
}

class EndDateField extends ConsumerWidget {
  const EndDateField({
    super.key,
    required this.collEventId,
    required this.collEventCtr,
  });

  final int collEventId;
  final CollEventFormCtrModel collEventCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonDateField(
      labelText: 'End Date',
      hintText: 'Enter date',
      controller: collEventCtr.endDateCtr,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      onTap: () {
        CollEventServices(ref: ref).updateCollEvent(
          collEventId,
          CollEventCompanion(
            endDate: db.Value(collEventCtr.endDateCtr.text),
          ),
        );
      },
    );
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
    return collEventCtr.siteIDCtr != null
        ? ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            title: EventIDText(
              collEventId: collEventId,
              collEventCtr: collEventCtr,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.edit_rounded,
                color: Theme.of(context).disabledColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Edit Collecting Event ID'),
                      content: TextFormField(
                        controller: collEventCtr.idSuffixCtr,
                        decoration: InputDecoration(
                            labelText: 'ID suffix',
                            hintText: 'Enter ID suffix',
                            suffix: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                collEventCtr.idSuffixCtr.clear();
                              },
                            )),
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
                            CollEventServices(ref: ref).updateCollEvent(
                              collEventId,
                              CollEventCompanion(
                                idSuffix:
                                    db.Value(collEventCtr.idSuffixCtr.text),
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
          )
        : const SizedBox.shrink();
  }
}

class EventIDText extends ConsumerStatefulWidget {
  const EventIDText({
    super.key,
    required this.collEventId,
    required this.collEventCtr,
  });

  final int collEventId;
  final CollEventFormCtrModel collEventCtr;

  @override
  EventIDTextState createState() => EventIDTextState();
}

class EventIDTextState extends ConsumerState<EventIDText> {
  @override
  Widget build(BuildContext context) {
    return widget.collEventCtr.siteIDCtr != null
        ? FutureBuilder(
            builder: (builder, snapshot) {
              return snapshot.hasData
                  ? RichText(
                      text: TextSpan(
                        text: 'Coll. Event ID: ',
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(
                            text: snapshot.data.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink();
            },
            future: _getEventID())
        : const SizedBox.shrink();
  }

  Future<String> _getEventID() async {
    CollEventServices services = CollEventServices(ref: ref);
    CollEventData? collEvent = await services.getCollEvent(widget.collEventId);
    if (collEvent != null) {
      return services.getCollEventID(collEvent);
    } else {
      return '';
    }
  }
}

class EventTimeField extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveLayout(
      useHorizontalLayout: useHorizontalLayout,
      children: [
        CommonTimeField(
          labelText: 'Start time',
          hintText: 'Enter date',
          controller: collEventCtr.startTimeCtr,
          initialTime: _getInitialTime(ref),
          onTap: () {
            CollEventServices(ref: ref).updateCollEvent(
              collEventId,
              CollEventCompanion(
                startTime: db.Value(collEventCtr.startTimeCtr.text),
              ),
            );
          },
        ),
        CommonTimeField(
          labelText: 'End time',
          hintText: 'Enter date',
          controller: collEventCtr.endTimeCtr,
          initialTime: _getInitialTime(ref),
          onTap: () {
            CollEventServices(ref: ref).updateCollEvent(
              collEventId,
              CollEventCompanion(
                endTime: db.Value(collEventCtr.endTimeCtr.text),
              ),
            );
          },
        ),
      ],
    );
  }

  TimeOfDay _getInitialTime(WidgetRef ref) {
    return ref.read(catalogFmtNotifierProvider).when(
          data: (catalogFmt) {
            switch (catalogFmt) {
              case CatalogFmt.birds:
                return TimeOfDay.now();
              case CatalogFmt.generalMammals:
                return const TimeOfDay(hour: 7, minute: 0);
              case CatalogFmt.bats:
                return TimeOfDay.now();
              default:
                return TimeOfDay.now();
            }
          },
          loading: () => TimeOfDay.now(),
          error: (err, stack) => TimeOfDay.now(),
        );
  }
}
