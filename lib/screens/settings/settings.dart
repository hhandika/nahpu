import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/screens/settings/collevent_settings.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/screens/settings/shared.dart';
import 'package:nahpu/screens/settings/specimen_settings.dart';
import 'package:nahpu/styles/settings.dart';
import 'package:settings_ui/settings_ui.dart';

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
        title: const Text('Project Settings'),
      ),
      body: SafeArea(
        child: SettingsList(
          lightTheme: getSettingData(context),
          darkTheme: getSettingData(context),
          sections: [
            ref.watch(catalogFmtNotifierProvider).when(
                  data: (data) =>
                      GeneralSettings(ref: ref, catalogFmt: data).getSetting(),
                  loading: () => const SettingsSection(
                    title: SettingTitle(title: 'Loading...'),
                    tiles: [],
                  ),
                  error: (e, s) => const SettingsSection(
                    title: SettingTitle(title: 'Error'),
                    tiles: [],
                  ),
                ),
            AppearanceSettings(ref: ref).getSetting(),
          ],
        ),
      ),
    );
  }
}

class GeneralSettings {
  GeneralSettings({
    required this.ref,
    required this.catalogFmt,
  });

  final WidgetRef ref;
  final CatalogFmt catalogFmt;

  SettingsSection getSetting() {
    return SettingsSection(
      title: const SettingTitle(title: 'Catalog Settings'),
      tiles: [
        _getCatalogFmtSetting(),
        _getCollEventSettings(),
        _getSpecimenPartSettings(),
      ],
    );
  }

  SettingsTile _getCatalogFmtSetting() {
    final selectedFmt = matchCatFmtToTaxonGroup(catalogFmt);
    return SettingsTile.navigation(
      leading: Icon(MdiIcons.fileCabinet),
      title: const SettingTitle(title: 'Catalog Format'),
      value: Text(selectedFmt),
      onPressed: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatalogFmtSelection(
            selectedFmt: selectedFmt,
          ),
        ),
      ),
    );
  }

  SettingsTile _getSpecimenPartSettings() {
    return SettingsTile.navigation(
      leading: Icon(matchCatFmtToIcon(catalogFmt, false)),
      title: const SettingTitle(title: 'Specimens'),
      onPressed: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SpecimenSelection(),
        ),
      ),
    );
  }

  SettingsTile _getCollEventSettings() {
    return SettingsTile.navigation(
      leading: const Icon(Icons.calendar_month_outlined),
      title: const SettingTitle(title: 'Collecting Events'),
      onPressed: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CollEventSelection(),
        ),
      ),
    );
  }
}

class CatalogFmtSelection extends ConsumerStatefulWidget {
  const CatalogFmtSelection({super.key, required this.selectedFmt});
  final String selectedFmt;
  @override
  CatalogFmtSelectionState createState() => CatalogFmtSelectionState();
}

class CatalogFmtSelectionState extends ConsumerState<CatalogFmtSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog Format'),
      ),
      body: SettingsList(
          lightTheme: getSettingData(context),
          darkTheme: getSettingData(context),
          sections: [
            SettingsSection(
                title: const SettingTitle(title: 'Catalog Format'),
                tiles: [
                  SettingsTile(
                    title: const Text('General Mammals'),
                    leading: Icon(MdiIcons.paw),
                    trailing: widget.selectedFmt == 'General Mammals'
                        ? const Icon(Icons.check)
                        : null,
                    onPressed: (context) {
                      ref
                          .read(catalogFmtNotifierProvider.notifier)
                          .set(CatalogFmt.generalMammals);
                      Navigator.pop(context);
                    },
                  ),
                  SettingsTile(
                    title: const Text('Birds'),
                    leading: Icon(MdiIcons.owl),
                    trailing: widget.selectedFmt == 'Birds'
                        ? const Icon(Icons.check)
                        : null,
                    onPressed: (context) {
                      ref
                          .read(catalogFmtNotifierProvider.notifier)
                          .set(CatalogFmt.birds);
                      Navigator.pop(context);
                    },
                  ),
                  SettingsTile(
                    title: const Text('Bats'),
                    leading: Icon(MdiIcons.bat),
                    trailing: widget.selectedFmt == 'Bats'
                        ? const Icon(Icons.check)
                        : null,
                    onPressed: (context) {
                      ref
                          .read(catalogFmtNotifierProvider.notifier)
                          .set(CatalogFmt.bats);
                      Navigator.pop(context);
                    },
                  ),
                ])
          ]),
    );
  }
}
