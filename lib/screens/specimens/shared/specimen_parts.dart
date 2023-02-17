import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/associated_data.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/specimen_services.dart';

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
        Expanded(
          child: PartList(
            specimenUuid: specimenUuid,
          ),
        ),
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
  const PartList({
    super.key,
    required this.specimenUuid,
  });

  final String specimenUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specimenPartList = ref.watch(partBySpecimenProvider(specimenUuid));
    return specimenPartList.when(
      data: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final part = data[index];
            return ListTile(
              title: Text(part.type ?? 'No type'),
              subtitle: Text('Count: ${part.count.toString()}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditPart(
                        specimenUuid: specimenUuid,
                        specimenPartId: part.id,
                        partCtr: PartFormCtrModel.fromData(part),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
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
        child: PartForm(
          specimenUuid: specimenUuid,
          specimenPartId: null,
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
    required this.specimenPartId,
    required this.partCtr,
  });

  final String specimenUuid;
  final int? specimenPartId;
  final PartFormCtrModel partCtr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit specimen parts'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: PartForm(
          specimenUuid: specimenUuid,
          specimenPartId: specimenPartId,
          partCtr: partCtr,
          isEditing: true,
        ),
      ),
    );
  }
}

class PartForm extends ConsumerStatefulWidget {
  const PartForm({
    super.key,
    required this.specimenUuid,
    required this.specimenPartId,
    required this.partCtr,
    this.isEditing = false,
  });

  final String specimenUuid;
  final int? specimenPartId;
  final PartFormCtrModel partCtr;
  final bool isEditing;

  @override
  PartFormState createState() => PartFormState();
}

class PartFormState extends ConsumerState<PartForm> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PartIdForm(
              specimenUuid: widget.specimenUuid,
              partCtr: widget.partCtr,
            ),
            CommonTextField(
              controller: widget.partCtr.typeCtr,
              labelText: 'Preparation type',
              hintText: 'Enter prep type: e.g. "skin", "liver", etc."',
              isLastField: false,
            ),
            CommonNumField(
              controller: widget.partCtr.countCtr,
              labelText: 'Counts',
              hintText: 'Enter part counts',
              isLastField: false,
            ),
            CommonTextField(
              controller: widget.partCtr.treatmentCtr,
              labelText: 'Treatment',
              hintText: 'Enter a treatment: e.g. "formalin", "alcohol", etc."',
              isLastField: false,
            ),
            CommonTextField(
              controller: widget.partCtr.additionalTreatmentCtr,
              labelText: 'Additional treatment',
              hintText: 'Enter a treatment: e.g. "formalin", "alcohol", etc."',
              isLastField: false,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Date taken',
                hintText: 'Enter date',
              ),
              controller: widget.partCtr.dateTakenCtr,
              onTap: () async {
                final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now());

                if (selectedDate != null) {
                  widget.partCtr.dateTakenCtr.text =
                      DateFormat.yMMMd().format(selectedDate);
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Time taken',
                hintText: 'Enter time',
              ),
              controller: widget.partCtr.timeTakenCtr,
              onTap: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((time) {
                  if (time != null) {
                    widget.partCtr.timeTakenCtr.text = time.format(context);
                  }
                });
              },
            ),
            CommonTextField(
              controller: widget.partCtr.museumPermanentCtr,
              labelText: 'Museum permanent',
              hintText: 'Enter a museum name or abbreviation',
              isLastField: false,
            ),
            CommonTextField(
              controller: widget.partCtr.museumLoanCtr,
              labelText: 'Museum loan',
              hintText: 'Enter a museum name or abbreviation',
              isLastField: false,
            ),
            CommonTextField(
              controller: widget.partCtr.remarkCtr,
              maxLines: 3,
              labelText: 'Remarks',
              hintText: 'Enter a remark specific to this part',
              isLastField: false,
            ),
            const SizedBox(height: 10),
            widget.isEditing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (widget.specimenPartId != null) {
                              SpecimenServices(ref)
                                  .deleteSpecimenPart(widget.specimenPartId!);
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.delete_rounded)),
                      _buildButtons(),
                    ],
                  )
                : _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Wrap(
      children: [
        SecondaryButton(
          text: 'Cancel',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(width: 10),
        PrimaryButton(
          text: widget.isEditing ? 'Update' : 'Add',
          onPressed: () {
            widget.isEditing ? _updatePart() : _createPart();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future<void> _createPart() async {
    SpecimenPartCompanion form = _getForm();

    await SpecimenServices(ref).createSpecimenPart(form);
  }

  Future<void> _updatePart() async {
    SpecimenPartCompanion form = _getForm();

    await SpecimenServices(ref)
        .updateSpecimenPart(widget.specimenPartId!, form);
  }

  SpecimenPartCompanion _getForm() {
    return SpecimenPartCompanion(
      specimenUuid: db.Value(widget.specimenUuid),
      tissueID: db.Value(widget.partCtr.tissueIdCtr.text),
      barcodeID: db.Value(widget.partCtr.barcodeIdCtr.text),
      type: db.Value(widget.partCtr.typeCtr.text),
      count: db.Value(widget.partCtr.countCtr.text),
      treatment: db.Value(widget.partCtr.treatmentCtr.text),
      additionalTreatment: db.Value(widget.partCtr.additionalTreatmentCtr.text),
      dateTaken: db.Value(widget.partCtr.dateTakenCtr.text),
      timeTaken: db.Value(widget.partCtr.timeTakenCtr.text),
      museumPermanent: db.Value(widget.partCtr.museumPermanentCtr.text),
      museumLoan: db.Value(widget.partCtr.museumLoanCtr.text),
      remark: db.Value(widget.partCtr.remarkCtr.text),
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
          'Additional Part ID',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        CommonTextField(
            controller: partCtr.tissueIdCtr,
            labelText: 'Tissue ID',
            hintText: 'Enter tissue ID (if applicable)',
            isLastField: false),
        CommonTextField(
            controller: partCtr.barcodeIdCtr,
            labelText: 'Barcode ID',
            hintText: 'Enter barcode ID (if applicable)',
            isLastField: false),
      ]),
    );
  }
}
