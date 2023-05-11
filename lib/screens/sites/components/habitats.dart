import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/site_services.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: siteFormCtr.habitatTypeCtr,
              decoration: const InputDecoration(
                labelText: 'Type',
                hintText:
                    'Enter a habitat type, e.g. "Urban", "Montane Forest", "Desert", "etc."',
              ),
              onChanged: (value) => SiteServices(ref).updateSite(
                id,
                SiteCompanion(habitatType: db.Value(value)),
              ),
            ),
            TextFormField(
              controller: siteFormCtr.habitatConditionCtr,
              decoration: const InputDecoration(
                labelText: 'Condition',
                hintText:
                    'Enter habitat condition, e.g. "Pristine", "Disturbed", "etc."',
              ),
              onChanged: (value) => SiteServices(ref).updateSite(
                id,
                SiteCompanion(habitatCondition: db.Value(value)),
              ),
            ),
            TextFormField(
              maxLines: 6,
              controller: siteFormCtr.habitatDescriptionCtr,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText:
                    'Describe the site, e.g. "A camp site in the middle of the forest."',
              ),
              onChanged: (value) => SiteServices(ref).updateSite(
                id,
                SiteCompanion(habitatDescription: db.Value(value)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
