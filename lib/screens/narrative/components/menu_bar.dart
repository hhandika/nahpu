import 'package:nahpu/screens/narrative/narrative_view.dart';
import 'package:nahpu/services/narrative_services.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nahpu/screens/narrative/new_narrative.dart';
import 'package:flutter/material.dart';

enum MenuSelection { newNarrative, pdfExport, deleteRecords, deleteAllRecords }

Future<void> createNewNarrative(BuildContext context, WidgetRef ref) {
  String projectUuid = ref.watch(projectUuidProvider);
  return NarrativeServices(ref).createNewNarrative(projectUuid).then((_) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const NarrativeViewer()));
  });
}

class NewNarrative extends ConsumerWidget {
  const NewNarrative({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline_rounded),
      onPressed: () {
        createNewNarrative(context, ref);
      },
    );
  }
}

class NarrativeMenu extends ConsumerStatefulWidget {
  const NarrativeMenu({super.key, required this.narrativeId});

  final int? narrativeId;

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
        createNewNarrative(context, ref);
        break;
      case MenuSelection.pdfExport:
        break;
      case MenuSelection.deleteRecords:
        if (widget.narrativeId != null) {
          NarrativeServices(ref).deleteNarrative(widget.narrativeId!);
        }
        break;
      case MenuSelection.deleteAllRecords:
        final projectUuid = ref.read(projectUuidProvider.notifier).state;
        NarrativeServices(ref).deleteAllNarrative(projectUuid);

        break;
    }
  }
}
