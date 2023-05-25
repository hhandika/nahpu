import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:settings_ui/settings_ui.dart';

class SpecimenPartSelection extends StatefulWidget {
  const SpecimenPartSelection({super.key});

  @override
  State<SpecimenPartSelection> createState() => _SpecimenPartSelectionState();
}

class _SpecimenPartSelectionState extends State<SpecimenPartSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Specimen Part Settings'),
      ),
      body: SafeArea(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return SettingsList(sections: [
            SettingsSection(
              title: const Text('Tissue ID'),
              tiles: [
                androidPadding,
                CustomSettingsTile(
                  child: TissueIDFields(
                    isMobile: isMobile,
                  ),
                ),
                androidPadding,
              ],
            ),
            const SettingsSection(
              title: Text('Specimen Types'),
              tiles: [
                CustomSettingsTile(
                  child: SpecimenTypeSettings(),
                ),
              ],
            ),
            const SettingsSection(
              title: Text('Treatments'),
              tiles: [
                CustomSettingsTile(
                  child: TreatmentOptionSettings(),
                ),
              ],
            )
          ]);
        },
      )),
    );
  }
}

class SpecimenTypeSettings extends ConsumerWidget {
  const SpecimenTypeSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController partController = TextEditingController();
    return SettingChip(
      controller: partController,
      chipList: ref.watch(specimenTypesProvider).when(
            data: (data) {
              return data
                  .map((e) => CommonChip(
                        text: e,
                        primaryColor: Theme.of(context).colorScheme.secondary,
                        onDeleted: () {
                          SpecimenPartServices(ref).removeType(e);
                        },
                      ))
                  .toList();
            },
            loading: () => const [CommonProgressIndicator()],
            error: (error, stackTrace) {
              return const [Text('Error loading data')];
            },
          ),
      labelText: 'Add Type',
      hintText: 'Enter part type',
      onPressed: () {
        if (partController.text.isNotEmpty) {
          SpecimenPartServices(ref).addType(
            partController.text.trim(),
          );
          partController.clear();
        }
      },
      resetLabel: 'Reset types',
      onReset: () => SpecimenPartServices(ref).getSpecimenTypes(),
    );
  }
}

class TreatmentOptionSettings extends ConsumerWidget {
  const TreatmentOptionSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController treatmentController = TextEditingController();
    return SettingChip(
      controller: treatmentController,
      chipList: ref.watch(treatmentOptionsProvider).when(
            data: (data) {
              return data
                  .map((e) => CommonChip(
                        text: e,
                        primaryColor: Theme.of(context).colorScheme.tertiary,
                        onDeleted: () {
                          SpecimenPartServices(ref).removeTreatment(e);
                        },
                      ))
                  .toList();
            },
            loading: () => const [CommonProgressIndicator()],
            error: (error, stackTrace) {
              return const [Text('Error loading data')];
            },
          ),
      labelText: 'Add Treatment',
      hintText: 'Enter treatment',
      onPressed: () {
        if (treatmentController.text.isNotEmpty) {
          SpecimenPartServices(ref).addTreatment(
            treatmentController.text.trim(),
          );
          treatmentController.clear();
        }
      },
      resetLabel: 'Reset treatments',
      onReset: () => SpecimenPartServices(ref).getTreatmentOptions(),
    );
  }
}

class TissueIDFields extends ConsumerWidget {
  const TissueIDFields({super.key, required this.isMobile});

  final bool isMobile;

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
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: AdaptiveLayout(
                    useHorizontalLayout: !isMobile,
                    children: [
                      TissuePrefixField(prefixCtr: prefixController),
                      TissueNumField(tissueNumCtr: numberController),
                    ],
                  ),
                ),
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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: CommonTextField(
          controller: prefixCtr,
          labelText: 'Prefix',
          hintText: 'Enter tissue ID prefix, e.g. M',
          isLastField: false,
          onChanged: (String? value) async {
            if (value != null) {
              await TissueIdServices(ref).setPrefix(value);
            }
          }),
    );
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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: CommonNumField(
        controller: tissueNumCtr,
        labelText: 'Tissue no.',
        hintText: 'Enter the initial starting number',
        isLastField: true,
        onChanged: (String? value) async {
          if (value != null) {
            await TissueIdServices(ref).setNumber(value);
          }
        },
      ),
    );
  }
}
