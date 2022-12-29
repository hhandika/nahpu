import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/controller/updaters.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/models/types.dart';
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
  bool _isScrotal = false;

  final BirdMeasurementCtrModel birdMeasurementCtrModel =
      BirdMeasurementCtrModel.empty();

  @override
  Widget build(BuildContext context) {
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
              ),
              NumberOnlyField(
                controller: birdMeasurementCtrModel.wingspanCtr,
                labelText: 'Wingspan (mm)',
                hintText: 'Enter TL',
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
              ),
              CustomTextField(
                controller: birdMeasurementCtrModel.billCtr,
                labelText: 'Bill color',
                hintText: 'Enter bill color',
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
              ),
              CustomTextField(
                controller: birdMeasurementCtrModel.tarsusCtr,
                labelText: 'Tarsus color',
                hintText: 'Enter foot color',
              ),
            ],
          ),
          const Divider(),
          Text('Molt', style: Theme.of(context).textTheme.titleMedium),
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
              ),
              CustomTextField(
                controller: birdMeasurementCtrModel.tailMoltCtr,
                labelText: 'Tail',
                hintText: 'Enter tail molt',
              ),
            ],
          ),
          const Divider(),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              CustomTextField(
                controller: birdMeasurementCtrModel.bodyMoltCtr,
                labelText: 'Body',
                hintText: 'Enter body molt',
              ),
              NumberOnlyField(
                controller: birdMeasurementCtrModel.bursaCtr,
                labelText: 'Bursa (mm)',
                hintText: 'Enter tail molt',
              ),
              CustomTextField(
                  controller: birdMeasurementCtrModel.skullOssCtr,
                  labelText: 'Skull ossification (%)',
                  hintText: 'Enter percentage')
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              CustomTextField(
                controller: birdMeasurementCtrModel.fatCtr,
                labelText: 'Fat',
                hintText: 'Enter fat',
              ),
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
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: CustomTextField(
              controller: birdMeasurementCtrModel.gonadCtr,
              labelText: 'Gonads',
              hintText: 'Enter gonads',
            ),
          ),
          Visibility(
            visible: _specimenSex == SpecimenSex.male,
            child: AdaptiveLayout(
              useHorizontalLayout: widget.useHorizontalLayout,
              children: [
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Testes Position',
                      hintText: 'Select specimen age',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Scrotal',
                        child: Text('Scrotal'),
                      ),
                      DropdownMenuItem(
                        value: 'Abdominal',
                        child: Text('Abdominal'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        _isScrotal = newValue == 'Scrotal';
                      });
                    }),
                CustomTextField(
                  controller: birdMeasurementCtrModel.testisCtr,
                  enabled: _isScrotal,
                  labelText: 'Testes size (L x W mm)',
                  hintText: 'Enter length and width of the right testes ',
                ),
              ],
            ),
          ),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Stomach contents',
              hintText: 'Enter stomach contents',
            ),
          ),
        ],
      ),
    );
  }
}
