import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/screens/settings/shared.dart';
import 'package:nahpu/screens/settings/specimen_settings.dart';
import 'package:settings_ui/settings_ui.dart';

class ProjectSettings extends ConsumerStatefulWidget {
  const ProjectSettings({Key? key}) : super(key: key);

  @override
  ProjectSettingState createState() => ProjectSettingState();
}

class ProjectSettingState extends ConsumerState<ProjectSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Settings'),
      ),
      body: SafeArea(
        child: SettingsList(
          sections: [
            GeneralSettings(ref: ref).getSetting(),
            AppearanceSettings(ref: ref).getSetting(),
          ],
        ),
      ),
    );
  }
}

class GeneralSettings {
  GeneralSettings({required this.ref});

  final WidgetRef ref;

  SettingsSection getSetting() {
    return SettingsSection(
      title: const Text('Catalog Settings'),
      tiles: [
        getCatalogFmtSetting(),
        getSpecimenPartSettings(),
      ],
    );
  }

  SettingsTile getCatalogFmtSetting() {
    final catalogFmt = ref.watch(catalogFmtNotifier);
    final selectedFmt = matchCatFmtToTaxonGroup(catalogFmt);
    return SettingsTile.navigation(
      leading: const Icon(MdiIcons.fileCabinet),
      title: const Text('Format'),
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

  SettingsTile getSpecimenPartSettings() {
    CatalogFmt catalogFmt = ref.watch(catalogFmtNotifier);
    return SettingsTile.navigation(
      leading: Icon(matchCatFmtToIcon(catalogFmt, false)),
      title: const Text('Specimen Parts'),
      onPressed: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SpecimenPartSelection(),
        ),
      ),
    );
  }
}

class CatalogFmtSelection extends ConsumerStatefulWidget {
  const CatalogFmtSelection({Key? key, required this.selectedFmt})
      : super(key: key);
  final String selectedFmt;
  @override
  CatalogFmtSelectionState createState() => CatalogFmtSelectionState();
}

class CatalogFmtSelectionState extends ConsumerState<CatalogFmtSelection> {
  final List<String> catalogFmtOpts = ['General Mammals', 'Birds', 'Bats'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog Format'),
      ),
      body: SettingsList(sections: [
        SettingsSection(title: const Text('Catalog Format'), tiles: [
          SettingsTile(
            title: const Text('General Mammals'),
            leading: const Icon(MdiIcons.paw),
            trailing: widget.selectedFmt == 'General Mammals'
                ? const Icon(Icons.check)
                : null,
            onPressed: (context) {
              ref
                  .read(catalogFmtNotifier.notifier)
                  .setCatalogFmt(CatalogFmt.generalMammals);
              Navigator.pop(context);
            },
          ),
          SettingsTile(
            title: const Text('Birds'),
            leading: const Icon(MdiIcons.owl),
            trailing:
                widget.selectedFmt == 'Birds' ? const Icon(Icons.check) : null,
            onPressed: (context) {
              ref
                  .read(catalogFmtNotifier.notifier)
                  .setCatalogFmt(CatalogFmt.birds);
              Navigator.pop(context);
            },
          ),
          SettingsTile(
            title: const Text('Bats'),
            leading: const Icon(MdiIcons.bat),
            trailing:
                widget.selectedFmt == 'Bats' ? const Icon(Icons.check) : null,
            onPressed: (context) {
              ref
                  .read(catalogFmtNotifier.notifier)
                  .setCatalogFmt(CatalogFmt.bats);
              Navigator.pop(context);
            },
          ),
        ])
      ]),
    );
  }
}
