import 'package:nahpu/screens/shared/actions/adaptive_menu.dart';
import 'package:nahpu/screens/shared/dialogs/record_sort_dialog.dart';
import 'package:nahpu/screens/shared/forms/forms.dart';
import 'package:nahpu/services/narrative/narrative_services.dart';
import 'package:nahpu/services/providers/narrative.dart';
import 'package:nahpu/services/providers/page_jump.dart';
import 'package:nahpu/services/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

enum MenuSelection {
  newNarrative,
  duplicate,
  pdfExport,
  sortRecords,
  deleteRecords,
  deleteAllRecords,
}

Future<void> createNewNarrative(BuildContext context, WidgetRef ref) {
  return NarrativeServices(ref: ref).createNewNarrative().then((newId) {
    // Refresh the always-mounted viewer in place and land on the new
    // narrative.
    ref
        .read(pendingRecordJumpProvider(RecordViewer.narrative).notifier)
        .updateState(newId);
    ref.invalidate(narrativeEntryProvider);
  });
}

class NewNarrativeTextButton extends ConsumerStatefulWidget {
  const NewNarrativeTextButton({super.key});

  @override
  NewNarrativeTextButtonState createState() => NewNarrativeTextButtonState();
}

class NewNarrativeTextButtonState
    extends ConsumerState<NewNarrativeTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          await createNewNarrative(context, ref);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }
      },
      child: const Text('Create narrative'),
    );
  }
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
    return AdaptiveMenuButton<MenuSelection>(
      tooltip: 'Narrative actions',
      itemBuilder: _items,
      onSelected: _onSelected,
    );
  }

  List<AdaptiveMenuItem<MenuSelection>> _items() => const [
    AdaptiveMenuItem(
      value: MenuSelection.newNarrative,
      icon: Icons.create_outlined,
      label: 'Create narrative',
    ),
    AdaptiveMenuItem(
      value: MenuSelection.sortRecords,
      icon: Icons.sort_rounded,
      label: 'Sort records',
      hasDividerBefore: true,
    ),
    AdaptiveMenuItem(
      value: MenuSelection.deleteRecords,
      icon: Icons.delete_outline,
      label: 'Delete record',
      isDestructive: true,
      hasDividerBefore: true,
    ),
    AdaptiveMenuItem(
      value: MenuSelection.deleteAllRecords,
      icon: Icons.delete_forever_outlined,
      label: 'Delete all records',
      isDestructive: true,
    ),
  ];

  void _onSelected(MenuSelection action) {
    switch (action) {
      case MenuSelection.newNarrative:
        createNewNarrative(context, ref);
      case MenuSelection.sortRecords:
        showRecordSortDialog(context: context, viewer: RecordViewer.narrative);
      case MenuSelection.deleteRecords:
        _deleteNarrative();
      case MenuSelection.deleteAllRecords:
        _deleteAllNarrative();
      case MenuSelection.duplicate:
      case MenuSelection.pdfExport:
        return;
    }
  }

  void _deleteNarrative() {
    showDeleteAlertOnMenu(
      context: context,
      title: 'Delete narrative?',
      deletePrompt: 'You will delete this narrative',
      onDelete: () async {
        if (widget.narrativeId != null) {
          try {
            await NarrativeServices(
              ref: ref,
            ).deleteNarrative(widget.narrativeId!);
            // Close the delete dialog.
            if (mounted) {
              Navigator.of(context).pop();
            }
            ref.invalidate(narrativeEntryProvider);
          } catch (e) {
            if (context.mounted) {
              _showError(e.toString());
            }
          }
        }
      },
    );
  }

  void _showError(String errors) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error deleting narrative: $errors',
          style: const TextStyle(color: Colors.white),
        ),
      ),
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
          if (context.mounted) {
            _showSuccess();
          }
        } catch (e) {
          if (context.mounted) {
            _showError(e.toString());
          }
        }
      },
    );
  }

  void _showSuccess() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Narrative deleted')));
  }
}
