import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/associated_data.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/utility_services.dart';

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
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      child: MediaTabBars(
        tabController: _tabController,
        length: _length,
        height: MediaQuery.of(context).size.height * 0.5,
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const TitleForm(text: 'Specimen Parts'),
        Flexible(
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
              title: PartTitle(
                partType: part.type,
                partCount: part.count.toString(),
                barcodeID: part.barcodeID ?? '',
              ),
              subtitle: PartSubTitle(part: part),
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

class PartTitle extends StatelessWidget {
  const PartTitle({
    super.key,
    required this.partType,
    required this.partCount,
    required this.barcodeID,
  });

  final String? partType;
  final String? partCount;
  final String barcodeID;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${partType ?? 'Unknown part'}'
          '$listTileSeparator'
          '${partCount ?? 'No count'}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        barcodeID.isNotEmpty
            ? BarcodeText(barcodeID: barcodeID)
            : const SizedBox.shrink(),
      ],
    );
  }
}

class BarcodeText extends StatelessWidget {
  const BarcodeText({
    super.key,
    required this.barcodeID,
  });

  final String? barcodeID;

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        const WidgetSpan(
            child: TileIcon(icon: MdiIcons.barcode),
            alignment: PlaceholderAlignment.middle),
        const TextSpan(text: ' '),
        TextSpan(
          text: barcodeIDText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ]),
    );
  }

  String get barcodeIDText {
    if (barcodeID == null) {
      return '';
    } else if (barcodeID!.isEmpty) {
      return '';
    } else {
      return '$barcodeID';
    }
  }
}

class PartSubTitle extends StatelessWidget {
  const PartSubTitle({super.key, required this.part});

  final SpecimenPartData part;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_getTextFirst(part.tissueID)}'
      '$treatment'
      '${_getText(part.additionalTreatment)}'
      '${_getText(part.dateTaken)}'
      '${_getText(part.timeTaken)}'
      '$remark',
      style: Theme.of(context).textTheme.bodyMedium,
      overflow: TextOverflow.ellipsis,
    );
  }

  String _getTextFirst(String? text) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return '';
    } else {
      return '$text$listTileSeparator';
    }
  }

  String get treatment {
    if (part.treatment == null) {
      return 'None';
    } else if (part.treatment!.isEmpty) {
      return 'None';
    } else {
      return '${part.treatment}';
    }
  }

  String _getText(String? text) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return '';
    } else {
      return '$listTileSeparator$text';
    }
  }

  String get remark {
    if (part.remark == null) {
      return '';
    } else if (part.remark!.isEmpty) {
      return '';
    } else {
      return '${listTileSeparator}has remark';
    }
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
  bool _showMore = false;

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
            AdditionalPartFields(visible: _showMore, partCtr: widget.partCtr),
            TextButton(
              onPressed: () {
                setState(() {
                  _showMore = !_showMore;
                });
              },
              child: Text(_showMore ? 'Show less' : 'Show more'),
            ),
            const SizedBox(height: 10),
            FormButtonWithDelete(
              isEditing: widget.isEditing,
              onDeleted: () {
                if (widget.specimenPartId != null) {
                  SpecimenServices(ref)
                      .deleteSpecimenPart(widget.specimenPartId!);
                  Navigator.pop(context);
                }
              },
              onSubmitted: () {
                widget.isEditing ? _updatePart() : _createPart();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
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

class AdditionalPartFields extends StatelessWidget {
  const AdditionalPartFields({
    super.key,
    required this.visible,
    required this.partCtr,
  });

  final bool visible;
  final PartFormCtrModel partCtr;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Column(children: [
        CommonTextField(
          controller: partCtr.additionalTreatmentCtr,
          labelText: 'Additional treatment',
          hintText: 'Enter a treatment: e.g. "formalin", "alcohol", etc."',
          isLastField: false,
        ),
        CommonDateField(
          labelText: 'Date taken',
          hintText: 'Enter date',
          controller: partCtr.dateTakenCtr,
          initialDate: DateTime.now(),
          lastDate: DateTime.now(),
          onTap: () {},
        ),
        CommonTimeField(
          labelText: 'Time taken',
          hintText: 'Enter time',
          controller: partCtr.timeTakenCtr,
          initialTime: TimeOfDay.now(),
          onTap: () {},
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
        )
      ]),
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
          color: Theme.of(context).dividerColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Text(
          'Additional Part ID',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        TissueIDform(
          specimenUuid: specimenUuid,
          partCtr: partCtr,
        ),
        CommonTextField(
            controller: partCtr.barcodeIdCtr,
            labelText: 'Barcode ID',
            hintText: 'Enter barcode ID (if applicable)',
            isLastField: false),
      ]),
    );
  }
}

class TissueIDform extends ConsumerWidget {
  const TissueIDform({
    super.key,
    required this.specimenUuid,
    required this.partCtr,
  });

  final String specimenUuid;
  final PartFormCtrModel partCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            controller: partCtr.tissueIdCtr,
            decoration: InputDecoration(
                labelText: 'Tissue ID',
                hintText: 'Enter tissue ID',
                suffix: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.repeat_rounded,
                  ),
                )),
            textInputAction: TextInputAction.done,
          ),
        ),
        const TissueIDMenu(),
      ],
    );
  }
}

class TissueIDMenu extends StatefulWidget {
  const TissueIDMenu({super.key});

  @override
  State<TissueIDMenu> createState() => _TissueIDMenuState();
}

class _TissueIDMenuState extends State<TissueIDMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(itemBuilder: (BuildContext context) {
      return [
        const PopupMenuItem(
            value: 1,
            child: ListTile(
              leading: Icon(Icons.add_rounded),
              title: Text('New number'),
            )),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 2,
          child: ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
          ),
        ),
      ];
    });
  }
}
