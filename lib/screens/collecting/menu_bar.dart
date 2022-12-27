import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/providers/catalogs.dart';

import 'package:nahpu/services/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/collecting/new_coll_events.dart';
// import 'package:nahpu/providers/page_viewer.dart';

enum MenuSelection { newEvent, pdfExport, deleteRecords, deleteAllRecords }

Future<void> createNewCollEvents(BuildContext context, WidgetRef ref) {
  String projectUuid = ref.watch(projectUuidProvider);

  return ref
      .read(databaseProvider)
      .createCollEvent(CollEventCompanion(
        projectUuid: db.Value(projectUuid),
      ))
      .then((value) {
    ref.invalidate(collEventEntryProvider);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => NewCollEventForm(
              collEventId: value,
            )));
  });
}

class NewCollEvents extends ConsumerWidget {
  const NewCollEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_rounded),
      onPressed: () async {
        createNewCollEvents(context, ref);
      },
    );
  }
}

class CollEventMenu extends ConsumerStatefulWidget {
  const CollEventMenu({Key? key}) : super(key: key);

  @override
  NarrativeMenuState createState() => NarrativeMenuState();
}

class NarrativeMenuState extends ConsumerState<CollEventMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuSelection>(
        // Callback that sets the selected popup menu item.
        onSelected: _onPopupMenuSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuSelection>>[
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.newEvent,
                child: Text('Create a new event'),
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
      case MenuSelection.newEvent:
        createNewCollEvents(context, ref);
        break;
      case MenuSelection.pdfExport:
        break;
      case MenuSelection.deleteRecords:
        break;
      case MenuSelection.deleteAllRecords:
        final projectUuid = ref.read(projectUuidProvider.notifier).state;
        ref.read(databaseProvider).deleteAllCollEvents(projectUuid);
        //ref.invalidate(collEventEntryProvider);
        //ref.invalidate(pageNavigationProvider);
        break;
    }
  }
}
