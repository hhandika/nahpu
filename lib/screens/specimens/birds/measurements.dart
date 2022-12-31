import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/controller/updaters.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database.dart';
import 'package:drift/drift.dart' as db;

class BirdMeasurementForms extends ConsumerStatefulWidget {
  const BirdMeasurementForms(
      {Key? key, required this.useHorizontalLayout, required this.specimenUuid})
      : super(key: key);

  final bool useHorizontalLayout;
  final String specimenUuid;

  @override
  BirdMeasurementFormsState createState() => BirdMeasurementFormsState();
}

class BirdMeasurementFormsState extends ConsumerState<BirdMeasurementForms> {
  SpecimenSex _specimenSex = SpecimenSex.unknown;
  bool _molting = false;

  final BirdMeasurementCtrModel birdMeasurementCtrModel =
      BirdMeasurementCtrModel.empty();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateController();
    return FormCard(
      title: 'Measurements',
      child: Column(
        children: [
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              NumberOnlyField(
                controller: birdMeasurementCtrModel.weightCtr,
                labelText: 'Weight (grams)',
                hintText: 'Enter weight',
                isLastField: false,
              ),
              NumberOnlyField(
                controller: birdMeasurementCtrModel.wingspanCtr,
                labelText: 'Wingspan (mm)',
                hintText: 'Enter TL',
                isLastField: false,
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              CustomTextField(
                controller: birdMeasurementCtrModel.irisCtr,
                labelText: 'Iris color',
                hintText: 'Enter iris color',
                isLastField: false,
              ),
              CustomTextField(
                controller: birdMeasurementCtrModel.billCtr,
                labelText: 'Bill color',
                hintText: 'Enter bill color',
                isLastField: false,
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              CustomTextField(
                controller: birdMeasurementCtrModel.footCtr,
                labelText: 'Foot color',
                hintText: 'Enter foot color',
                isLastField: false,
              ),
              CustomTextField(
                controller: birdMeasurementCtrModel.tarsusCtr,
                labelText: 'Tarsus color',
                hintText: 'Enter foot color',
                isLastField: true,
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              CustomTextField(
                controller: birdMeasurementCtrModel.wingMoltCtr,
                labelText: 'Wing',
                hintText: 'Enter wing molt',
                onChanged: (newValue) {
                  setState(() {
                    updateBirdMeasurement(
                        widget.specimenUuid,
                        BirdMeasurementCompanion(
                            moltingWing: db.Value(newValue)),
                        ref);
                  });
                },
                isLastField: false,
              ),
              CustomTextField(
                controller: birdMeasurementCtrModel.tailMoltCtr,
                labelText: 'Tail',
                hintText: 'Enter tail molt',
                isLastField: false,
              ),
              CustomTextField(
                controller: birdMeasurementCtrModel.bodyMoltCtr,
                labelText: 'Body',
                hintText: 'Enter body molt',
                isLastField: false,
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Sex',
                  hintText: 'Choose one',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                  DropdownMenuItem(
                    value: 'Unknown',
                    child: Text('Unknown'),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _specimenSex = matchSpecimenSex(newValue);
                  });
                },
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Molting',
                  hintText: 'Choose one',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Yes',
                    child: Text('Yes'),
                  ),
                  DropdownMenuItem(
                    value: 'No',
                    child: Text('No'),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _molting = newValue == 'Yes' ? true : false;
                  });
                },
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Brood patch',
                  hintText: 'Choose one',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Yes',
                    child: Text('Yes'),
                  ),
                  DropdownMenuItem(
                    value: 'No',
                    child: Text('No'),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {});
                },
              ),
            ],
          ),
          const Divider(),
          Text('Gonads', style: Theme.of(context).textTheme.titleLarge),
          MaleGonadForm(
            specimenUuid: widget.specimenUuid,
            useHorizontalLayout: widget.useHorizontalLayout,
            sex: _specimenSex,
          ),
          FemaleGonadForm(
            specimenUuid: widget.specimenUuid,
            useHorizontalLayout: widget.useHorizontalLayout,
            sex: _specimenSex,
          ),
          const Divider(),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              NumberOnlyField(
                controller: birdMeasurementCtrModel.bursaCtr,
                labelText: 'Bursa (mm)',
                hintText: 'Enter tail molt',
                isLastField: false,
              ),
              CustomTextField(
                controller: birdMeasurementCtrModel.skullOssCtr,
                labelText: 'Skull ossification (%)',
                hintText: 'Enter percentage',
                isLastField: false,
              ),
              CustomTextField(
                controller: birdMeasurementCtrModel.fatCtr,
                labelText: 'Fat',
                hintText: 'Enter fat',
                isLastField: false,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: CustomTextField(
              controller: birdMeasurementCtrModel.gonadCtr,
              labelText: 'Gonads',
              hintText: 'Enter gonads',
              isLastField: false,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5),
            child: CustomTextField(
              maxLines: 3,
              labelText: 'Stomach contents',
              hintText: 'Enter stomach contents',
              isLastField: false,
            ),
          )
        ],
      ),
    );
  }

  void _updateController() {
    ref
        .watch(specimenProvider)
        .getBirdMeasurementByUuid(widget.specimenUuid)
        .then(
          (value) => {
            if (value != null)
              {
                birdMeasurementCtrModel.weightCtr.text =
                    value.weight?.toString() ?? '',
                birdMeasurementCtrModel.wingspanCtr.text =
                    value.wingspan?.toString() ?? '',
                birdMeasurementCtrModel.irisCtr.text = value.irisColor ?? '',
                birdMeasurementCtrModel.billCtr.text = value.feetColor ?? '',
              }
          },
        );
  }
}

class MaleGonadForm extends ConsumerWidget {
  const MaleGonadForm({
    super.key,
    required this.specimenUuid,
    required this.useHorizontalLayout,
    required this.sex,
  });

  final String specimenUuid;
  final bool useHorizontalLayout;
  final SpecimenSex sex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: sex == SpecimenSex.male,
      child: const CustomTextField(
        labelText: 'Testes size (L x W mm)',
        hintText: 'Enter length and width of the right testes ',
        isLastField: false,
      ),
    );
  }
}

class FemaleGonadForm extends ConsumerStatefulWidget {
  const FemaleGonadForm({
    super.key,
    required this.specimenUuid,
    required this.useHorizontalLayout,
    required this.sex,
  });

  final String specimenUuid;
  final bool useHorizontalLayout;
  final SpecimenSex sex;

  @override
  FemaleGonadFormState createState() => FemaleGonadFormState();
}

class FemaleGonadFormState extends ConsumerState<FemaleGonadForm> {
  bool _isLargOvum = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.sex == SpecimenSex.female,
      child: Column(
        children: [
          Text(
            'Ovaries',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: const [
              CustomTextField(
                labelText: 'Length (mm)',
                hintText: 'Enter length',
                isLastField: false,
              ),
              CustomTextField(
                labelText: 'Width (mm)',
                hintText: 'Enter width',
                isLastField: false,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Appearance',
                hintText: 'Choose one',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Smooth',
                  child: Text('Smooth'),
                ),
                DropdownMenuItem(
                  value: 'small',
                  child: Text('All ova <1 mm'),
                ),
                DropdownMenuItem(
                  value: 'large',
                  child: Text('At least one ovum >1 mm'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _isLargOvum = newValue == 'large' ? true : false;
                });
              },
            ),
          ),
          Visibility(
            visible: _isLargOvum,
            child: OvumSizeForm(
              useHorizontalLayout: widget.useHorizontalLayout,
            ),
          ),
          Text(
            'Oviduct',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          OviductForm(useHorizontalLayout: widget.useHorizontalLayout),
          const CustomTextField(
            maxLines: 3,
            labelText: 'Remarks',
            hintText: 'Add additional information about the gonads',
            isLastField: true,
          )
        ],
      ),
    );
  }
}

class OvumSizeForm extends StatelessWidget {
  const OvumSizeForm({super.key, required this.useHorizontalLayout});
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Third Largest Ovum Size (mm)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: const [
            NumberOnlyField(
              labelText: 'First',
              hintText: 'Enter size',
              isLastField: false,
            ),
            NumberOnlyField(
              labelText: 'Second',
              hintText: 'Enter size',
              isLastField: false,
            ),
            NumberOnlyField(
              labelText: 'Third',
              hintText: 'Enter size',
              isLastField: false,
            ),
          ],
        )
      ],
    );
  }
}

class OviductForm extends StatelessWidget {
  const OviductForm({super.key, required this.useHorizontalLayout});

  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(useHorizontalLayout: useHorizontalLayout, children: [
      const NumberOnlyField(
        labelText: 'Width (mm)',
        hintText: 'Enter width',
        isLastField: false,
      ),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: 'Appearance',
          hintText: 'Choose one',
        ),
        items: const [
          DropdownMenuItem(
            value: 'Straight',
            child: Text('Straight'),
          ),
          DropdownMenuItem(
            value: 'Convoluted',
            child: Text('Convoluted'),
          ),
        ],
        onChanged: (String? newValue) {},
      ),
    ]);
  }
}
