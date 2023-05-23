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
        child: SettingsList(
          sections: [
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
            SettingsSection(
                title: Text(
                  'Specimen Part Type',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                tiles: const [
                  CustomSettingsTile(
                    child: SpecimenPartMenu(),
                  )
                ])
          ],
        ),
      ),
    );
  }
}

class SpecimenPartMenu extends ConsumerStatefulWidget {
  const SpecimenPartMenu({super.key});

  @override
  SpecimenPartMenuState createState() => SpecimenPartMenuState();
}

class SpecimenPartMenuState extends ConsumerState<SpecimenPartMenu> {
  final TextEditingController _partController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SettingCard(children: [
      ref.watch(specimenTypeNotifierProvider).when(
            data: (data) {
              return Wrap(
                spacing: 15,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: data.typeList
                    .map((e) => Chip(
                          label: Text(e),
                          shape: const StadiumBorder(
                              side: BorderSide(color: Colors.transparent)),
                          backgroundColor: Color.lerp(
                              Theme.of(context).colorScheme.secondaryContainer,
                              Theme.of(context).colorScheme.surface,
                              0.5),
                          onDeleted: () {
                            ref
                                .read(specimenTypeNotifierProvider.notifier)
                                .deleteType(e);
                            ref.invalidate(specimenTypeNotifierProvider);
                          },
                        ))
                    .toList(),
              );
            },
            loading: () => const CommonProgressIndicator(),
            error: (err, stack) => const Center(
              child: Text('Error loading data'),
            ),
          ),
      const SizedBox(height: 20),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: TextField(
                controller: _partController,
                decoration: const InputDecoration(
                  labelText: 'Add Type',
                  hintText: 'Enter part type',
                ),
              ),
            ),
            const SizedBox(width: 5),
            IconButton(
              iconSize: 25,
              color: Theme.of(context).colorScheme.onSurface,
              icon: const Icon(Icons.add),
              onPressed: () {
                if (_partController.text.isNotEmpty) {
                  ref
                      .read(specimenTypeNotifierProvider.notifier)
                      .addType(_partController.text.trim());
                  _partController.clear();
                  ref.invalidate(specimenTypeNotifierProvider);
                }
              },
            ),
          ]),
    ]);
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
