import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/screens/settings/catalog_format.dart';
import 'package:nahpu/screens/settings/collevent_settings.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/types/specimens.dart';
import 'package:nahpu/screens/settings/application_settings.dart';
import 'package:nahpu/screens/settings/specimen_settings.dart';

class AppSettings extends ConsumerStatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  ProjectSettingState createState() => ProjectSettingState();
}

class ProjectSettingState extends ConsumerState<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: CommonSettingList(
          sections: [
            ref.watch(catalogFmtNotifierProvider).when(
                  data: (data) => CatalogSettings(ref: ref, catalogFmt: data),
                  loading: () => const CommonProgressIndicator(),
                  error: (e, s) => const Text('Error'),
                ),
            const AppearanceSetting(),
          ],
        ),
      ),
    );
  }
}

class CatalogSettings extends StatelessWidget {
  const CatalogSettings({
    super.key,
    required this.ref,
    required this.catalogFmt,
  });

  final WidgetRef ref;
  final CatalogFmt catalogFmt;

  @override
  Widget build(BuildContext context) {
    return CommonSettingSection(
      title: 'Catalogs',
      children: [
        CatalogFmtSection(selectedFmt: matchCatFmtToTaxonGroup(catalogFmt)),
        SpecimenSection(catalogFmt: catalogFmt),
        const CollEventSection(),
      ],
    );
  }
}

class CatalogFmtSection extends StatelessWidget {
  const CatalogFmtSection({super.key, required this.selectedFmt});

  final String selectedFmt;

  @override
  Widget build(BuildContext context) {
    return CommonSettingTile(
        isNavigation: true,
        icon: MdiIcons.fileCabinet,
        title: 'Catalog Format',
        value: selectedFmt,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CatalogFmtSelection(
                selectedFmt: selectedFmt,
              ),
            ),
          );
        });
  }
}

class SpecimenSection extends StatelessWidget {
  const SpecimenSection({super.key, required this.catalogFmt});

  final CatalogFmt catalogFmt;

  @override
  Widget build(BuildContext context) {
    return CommonSettingTile(
        isNavigation: true,
        icon: matchCatFmtToIcon(catalogFmt, false),
        title: 'Specimens',
        label: 'Set tissue ID, specimen type, treatments and more',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SpecimenSelection(),
            ),
          );
        });
  }
}

class CollEventSection extends StatelessWidget {
  const CollEventSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSettingTile(
      isNavigation: true,
      icon: Icons.calendar_month_outlined,
      title: 'Collecting Events',
      label: 'Set collecting methods and coll. personnel roles',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CollEventSelection(),
        ),
      ),
    );
  }
}
