import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/services/taxonomy_queries.dart';

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
