import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/mammals.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/screens/specimens/shared/taxa.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';

class CollectingRecordField extends ConsumerStatefulWidget {
  const CollectingRecordField({
    super.key,
    required this.specimenUuid,
    required this.specimenCtr,
  });

  final SpecimenFormCtrModel specimenCtr;
  final String specimenUuid;

  @override
  CollectingRecordFieldState createState() => CollectingRecordFieldState();
}

class CollectingRecordFieldState extends ConsumerState<CollectingRecordField> {
  List<PersonnelData> personnelList = [];

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
                setState(
                  () {
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
                  },
                );
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
            items: conditionList
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
  bool hasChanged = false;

  @override
  Widget build(BuildContext context) {
    final personnelEntry = ref.watch(personnelListProvider);
    personnelEntry.whenData(
      (personnelEntry) => personnelList = personnelEntry,
    );
    return Column(
      children: [
        DropdownButtonFormField(
          value: widget.specimenCtr.catalogerCtr,
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
          onChanged: (String? uuid) async {
            // TODO: Apply on-change once.
            if (uuid != null) {
              int fieldNumber = await _getCurrentCollectorNumber(uuid);
              setState(() {
                widget.specimenCtr.catalogerCtr = uuid;
                widget.specimenCtr.preparatorCtr = uuid;
                _getCurrentCollectorNumber(uuid);
                widget.specimenCtr.collectorNumberCtr.text =
                    fieldNumber.toString();
                if (!hasChanged) {
                  PersonnelServices(ref).updatePersonnelEntry(
                      uuid,
                      PersonnelCompanion(
                          currentFieldNumber: db.Value(fieldNumber + 1)));
                  hasChanged = true;
                }
                SpecimenServices(ref).updateSpecimen(
                  widget.specimenUuid,
                  SpecimenCompanion(
                    catalogerID: db.Value(uuid),
                    fieldNumber: db.Value(
                      fieldNumber,
                    ),
                    preparatorID: db.Value(uuid),
                  ),
                );
              });
            }
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

  Future<int> _getCurrentCollectorNumber(String personnelUuid) async {
    int fieldNumber = await SpecimenServices(ref)
        .getSpecimenFieldNumber(personnelUuid, widget.specimenUuid);

    return fieldNumber;
  }
}
