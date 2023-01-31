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
    this.controller,
    this.onChanged,
    required this.isLastField,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged? onChanged;
  final bool isLastField;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTextField(
      labelText: labelText,
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      isLastField: isLastField,
    );
  }
}

class CommonTextField extends ConsumerWidget {
  const CommonTextField({
    Key? key,
    required this.labelText,
    this.controller,
    required this.hintText,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    required this.isLastField,
    this.maxLines,
  }) : super(key: key);

  final bool enabled;
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final ValueChanged? onChanged;
  final bool isLastField;
  final int? maxLines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      enabled: enabled,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      textInputAction:
          isLastField ? TextInputAction.done : TextInputAction.next,
    );
  }
}
