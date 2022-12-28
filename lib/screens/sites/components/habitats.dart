import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/shared/forms.dart';

class Habitat extends ConsumerWidget {
  const Habitat(
      {super.key,
      required this.id,
      required this.useHorizontalLayout,
      required this.siteFormCtr});

  final int id;
  final bool useHorizontalLayout;
  final SiteFormCtrModel siteFormCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormCard(
      title: 'Habitat',
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Type',
                hintText:
                    'Enter a habitat type, e.g. "Urban", "Montane Forest", "Desert", "etc."',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Condition',
                hintText:
                    'Enter habitat condition, e.g. "Prestine", "Disturbed", "etc."',
              ),
            ),
            TextFormField(
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText:
                    'Describe the site, e.g. "A camp site in the middle of the forest."',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
