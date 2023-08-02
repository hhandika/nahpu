import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/controllers.dart';
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
      infoContent: const HabitatInfoContent(),
      mainAxisAlignment: MainAxisAlignment.start,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextFormField(
              controller: siteFormCtr.habitatTypeCtr,
              decoration: const InputDecoration(
                labelText: 'Type',
                hintText:
                    'E.g. "Urban", "Upper Montane Forest", "Desert", "etc."',
              ),
              onChanged: (value) => SiteServices(ref: ref).updateSite(
                id,
                SiteCompanion(habitatType: db.Value(value)),
              ),
            ),
            TextFormField(
              controller: siteFormCtr.habitatConditionCtr,
              decoration: const InputDecoration(
                labelText: 'Condition',
                hintText: 'E.g. "Pristine", "Disturbed", "etc."',
              ),
              onChanged: (value) => SiteServices(ref: ref).updateSite(
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
              onChanged: (value) => SiteServices(ref: ref).updateSite(
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

class HabitatInfoContent extends StatelessWidget {
  const HabitatInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoContainer(
      content: [
        InfoContent(
            header: 'Habitat',
            content: 'Information about the habitat of the site.'
                ' Note important information about the habitat in the description.'
                ' For example, the dominant tree species, ground cover, etc.'),
      ],
    );
  }
}
