import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

class MammalMeasurementForms extends ConsumerStatefulWidget {
  const MammalMeasurementForms(
      {Key? key, required this.useHorizontalLayout, required this.isBats})
      : super(key: key);

  final bool useHorizontalLayout;
  final bool isBats;

  @override
  MammalMeasurementFormsState createState() => MammalMeasurementFormsState();
}

class MammalMeasurementFormsState
    extends ConsumerState<MammalMeasurementForms> {
  SpecimenSex _specimenSex = SpecimenSex.unknown;

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
                labelText: 'Total length (mm)',
                hintText: 'Enter TTL',
                isLastField: false,
              ),
              NumberOnlyField(
                labelText: 'Tail length (mm)',
                hintText: 'Enter TL',
                isLastField: false,
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: const [
              NumberOnlyField(
                labelText: 'Hind foot length (mm)',
                hintText: 'Enter HF length',
                isLastField: false,
              ),
              NumberOnlyField(
                labelText: 'Ear length (mm)',
                hintText: 'Enter ER length',
                isLastField: false,
              ),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              const NumberOnlyField(
                labelText: 'Weight (grams)',
                hintText: 'Enter specimen weight',
                isLastField: false,
              ),
              Visibility(
                visible: widget.isBats,
                child: const NumberOnlyField(
                  labelText: 'Forearm Length (mm)',
                  hintText: 'Enter FL length',
                  isLastField: true,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Accuracy',
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
                    labelText: 'Age',
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
          MaleGonadForm(
            specimenSex: _specimenSex,
            useHorizontalLayout: widget.useHorizontalLayout,
          ),
          FemaleGonadForm(
            specimenSex: _specimenSex,
            useHorizontalLayout: widget.useHorizontalLayout,
          ),
          const Padding(
            padding: EdgeInsets.all(5),
            child: CustomTextField(
              maxLines: 5,
              labelText: 'Remarks',
              hintText: 'Write notes about the measurements (optional)',
              isLastField: true,
            ),
          ),
        ],
      ),
    );
  }
}

class MaleGonadForm extends StatefulWidget {
  const MaleGonadForm({
    super.key,
    required this.specimenSex,
    required this.useHorizontalLayout,
  });

  final SpecimenSex specimenSex;
  final bool useHorizontalLayout;

  @override
  State<MaleGonadForm> createState() => _MaleGonadFormState();
}

class _MaleGonadFormState extends State<MaleGonadForm> {
  bool _isScrotal = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.specimenSex == SpecimenSex.male,
      child: Column(
        children: [
          const Divider(),
          Text('Testes', style: Theme.of(context).textTheme.titleMedium),
          Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Position',
                hintText: 'Select testis position',
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
              },
            ),
          ),
          ScrotalMaleForm(
            visible: _isScrotal,
            useHorizontalLayout: widget.useHorizontalLayout,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Epididymis',
                hintText: 'Select epididymis appearance',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Tubular',
                  child: Text('Tubular'),
                ),
                DropdownMenuItem(
                  value: 'Partial',
                  child: Text('Partial'),
                ),
                DropdownMenuItem(
                  value: 'Not tubular',
                  child: Text('Not tubular'),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class ScrotalMaleForm extends StatelessWidget {
  const ScrotalMaleForm(
      {super.key, required this.visible, required this.useHorizontalLayout});

  final bool visible;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visible,
        child: AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: const [
            NumberOnlyField(
              labelText: 'Length (mm)',
              hintText: 'Enter the length of the right testes ',
              isLastField: false,
            ),
            NumberOnlyField(
              labelText: 'Width (mm)',
              hintText: 'Enter the width of the right testes ',
              isLastField: true,
            ),
          ],
        ));
  }
}

class FemaleGonadForm extends StatefulWidget {
  const FemaleGonadForm({
    super.key,
    required this.specimenSex,
    required this.useHorizontalLayout,
  });

  final SpecimenSex specimenSex;
  final bool useHorizontalLayout;
  @override
  State<FemaleGonadForm> createState() => _FemaleGonadFormState();
}

class _FemaleGonadFormState extends State<FemaleGonadForm> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.specimenSex == SpecimenSex.female,
      child: Column(
        children: [
          const Divider(),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Vagina',
                  hintText: 'Select vagina condition',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Imperforate',
                    child: Text('Imperforate'),
                  ),
                  DropdownMenuItem(
                    value: 'Perforate',
                    child: Text('Perforate'),
                  ),
                ],
                onChanged: (String? newValue) {},
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Pubic symphysis',
                  hintText: 'Select pubic symphysis condition',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Closed',
                    child: Text('Closed'),
                  ),
                  DropdownMenuItem(
                    value: 'Small open',
                    child: Text('Small open'),
                  ),
                  DropdownMenuItem(
                    value: 'Open',
                    child: Text('Open'),
                  ),
                ],
                onChanged: (String? newValue) {},
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Reproductive stage',
                  hintText: 'Select reproductive stage',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Nulliparous',
                    child: Text('Nulliparous'),
                  ),
                  DropdownMenuItem(
                    value: 'Primiparous',
                    child: Text('Primiparous'),
                  ),
                  DropdownMenuItem(
                    value: 'Multiparous',
                    child: Text('Multiparous'),
                  ),
                ],
                onChanged: (String? newValue) {},
              ),
              Text('Mammae Counts',
                  style: Theme.of(context).textTheme.titleMedium),
              MammaeForm(useHorizontalLayout: widget.useHorizontalLayout),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Mammae condition',
                  hintText: 'Select mammae condition',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Small',
                    child: Text('Small'),
                  ),
                  DropdownMenuItem(
                    value: 'Large',
                    child: Text('Large'),
                  ),
                  DropdownMenuItem(
                    value: 'Lactating',
                    child: Text('Lactating'),
                  ),
                ],
                onChanged: (String? newValue) {},
              ),
              Text(
                'Embryo',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              EmbryoForm(
                useHorizontalLayout: widget.useHorizontalLayout,
              ),
              const NumberOnlyField(
                labelText: 'CR length (mm)',
                hintText: 'Enter crown-rump length',
                isLastField: true,
              ),
              Text('Placental Scars',
                  style: Theme.of(context).textTheme.titleMedium),
              PlacentalScarForm(
                useHorizontalLayout: widget.useHorizontalLayout,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MammaeForm extends StatelessWidget {
  const MammaeForm({super.key, required this.useHorizontalLayout});

  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
        useHorizontalLayout: useHorizontalLayout,
        children: const [
          NumberOnlyField(
            labelText: 'Axillary',
            hintText: 'Enter the axillary pair number',
            isLastField: false,
          ),
          NumberOnlyField(
            labelText: 'Abdominal',
            hintText: 'Enter the abdominal pair number',
            isLastField: false,
          ),
          NumberOnlyField(
            labelText: 'Inguinal',
            hintText: 'Enter the inguinal pair number',
            isLastField: false,
          ),
        ]);
  }
}

class EmbryoForm extends StatelessWidget {
  const EmbryoForm({super.key, required this.useHorizontalLayout});

  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
        useHorizontalLayout: useHorizontalLayout,
        children: const [
          NumberOnlyField(
              labelText: 'Left', hintText: 'Left', isLastField: false),
          NumberOnlyField(
              labelText: 'Right', hintText: 'Right', isLastField: true),
        ]);
  }
}

class PlacentalScarForm extends StatelessWidget {
  const PlacentalScarForm({super.key, required this.useHorizontalLayout});

  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
        useHorizontalLayout: useHorizontalLayout,
        children: const [
          NumberOnlyField(
              labelText: 'Left', hintText: 'Left', isLastField: false),
          NumberOnlyField(
              labelText: 'Right', hintText: 'Right', isLastField: true),
        ]);
  }
}
