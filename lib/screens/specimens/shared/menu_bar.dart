import 'package:flutter/material.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/specimens/specimen_view.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/specimen_services.dart';

enum MenuSelection { newSpecimen, pdfExport, deleteRecords, deleteAllRecords }

Future<void> createNewSpecimens(BuildContext context, WidgetRef ref) async {
  await SpecimenServices(ref).createSpecimen();
  if (context.mounted) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SpecimenViewer()),
    );
  }
}

class NewSpecimens extends ConsumerWidget {
  const NewSpecimens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline_rounded),
      onPressed: () async {
        createNewSpecimens(context, ref);
      },
    );
  }
}

class SpecimenMenu extends ConsumerStatefulWidget {
  const SpecimenMenu({Key? key}) : super(key: key);

  @override
  NarrativeMenuState createState() => NarrativeMenuState();
}

class NarrativeMenuState extends ConsumerState<SpecimenMenu> {
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
        final projectUuid = ref.read(projectUuidProvider.notifier).state;
        SpecimenQuery(ref.read(databaseProvider))
            .deleteAllSpecimens(projectUuid);
        ref.invalidate(specimenEntryProvider);
        //ref.invalidate(pageNavigationProvider);
        break;
    }
  }
}
