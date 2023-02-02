import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/models/form.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/associated_data.dart';

class PartDataForm extends ConsumerStatefulWidget {
  const PartDataForm({
    super.key,
    required this.specimenCtr,
    required this.catalogFmt,
  });

  final SpecimenFormCtrModel specimenCtr;
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
                  color: Theme.of(context).colorScheme.tertiary))
        ],
        children: [
          SpecimenPartFields(specimenCtr: widget.specimenCtr),
          const AssociatedDataViewer(),
        ],
      ),
    );
  }
}

class SpecimenPartFields extends ConsumerWidget {
  const SpecimenPartFields({super.key, required this.specimenCtr});

  final SpecimenFormCtrModel specimenCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TitleForm(text: 'Specimen Parts'),
        const Expanded(child: PartList()),
        PrimaryButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PartForms(
                    specimenCtr: specimenCtr,
                  );
                });
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

class PartForms extends ConsumerWidget {
  const PartForms({Key? key, required this.specimenCtr}) : super(key: key);

  final SpecimenFormCtrModel specimenCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Date taken',
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
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Time taken',
              hintText: 'Enter time',
            ),
            controller: specimenCtr.prepTimeCtr,
            onTap: () {
              showTimePicker(context: context, initialTime: TimeOfDay.now())
                  .then((time) {
                if (time != null) {
                  specimenCtr.prepTimeCtr.text = time.format(context);
                }
              });
            },
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
