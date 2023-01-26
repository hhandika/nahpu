import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nahpu/providers/catalogs.dart';

class SpeciesAutoComplete extends ConsumerWidget {
  const SpeciesAutoComplete({super.key, required this.onSelected});

  final void Function(String?) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> species = [
      "Rattus rattus",
      "Rattus norvegicus",
      "Rattus exulans",
      "Mus musculus",
    ];
    return TypeAheadField(
      textFieldConfiguration: const TextFieldConfiguration(
        decoration: InputDecoration(
          labelText: 'Species',
          hintText: 'Choose a species',
        ),
      ),
      suggestionsCallback: (pattern) {
        return species
            .where((element) => element.contains(pattern.toSentenceCase()));
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
