import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

import 'package:drift/drift.dart' as db;

class SpeciesAutoComplete extends ConsumerStatefulWidget {
  const SpeciesAutoComplete({
    super.key,
    required this.specimenUuid,
    required this.speciesCtr,
    required this.options,
  });

  final String specimenUuid;
  final TextEditingController speciesCtr;
  final List<String> options;

  @override
  SpeciesAutoCompleteState createState() => SpeciesAutoCompleteState();
}

class SpeciesAutoCompleteState extends ConsumerState<SpeciesAutoComplete> {
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      focusNode: _focusNode,
      textEditingController: widget.speciesCtr,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return widget.options.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        setState(() {
          _inputTaxon(selection);
        });
        _focusNode.unfocus();
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return SpeciesField(
          speciesCtr: controller,
          enable: true,
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
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
            child: Container(
              width: 300,
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                shrinkWrap: true,
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

  void _inputTaxon(String selection) {
    _copyTaxon(selection);
    var taxon = widget.speciesCtr.text.split(' ');
    SpecimenServices(ref).getTaxonIdByGenusEpithet(taxon[0], taxon[1]).then(
          (data) => SpecimenServices(ref).updateSpecimen(
            widget.specimenUuid,
            SpecimenCompanion(speciesID: db.Value(data.id)),
          ),
        );
  }

  void _copyTaxon(String selection) {
    widget.speciesCtr.value = widget.speciesCtr.value.copyWith(
      text: selection,
      selection: TextSelection.collapsed(offset: selection.length),
    );
  }
}

class SpeciesInputField extends StatelessWidget {
  const SpeciesInputField({
    super.key,
    required this.specimenUuid,
    required this.speciesCtr,
    required this.taxonList,
  });

  final String specimenUuid;
  final int? speciesCtr;
  final List<TaxonomyData> taxonList;

  @override
  Widget build(BuildContext context) {
    return CommonPadding(
        child: SpeciesAutoComplete(
      specimenUuid: specimenUuid,
      speciesCtr: _getSpeciesCtr,
      options: _options,
    ));
  }

  TextEditingController get _getSpeciesCtr {
    if (speciesCtr == null) {
      return TextEditingController();
    }
    var data = taxonList.firstWhere((taxon) => taxon.id == speciesCtr);
    TextEditingController ctr =
        TextEditingController(text: '${data.genus} ${data.specificEpithet}');
    ctr.selection =
        TextSelection.fromPosition(TextPosition(offset: ctr.text.length));
    return ctr;
  }

  List<String> get _options => taxonList
      .map((taxon) => '${taxon.genus} ${taxon.specificEpithet}')
      .toList();
}

/// Species field that is disabled
/// Used when the taxon list is empty
class DisabledSpeciesField extends StatelessWidget {
  const DisabledSpeciesField({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPadding(
      child: TextFormField(
        enabled: false,
        decoration: const InputDecoration(
          labelText: 'Species',
          hintText: 'Enter species',
        ),
      ),
    );
  }
}

class SpeciesField extends StatelessWidget {
  const SpeciesField({
    super.key,
    required this.speciesCtr,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.enable,
  });

  final TextEditingController speciesCtr;
  final FocusNode focusNode;
  final void Function(String) onFieldSubmitted;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      controller: speciesCtr,
      decoration: const InputDecoration(
        labelText: 'Species',
        hintText: 'Choose a species',
      ),
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      validator: (value) => value!.isEmpty ? 'Please enter a species' : null,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
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
