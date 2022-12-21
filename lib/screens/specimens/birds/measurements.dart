import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
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
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Total length (mm)',
                  hintText: 'Enter TTL',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tail length (mm)',
                  hintText: 'Enter TL',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Hind foot length (mm)',
                  hintText: 'Enter HF length',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ear length (mm)',
                  hintText: 'Enter ER length',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Weight (grams)',
                  hintText: 'Enter specimen weight',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Measurement accuracy',
                  hintText: 'Select measurement accuracy',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Accurate',
                    child: Text('Accurate'),
                  ),
                  DropdownMenuItem(
                    value: 'Tail cropped',
                    child: Text('Tail cropped'),
                  ),
                  DropdownMenuItem(
                    value: 'Partially eaten',
                    child: Text('Partially eaten'),
                  ),
                ],
                onChanged: (String? newValue) {}),
          ),
          Divider(
            color: Theme.of(context).dividerColor,
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
                  }),
              DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Life stage',
                    hintText: 'Select specimen age',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Adult',
                      child: Text('Adult'),
                    ),
                    DropdownMenuItem(
                      value: 'Subadult',
                      child: Text('Subadult'),
                    ),
                    DropdownMenuItem(
                      value: 'Juvenile',
                      child: Text('Juvenile'),
                    ),
                    DropdownMenuItem(
                      value: 'Unknown',
                      child: Text('Unknown'),
                    ),
                  ],
                  onChanged: (String? newValue) {}),
            ],
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
                TextFormField(
                  enabled: _isScrotal,
                  decoration: const InputDecoration(
                    labelText: 'Testes size (L x W mm)',
                    hintText: 'Enter length and width of the right testes ',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          TextFormField(
            enabled: false,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Measurements notes',
              hintText: 'Write any notes about the measurements (optional)',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
