import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/services/providers/specimens.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/services/types/specimens.dart';

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
      body: CommonSettingList(
        sections: [
          CommonSettingSection(
            title: 'Catalog Format',
            isDivided: true,
            children: [
              CommonSettingTile(
                title: 'General Mammals',
                icon: MdiIcons.paw,
                trailing: widget.selectedFmt == 'General Mammals'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  ref
                      .read(catalogFmtNotifierProvider.notifier)
                      .set(CatalogFmt.generalMammals);
                  Navigator.pop(context);
                },
              ),
              CommonSettingTile(
                title: 'Birds',
                icon: MdiIcons.owl,
                trailing: widget.selectedFmt == 'Birds'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  ref
                      .read(catalogFmtNotifierProvider.notifier)
                      .set(CatalogFmt.birds);
                  Navigator.pop(context);
                },
              ),
              CommonSettingTile(
                title: 'Bats',
                icon: MdiIcons.bat,
                trailing: widget.selectedFmt == 'Bats'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  ref
                      .read(catalogFmtNotifierProvider.notifier)
                      .set(CatalogFmt.bats);
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
