import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/screens/specimens/shared/species.dart';
import 'package:nahpu/services/database.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/taxonomy_queries.dart';

class CollectingRecordField extends ConsumerStatefulWidget {
  const CollectingRecordField({
    Key? key,
    required this.specimenUuid,
    required this.specimenCtr,
  }) : super(key: key);

  final SpecimenFormCtrModel specimenCtr;
  final String specimenUuid;

  @override
  CollectingRecordFieldState createState() => CollectingRecordFieldState();
}

class CollectingRecordFieldState extends ConsumerState<CollectingRecordField> {
  List<PersonnelData> personnelList = [];
  final List<String> conditions = [
    'Freshy Euthanized',
    'Good',
    'Fair',
    'Poor',
    'Rotten',
    'Released',
  ];

  final speciesCtr = TextEditingController();
  late FocusNode _speciesFocusNode;

  @override
  void initState() {
    super.initState();
    speciesCtr.text = widget.specimenCtr.taxonDataCtr.speciesName;
    _speciesFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final personnelEntry = ref.watch(personnelListProvider);
    personnelEntry.whenData(
      (personnelEntry) => personnelList = personnelEntry,
    );
    return FormCard(
      title: 'Collecting Records',
      isPrimary: true,
      child: Column(
        children: [
          PersonnelRecords(
              specimenUuid: widget.specimenUuid,
              specimenCtr: widget.specimenCtr),
          SpeciesAutoComplete(
              controller: speciesCtr,
              onSelected: (String value) {
                _speciesFocusNode.requestFocus();
                setState(() {
                  speciesCtr.text = value;
                  var taxon = value.split(' ');
                  TaxonomyQuery(ref.read(databaseProvider))
                      .getTaxonIdByGenusEpithet(taxon[0], taxon[1])
                      .then(
                        (data) => SpecimenServices(ref).updateSpecimen(
                          widget.specimenUuid,
                          SpecimenCompanion(speciesID: db.Value(data.id)),
                        ),
                      );
                });
              }),
          DropdownButtonFormField(
            value: widget.specimenCtr.conditionCtr,
            onChanged: (String? value) {
              SpecimenServices(ref).updateSpecimen(
                widget.specimenUuid,
                SpecimenCompanion(condition: db.Value(value)),
              );
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
                  controller: widget.specimenCtr.prepDateCtr,
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now());

                    if (selectedDate != null) {
                      widget.specimenCtr.prepDateCtr.text =
                          DateFormat.yMMMd().format(selectedDate);
                      SpecimenServices(ref).updateSpecimen(
                        widget.specimenUuid,
                        SpecimenCompanion(
                            prepDate:
                                db.Value(widget.specimenCtr.prepDateCtr.text)),
                      );
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
                  controller: widget.specimenCtr.prepTimeCtr,
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((time) {
                      if (time != null) {
                        widget.specimenCtr.prepTimeCtr.text =
                            time.format(context);
                        SpecimenServices(ref).updateSpecimen(
                          widget.specimenUuid,
                          SpecimenCompanion(
                            prepTime:
                                db.Value(widget.specimenCtr.prepTimeCtr.text),
                          ),
                        );
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

class PersonnelRecords extends ConsumerStatefulWidget {
  const PersonnelRecords({
    Key? key,
    required this.specimenUuid,
    required this.specimenCtr,
  }) : super(key: key);

  final SpecimenFormCtrModel specimenCtr;
  final String specimenUuid;

  @override
  PersonnelRecordsState createState() => PersonnelRecordsState();
}

class PersonnelRecordsState extends ConsumerState<PersonnelRecords> {
  List<PersonnelData> personnelList = [];

  @override
  Widget build(BuildContext context) {
    final personnelEntry = ref.watch(personnelListProvider);
    personnelEntry.whenData(
      (personnelEntry) => personnelList = personnelEntry,
    );
    return Column(
      children: [
        DropdownButtonFormField(
          value: widget.specimenCtr.collectorCtr,
          decoration: const InputDecoration(
            labelText: 'Cataloger',
            hintText: 'Choose a person with field number',
          ),
          items: personnelList
              .where((element) => element.role == 'Cataloger')
              .map((e) => DropdownMenuItem(
                    value: e.uuid,
                    child: Text(e.name ?? ''),
                  ))
              .toList(),
          onChanged: (String? uuid) {
            setState(() {
              widget.specimenCtr.collectorCtr = uuid;
              widget.specimenCtr.preparatorCtr = uuid;
              var currentCollNum = _getCurrentCollectorNumber(uuid);
              widget.specimenCtr.collectorNumberCtr.text =
                  currentCollNum.toString();
              SpecimenServices(ref).updateSpecimen(
                widget.specimenUuid,
                SpecimenCompanion(
                  collectorID: db.Value(uuid),
                  collectorNumber: db.Value(
                    currentCollNum,
                  ),
                  preparatorID: db.Value(uuid),
                ),
              );
              if (uuid != null) {
                ref.read(databaseProvider).updatePersonnelEntry(
                    uuid,
                    PersonnelCompanion(
                        nextCollectorNumber: db.Value(currentCollNum)));
              }
            });
          },
        ),
        TextFormField(
          controller: widget.specimenCtr.collectorNumberCtr,
          enabled: false,
          decoration: const InputDecoration(
            labelText: 'Field Number',
            hintText: 'Autofill',
          ),
        ),
        DropdownButtonFormField(
          value: widget.specimenCtr.preparatorCtr,
          decoration: const InputDecoration(
            labelText: 'Preparator',
            hintText: 'Choose a preparator (default is cataloger)',
          ),
          items: personnelList
              .where((element) =>
                  element.role == 'Cataloger' ||
                  element.role == 'Preparator only')
              .map((e) => DropdownMenuItem(
                    value: e.uuid,
                    child: Text(e.name ?? ''),
                  ))
              .toList(),
          onChanged: (String? uuid) {
            SpecimenServices(ref).updateSpecimen(
              widget.specimenUuid,
              SpecimenCompanion(preparatorID: db.Value(uuid)),
            );
          },
        )
      ],
    );
  }

  int _getCurrentCollectorNumber(String? uuid) {
    var collector = personnelList.firstWhere((element) => element.uuid == uuid);
    int currentCollNum = collector.nextCollectorNumber! + 1;
    return currentCollNum;
  }
}
