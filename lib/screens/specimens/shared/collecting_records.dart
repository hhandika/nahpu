import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/providers/taxa.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/services/types/mammals.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/shared/taxa.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/specimen_services.dart';

class CollectingRecordField extends ConsumerStatefulWidget {
  const CollectingRecordField({
    super.key,
    required this.specimenUuid,
    required this.specimenCtr,
    required this.useHorizontalLayout,
  });

  final SpecimenFormCtrModel specimenCtr;
  final String specimenUuid;
  final bool useHorizontalLayout;

  @override
  CollectingRecordFieldState createState() => CollectingRecordFieldState();
}

class CollectingRecordFieldState extends ConsumerState<CollectingRecordField> {
  List<PersonnelData> personnelList = [];

  TextEditingController speciesCtr =
      TextEditingController(text: 'Species found');

  @override
  void initState() {
    super.initState();
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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      child: Column(
        children: [
          PersonnelRecords(
              specimenUuid: widget.specimenUuid,
              specimenCtr: widget.specimenCtr),
          SpeciesFieldCtr(
            specimenUuid: widget.specimenUuid,
            speciesCtr: widget.specimenCtr.speciesCtr,
          ),
          widget.specimenCtr.conditionCtr == 'Freshly Euthanized'
              ? AdaptiveLayout(
                  useHorizontalLayout: widget.useHorizontalLayout,
                  children: [
                      SpecimenConditionField(
                        specimenCtr: widget.specimenCtr,
                        specimenUuid: widget.specimenUuid,
                      ),
                      SpecimenCollectedField(
                        specimenCtr: widget.specimenCtr,
                        specimenUuid: widget.specimenUuid,
                      ),
                    ])
              : CommonPadding(
                  child: SpecimenConditionField(
                  specimenCtr: widget.specimenCtr,
                  specimenUuid: widget.specimenUuid,
                )),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              PrepDateField(
                specimenCtr: widget.specimenCtr,
                specimenUuid: widget.specimenUuid,
              ),
              PrepTimeField(
                specimenCtr: widget.specimenCtr,
                specimenUuid: widget.specimenUuid,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SpeciesFieldCtr extends ConsumerWidget {
  const SpeciesFieldCtr({
    super.key,
    required this.specimenUuid,
    required this.speciesCtr,
  });

  final String specimenUuid;
  final int? speciesCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(taxonProvider).when(
          data: (taxa) {
            if (taxa.isEmpty) {
              return const DisabledSpeciesField();
            }
            return SpeciesInputField(
              specimenUuid: specimenUuid,
              speciesCtr: speciesCtr,
              taxonList: taxa,
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => const Text('Error loading taxa'),
        );
  }
}

class SpecimenCollectedField extends ConsumerWidget {
  const SpecimenCollectedField({
    super.key,
    required this.specimenCtr,
    required this.specimenUuid,
  });

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTimeField(
        controller: specimenCtr.collTimeCtr,
        labelText: 'Collection time',
        hintText: 'Enter time',
        initialTime: TimeOfDay.now(),
        onTap: () {
          SpecimenServices(ref: ref).updateSpecimen(
            specimenUuid,
            SpecimenCompanion(
                collectionTime: db.Value(
              specimenCtr.collTimeCtr.text,
            )),
          );
        });
  }
}

class SpecimenConditionField extends ConsumerWidget {
  const SpecimenConditionField({
    super.key,
    required this.specimenCtr,
    required this.specimenUuid,
  });

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField(
      value: specimenCtr.conditionCtr,
      onChanged: (String? value) {
        SpecimenServices(ref: ref).updateSpecimen(
          specimenUuid,
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
                child: CommonDropdownText(text: condition),
              ))
          .toList(),
    );
  }
}

class PrepDateField extends ConsumerWidget {
  const PrepDateField({
    super.key,
    required this.specimenCtr,
    required this.specimenUuid,
  });

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonDateField(
      controller: specimenCtr.prepDateCtr,
      labelText: 'Prep. date',
      hintText: 'Enter date',
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      onTap: () {
        SpecimenServices(ref: ref).updateSpecimen(
          specimenUuid,
          SpecimenCompanion(
            prepDate: db.Value(specimenCtr.prepDateCtr.text),
          ),
        );
      },
    );
  }
}

class PrepTimeField extends ConsumerWidget {
  const PrepTimeField({
    super.key,
    required this.specimenCtr,
    required this.specimenUuid,
  });

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTimeField(
        controller: specimenCtr.prepTimeCtr,
        labelText: 'Prep. time',
        hintText: 'Enter time',
        initialTime: TimeOfDay.now(),
        onTap: () {
          SpecimenServices(ref: ref).updateSpecimen(
            specimenUuid,
            SpecimenCompanion(
              prepTime: db.Value(specimenCtr.prepTimeCtr.text),
            ),
          );
        });
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
  final Set<String> _selectedPersonnel = {};

  @override
  Widget build(BuildContext context) {
    return CommonPadding(
      child: Column(
        children: [
          widget.specimenCtr.catalogerCtr != null
              ? IdTile(
                  specimenUuid: widget.specimenUuid,
                  specimenCtr: widget.specimenCtr,
                  catalogerUuid: widget.specimenCtr.catalogerCtr!,
                )
              : const SizedBox.shrink(),
          DropdownButtonFormField<String>(
            value: widget.specimenCtr.catalogerCtr,
            decoration: const InputDecoration(
              labelText: 'Cataloger',
              hintText: 'Choose a person with field number',
            ),
            items: ref.watch(personnelListProvider).when(
                  data: (data) => data
                      .where((element) => element.role == 'Cataloger')
                      .map((e) => DropdownMenuItem(
                            value: e.uuid,
                            child: CommonDropdownText(text: e.name ?? ''),
                          ))
                      .toList(),
                  loading: () => const [],
                  error: (e, s) => const [],
                ),
            onChanged: (String? uuid) async {
              if (uuid != null) {
                int fieldNumber = await _getCurrentCollectorNumber(uuid);
                setState(() {
                  bool hasSelected = _selectedPersonnel.contains(uuid);
                  int currentFieldNumber =
                      hasSelected ? fieldNumber - 1 : fieldNumber;
                  widget.specimenCtr.catalogerCtr = uuid;
                  widget.specimenCtr.preparatorCtr = uuid;
                  widget.specimenCtr.fieldNumberCtr.text =
                      currentFieldNumber.toString();

                  if (!hasSelected) {
                    PersonnelServices(ref: ref).updatePersonnelEntry(
                        uuid,
                        PersonnelCompanion(
                            currentFieldNumber: db.Value(fieldNumber + 1)));
                    _selectedPersonnel.add(uuid);
                  }
                  SpecimenServices(ref: ref).updateSpecimen(
                    widget.specimenUuid,
                    SpecimenCompanion(
                      catalogerID: db.Value(uuid),
                      fieldNumber: db.Value(
                        currentFieldNumber,
                      ),
                      preparatorID: db.Value(uuid),
                    ),
                  );
                });
              }
            },
          ),
          DropdownButtonFormField<String>(
            value: widget.specimenCtr.preparatorCtr,
            decoration: const InputDecoration(
              labelText: 'Preparator',
              hintText: 'Choose a preparator (default is cataloger)',
            ),
            items: ref.watch(personnelListProvider).when(
                  data: (data) => data
                      .where((element) =>
                          element.role == 'Cataloger' ||
                          element.role == 'Preparator only')
                      .map((e) => DropdownMenuItem(
                            value: e.uuid,
                            child: CommonDropdownText(text: e.name ?? ''),
                          ))
                      .toList(),
                  loading: () => const [],
                  error: (e, s) => const [],
                ),
            onChanged: (String? uuid) {
              SpecimenServices(ref: ref).updateSpecimen(
                widget.specimenUuid,
                SpecimenCompanion(preparatorID: db.Value(uuid)),
              );
            },
          )
        ],
      ),
    );
  }

  Future<int> _getCurrentCollectorNumber(String personnelUuid) async {
    int fieldNumber = await SpecimenServices(ref: ref).getSpecimenFieldNumber(
      personnelUuid,
    );

    return fieldNumber;
  }
}

class IdTile extends ConsumerWidget {
  const IdTile({
    Key? key,
    required this.specimenUuid,
    required this.specimenCtr,
    required this.catalogerUuid,
  }) : super(key: key);

  final SpecimenFormCtrModel specimenCtr;
  final String specimenUuid;
  final String catalogerUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IDFormContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: CommonTextField(
              controller: specimenCtr.museumIDCtr,
              labelText: 'Museum ID',
              hintText: 'Enter museum ID (if applicable)',
              isLastField: true,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref: ref).updateSpecimen(
                    specimenUuid,
                    SpecimenCompanion(
                      museumID: db.Value(value),
                    ),
                  );
                }
              },
            ),
          ),
          SpecimenIdTile(
            specimenUuid: specimenUuid,
            specimenCtr: specimenCtr,
            catalogerUuid: catalogerUuid,
          ),
        ],
      ),
    );
  }
}

class SpecimenIdTile extends ConsumerWidget {
  const SpecimenIdTile({
    Key? key,
    required this.specimenUuid,
    required this.specimenCtr,
    required this.catalogerUuid,
  }) : super(key: key);

  final SpecimenFormCtrModel specimenCtr;
  final String specimenUuid;
  final String catalogerUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initial = ref.watch(personnelInitialProvider(catalogerUuid));
    return ListTile(
      title: initial.when(
        data: (initial) => Text(
          'Field ID: $initial${specimenCtr.fieldNumberCtr.text}',
        ),
        loading: () => const Text('Loading...'),
        error: (error, stack) => Text('Error: $error'),
      ),
      trailing: Visibility(
        visible: specimenCtr.fieldNumberCtr.text.isNotEmpty,
        child: IconButton(
          icon: Icon(
            Icons.edit_rounded,
            color: Theme.of(context).disabledColor,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Edit field number'),
                  content: TextField(
                    controller: specimenCtr.fieldNumberCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Field number',
                      hintText: 'Enter field number',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        int fieldNumber =
                            int.parse(specimenCtr.fieldNumberCtr.text);
                        int nextFieldNumber = fieldNumber + 1;
                        await PersonnelServices(ref: ref).updatePersonnelEntry(
                            catalogerUuid,
                            PersonnelCompanion(
                                currentFieldNumber: db.Value(nextFieldNumber)));
                        await SpecimenServices(ref: ref).updateSpecimen(
                          specimenUuid,
                          SpecimenCompanion(
                            fieldNumber: db.Value(
                              fieldNumber,
                            ),
                          ),
                        );

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
