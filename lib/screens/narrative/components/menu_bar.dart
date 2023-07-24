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
      context: context,
      title: 'Delete narrative?',
      deletePrompt: 'You will delete this narrative',
      onDelete: () async {
        if (widget.narrativeId != null) {
          try {
            await NarrativeServices(ref: ref)
                .deleteNarrative(widget.narrativeId!);
            if (mounted) {
              Navigator.of(context).pop();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const NarrativeViewer()));
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error deleting narrative: $e',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }

  void _deleteAllNarrative() {
    showDeleteAlertOnMenu(
      context: context,
      title: 'Delete all narrative?',
      deletePrompt: 'You will delete all narrative in this project',
      onDelete: () async {
        final projectUuid = ref.read(projectUuidProvider);
        try {
          await NarrativeServices(ref: ref).deleteAllNarrative(projectUuid);
          if (mounted) {
            Navigator.of(context).pop();
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error deleting all narrative: $e',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }
}
