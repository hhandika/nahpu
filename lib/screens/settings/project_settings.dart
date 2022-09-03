import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/models/catalogs.dart';
import 'package:nahpu/providers/catalog.dart';
import 'package:settings_ui/settings_ui.dart';

class ProjectSettings extends StatefulWidget {
  const ProjectSettings({Key? key}) : super(key: key);

  @override
  State<ProjectSettings> createState() => _ProjectSettingsState();
}

class _ProjectSettingsState extends State<ProjectSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Project Settings'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: const SafeArea(
          child: Center(
            child: CatalogSettings(),
          ),
        ));
  }
}

class CatalogSettings extends ConsumerWidget {
  const CatalogSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogFmt = ref.watch(catalogFmtProvider);
    final selectedFmt = _parseCatalogFmt(catalogFmt);
    return SettingsList(sections: [
      SettingsSection(title: const Text('Catalog'), tiles: [
        SettingsTile.navigation(
          leading: const Icon(MdiIcons.fileCabinet),
          title: const Text('Catalog Format'),
          value: Text(selectedFmt),
          onPressed: (context) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CatalogFmtSelection(
                selectedFmt: selectedFmt,
              ),
            ),
          ),
        ),
      ])
    ]);
  }

  String _parseCatalogFmt(CatalogFmt fmt) {
    switch (fmt) {
      case CatalogFmt.generalMammals:
        return 'General Mammals';
      case CatalogFmt.bats:
        return 'Bats';
      case CatalogFmt.birds:
        return 'Birds';
    }
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
  final List<String> catalogFmtOpts = ['General Mammals', 'Birds'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog Format'),
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                  .read(catalogFmtProvider.notifier)
                  .setCatalogFmt(CatalogFmt.generalMammals);
              Navigator.pop(context);
            },
          ),
          SettingsTile(
            title: const Text('Birds'),
            leading: const Icon(MdiIcons.feather),
            trailing:
                widget.selectedFmt == 'Birds' ? const Icon(Icons.check) : null,
            onPressed: (context) {
              ref
                  .read(catalogFmtProvider.notifier)
                  .setCatalogFmt(CatalogFmt.birds);
              Navigator.pop(context);
            },
          ),
        ])
      ]),
    );
  }
}
