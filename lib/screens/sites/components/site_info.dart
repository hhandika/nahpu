import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/controller/updaters.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database.dart';
import 'package:nahpu/models/form.dart';

class SiteInfo extends ConsumerWidget {
  const SiteInfo({
    Key? key,
    required this.id,
    required this.useHorizontalLayout,
    required this.siteFormCtr,
  }) : super(key: key);

  final int id;
  final bool useHorizontalLayout;
  final SiteFormCtrModel siteFormCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PersonnelData> personnelList = [];
    final personnelEntry = ref.watch(personnelListProvider);
    personnelEntry.when(
      data: (personnelEntry) => personnelList = personnelEntry,
      loading: () => null,
      error: (e, s) => null,
    );

    return FormCard(
      isPrimary: true,
      title: 'Site Info',
      child: AdaptiveLayout(
        useHorizontalLayout: useHorizontalLayout,
        children: [
          TextFormField(
            controller: siteFormCtr.siteIDCtr,
            maxLength: 10,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-_]+'))
            ],
            decoration: const InputDecoration(
              labelText: 'Site ID',
              hintText: 'Enter a site ID, e.g. "CAMP-01", "LINE-1"',
            ),
            onChanged: (value) {
              updateSite(id,
                  SiteCompanion(siteID: db.Value(value.toUpperCase())), ref);
            },
          ),
          DropdownButtonFormField(
            value: siteFormCtr.leadStaffCtr,
            decoration: const InputDecoration(
              labelText: 'Lead Staff',
              hintText: 'Choose a lead staff',
            ),
            items: personnelList
                .map(
                  (e) => DropdownMenuItem(
                    value: e.uuid,
                    child: Text(e.name ?? ''),
                  ),
                )
                .toList(),
            onChanged: (String? uuid) {
              updateSite(id, SiteCompanion(leadStaffId: db.Value(uuid)), ref);
            },
          ),
          TextFormField(
            controller: siteFormCtr.siteTypeCtr,
            decoration: const InputDecoration(
              labelText: 'Site Type',
              hintText: 'Enter a site type, e.g. "Camp", "City", "etc."',
            ),
            onChanged: (value) {
              updateSite(id, SiteCompanion(siteType: db.Value(value)), ref);
            },
          ),
        ],
      ),
    );
  }
}
