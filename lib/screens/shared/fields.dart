import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/database/database.dart';

class SearchButtonField extends StatelessWidget {
  const SearchButtonField({
    super.key,
    required this.onChanged,
  });

  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: const InputDecoration(
        labelText: 'Search',
        hintText: 'Enter a query',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

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
        labelText: 'Main Taxon Group',
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

class SiteIdField extends ConsumerWidget {
  const SiteIdField({
    Key? key,
    required this.onChanges,
    required this.siteData,
    required this.value,
  }) : super(key: key);

  final void Function(int?) onChanges;
  final List<SiteData> siteData;
  final int? value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField(
      value: value,
      decoration: const InputDecoration(
        labelText: 'Site ID',
        hintText: 'Enter a site',
      ),
      items: siteData
          .map((site) => DropdownMenuItem(
                value: site.id,
                child: Text(site.siteID ?? ''),
              ))
          .toList(),
      onChanged: onChanges,
    );
  }
}

class CommonNumField extends ConsumerWidget {
  const CommonNumField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.onChanged,
    required this.isLastField,
    this.isDouble = false,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final bool isLastField;
  final bool isDouble;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      inputFormatters: isDouble
          ? [FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))]
          : [FilteringTextInputFormatter.digitsOnly],
      keyboardType: isDouble
          ? const TextInputType.numberWithOptions(decimal: true, signed: true)
          : const TextInputType.numberWithOptions(signed: true),
      onChanged: onChanged,
      textInputAction:
          isLastField ? TextInputAction.done : TextInputAction.next,
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
  final void Function(String?)? onChanged;
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

class SwitchField extends StatelessWidget {
  const SwitchField({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  final String label;
  final bool value;
  final void Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(
          value: value,
          onChanged: onPressed,
        ),
      ],
    );
  }
}
