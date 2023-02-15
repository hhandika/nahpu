import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/associated_data.dart';

class PartDataForm extends ConsumerStatefulWidget {
  const PartDataForm({
    super.key,
    required this.specimenUuid,
    required this.catalogFmt,
  });

  final String specimenUuid;
  final CatalogFmt catalogFmt;

  @override
  PartDataFormState createState() => PartDataFormState();
}

class PartDataFormState extends ConsumerState<PartDataForm>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final int _length = 2;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormCard(
      withTitle: false,
      child: MediaTabBars(
        tabController: _tabController,
        length: _length,
        tabs: [
          Tab(
            icon: Icon(matchCatFmtToPartIcon(widget.catalogFmt)),
          ),
          Tab(
            icon: Icon(MdiIcons.databaseOutline,
                color: Theme.of(context).colorScheme.tertiary),
          )
        ],
        children: [
          SpecimenPartFields(specimenUuid: widget.specimenUuid),
          const AssociatedDataViewer(),
        ],
      ),
    );
  }
}

class SpecimenPartFields extends ConsumerWidget {
  const SpecimenPartFields({
    super.key,
    required this.specimenUuid,
  });

  final String specimenUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TitleForm(text: 'Specimen Parts'),
        const Expanded(child: PartList()),
        PrimaryButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewPart(specimenUuid: specimenUuid),
              ),
            );
          },
          text: 'Add Part',
        ),
        TextFormField(
          maxLines: 5,
          decoration: const InputDecoration(
            labelText: 'Notes',
            hintText: 'Add notes',
          ),
        ),
      ],
    );
  }
}

class PartList extends ConsumerWidget {
  const PartList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: const [Text('Parts'), Text('data')],
    );
  }
}

class NewPart extends StatelessWidget {
  const NewPart({
    super.key,
    required this.specimenUuid,
  });

  final String specimenUuid;

  @override
  Widget build(BuildContext context) {
    final PartFormCtrModel partCtr = PartFormCtrModel.empty();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add specimen parts'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: PartForms(
          specimenUuid: specimenUuid,
          partCtr: partCtr,
        ),
      ),
    );
  }
}

class EditPart extends StatelessWidget {
  const EditPart({
    super.key,
    required this.specimenUuid,
    required this.partUuid,
  });

  final String specimenUuid;
  final String partUuid;

  @override
  Widget build(BuildContext context) {
    final PartFormCtrModel partCtr = PartFormCtrModel.empty();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit specimen parts'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: PartForms(
          specimenUuid: specimenUuid,
          partCtr: partCtr,
          isEditing: true,
        ),
      ),
    );
  }
}

class PartIdForm extends ConsumerWidget {
  const PartIdForm({
    super.key,
    required this.specimenUuid,
    required this.partCtr,
  });

  final String specimenUuid;
  final PartFormCtrModel partCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Text(
          'Part ID',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        CommonTextField(
            controller: partCtr.primaryIdCtr,
            labelText: 'Primary',
            hintText: 'Enter primary ID',
            isLastField: false),
        CommonTextField(
            controller: partCtr.secondaryIdCtr,
            labelText: 'Secondary',
            hintText: 'Enter secondary ID',
            isLastField: false),
        CommonTextField(
            controller: partCtr.tertiaryIdCtr,
            labelText: 'Tertiary',
            hintText: 'Enter tertiary ID',
            isLastField: true),
      ]),
    );
  }
}

class PartForms extends ConsumerWidget {
  const PartForms({
    super.key,
    required this.specimenUuid,
    required this.partCtr,
    this.isEditing = false,
  });

  final String specimenUuid;
  final PartFormCtrModel partCtr;
  final bool isEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PartIdForm(
                specimenUuid: specimenUuid,
                partCtr: partCtr,
              ),
              CommonTextField(
                controller: partCtr.typeCtr,
                labelText: 'Preparation type',
                hintText: 'Enter prep type: e.g. "skin", "liver", etc."',
                isLastField: false,
              ),
              CommonNumField(
                controller: partCtr.countCtr,
                labelText: 'Counts',
                hintText: 'Enter part counts',
                isLastField: false,
              ),
              CommonTextField(
                controller: partCtr.treatmentCtr,
                labelText: 'Treatment',
                hintText:
                    'Enter a treatment: e.g. "formalin", "alcohol", etc."',
                isLastField: false,
              ),
              CommonTextField(
                controller: partCtr.dateTakenCtr,
                labelText: 'Additional treatment',
                hintText:
                    'Enter a treatment: e.g. "formalin", "alcohol", etc."',
                isLastField: false,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Date taken',
                  hintText: 'Enter date',
                ),
                controller: partCtr.dateTakenCtr,
                onTap: () async {
                  final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());

                  if (selectedDate != null) {
                    partCtr.dateTakenCtr.text =
                        DateFormat.yMMMd().format(selectedDate);
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Time taken',
                  hintText: 'Enter time',
                ),
                controller: partCtr.timeTakenCtr,
                onTap: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((time) {
                    if (time != null) {
                      partCtr.timeTakenCtr.text = time.format(context);
                    }
                  });
                },
              ),
              CommonTextField(
                controller: partCtr.museumPermanentCtr,
                labelText: 'Museum permanent',
                hintText: 'Enter a museum name or abbreviation',
                isLastField: false,
              ),
              CommonTextField(
                controller: partCtr.museumLoanCtr,
                labelText: 'Museum loan',
                hintText: 'Enter a museum name or abbreviation',
                isLastField: false,
              ),
              CommonTextField(
                controller: partCtr.remarkCtr,
                maxLines: 3,
                labelText: 'Remarks',
                hintText: 'Enter a remark specific to this part',
                isLastField: false,
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  SecondaryButton(
                    text: 'Cancel',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 10),
                  PrimaryButton(
                    text: isEditing ? 'Update' : 'Add',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
