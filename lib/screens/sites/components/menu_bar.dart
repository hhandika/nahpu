import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/sites/site_view.dart';
import 'package:nahpu/services/site_services.dart';

Future<void> createNewSite(BuildContext context, WidgetRef ref) {
  String projectUuid = ref.watch(projectUuidProvider);

  return SiteServices(ref).createNewSite(projectUuid).then((_) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SiteViewer()));
  });
}

class NewSite extends ConsumerWidget {
  const NewSite({super.key});

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
  const SiteMenu({
    super.key,
    required this.siteId,
  });

  final int? siteId;

  @override
  SiteMenuState createState() => SiteMenuState();
}

class SiteMenuState extends ConsumerState<SiteMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SiteMenuSelection>(
        // Callback that sets the selected popup menu item.
        onSelected: _onPopupMenuSelected,
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<SiteMenuSelection>>[
              const PopupMenuItem<SiteMenuSelection>(
                value: SiteMenuSelection.newSite,
                child: ListTile(
                  leading: Icon(Icons.create_outlined),
                  title: Text('Create a new site'),
                ),
              ),
              const PopupMenuItem<SiteMenuSelection>(
                value: SiteMenuSelection.duplicate,
                child: ListTile(
                  leading: Icon(Icons.copy_outlined),
                  title: Text('Duplicate site'),
                ),
              ),
              const PopupMenuItem<SiteMenuSelection>(
                  value: SiteMenuSelection.pdfExport,
                  child: ListTile(
                    leading: Icon(Icons.picture_as_pdf_outlined),
                    title: Text('Export to PDF'),
                  )),
              const PopupMenuDivider(height: 10),
              const PopupMenuItem<SiteMenuSelection>(
                  value: SiteMenuSelection.deleteRecords,
                  child: ListTile(
                    leading: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Delete record',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )),
              const PopupMenuItem<SiteMenuSelection>(
                value: SiteMenuSelection.deleteAllRecords,
                child: ListTile(
                  leading: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Delete all records',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ]);
  }

  void _onPopupMenuSelected(SiteMenuSelection item) {
    switch (item) {
      case SiteMenuSelection.newSite:
        createNewSite(context, ref);
        break;
      case SiteMenuSelection.duplicate:
        break;
      case SiteMenuSelection.pdfExport:
        break;
      case SiteMenuSelection.deleteRecords:
        if (widget.siteId != null) {
          SiteServices(ref).deleteSite(widget.siteId!);
        }
        break;
      case SiteMenuSelection.deleteAllRecords:
        SiteServices(ref).deleteAllSites();
        break;
    }
  }
}
