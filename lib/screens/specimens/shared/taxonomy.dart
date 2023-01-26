import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

class TaxonomicForm extends ConsumerWidget {
  const TaxonomicForm(
      {Key? key, required this.useHorizontalLayout, required this.taxonData})
      : super(key: key);

  final bool useHorizontalLayout;
  final TaxonData? taxonData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> terms = ['Class', 'Order', 'Family'];
    List<String> taxonomy = [
      taxonData?.taxonClass ?? '',
      taxonData?.taxonOrder ?? '',
      taxonData?.taxonFamily ?? '',
    ];
    return FormCard(
      title: 'Taxonomy',
      child: AdaptiveLayout(
        useHorizontalLayout: useHorizontalLayout,
        children: [
          for (var i = 0; i < terms.length; i++)
            ListTile(
              title: Text(terms[i]),
              subtitle: Text(taxonomy[i]),
            ),
        ],
      ),
    );
  }
}
