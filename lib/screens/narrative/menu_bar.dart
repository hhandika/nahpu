import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;

import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/narrative/new_narrative.dart';
import 'package:nahpu/providers/narrative.dart';

enum MenuSelection { newNarrative, pdfExport, deleteRecords, deleteAllRecords }

Future<void> createNewNarrative(BuildContext context, WidgetRef ref) {
  String projectUuid = ref.watch(projectUuidProvider.state).state;

  return ref
      .read(databaseProvider)
      .createNarrative(NarrativeCompanion(
        projectUuid: db.Value(projectUuid),
      ))
      .then((value) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => NewNarrativeForm(
              narrativeId: value,
            )));
  });
}

class NewNarrative extends ConsumerWidget {
  const NewNarrative({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_rounded),
      onPressed: () async {
        createNewNarrative(context, ref);
      },
    );
  }
}

class NarrativeMenu extends ConsumerStatefulWidget {
  const NarrativeMenu({Key? key}) : super(key: key);

  @override
  NarrativeMenuState createState() => NarrativeMenuState();
}

class NarrativeMenuState extends ConsumerState<NarrativeMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuSelection>(
        // Callback that sets the selected popup menu item.
        onSelected: _onPopupMenuSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuSelection>>[
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.newNarrative,
                child: Text('Create a new narrative'),
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
      case MenuSelection.newNarrative:
        break;
      case MenuSelection.pdfExport:
        break;
      case MenuSelection.deleteRecords:
        break;
      case MenuSelection.deleteAllRecords:
        final projectUuid = ref.read(projectUuidProvider.state).state;
        ref.read(databaseProvider).deleteAllNarrative(projectUuid);
        ref.refresh(narrativeEntryProvider);
        ref.refresh(pageNavigationProvider);
        break;
    }
  }
}
