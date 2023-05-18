import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';

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
        child: ScreenLayout(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tissue ID',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SettingCard(children: [
                CommonTextField(
                  labelText: 'Prefix',
                  hintText: 'Enter tissue ID prefix, e.g. M',
                  isLastField: false,
                ),
                CommonNumField(
                  labelText: 'Tissue no.',
                  hintText: 'Enter the initial starting number',
                  isLastField: true,
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
