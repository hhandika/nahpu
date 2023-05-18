import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/birds.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/shared/measurements.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:drift/drift.dart' as db;

class BirdMeasurementForms extends ConsumerStatefulWidget {
  const BirdMeasurementForms(
      {super.key,
      required this.useHorizontalLayout,
      required this.specimenUuid});

  final bool useHorizontalLayout;
  final String specimenUuid;

  @override
  BirdMeasurementFormsState createState() => BirdMeasurementFormsState();
}

class BirdMeasurementFormsState extends ConsumerState<BirdMeasurementForms> {
  AvianMeasurementCtrModel ctr = AvianMeasurementCtrModel.empty();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCtr(widget.specimenUuid);
    });
  }

  @override
  void dispose() {
    ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MeasurementForm(children: [
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
                SpecimenServices(ref).updateAvianMeasurement(
                  widget.specimenUuid,
                  AvianMeasurementCompanion(
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
            isDouble: true,
            isLastField: false,
            onChanged: (String? value) {
              if (value != null && value.isNotEmpty) {
                SpecimenServices(ref).updateAvianMeasurement(
                  widget.specimenUuid,
                  AvianMeasurementCompanion(
                    wingspan: db.Value(double.tryParse(value) ?? 0),
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
                SpecimenServices(ref).updateAvianMeasurement(
                  widget.specimenUuid,
                  AvianMeasurementCompanion(
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
                SpecimenServices(ref).updateAvianMeasurement(
                  widget.specimenUuid,
                  AvianMeasurementCompanion(
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
                SpecimenServices(ref).updateAvianMeasurement(
                  widget.specimenUuid,
                  AvianMeasurementCompanion(
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
                SpecimenServices(ref).updateAvianMeasurement(
                  widget.specimenUuid,
                  AvianMeasurementCompanion(
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
                  SpecimenServices(ref).updateAvianMeasurement(
                      widget.specimenUuid,
                      AvianMeasurementCompanion(
                        sex: db.Value(newValue.index),
                      ));
                });
              }
            },
          ),
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
                  SpecimenServices(ref).updateAvianMeasurement(
                      widget.specimenUuid,
                      AvianMeasurementCompanion(
                        broodPatch: db.Value(newValue),
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
            hintText: 'Enter bursa size',
            isDouble: true,
            isLastField: false,
            onChanged: (String? value) {
              if (value != null && value.isNotEmpty) {
                SpecimenServices(ref).updateAvianMeasurement(
                  widget.specimenUuid,
                  AvianMeasurementCompanion(
                    bursaLength: db.Value(double.tryParse(value) ?? 0),
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
              SpecimenServices(ref).updateAvianMeasurement(
                widget.specimenUuid,
                AvianMeasurementCompanion(
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
      ),
      Notes(
        specimenUuid: widget.specimenUuid,
        ctr: ctr,
      )
    ]);
  }

  Future<void> _updateCtr(String specimenUuid) async {
    AvianMeasurementData data =
        await SpecimenServices(ref).getAvianMeasurementData(specimenUuid);
    setState(() {
      ctr = AvianMeasurementCtrModel.fromData(data);
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
  final AvianMeasurementCtrModel ctr;
  final SpecimenSex? sex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
        visible: sex == SpecimenSex.male,
        child: Column(
          children: [
            const CommonDivider(),
            Text('Male Gonads', style: Theme.of(context).textTheme.titleLarge),
            Text('Left testis size (mm)',
                style: Theme.of(context).textTheme.titleSmall),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: [
                CommonNumField(
                  controller: ctr.testisLengthCtr,
                  labelText: 'Length',
                  hintText: 'Enter length',
                  isDouble: true,
                  isLastField: false,
                  onChanged: (String? value) {
                    if (value != null && value.isNotEmpty) {
                      SpecimenServices(ref).updateAvianMeasurement(
                        specimenUuid,
                        AvianMeasurementCompanion(
                          testisLength: db.Value(double.tryParse(value) ?? 0),
                        ),
                      );
                    }
                  },
                ),
                CommonNumField(
                  controller: ctr.testisWidthCtr,
                  labelText: 'Width',
                  hintText: 'Enter width',
                  isDouble: true,
                  isLastField: false,
                  onChanged: (String? value) {
                    if (value != null && value.isNotEmpty) {
                      SpecimenServices(ref).updateAvianMeasurement(
                        specimenUuid,
                        AvianMeasurementCompanion(
                          testisWidth: db.Value(double.tryParse(value) ?? 0),
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
                hintText: 'Enter remarks, e.g. right testis size',
                isLastField: false,
                onChanged: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    SpecimenServices(ref).updateAvianMeasurement(
                      specimenUuid,
                      AvianMeasurementCompanion(
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
  final AvianMeasurementCtrModel ctr;
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
            'Ovary size',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AdaptiveLayout(
            useHorizontalLayout: widget.useHorizontalLayout,
            children: [
              CommonNumField(
                controller: widget.ctr.ovaryLengthCtr,
                labelText: 'Length (mm)',
                hintText: 'Enter length',
                isDouble: true,
                isLastField: false,
                onChanged: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    SpecimenServices(ref).updateAvianMeasurement(
                      widget.specimenUuid,
                      AvianMeasurementCompanion(
                        ovaryLength: db.Value(double.tryParse(value) ?? 0),
                      ),
                    );
                  }
                },
              ),
              CommonNumField(
                controller: widget.ctr.ovaryWidthCtr,
                labelText: 'Width (mm)',
                hintText: 'Enter width',
                isDouble: true,
                isLastField: false,
                onChanged: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    SpecimenServices(ref).updateAvianMeasurement(
                      widget.specimenUuid,
                      AvianMeasurementCompanion(
                        ovaryWidth: db.Value(double.tryParse(value) ?? 0),
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
                    SpecimenServices(ref).updateAvianMeasurement(
                      widget.specimenUuid,
                      AvianMeasurementCompanion(
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
                  SpecimenServices(ref).updateAvianMeasurement(
                    widget.specimenUuid,
                    AvianMeasurementCompanion(
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
  final AvianMeasurementCtrModel ctr;

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
          SpecimenServices(ref).updateAvianMeasurement(
            specimenUuid,
            AvianMeasurementCompanion(
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
  final AvianMeasurementCtrModel ctr;

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
            SpecimenServices(ref).updateAvianMeasurement(
              specimenUuid,
              AvianMeasurementCompanion(
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
  final AvianMeasurementCtrModel ctr;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          'The Diameter of Three Largest Ova (mm)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            CommonNumField(
              controller: ctr.firstOvaSizeCtr,
              labelText: 'First',
              hintText: 'Enter size',
              isDouble: true,
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateAvianMeasurement(
                    specimenUuid,
                    AvianMeasurementCompanion(
                      firstOvaSize: db.Value(double.parse(value)),
                    ),
                  );
                }
              },
            ),
            CommonNumField(
              controller: ctr.secondOvaSizeCtr,
              labelText: 'Second',
              hintText: 'Enter size',
              isDouble: true,
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateAvianMeasurement(
                    specimenUuid,
                    AvianMeasurementCompanion(
                      secondOvaSize: db.Value(double.parse(value)),
                    ),
                  );
                }
              },
            ),
            CommonNumField(
              controller: ctr.thirdOvaSizeCtr,
              labelText: 'Third',
              hintText: 'Enter size',
              isDouble: true,
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateAvianMeasurement(
                    specimenUuid,
                    AvianMeasurementCompanion(
                      thirdOvaSize: db.Value(double.parse(value)),
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
  final AvianMeasurementCtrModel ctr;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveLayout(useHorizontalLayout: useHorizontalLayout, children: [
      CommonNumField(
        controller: ctr.oviductWidthCtr,
        labelText: 'Width (mm)',
        hintText: 'Enter width',
        isDouble: true,
        isLastField: false,
        onChanged: (String? value) {
          if (value != null) {
            SpecimenServices(ref).updateAvianMeasurement(
              specimenUuid,
              AvianMeasurementCompanion(
                oviductWidth: db.Value(double.parse(value)),
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
            SpecimenServices(ref).updateAvianMeasurement(
              specimenUuid,
              AvianMeasurementCompanion(
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

class MoltingForm extends ConsumerStatefulWidget {
  const MoltingForm({
    super.key,
    required this.specimenUuid,
    required this.ctr,
    required this.useHorizontalLayout,
  });

  final String specimenUuid;
  final AvianMeasurementCtrModel ctr;
  final bool useHorizontalLayout;

  @override
  MoltingFormState createState() => MoltingFormState();
}

class MoltingFormState extends ConsumerState<MoltingForm> {
  bool _wingMolting = false;
  bool _tailMolting = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          const CommonDivider(),
          Text(
            'Molt',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          BodyMoltForm(
            specimenUuid: widget.specimenUuid,
            ctr: widget.ctr,
          ),
          DropdownButtonFormField<int?>(
            value: widget.ctr.wingIsMoltCtr,
            decoration: const InputDecoration(
              labelText: 'Wing Molting',
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
                  _wingMolting = newValue == 0 ? true : false;
                  SpecimenServices(ref).updateAvianMeasurement(
                      widget.specimenUuid,
                      AvianMeasurementCompanion(
                        wingIsMolt: db.Value(newValue),
                      ));
                });
              }
            },
          ),
          Visibility(
            visible: _wingMolting,
            child: WingMoltForm(
              specimenUuid: widget.specimenUuid,
              ctr: widget.ctr,
              useHorizontalLayout: widget.useHorizontalLayout,
            ),
          ),
          DropdownButtonFormField<int?>(
            value: widget.ctr.wingIsMoltCtr,
            decoration: const InputDecoration(
              labelText: 'Tail Molting',
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
                  _tailMolting = newValue == 0 ? true : false;
                  SpecimenServices(ref).updateAvianMeasurement(
                      widget.specimenUuid,
                      AvianMeasurementCompanion(
                        tailIsMolt: db.Value(newValue),
                      ));
                });
              }
            },
          ),
          Visibility(
            visible: _tailMolting,
            child: TailMoltForm(
              specimenUuid: widget.specimenUuid,
              ctr: widget.ctr,
              useHorizontalLayout: widget.useHorizontalLayout,
            ),
          ),
          CommonTextField(
            controller: widget.ctr.moltRemarkCtr,
            maxLines: 3,
            labelText: 'Remarks',
            hintText: 'Add additional information about the molting',
            isLastField: true,
            onChanged: (String? value) {
              if (value != null) {
                SpecimenServices(ref).updateAvianMeasurement(
                  widget.specimenUuid,
                  AvianMeasurementCompanion(
                    moltRemark: db.Value(value),
                  ),
                );
              }
            },
          ),
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
  final AvianMeasurementCtrModel ctr;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTextField(
      controller: ctr.wingMoltCtr,
      labelText: 'Wing Molt',
      hintText: 'Enter wing molt',
      isLastField: false,
      maxLines: 2,
      onChanged: (String? value) {
        if (value != null) {
          SpecimenServices(ref).updateAvianMeasurement(
            specimenUuid,
            AvianMeasurementCompanion(
              wingMolt: db.Value(value),
            ),
          );
        }
      },
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
  final AvianMeasurementCtrModel ctr;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTextField(
      controller: ctr.tailMoltCtr,
      labelText: 'Tail Molt',
      hintText: 'Enter tail molt',
      maxLines: 2,
      isLastField: false,
      onChanged: (String? value) {
        if (value != null) {
          SpecimenServices(ref).updateAvianMeasurement(
            specimenUuid,
            AvianMeasurementCompanion(
              tailMolt: db.Value(value),
            ),
          );
        }
      },
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
  final AvianMeasurementCtrModel ctr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<BodyMolt>(
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
          SpecimenServices(ref).updateAvianMeasurement(
            specimenUuid,
            AvianMeasurementCompanion(
              bodyMolt: db.Value(newValue.index),
            ),
          );
        }
      },
    );
  }

  BodyMolt? _getMoltValue() {
    if (ctr.bodyMoltCtr != null) {
      return BodyMolt.values[ctr.bodyMoltCtr!];
    }
    return null;
  }
}

class Notes extends ConsumerWidget {
  const Notes({
    super.key,
    required this.specimenUuid,
    required this.ctr,
  });

  final String specimenUuid;
  final AvianMeasurementCtrModel ctr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              'Notes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            CommonTextField(
              controller: ctr.habitatRemarkCtr,
              maxLines: 3,
              labelText: 'Habitat',
              hintText: 'Add additional information about the habitat',
              isLastField: true,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateAvianMeasurement(
                    specimenUuid,
                    AvianMeasurementCompanion(
                      habitatRemark: db.Value(value),
                    ),
                  );
                }
              },
            ),
            CommonTextField(
              controller: ctr.specimenRemarkCtr,
              maxLines: 3,
              labelText: 'Specimen',
              hintText: 'Add additional information about the specimen',
              isLastField: true,
              onChanged: (String? value) {
                if (value != null) {
                  SpecimenServices(ref).updateAvianMeasurement(
                    specimenUuid,
                    AvianMeasurementCompanion(
                      specimenRemark: db.Value(value),
                    ),
                  );
                }
              },
            )
          ],
        ));
  }
}