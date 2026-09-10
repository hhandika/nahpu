import 'package:material_ui/material_ui.dart';
import 'package:nahpu/screens/shared/actions/adaptive_menu.dart';

/// App-bar actions shared by document, template, and tabular preset screens.
///
/// Export is offered at two scopes: the selected item alone, and everything.
/// The selected-item entry is hidden when nothing is selected.
class PresetAppBarActions extends StatelessWidget {
  const PresetAppBarActions({
    super.key,
    required this.onCreate,
    required this.onScanQr,
    required this.onImport,
    required this.onExportAll,
    this.onExportSelected,
    this.itemName = 'preset',
  });

  final VoidCallback onCreate;
  final VoidCallback onScanQr;
  final VoidCallback onImport;
  final VoidCallback onExportAll;

  /// Exports only the currently selected item, when there is one.
  final VoidCallback? onExportSelected;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onCreate,
          icon: const Icon(Icons.add_circle_outline_rounded),
          tooltip: 'Create new $itemName',
        ),
        AdaptiveMenuButton<_PresetMenuAction>(
          tooltip:
              '${itemName[0].toUpperCase()}${itemName.substring(1)} options',
          itemBuilder: _items,
          onSelected: _onSelected,
        ),
      ],
    );
  }

  List<AdaptiveMenuItem<_PresetMenuAction>> _items() => [
    const AdaptiveMenuItem(
      value: _PresetMenuAction.create,
      icon: Icons.add_circle_outline_rounded,
      label: 'Create new',
    ),
    const AdaptiveMenuItem(
      value: _PresetMenuAction.scanQr,
      icon: Icons.qr_code_scanner_outlined,
      label: 'Scan QR',
      hasDividerBefore: true,
    ),
    const AdaptiveMenuItem(
      value: _PresetMenuAction.import,
      icon: Icons.file_download_outlined,
      label: 'Import',
    ),
    if (onExportSelected != null)
      AdaptiveMenuItem(
        value: _PresetMenuAction.exportSelected,
        icon: Icons.file_upload_outlined,
        label: 'Export this $itemName',
      ),
    AdaptiveMenuItem(
      value: _PresetMenuAction.exportAll,
      icon: Icons.drive_folder_upload_outlined,
      // Only distinguish the scopes when both are offered.
      label: onExportSelected == null ? 'Export' : 'Export all ${itemName}s',
    ),
  ];

  void _onSelected(_PresetMenuAction action) {
    switch (action) {
      case _PresetMenuAction.create:
        onCreate();
      case _PresetMenuAction.scanQr:
        onScanQr();
      case _PresetMenuAction.import:
        onImport();
      case _PresetMenuAction.exportSelected:
        onExportSelected?.call();
      case _PresetMenuAction.exportAll:
        onExportAll();
    }
  }
}

enum _PresetMenuAction { create, scanQr, import, exportSelected, exportAll }
