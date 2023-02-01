import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

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
              CommonNumField(
                controller: birdMeasurementCtrModel.weightCtr,
                labelText: 'Weight (grams)',
                hintText: 'Enter weight',
                isLastField: false,
              ),
              CommonNumField(
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
              CommonTextField(
                controller: birdMeasurementCtrModel.irisCtr,
                labelText: 'Iris color',
                hintText: 'Enter iris color',
                isLastField: false,
              ),
              CommonTextField(
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
              CommonTextField(
                controller: birdMeasurementCtrModel.footCtr,
                labelText: 'Foot color',
                hintText: 'Enter foot color',
                isLastField: false,
              ),
              CommonTextField(
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
              const SkullOssField(),
            ],
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              CommonNumField(
                controller: birdMeasurementCtrModel.bursaCtr,
                labelText: 'Bursa (mm)',
                hintText: 'Enter tail molt',
                isLastField: false,
              ),
              const FatField(),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(5),
            child: CommonTextField(
              maxLines: 3,
              labelText: 'Stomach contents',
              hintText: 'Enter stomach contents',
              isLastField: false,
            ),
          ),
          const Divider(),
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
          MoltingForm(
            useHorizontalLayout: widget.useHorizontalLayout,
            visible: _molting,
          ),
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
        child: Column(
          children: [
            Text('Male Gonads', style: Theme.of(context).textTheme.titleLarge),
            Text('Testis size (mm)',
                style: Theme.of(context).textTheme.titleSmall),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: const [
                CommonNumField(
                  labelText: 'Length',
                  hintText: 'Enter length',
                  isLastField: false,
                ),
                CommonNumField(
                  labelText: 'Width',
                  hintText: 'Enter width',
                  isLastField: false,
                ),
              ],
            ),
            // Remarks
            const Padding(
              padding: EdgeInsets.all(5),
              child: CommonTextField(
                maxLines: 3,
                labelText: 'Remarks',
                hintText: 'Enter remarks',
                isLastField: false,
              ),
            ),
          ],
        ));
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
          Text('Female Gonads', style: Theme.of(context).textTheme.titleLarge),
          Text(
            'Ovaries',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: const [
              CommonTextField(
                labelText: 'Length (mm)',
                hintText: 'Enter length',
                isLastField: false,
              ),
              CommonTextField(
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
          const Padding(
            padding: EdgeInsets.all(5),
            child: CommonTextField(
              maxLines: 3,
              labelText: 'Remarks',
              hintText: 'Add additional information about the gonads',
              isLastField: true,
            ),
          )
        ],
      ),
    );
  }
}

class SkullOssField extends StatelessWidget {
  const SkullOssField({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> skullOss = [5, 10, 25, 50, 75, 90, 95, 99];
    return DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: 'Skull ossification (%)',
          hintText: 'Enter percentage',
        ),
        items: skullOss.reversed
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text('$e %'),
                ))
            .toList(),
        onChanged: (int? newValue) {});
  }
}

class FatField extends StatelessWidget {
  const FatField({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> fatClass = [
      'No fat',
      'Trace',
      'Light',
      'Moderate',
      'Heavy',
      'Extremely heavy'
    ];
    return DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: 'Fat',
          hintText: 'Enter amount of fat',
        ),
        items: fatClass
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (String? newValue) {});
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
          'The Size of Three Largest Ova (mm)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: const [
            CommonNumField(
              labelText: 'First',
              hintText: 'Enter size',
              isLastField: false,
            ),
            CommonNumField(
              labelText: 'Second',
              hintText: 'Enter size',
              isLastField: false,
            ),
            CommonNumField(
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
      const CommonNumField(
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

class MoltingForm extends StatelessWidget {
  const MoltingForm({
    super.key,
    required this.useHorizontalLayout,
    required this.visible,
  });

  final bool useHorizontalLayout;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Column(
        children: [
          Text(
            'Molt',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          WingMoltForm(useHorizontalLayout: useHorizontalLayout),
          TailMoltForm(useHorizontalLayout: useHorizontalLayout),
          const BodyMoltForm(),
          const Padding(
            padding: EdgeInsets.all(5),
            child: CommonTextField(
              maxLines: 3,
              labelText: 'Remarks',
              hintText: 'Add additional information about the molting',
              isLastField: true,
            ),
          )
        ],
      ),
    );
  }
}

class WingMoltForm extends StatelessWidget {
  const WingMoltForm({
    super.key,
    required this.useHorizontalLayout,
  });

  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Wing Molt',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: const [
            CommonNumField(
              labelText: 'Right primaries',
              hintText: 'Enter right primaries molt',
              isLastField: false,
            ),
            CommonNumField(
              labelText: 'Left primaries',
              hintText: 'Enter left primaries molt',
              isLastField: false,
            ),
          ],
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: const [
            CommonNumField(
              labelText: 'Right secondaries',
              hintText: 'Enter right secondaries molt',
              isLastField: false,
            ),
            CommonNumField(
              labelText: 'Left secondaries',
              hintText: 'Enter left secondaries molt',
              isLastField: false,
            ),
          ],
        ),
      ],
    );
  }
}

class TailMoltForm extends StatelessWidget {
  const TailMoltForm({
    super.key,
    required this.useHorizontalLayout,
  });

  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Tail Molt',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: const [
            CommonNumField(
              labelText: 'Right rectrices',
              hintText: 'Enter right rectrices molt',
              isLastField: false,
            ),
            CommonNumField(
              labelText: 'Left retrices',
              hintText: 'Enter left retrices molt',
              isLastField: false,
            ),
          ],
        ),
      ],
    );
  }
}

class BodyMoltForm extends StatelessWidget {
  const BodyMoltForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: 'Body Molt',
          hintText: 'Choose one',
        ),
        items: const [
          DropdownMenuItem(
            value: 'Trace',
            child: Text('Trace'),
          ),
          DropdownMenuItem(
            value: 'Moderate',
            child: Text('Moderate'),
          ),
          DropdownMenuItem(
            value: 'Heavy',
            child: Text('Heavy'),
          ),
        ],
        onChanged: (String? newValue) {},
      ),
    );
  }
}
