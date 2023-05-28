import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/database/database.dart';

class CommonDateField extends StatelessWidget {
  const CommonDateField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.initialDate,
    required this.lastDate,
    required this.onTap,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final DateTime initialDate;
  final DateTime lastDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
      controller: controller,
      onTap: () async {
        final selectedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(2000),
            lastDate: lastDate);

        if (selectedDate != null) {
          controller.text = DateFormat.yMMMd().format(selectedDate);
          onTap();
        }
      },
    );
  }
}

class CommonTimeField extends StatelessWidget {
  const CommonTimeField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.initialTime,
    required this.onTap,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TimeOfDay initialTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
      controller: controller,
      onTap: () {
        showTimePicker(context: context, initialTime: initialTime).then((time) {
          if (time != null) {
            controller.text = time.format(context);
            onTap();
          }
        });
      },
    );
  }
}

class SearchButtonField extends StatelessWidget {
  const SearchButtonField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Enter a query',
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
        ),
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        suffix: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              )
            : null,
      ),
      onChanged: onChanged,
    );
  }
}

class TaxonGroupFields extends ConsumerWidget {
  const TaxonGroupFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CatalogFmt catalogFmt = ref.watch(catalogFmtNotifier);
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Main Taxon Group',
        hintText: 'Choose a taxon group',
      ),
      items: taxonGroupList
          .map((taxonGroup) => DropdownMenuItem(
                value: taxonGroup,
                child: Text(taxonGroup),
              ))
          .toList(),
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
        floatingLabelStyle: TextStyle(
          fontSize: 18,
        ),
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

class CommonDropdownText extends StatelessWidget {
  const CommonDropdownText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge,
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
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
        ),
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
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
        ),
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

class AutoCompleteField extends StatelessWidget {
  const AutoCompleteField({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.options,
    required this.onSelected,
    required this.labelText,
    required this.hintText,
  });

  final FocusNode focusNode;
  final TextEditingController controller;
  final List<String> options;
  final void Function(String) onSelected;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      focusNode: focusNode,
      textEditingController: controller,
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
      onSelected: onSelected,
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return AutoCompleteText(
          controller: controller,
          enable: true,
          focusNode: focusNode,
          labelText: labelText,
          hintText: hintText,
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
              constraints: const BoxConstraints(maxHeight: 350),
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
}

class AutoCompleteText extends StatelessWidget {
  const AutoCompleteText({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.hintText,
    required this.onFieldSubmitted,
    required this.enable,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onFieldSubmitted;
  final String labelText;
  final String hintText;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }
}
