import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

class BirdMeasurementForms extends ConsumerStatefulWidget {
  const BirdMeasurementForms({Key? key, required this.useHorizontalLayout})
      : super(key: key);

  final bool useHorizontalLayout;

  @override
  BirdMeasurementFormsState createState() => BirdMeasurementFormsState();
}

class BirdMeasurementFormsState extends ConsumerState<BirdMeasurementForms> {
  SpecimenSex _specimenSex = SpecimenSex.unknown;
  bool _isScrotal = false;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Measurements',
      child: Column(
        children: [
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: const [
              NumberOnlyField(
                labelText: 'Weight (grams)',
                hintText: 'Enter weight',
              ),
              NumberOnlyField(
                labelText: 'Wingspan (mm)',
                hintText: 'Enter TL',
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: const [
              CustomTextField(
                labelText: 'Iris color',
                hintText: 'Enter iris color',
              ),
              CustomTextField(
                labelText: 'Bill color',
                hintText: 'Enter bill color',
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: const [
              CustomTextField(
                labelText: 'Foot color',
                hintText: 'Enter foot color',
              ),
              CustomTextField(
                labelText: 'Tarsus color',
                hintText: 'Enter foot color',
              ),
            ],
          ),
          const Divider(),
          Text('Molt', style: Theme.of(context).textTheme.titleMedium),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: const [
              CustomTextField(
                labelText: 'Wing',
                hintText: 'Enter wing molt',
              ),
              CustomTextField(
                labelText: 'Tail',
                hintText: 'Enter tail molt',
              ),
            ],
          ),
          const Divider(),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: const [
              CustomTextField(
                labelText: 'Body',
                hintText: 'Enter body fat',
              ),
              NumberOnlyField(
                labelText: 'Bursa (mm)',
                hintText: 'Enter tail molt',
              ),
              CustomTextField(
                  labelText: 'Skull ossification (%)',
                  hintText: 'Enter percentage')
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              const CustomTextField(
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
          const Padding(
            padding: EdgeInsets.all(5),
            child: CustomTextField(
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
