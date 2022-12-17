import 'package:drift/drift.dart' as db;
import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/updater.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/mammals/forms.dart';

class SpecimenForm extends ConsumerStatefulWidget {
  const SpecimenForm(
      {Key? key, required this.specimenUuid, required this.specimenCtr})
      : super(key: key);

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  SpecimenFormState createState() => SpecimenFormState();
}

class SpecimenFormState extends ConsumerState<SpecimenForm>
    with TickerProviderStateMixin {
  late TabController _tabController;

  List<PersonnelData> personnelList = [];
  String? personnel;

  final List<String> conditions = [
    'Freshy Euthanized',
    'Good',
    'Fair',
    'Poor',
    'Rotten'
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        bool useHorizontalLayout = c.maxWidth > 600;
        return SingleChildScrollView(
          child: AdaptiveColumn(children: [
            AdaptiveContainer(
              columnSpan: 12,
              child: AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  _buildSpecimenDataFields(),
                  _buildCaptureRecordFields(),
                ],
              ),
            ),
            AdaptiveContainer(
              columnSpan: 12,
              child: AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  const MeasurementForms(),
                  _buildPartFields(),
                ],
              ),
            ),
            AdaptiveContainer(
              columnSpan: 12,
              child: _buildMediaFields(),
            )
          ]),
        );
      },
    );
  }

  Widget _buildSpecimenDataFields() {
    final personnelEntry = ref.watch(personnelListProvider);
    personnelEntry.when(
      data: (personnelEntry) => personnelList = personnelEntry,
      loading: () => null,
      error: (e, s) => null,
    );
    return FormCard(
      title: 'Specimen Data',
      isPrimary: true,
      child: Column(
        children: [
          DropdownButtonFormField(
            value: widget.specimenCtr.collectorCtr,
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
              personnel = id;
              updateSpecimen(widget.specimenUuid,
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
            value: widget.specimenCtr.preparatorCtr,
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
              personnel = id;
              updateSpecimen(widget.specimenUuid,
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
            value: widget.specimenCtr.conditionCtr,
            onChanged: (String? value) {
              updateSpecimen(widget.specimenUuid,
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
                      updateSpecimen(
                          widget.specimenUuid,
                          SpecimenCompanion(
                              prepDate: db.Value(
                                  widget.specimenCtr.prepDateCtr.text)),
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
                  controller: widget.specimenCtr.prepTimeCtr,
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((time) {
                      if (time != null) {
                        widget.specimenCtr.prepTimeCtr.text =
                            time.format(context);
                        updateSpecimen(
                            widget.specimenUuid,
                            SpecimenCompanion(
                              prepTime:
                                  db.Value(widget.specimenCtr.prepTimeCtr.text),
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

  Widget _buildCaptureRecordFields() {
    return FormCard(
      title: 'Capture Records',
      child: Column(
        children: [
          DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Site ID',
                hintText: 'Choose a site ID',
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
              decoration: const InputDecoration(
                labelText: 'Trap type',
                hintText: 'Choose a trap type',
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
          TextFormField(
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
                }
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Collecting Event ID',
              hintText: 'Enter collecting event ID',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartFields() {
    return FormCard(
      title: 'Specimen Parts',
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              elevation: 0,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _showPartForm();
                  });
            },
            child: const Text(
              'Add a part',
            ),
          ),
          TextFormField(
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Part notes',
              hintText: 'Add notes',
            ),
          ),
        ],
      ),
    );
  }

  Widget _showPartForm() {
    return AlertDialog(
      title: const Text('Add a part'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Preparation type',
              hintText: 'Enter prep type: e.g. "skin", "liver", etc."',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Counts',
              hintText: 'Enter part counts',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Treatment',
              hintText: 'Enter part counts',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          child: const Text('Add'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildMediaFields() {
    return Column(
      // Media inputs
      children: [
        DefaultTabController(
          length: 3,
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                  icon: Icon(Icons.photo_album_rounded,
                      color: Theme.of(context).colorScheme.tertiary)),
              Tab(
                  icon: Icon(Icons.video_library_rounded,
                      color: Theme.of(context).colorScheme.tertiary)),
              Tab(
                  icon: Icon(Icons.audiotrack_rounded,
                      color: Theme.of(context).colorScheme.tertiary)),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: TabBarView(
            controller: _tabController,
            children: [
              Column(
                children: [
                  _addPhotoButton(),
                ],
              ),
              Column(
                children: [
                  _addVideoButton(),
                ],
              ),
              Column(
                children: [
                  _addAudioButton(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _addPhotoButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return _showPhotoForm();
            });
      },
      child: const Text(
        'Add a photo',
      ),
    );
  }

  Widget _addVideoButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      onPressed: () {},
      child: const Text(
        'Add a video',
      ),
    );
  }

  Widget _addAudioButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      onPressed: () {},
      child: const Text(
        'Add an audio file',
      ),
    );
  }

  Widget _showPhotoForm() {
    return AlertDialog(
      title: const Text('Add a part'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Preparation type',
              hintText: 'Enter prep type: e.g. "skin", "liver", etc."',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Counts',
              hintText: 'Enter part counts',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Treatment',
              hintText: 'Enter part counts',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          child: const Text('Add'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
