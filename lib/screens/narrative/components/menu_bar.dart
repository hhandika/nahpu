import 'package:nahpu/screens/narrative/narrative_view.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/narrative_services.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

enum MenuSelection {
  newNarrative,
  duplicate,
  pdfExport,
  deleteRecords,
  deleteAllRecords
}

Future<void> createNewNarrative(BuildContext context, WidgetRef ref) {
  return NarrativeServices(ref: ref).createNewNarrative().then((_) {
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
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuSelection>>[
              PopupMenuItem<MenuSelection>(
                value: MenuSelection.newNarrative,
                child: const CreateMenuButton(text: 'Create narrative'),
                onTap: () => createNewNarrative(context, ref),
              ),
              const PopupMenuDivider(height: 10),
              PopupMenuItem<MenuSelection>(
                value: MenuSelection.deleteRecords,
                child: const DeleteMenuButton(
                  deleteAll: false,
                ),
                onTap: () => _deleteNarrative(),
              ),
              PopupMenuItem<MenuSelection>(
                value: MenuSelection.deleteAllRecords,
                child: const DeleteMenuButton(
                  deleteAll: true,
                ),
                onTap: () => _deleteAllNarrative(),
              ),
            ]);
  }

  void _deleteNarrative() {
    showDeleteAlertOnMenu(
      () {
        if (widget.narrativeId != null) {
          NarrativeServices(ref: ref).deleteNarrative(widget.narrativeId!);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const NarrativeViewer()));
        }
      },
      'Delete this narrative?',
      context,
    );
  }

  void _deleteAllNarrative() {
    showDeleteAlertOnMenu(
      () {
        final projectUuid = ref.read(projectUuidProvider.notifier).state;
        NarrativeServices(ref: ref).deleteAllNarrative(projectUuid);
      },
      'Delete all narrative\nTHIS ACTION CANNOT BE UNDONE!',
      context,
    );
  }
}
