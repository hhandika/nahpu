import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

import 'package:drift/drift.dart' as db;

class SpeciesInputField extends ConsumerWidget {
  const SpeciesInputField({
    super.key,
    required this.specimenUuid,
    required this.speciesCtr,
    required this.options,
  });

  final String specimenUuid;
  final TextEditingController speciesCtr;
  final List<String> options;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonPadding(
      child: RawAutocomplete<String>(
        focusNode: FocusNode(),
        textEditingController: speciesCtr,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return options.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        fieldViewBuilder: (
          BuildContext context,
          speciesCtr,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted,
        ) {
          return TextFormField(
            controller: speciesCtr,
            decoration: const InputDecoration(
              labelText: 'Species',
              hintText: 'Choose a species',
            ),
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              speciesCtr.text = value;
              onFieldSubmitted();
              var taxon = speciesCtr.text.split(' ');
              TaxonomyQuery(ref.read(databaseProvider))
                  .getTaxonIdByGenusEpithet(taxon[0], taxon[1])
                  .then(
                    (data) => SpecimenServices(ref).updateSpecimen(
                      specimenUuid,
                      SpecimenCompanion(speciesID: db.Value(data.id)),
                    ),
                  );
              ref.invalidate(taxonProvider);
            },
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: SizedBox(
                height: 200.0,
                width: 250,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(option),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TaxonDropdownMenu extends ConsumerWidget {
  const TaxonDropdownMenu({
    super.key,
    required this.onSelected,
    required this.controller,
  });

  final void Function(int?) onSelected;
  final SpecimenFormCtrModel controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<int?>(
      value: controller.speciesCtr,
      decoration: const InputDecoration(
        labelText: 'Taxon',
        hintText: 'Choose a taxon',
      ),
      items: ref.watch(taxonProvider).when(
            data: (taxa) {
              if (taxa.isEmpty) {
                return const [];
              } else {
                return taxa
                    .map(
                      (taxon) => DropdownMenuItem<int>(
                        value: taxon.id,
                        child: Text('${taxon.genus} ${taxon.specificEpithet}'),
                      ),
                    )
                    .toList();
              }
            },
            loading: () => const [],
            error: (error, stack) => const [],
          ),
      onChanged: onSelected,
    );
  }
}

class TaxonomicForm extends ConsumerWidget {
  const TaxonomicForm({
    super.key,
    required this.useHorizontalLayout,
    required this.specimenUuid,
  });

  final bool useHorizontalLayout;
  final String specimenUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormCard(
      title: 'Taxonomy',
      child: ref.watch(taxonDataProvider(specimenUuid)).when(
            data: (taxonData) {
              if (taxonData == null) {
                return const Text('No species added!');
              } else {
                return AdaptiveLayout(
                  useHorizontalLayout: useHorizontalLayout,
                  children: [
                    Text('Class: ${taxonData.taxonClass}'),
                    Text('Order: ${taxonData.taxonOrder}'),
                    Text('Family: ${taxonData.taxonFamily}'),
                  ],
                );
              }
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
          ),
    );
  }
}
