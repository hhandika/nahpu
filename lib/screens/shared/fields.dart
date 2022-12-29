import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/settings.dart';

class TaxonGroupFields extends ConsumerWidget {
  const TaxonGroupFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> taxonGroups = [
      'Birds',
      'Bats',
      'General Mammals',
    ];

    CatalogFmt catalogFmt = ref.watch(catalogFmtNotifier);
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Taxon Group',
        hintText: 'Choose a taxon group',
      ),
      items: [
        for (var i in taxonGroups)
          DropdownMenuItem(
            value: i,
            child: Text(i),
          )
      ],
      value: matchCatFmtToTaxonGroup(catalogFmt),
      onChanged: (String? newValue) {
        catalogFmt = matchTaxonGroupToCatFmt(newValue!);
        ref.read(catalogFmtNotifier.notifier).setCatalogFmt(catalogFmt);
      },
    );
  }
}

class NumberOnlyField extends ConsumerWidget {
  const NumberOnlyField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextField(
      labelText: labelText,
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.number,
    );
  }
}

class CustomTextField extends ConsumerWidget {
  const CustomTextField({
    Key? key,
    required this.labelText,
    this.controller,
    required this.hintText,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  }) : super(key: key);

  final bool enabled;
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}
