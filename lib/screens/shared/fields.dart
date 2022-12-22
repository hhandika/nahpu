import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalog.dart';

class TaxonGroupFields extends ConsumerWidget {
  const TaxonGroupFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> taxonGroups = [
      'Birds',
      'Bats',
      'General Mammals',
    ];

    CatalogFmt catalogFmt = ref.watch(catalogFmtProvider);
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
        ref.read(catalogFmtProvider.notifier).setCatalogFmt(catalogFmt);
      },
    );
  }
}
