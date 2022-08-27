import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;

import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/collecting/new_coll_events.dart';
import 'package:nahpu/providers/page_viewer.dart';

enum MenuSelection { newSpecimen, pdfExport, deleteRecords, deleteAllRecords }

Future<void> createNewSpecimens(BuildContext context, WidgetRef ref) {
  String projectUuid = ref.watch(projectUuidProvider.state).state;

  return ref
      .read(databaseProvider)
      .createSpecimen(SpecimenCompanion(
        projectUuid: db.Value(projectUuid),
      ))
      .then((value) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => NewCollEventForm(
              collEventId: value,
            )));
  });
}

class NewSpecimens extends ConsumerWidget {
  const NewSpecimens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_rounded),
      onPressed: () async {
        createNewSpecimens(context, ref);
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
        onSelected: _onPopupMenuSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuSelection>>[
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.newSpecimen,
                child: Text('Create a new record'),
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
      case MenuSelection.newSpecimen:
        createNewSpecimens(context, ref);
        break;
      case MenuSelection.pdfExport:
        break;
      case MenuSelection.deleteRecords:
        break;
      case MenuSelection.deleteAllRecords:
        final projectUuid = ref.read(projectUuidProvider.state).state;
        ref.read(databaseProvider).deleteAllSpecimens(projectUuid);
        ref.refresh(collEventEntryProvider);
        ref.refresh(pageNavigationProvider);
        break;
    }
  }
}
