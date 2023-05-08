import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/birds.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/shared/measurements.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';
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
  bool _molting = false;

  BirdMeasurementCtrModel ctr = BirdMeasurementCtrModel.empty();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCtr(widget.specimenUuid);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MeasurementForm(
      children: [
        AdaptiveLayout(
          useHorizontalLayout: widget.useHorizontalLayout,
          children: [
            CommonNumField(
              controller: ctr.weightCtr,
              labelText: 'Weight (grams)',
              hintText: 'Enter weight',
              isDouble: true,
              isLastField: false,
              onChanged: (String? value) {
                if (value != null && value.isNotEmpty) {
                  final double weight = double.tryParse(value) ?? 0.0;
                  SpecimenServices(ref).updateBirdMeasurement(
                    widget.specimenUuid,
                    BirdMeasurementCompanion(
                      weight: db.Value(weight),
                    ),
                  );
                }
              },
            ),
            CommonNumField(
              controller: ctr.wingspanCtr,
              labelText: 'Wingspan (mm)',
              hintText: 'Enter wingspan length',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null && value.isNotEmpty) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    widget.specimenUuid,
                    BirdMeasurementCompanion(
                      wingspan: db.Value(int.tryParse(value) ?? 0),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        AdaptiveLayout(
          useHorizontalLayout: widget.useHorizontalLayout,
          children: [
            CommonTextField(
              controller: ctr.irisCtr,
              labelText: 'Iris color',
              hintText: 'Enter iris color',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null && value.isNotEmpty) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    widget.specimenUuid,
                    BirdMeasurementCompanion(
                      irisColor: db.Value(value),
                    ),
                  );
                }
              },
            ),
            CommonTextField(
              controller: ctr.billCtr,
              labelText: 'Bill color',
              hintText: 'Enter bill color',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null && value.isNotEmpty) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    widget.specimenUuid,
                    BirdMeasurementCompanion(
                      billColor: db.Value(value),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        AdaptiveLayout(
          useHorizontalLayout: widget.useHorizontalLayout,
          children: [
            CommonTextField(
              controller: ctr.footCtr,
              labelText: 'Foot color',
              hintText: 'Enter foot color',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null && value.isNotEmpty) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    widget.specimenUuid,
                    BirdMeasurementCompanion(
                      footColor: db.Value(value),
                    ),
                  );
                }
              },
            ),
            CommonTextField(
              controller: ctr.tarsusCtr,
              labelText: 'Tarsus color',
              hintText: 'Enter foot color',
              isLastField: true,
              onChanged: (String? value) {
                if (value != null && value.isNotEmpty) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    widget.specimenUuid,
                    BirdMeasurementCompanion(
                      tarsusColor: db.Value(value),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        AdaptiveLayout(
          useHorizontalLayout: widget.useHorizontalLayout,
          children: [
            DropdownButtonFormField<SpecimenSex>(
              value: getSpecimenSex(ctr.sexCtr),
              decoration: const InputDecoration(
                labelText: 'Sex',
                hintText: 'Choose one',
              ),
              items: specimenSexList
                  .map((e) => DropdownMenuItem(
                        value: SpecimenSex.values[specimenSexList.indexOf(e)],
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (SpecimenSex? newValue) {
                if (newValue != null) {
                  setState(() {
                    ctr.sexCtr = newValue.index;
                    SpecimenServices(ref).updateBirdMeasurement(
                        widget.specimenUuid,
                        BirdMeasurementCompanion(
                          sex: db.Value(newValue.index),
                        ));
                  });
                }
              },
            ),
            DropdownButtonFormField<int?>(
              value: ctr.moltCtr,
              decoration: const InputDecoration(
                labelText: 'Molting',
                hintText: 'Choose one',
              ),
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text('Yes'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('No'),
                ),
              ],
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    _molting = newValue == 0 ? true : false;
                    SpecimenServices(ref).updateBirdMeasurement(
                        widget.specimenUuid,
                        BirdMeasurementCompanion(
                          molting: db.Value(newValue),
                        ));
                  });
                }
              },
            ),
          ],
        ),
        AdaptiveLayout(
          useHorizontalLayout: widget.useHorizontalLayout,
          children: [
            DropdownButtonFormField<int?>(
              decoration: const InputDecoration(
                labelText: 'Brood patch',
                hintText: 'Choose one',
              ),
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text('Yes'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('No'),
                ),
              ],
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    SpecimenServices(ref).updateBirdMeasurement(
                        widget.specimenUuid,
                        BirdMeasurementCompanion(
                          broodPatch: db.Value(newValue),
                        ));
                  });
                }
              },
            ),
            SkullOssField(
              specimenUuid: widget.specimenUuid,
              ctr: ctr,
            ),
          ],
        ),
        AdaptiveLayout(
          useHorizontalLayout: widget.useHorizontalLayout,
          children: [
            CommonNumField(
              controller: ctr.bursaCtr,
              labelText: 'Bursa (mm)',
              hintText: 'Enter tail molt',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null && value.isNotEmpty) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    widget.specimenUuid,
                    BirdMeasurementCompanion(
                      bursaLength: db.Value(int.tryParse(value) ?? 0),
                    ),
                  );
                }
              },
            ),
            FatField(
              specimenUuid: widget.specimenUuid,
              ctr: ctr,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: CommonTextField(
            controller: ctr.stomachContentCtr,
            maxLines: 3,
            labelText: 'Stomach contents',
            hintText: 'Enter stomach contents',
            isLastField: false,
            onChanged: (String? value) {
              if (value != null && value.isNotEmpty) {
                SpecimenServices(ref).updateBirdMeasurement(
                  widget.specimenUuid,
                  BirdMeasurementCompanion(
                    stomachContent: db.Value(value),
                  ),
                );
              }
            },
          ),
        ),
        MaleGonadForm(
          specimenUuid: widget.specimenUuid,
          ctr: ctr,
          useHorizontalLayout: widget.useHorizontalLayout,
          sex: getSpecimenSex(ctr.sexCtr),
        ),
        FemaleGonadForm(
          specimenUuid: widget.specimenUuid,
          ctr: ctr,
          useHorizontalLayout: widget.useHorizontalLayout,
          sex: getSpecimenSex(ctr.sexCtr),
        ),
        MoltingForm(
          specimenUuid: widget.specimenUuid,
          ctr: ctr,
          useHorizontalLayout: widget.useHorizontalLayout,
          visible: _molting,
        ),
      ],
    );
  }

  Future<void> _updateCtr(String specimenUuid) async {
    BirdMeasurementData data =
        await SpecimenServices(ref).getBirdMeasurementData(specimenUuid);
    setState(() {
      ctr = BirdMeasurementCtrModel.fromData(data);
    });
  }
}

class MaleGonadForm extends ConsumerWidget {
  const MaleGonadForm({
    super.key,
    required this.specimenUuid,
    required this.useHorizontalLayout,
    required this.ctr,
    required this.sex,
  });

  final String specimenUuid;
  final bool useHorizontalLayout;
  final BirdMeasurementCtrModel ctr;
  final SpecimenSex? sex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
        visible: sex == SpecimenSex.male,
        child: Column(
          children: [
            const CommonDivider(),
            Text('Male Gonads', style: Theme.of(context).textTheme.titleLarge),
            Text('Testis size (mm)',
                style: Theme.of(context).textTheme.titleSmall),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: [
                CommonNumField(
                  controller: ctr.testisLengthCtr,
                  labelText: 'Length',
                  hintText: 'Enter length',
                  isLastField: false,
                  onChanged: (String? value) {
                    if (value != null && value.isNotEmpty) {
                      SpecimenServices(ref).updateBirdMeasurement(
                        specimenUuid,
                        BirdMeasurementCompanion(
                          testisLength: db.Value(int.tryParse(value) ?? 0),
                        ),
                      );
                    }
                  },
                ),
                CommonNumField(
                  controller: ctr.testisWidthCtr,
                  labelText: 'Width',
                  hintText: 'Enter width',
                  isLastField: false,
                  onChanged: (String? value) {
                    if (value != null && value.isNotEmpty) {
                      SpecimenServices(ref).updateBirdMeasurement(
                        specimenUuid,
                        BirdMeasurementCompanion(
                          testisWidth: db.Value(int.tryParse(value) ?? 0),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            // Remarks
            Padding(
              padding: const EdgeInsets.all(5),
              child: CommonTextField(
                controller: ctr.testisRemarkCtr,
                maxLines: 3,
                labelText: 'Remarks',
                hintText: 'Enter remarks',
                isLastField: false,
                onChanged: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    SpecimenServices(ref).updateBirdMeasurement(
                      specimenUuid,
                      BirdMeasurementCompanion(
                        testisRemark: db.Value(value),
                      ),
                    );
                  }
                },
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
    required this.ctr,
    required this.useHorizontalLayout,
    required this.sex,
  });

  final String specimenUuid;
  final BirdMeasurementCtrModel ctr;
  final bool useHorizontalLayout;
  final SpecimenSex? sex;

  @override
  FemaleGonadFormState createState() => FemaleGonadFormState();
}

class FemaleGonadFormState extends ConsumerState<FemaleGonadForm> {
  bool _isLargeOvum = false;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.sex == SpecimenSex.female,
      child: Column(
        children: [
          const CommonDivider(),
          Text('Female Gonads', style: Theme.of(context).textTheme.titleLarge),
          Text(
            'Ovaries',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              CommonTextField(
                controller: widget.ctr.ovaryLengthCtr,
                labelText: 'Length (mm)',
                hintText: 'Enter length',
                isLastField: false,
                onChanged: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    SpecimenServices(ref).updateBirdMeasurement(
                      widget.specimenUuid,
                      BirdMeasurementCompanion(
                        ovaryLength: db.Value(int.tryParse(value) ?? 0),
                      ),
                    );
                  }
                },
              ),
              CommonTextField(
                controller: widget.ctr.ovaryWidthCtr,
                labelText: 'Width (mm)',
                hintText: 'Enter width',
                isLastField: false,
                onChanged: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    SpecimenServices(ref).updateBirdMeasurement(
                      widget.specimenUuid,
                      BirdMeasurementCompanion(
                        ovaryWidth: db.Value(int.tryParse(value) ?? 0),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButtonFormField<OvaryAppearance>(
              value: _getOvaryAppearance(),
              decoration: const InputDecoration(
                labelText: 'Appearance',
                hintText: 'Choose one',
              ),
              items: ovaryAppearanceList
                  .map((e) => DropdownMenuItem(
                        value: OvaryAppearance
                            .values[ovaryAppearanceList.indexOf(e)],
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (OvaryAppearance? newValue) {
                if (newValue != null) {
                  setState(() {
                    _isLargeOvum = newValue == OvaryAppearance.large;
                    SpecimenServices(ref).updateBirdMeasurement(
                      widget.specimenUuid,
                      BirdMeasurementCompanion(
                        ovaryAppearance: db.Value(newValue.index),
                      ),
                    );
                  });
                }
              },
            ),
          ),
          Visibility(
            visible: _isLargeOvum,
            child: OvumSizeForm(
              specimenUuid: widget.specimenUuid,
              ctr: widget.ctr,
              useHorizontalLayout: widget.useHorizontalLayout,
            ),
          ),
          Text(
            'Oviduct',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          OviductForm(
            specimenUuid: widget.specimenUuid,
            ctr: widget.ctr,
            useHorizontalLayout: widget.useHorizontalLayout,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: CommonTextField(
              controller: widget.ctr.ovaryRemarkCtr,
              maxLines: 3,
              labelText: 'Remarks',
              hintText: 'Add additional information about the gonads',
              isLastField: true,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    widget.specimenUuid,
                    BirdMeasurementCompanion(
                      ovaryRemark: db.Value(value),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  OvaryAppearance? _getOvaryAppearance() {
    if (widget.ctr.ovaryAppearanceCtr != null) {
      return OvaryAppearance.values[widget.ctr.ovaryAppearanceCtr!];
    }
    return null;
  }
}

class SkullOssField extends ConsumerWidget {
  const SkullOssField({
    super.key,
    required this.specimenUuid,
    required this.ctr,
  });

  final String specimenUuid;
  final BirdMeasurementCtrModel ctr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Skull ossification (%)',
        hintText: 'Enter percentage',
      ),
      items: skullOssificationList
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text('$e %'),
              ))
          .toList(),
      onChanged: (int? newValue) {
        if (newValue != null) {
          SpecimenServices(ref).updateBirdMeasurement(
            specimenUuid,
            BirdMeasurementCompanion(
              skullOssification: db.Value(newValue),
            ),
          );
        }
      },
    );
  }
}

class FatField extends ConsumerWidget {
  const FatField({
    super.key,
    required this.specimenUuid,
    required this.ctr,
  });

  final String specimenUuid;
  final BirdMeasurementCtrModel ctr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<FatCategory>(
        value: _getFatCategory(),
        decoration: const InputDecoration(
          labelText: 'Fat',
          hintText: 'Enter amount of fat',
        ),
        items: fatCategoryList
            .map((e) => DropdownMenuItem(
                  value: FatCategory.values[fatCategoryList.indexOf(e)],
                  child: Text(e),
                ))
            .toList(),
        onChanged: (FatCategory? newValue) {
          if (newValue != null) {
            SpecimenServices(ref).updateBirdMeasurement(
              specimenUuid,
              BirdMeasurementCompanion(
                fat: db.Value(newValue.index),
              ),
            );
          }
        });
  }

  FatCategory? _getFatCategory() {
    if (ctr.fatCtr != null) {
      return FatCategory.values[ctr.fatCtr!];
    }
    return null;
  }
}

class OvumSizeForm extends ConsumerWidget {
  const OvumSizeForm({
    super.key,
    required this.specimenUuid,
    required this.ctr,
    required this.useHorizontalLayout,
  });

  final String specimenUuid;
  final BirdMeasurementCtrModel ctr;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          'The Size of Three Largest Ova (mm)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            CommonNumField(
              controller: ctr.firstOvaSizeCtr,
              labelText: 'First',
              hintText: 'Enter size',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    specimenUuid,
                    BirdMeasurementCompanion(
                      firstOvaSize: db.Value(int.parse(value)),
                    ),
                  );
                }
              },
            ),
            CommonNumField(
              controller: ctr.secondOvaSizeCtr,
              labelText: 'Second',
              hintText: 'Enter size',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    specimenUuid,
                    BirdMeasurementCompanion(
                      secondOvaSize: db.Value(int.parse(value)),
                    ),
                  );
                }
              },
            ),
            CommonNumField(
              controller: ctr.thirdOvaSizeCtr,
              labelText: 'Third',
              hintText: 'Enter size',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    specimenUuid,
                    BirdMeasurementCompanion(
                      thirdOvaSize: db.Value(int.parse(value)),
                    ),
                  );
                }
              },
            ),
          ],
        )
      ],
    );
  }
}

class OviductForm extends ConsumerWidget {
  const OviductForm({
    super.key,
    required this.specimenUuid,
    required this.ctr,
    required this.useHorizontalLayout,
  });

  final String specimenUuid;
  final BirdMeasurementCtrModel ctr;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveLayout(useHorizontalLayout: useHorizontalLayout, children: [
      CommonNumField(
        controller: ctr.oviductWidthCtr,
        labelText: 'Width (mm)',
        hintText: 'Enter width',
        isLastField: false,
        onChanged: (String? value) {
          if (value != null) {
            SpecimenServices(ref).updateBirdMeasurement(
              specimenUuid,
              BirdMeasurementCompanion(
                oviductWidth: db.Value(int.parse(value)),
              ),
            );
          }
        },
      ),
      DropdownButtonFormField<OviductAppearance>(
        value: _getOviductAppearance(),
        decoration: const InputDecoration(
          labelText: 'Appearance',
          hintText: 'Choose one',
        ),
        items: oviductAppearanceList
            .map((e) => DropdownMenuItem(
                  value: OviductAppearance
                      .values[oviductAppearanceList.indexOf(e)],
                  child: Text(e),
                ))
            .toList(),
        onChanged: (OviductAppearance? newValue) {
          if (newValue != null) {
            SpecimenServices(ref).updateBirdMeasurement(
              specimenUuid,
              BirdMeasurementCompanion(
                oviductAppearance: db.Value(newValue.index),
              ),
            );
          }
        },
      ),
    ]);
  }

  OviductAppearance? _getOviductAppearance() {
    if (ctr.oviductAppearanceCtr != null) {
      return OviductAppearance.values[ctr.oviductAppearanceCtr!];
    }
    return null;
  }
}

class MoltingForm extends ConsumerWidget {
  const MoltingForm({
    super.key,
    required this.specimenUuid,
    required this.ctr,
    required this.useHorizontalLayout,
    required this.visible,
  });

  final String specimenUuid;
  final BirdMeasurementCtrModel ctr;
  final bool useHorizontalLayout;
  final bool visible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: visible,
      child: Column(
        children: [
          const CommonDivider(),
          Text(
            'Molt',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          WingMoltForm(
            specimenUuid: specimenUuid,
            ctr: ctr,
            useHorizontalLayout: useHorizontalLayout,
          ),
          TailMoltForm(
            specimenUuid: specimenUuid,
            ctr: ctr,
            useHorizontalLayout: useHorizontalLayout,
          ),
          BodyMoltForm(
            specimenUuid: specimenUuid,
            ctr: ctr,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: CommonTextField(
              controller: ctr.moltRemarkCtr,
              maxLines: 3,
              labelText: 'Remarks',
              hintText: 'Add additional information about the molting',
              isLastField: true,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    specimenUuid,
                    BirdMeasurementCompanion(
                      moltRemark: db.Value(value),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class WingMoltForm extends ConsumerWidget {
  const WingMoltForm({
    super.key,
    required this.specimenUuid,
    required this.ctr,
    required this.useHorizontalLayout,
  });

  final String specimenUuid;
  final BirdMeasurementCtrModel ctr;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          'Wing Molt',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            CommonNumField(
              controller: ctr.wingLeftPrimaryMoltCtr,
              labelText: 'Left primaries',
              hintText: 'Enter left primaries molt',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    specimenUuid,
                    BirdMeasurementCompanion(
                      wingLeftPrimary: db.Value(value),
                    ),
                  );
                }
              },
            ),
            CommonNumField(
              controller: ctr.wingRightPrimaryMoltCtr,
              labelText: 'Right primaries',
              hintText: 'Enter right primaries molt',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    specimenUuid,
                    BirdMeasurementCompanion(
                      wingRightPrimary: db.Value(value),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            CommonNumField(
              controller: ctr.wingLeftSecondaryMoltCtr,
              labelText: 'Left secondaries',
              hintText: 'Enter left secondaries molt',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    specimenUuid,
                    BirdMeasurementCompanion(
                      wingLeftSecondary: db.Value(value),
                    ),
                  );
                }
              },
            ),
            CommonNumField(
              controller: ctr.wingRightSecondaryMoltCtr,
              labelText: 'Right secondaries',
              hintText: 'Enter right secondaries molt',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    specimenUuid,
                    BirdMeasurementCompanion(
                      wingRightSecondary: db.Value(value),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class TailMoltForm extends ConsumerWidget {
  const TailMoltForm({
    super.key,
    required this.specimenUuid,
    required this.ctr,
    required this.useHorizontalLayout,
  });

  final String specimenUuid;
  final BirdMeasurementCtrModel ctr;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          'Tail Molt',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            CommonNumField(
              controller: ctr.tailLeftRectriceCtr,
              labelText: 'Left retrices',
              hintText: 'Enter left retrices molt',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    specimenUuid,
                    BirdMeasurementCompanion(
                      tailLeftRectrices: db.Value(value),
                    ),
                  );
                }
              },
            ),
            CommonNumField(
              controller: ctr.tailRightRectriceCtr,
              labelText: 'Right rectrices',
              hintText: 'Enter right rectrices molt',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateBirdMeasurement(
                    specimenUuid,
                    BirdMeasurementCompanion(
                      tailRightRectrices: db.Value(value),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class BodyMoltForm extends ConsumerWidget {
  const BodyMoltForm({
    super.key,
    required this.specimenUuid,
    required this.ctr,
  });

  final String specimenUuid;
  final BirdMeasurementCtrModel ctr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: DropdownButtonFormField<BodyMolt>(
        value: _getMoltValue(),
        decoration: const InputDecoration(
          labelText: 'Body Molt',
          hintText: 'Choose one',
        ),
        items: bodyMoltList
            .map((e) => DropdownMenuItem(
                  value: BodyMolt.values[bodyMoltList.indexOf(e)],
                  child: Text(e),
                ))
            .toList(),
        onChanged: (BodyMolt? newValue) {
          if (newValue != null) {
            SpecimenServices(ref).updateBirdMeasurement(
              specimenUuid,
              BirdMeasurementCompanion(
                bodyMolt: db.Value(newValue.index),
              ),
            );
          }
        },
      ),
    );
  }

  BodyMolt? _getMoltValue() {
    if (ctr.bodyMoltCtr != null) {
      return BodyMolt.values[ctr.bodyMoltCtr!];
    }
    return null;
  }
}
