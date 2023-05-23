import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
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
      body: const SafeArea(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: Text(
                'Tissue ID',
              ),
              tiles: [
                CustomSettingsTile(
                  child: TissueIDFields(),
                )
              ],
            )
          ],
        ),
      ),
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
            return Row(
              children: [
                Expanded(child: TissuePrefixField(prefixCtr: prefixController)),
                const SizedBox(width: 10),
                SizedBox(
                    width: 200,
                    child: TissueNumField(tissueNumCtr: numberController)),
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
        onChanged: (String? value) {
          if (value != null) {
            TissueIdServices(ref).setPrefix(value);
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
      onChanged: (String? value) {
        if (value != null) {
          TissueIdServices(ref).setNumber(value);
        }
      },
    );
  }
}
