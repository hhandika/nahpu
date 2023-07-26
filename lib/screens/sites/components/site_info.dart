import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/site_services.dart';

const List<String> siteTypeList = [
  'City',
  'Town',
  'Hotel',
  'Village',
  'Camp',
  'Trail',
  'Trapline',
  'Netline',
  'Cave',
  'Other',
];

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
    personnelEntry.whenData(
      (personnelEntry) => personnelList = personnelEntry,
    );

    return FormCard(
      isPrimary: true,
      title: 'Site Info',
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      child: AdaptiveLayout(
        useHorizontalLayout: useHorizontalLayout,
        children: [
          TextField(
            controller: siteFormCtr.siteIDCtr,
            inputFormatters: [
              LengthLimitingTextInputFormatter(15),
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-_]+'))
            ],
            decoration: const InputDecoration(
              labelText: 'Site ID',
              hintText:
                  'Enter a site ID (max. 15 chars), e.g. "CAMP-01", "LINE-1"',
            ),
            onChanged: (value) {
              siteFormCtr.siteIDCtr.value = TextEditingValue(
                text: value.toUpperCase(),
                selection: siteFormCtr.siteIDCtr.selection,
              );
              SiteServices(ref: ref).updateSite(
                id,
                SiteCompanion(siteID: db.Value(siteFormCtr.siteIDCtr.text)),
              );
            },
          ),
          DropdownButtonFormField(
            value: siteFormCtr.leadStaffCtr,
            decoration: const InputDecoration(
              labelText: 'Site Leader',
              hintText: 'Choose a person name',
            ),
            items: personnelList
                .map(
                  (e) => DropdownMenuItem(
                    value: e.uuid,
                    child: CommonDropdownText(text: e.name ?? ''),
                  ),
                )
                .toList(),
            onChanged: (String? uuid) {
              SiteServices(ref: ref).updateSite(
                id,
                SiteCompanion(leadStaffId: db.Value(uuid)),
              );
            },
          ),
          DropdownButtonFormField<String?>(
            value: siteFormCtr.siteTypeCtr,
            decoration: const InputDecoration(
              labelText: 'Site Type',
              hintText: 'Choose a site type',
            ),
            items: siteTypeList
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: CommonDropdownText(text: e),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              if (value != null) {
                SiteServices(ref: ref).updateSite(
                  id,
                  SiteCompanion(siteType: db.Value(value)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
