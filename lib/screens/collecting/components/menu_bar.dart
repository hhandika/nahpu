import 'package:flutter/material.dart';
import 'package:nahpu/screens/collecting/coll_event_view.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MenuSelection {
  newEvent,
  duplicate,
  pdfExport,
  deleteRecords,
  deleteAllRecords
}

Future<void> createNewCollEvents(BuildContext context, WidgetRef ref) {
  CollEventServices services = CollEventServices(ref: ref);

  return services.createNewCollEvents().then(
    (_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const CollEventViewer(),
        ),
      );
    },
  );
}

class NewCollEvents extends ConsumerWidget {
  const NewCollEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline_rounded),
      onPressed: () async {
        createNewCollEvents(context, ref);
      },
    );
  }
}

class CollEventMenu extends ConsumerStatefulWidget {
  const CollEventMenu({
    super.key,
    required this.collEventId,
  });

  final int? collEventId;

  @override
  NarrativeMenuState createState() => NarrativeMenuState();
}

class NarrativeMenuState extends ConsumerState<CollEventMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuSelection>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuSelection>>[
        PopupMenuItem<MenuSelection>(
          value: MenuSelection.newEvent,
          child: const CreateMenuButton(text: 'Create event'),
          onTap: () => createNewCollEvents(context, ref),
        ),
        // const PopupMenuItem<MenuSelection>(
        //   value: MenuSelection.duplicate,
        //   child: DuplicateMenuButton(text: 'Duplicate event'),
        // ),
        const PopupMenuDivider(height: 10),
        PopupMenuItem<MenuSelection>(
          value: MenuSelection.deleteRecords,
          child: const DeleteMenuButton(deleteAll: false),
          onTap: () => _deleteEvent(),
        ),
        PopupMenuItem<MenuSelection>(
          value: MenuSelection.deleteAllRecords,
          child: const DeleteMenuButton(deleteAll: true),
          onTap: () => _deleteAllEvents(),
        ),
      ],
    );
  }

  void _deleteEvent() {
    if (widget.collEventId != null) {
      showDeleteAlertOnMenu(
        context: context,
        title: 'Delete collecting event?',
        deletePrompt: 'You will also delete collecting effort'
            ', collecting personnel, and weather data in this event.',
        onDelete: () async {
          try {
            await CollEventServices(ref: ref)
                .deleteCollEvent(widget.collEventId!);
            if (mounted) {
              Navigator.of(context).pop();
              // We need to trigger a rebuild of the CollEventViewer
              // to update page numbers and the CollEventViewer
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const CollEventViewer(),
                ),
              );
            }
          } catch (e) {
            _showError(e.toString());
          }
        },
      );
    }
  }

  void _deleteAllEvents() {
    final projectUuid = ref.read(projectUuidProvider);
    showDeleteAlertOnMenu(
      context: context,
      title: 'Delete all collecting events?',
      deletePrompt:
          'Deleting all collecting events will also delete all associated'
          ' collecting effort, collecting personnel, '
          'and weather data from the database.',
      onDelete: () async {
        try {
          final service = CollEventServices(ref: ref);
          await service.deleteAllCollEvents(projectUuid);

          if (mounted) {
            Navigator.of(context).pop();
          }
        } catch (e) {
          _showError(e.toString());
        }
      },
    );
  }

  void _showError(String errors) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errors.contains('SqliteException(787)')
              ? 'Failed to delete the events.'
                  ' The events are currently in use by other records.'
              : errors.toString(),
        ),
      ),
    );
  }
}
