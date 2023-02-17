import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

class SpeciesAutoComplete extends ConsumerWidget {
  const SpeciesAutoComplete({
    super.key,
    required this.onSelected,
    required this.controller,
  });

  final void Function(String) onSelected;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Species',
          hintText: 'Choose a species',
        ),
      ),
      hideSuggestionsOnKeyboardHide: false,
      suggestionsCallback: (pattern) async {
        List<TaxonomyData> speciesList =
            await TaxonomyQuery(ref.watch(databaseProvider)).getTaxonList();
        List<String> sortedList = speciesList
            .map((e) => '${e.genus} ${e.specificEpithet}')
            .where((element) => element.contains(pattern.toSentenceCase()))
            .toList();
        if (pattern.isEmpty) {
          return ['Enter a species name'];
        } else if (sortedList.isEmpty) {
          return ['No species found'];
        } else {
          return sortedList;
        }
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: onSelected,
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
