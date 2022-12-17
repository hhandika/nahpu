import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

class TaxonomicForm extends ConsumerWidget {
  const TaxonomicForm({
    Key? key,
    required this.useHorizontalLayout,
    required this.taxonClass,
    required this.taxonOrder,
    required this.taxonFamily,
  }) : super(key: key);

  final bool useHorizontalLayout;
  final String taxonClass;
  final String taxonOrder;
  final String taxonFamily;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> terms = ['Class', 'Order', 'Family'];
    List<String> taxonomy = [taxonClass, taxonOrder, taxonFamily];
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
