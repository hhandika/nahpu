import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

class SpeciesInputField extends ConsumerWidget {
  const SpeciesInputField({
    super.key,
    required this.speciesCtr,
    required this.onFieldSubmitted,
  });

  final TextEditingController speciesCtr;
  final VoidCallback onFieldSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> options = ref.watch(taxonProvider).when(
          data: (taxa) {
            return taxa
                .map((taxon) => '${taxon.genus} ${taxon.specificEpithet}')
                .toList();
          },
          loading: () => const [],
          error: (error, stack) => const [],
        );
    return RawAutocomplete<String>(
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
      // onSelected: widget.onSelected,
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Species',
            hintText: 'Choose a species',
          ),
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            controller.text = value;
            onFieldSubmitted();
          },
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
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
