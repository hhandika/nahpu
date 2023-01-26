import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database.dart';

class SpeciesAutoComplete extends ConsumerWidget {
  const SpeciesAutoComplete(
      {super.key, required this.onSelected, required this.controller});

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
      suggestionsCallback: (pattern) async {
        Future<List<TaxonomyData>> speciesList =
            ref.watch(databaseProvider).getTaxonList();
        return await speciesList.then((value) =>
            value.map((e) => '${e.genus} ${e.specificEpithet}').toList());
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
