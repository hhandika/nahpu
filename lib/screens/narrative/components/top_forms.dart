import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/providers/sites.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/narrative_services.dart';

class SiteForm extends ConsumerWidget {
  const SiteForm({
    super.key,
    required this.narrativeId,
    required this.narrativeCtr,
  });

  final int narrativeId;
  final NarrativeFormCtrModel narrativeCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<SiteData> data = [];
    final siteEntry = ref.watch(siteEntryProvider);
    siteEntry.whenData(
      (siteEntry) => data = siteEntry,
    );
    return Container(
      padding: const EdgeInsets.all(10),
      child: SiteIdField(
        value: narrativeCtr.siteCtr,
        siteData: data,
        onChanges: (int? value) {
          NarrativeServices(ref: ref).updateNarrative(
            narrativeId,
            NarrativeCompanion(siteID: db.Value(value)),
          );
        },
      ),
    );
  }
}

class DateForm extends ConsumerWidget {
  const DateForm({
    super.key,
    required this.narrativeId,
    required this.narrativeCtr,
  });

  final int narrativeId;
  final NarrativeFormCtrModel narrativeCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Date',
          hintText: 'Enter date',
        ),
        controller: narrativeCtr.dateCtr,
        onTap: () async {
          final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now());
          if (selectedDate != null) {
            narrativeCtr.dateCtr.text = DateFormat.yMMMd().format(selectedDate);
            NarrativeServices(ref: ref).updateNarrative(
              narrativeId,
              NarrativeCompanion(date: db.Value(narrativeCtr.dateCtr.text)),
            );
          }
        },
      ),
    );
  }
}
