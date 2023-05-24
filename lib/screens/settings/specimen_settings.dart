import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:settings_ui/settings_ui.dart';

class SpecimenPartSelection extends ConsumerStatefulWidget {
  const SpecimenPartSelection({super.key});

  @override
  SpecimenPartSelectionState createState() => SpecimenPartSelectionState();
}

class SpecimenPartSelectionState extends ConsumerState<SpecimenPartSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Specimen Parts'),
      ),
      body: SafeArea(
          child: SettingsList(sections: [
        SettingsSection(
          title: Text(
            'Tissue ID',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          tiles: const [
            CustomSettingsTile(
              child: TissueIDFields(),
            )
          ],
        ),
        ref.watch(specimenTypeNotifierProvider).when(
              data: (data) {
                return SettingsSection(tiles: [
                  CustomSettingsTile(
                    child: TypeList(typeList: data.typeList),
                  ),
                  const CustomSettingsTile(
                      child: SizedBox(
                    height: 20,
                  )),
                  CustomSettingsTile(
                    child: TreatmentList(data: data.treatmentList),
                  ),
                ]);
              },
              loading: () => const SettingsSection(
                tiles: [
                  CustomSettingsTile(
                    child: CommonProgressIndicator(),
                  )
                ],
              ),
              error: (err, stack) => const SettingsSection(
                tiles: [
                  CustomSettingsTile(
                    child: Text('Error loading data'),
                  )
                ],
              ),
            ),
      ])),
    );
  }
}

class TypeList extends ConsumerWidget {
  const TypeList({
    super.key,
    required this.typeList,
  });

  final List<String> typeList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController partController = TextEditingController();
    return SettingChip(
      title: 'Specimen Types',
      controller: partController,
      chipList: typeList
          .map((e) => CommonChip(
                text: e,
                primaryColor: Colors.blue,
                onDeleted: () {
                  ref.read(specimenTypeNotifierProvider.notifier).deleteType(e);
                  ref.invalidate(specimenTypeNotifierProvider);
                },
              ))
          .toList(),
      labelText: 'Add Type',
      hintText: 'Enter part type',
      onPressed: () {
        if (partController.text.isNotEmpty) {
          ref
              .read(specimenTypeNotifierProvider.notifier)
              .addType(partController.text.trim());
          partController.clear();
          ref.invalidate(specimenTypeNotifierProvider);
        }
      },
    );
  }
}

class TreatmentList extends ConsumerWidget {
  const TreatmentList({
    super.key,
    required this.data,
  });

  final List<String> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController treatmentController = TextEditingController();
    return SettingChip(
      title: 'Treatments',
      controller: treatmentController,
      chipList: data
          .map((e) => CommonChip(
                text: e,
                primaryColor: Colors.red,
                onDeleted: () {
                  ref
                      .read(specimenTypeNotifierProvider.notifier)
                      .deleteTreatment(e);
                  ref.invalidate(specimenTypeNotifierProvider);
                },
              ))
          .toList(),
      labelText: 'Add Treatment',
      hintText: 'Enter treatment',
      onPressed: () {
        if (treatmentController.text.isNotEmpty) {
          ref
              .read(specimenTypeNotifierProvider.notifier)
              .addTreatment(treatmentController.text.trim());
          treatmentController.clear();
          ref.invalidate(specimenTypeNotifierProvider);
        }
      },
    );
  }
}

class TissueIDFields extends ConsumerWidget {
  const TissueIDFields({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController prefixController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    return ref.watch(tissueIDNotifierProvider).when(
          data: (data) {
            prefixController.text = data.prefix;
            numberController.text = data.number.toString();
            return SettingCard(
              children: [
                TissuePrefixField(prefixCtr: prefixController),
                const SizedBox(width: 10),
                TissueNumField(tissueNumCtr: numberController),
              ],
            );
          },
          loading: () => const CommonProgressIndicator(),
          error: (err, stack) => const Center(
            child: Text('Error loading data'),
          ),
        );
  }
}

class TissuePrefixField extends ConsumerWidget {
  const TissuePrefixField({
    super.key,
    required this.prefixCtr,
  });

  final TextEditingController prefixCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTextField(
        controller: prefixCtr,
        labelText: 'Prefix',
        hintText: 'Enter tissue ID prefix, e.g. M',
        isLastField: false,
        onChanged: (String? value) async {
          if (value != null) {
            await TissueIdServices(ref).setPrefix(value);
          }
        });
  }
}

class TissueNumField extends ConsumerWidget {
  const TissueNumField({
    super.key,
    required this.tissueNumCtr,
  });

  final TextEditingController tissueNumCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonNumField(
      controller: tissueNumCtr,
      labelText: 'Tissue no.',
      hintText: 'Enter the initial starting number',
      isLastField: true,
      onChanged: (String? value) async {
        if (value != null) {
          await TissueIdServices(ref).setNumber(value);
        }
      },
    );
  }
}
