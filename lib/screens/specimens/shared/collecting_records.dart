import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/providers/updater.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/database/database.dart';

class CollectingRecordFields extends ConsumerWidget {
  const CollectingRecordFields(
      {Key? key, required this.specimenUuid, required this.specimenCtr})
      : super(key: key);

  final SpecimenFormCtrModel specimenCtr;
  final String specimenUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PersonnelData> personnelList = [];
    final personnelEntry = ref.watch(personnelListProvider);

    final List<String> conditions = [
      'Freshy Euthanized',
      'Good',
      'Fair',
      'Poor',
      'Rotten',
      'Released',
    ];
    personnelEntry.when(
      data: (personnelEntry) => personnelList = personnelEntry,
      loading: () => null,
      error: (e, s) => null,
    );
    return FormCard(
      title: 'Collecting Records',
      isPrimary: true,
      child: Column(
        children: [
          DropdownButtonFormField(
            value: specimenCtr.collectorCtr,
            decoration: const InputDecoration(
              labelText: 'Collector',
              hintText: 'Choose a collector',
            ),
            items: personnelList
                .map((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name ?? ''),
                    ))
                .toList(),
            onChanged: (String? id) {
              updateSpecimen(specimenUuid,
                  SpecimenCompanion(collectorID: db.Value(id)), ref);
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Collector Number',
              hintText: 'Enter collector number',
            ),
          ),
          DropdownButtonFormField(
            value: specimenCtr.preparatorCtr,
            decoration: const InputDecoration(
              labelText: 'Preparator',
              hintText: 'Choose a preparator',
            ),
            items: personnelList
                .map((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name ?? ''),
                    ))
                .toList(),
            onChanged: (String? id) {
              updateSpecimen(specimenUuid,
                  SpecimenCompanion(preparatorID: db.Value(id)), ref);
            },
          ),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Species',
                hintText: 'Choose a speciess',
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
          DropdownButtonFormField(
            value: specimenCtr.conditionCtr,
            onChanged: (String? value) {
              updateSpecimen(specimenUuid,
                  SpecimenCompanion(condition: db.Value(value)), ref);
            },
            decoration: const InputDecoration(
              labelText: 'Condition',
              hintText: 'Choose a condition',
            ),
            items: conditions
                .map((String condition) => DropdownMenuItem(
                      value: condition,
                      child: Text(condition),
                    ))
                .toList(),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Preparation date',
                    hintText: 'Enter date',
                  ),
                  controller: specimenCtr.prepDateCtr,
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now());

                    if (selectedDate != null) {
                      specimenCtr.prepDateCtr.text =
                          DateFormat.yMMMd().format(selectedDate);
                      updateSpecimen(
                          specimenUuid,
                          SpecimenCompanion(
                              prepDate: db.Value(specimenCtr.prepDateCtr.text)),
                          ref);
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Prep. time',
                    hintText: 'Enter time',
                  ),
                  controller: specimenCtr.prepTimeCtr,
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((time) {
                      if (time != null) {
                        specimenCtr.prepTimeCtr.text = time.format(context);
                        updateSpecimen(
                            specimenUuid,
                            SpecimenCompanion(
                              prepTime: db.Value(specimenCtr.prepTimeCtr.text),
                            ),
                            ref);
                      }
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
