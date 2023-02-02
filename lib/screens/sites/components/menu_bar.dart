import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/sites/new_sites.dart';
import 'package:nahpu/services/site_services.dart';

enum MenuSelection { newSite, pdfExport, deleteRecords, deleteAllRecords }

Future<void> createNewSite(BuildContext context, WidgetRef ref) {
  String projectUuid = ref.watch(projectUuidProvider);

  return SiteServices(ref).createNewSite(projectUuid).then((value) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => NewSites(
              id: value,
            )));
  });
}

class NewSite extends ConsumerWidget {
  const NewSite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline_rounded),
      onPressed: () async {
        createNewSite(context, ref);
      },
    );
  }
}

class SiteMenu extends ConsumerStatefulWidget {
  const SiteMenu({Key? key}) : super(key: key);

  @override
  SiteMenuState createState() => SiteMenuState();
}

class SiteMenuState extends ConsumerState<SiteMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuSelection>(
        // Callback that sets the selected popup menu item.
        onSelected: _onPopupMenuSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuSelection>>[
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.newSite,
                child: Text('Create a new site'),
              ),
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.pdfExport,
                child: Text('Export to PDF'),
              ),
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.deleteRecords,
                child: Text('Delete current record',
                    style: TextStyle(color: Colors.red)),
              ),
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.deleteAllRecords,
                child: Text('Delete all records',
                    style: TextStyle(color: Colors.red)),
              ),
            ]);
  }

  void _onPopupMenuSelected(MenuSelection item) {
    switch (item) {
      case MenuSelection.newSite:
        createNewSite(context, ref);
        break;
      case MenuSelection.pdfExport:
        break;
      case MenuSelection.deleteRecords:
        break;
      case MenuSelection.deleteAllRecords:
        SiteServices(ref).deleteAllSites();
        break;
    }
  }
}
