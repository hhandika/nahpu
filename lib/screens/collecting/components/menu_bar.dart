import 'package:flutter/material.dart';
import 'package:nahpu/providers/collevents.dart';
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
        const PopupMenuItem<MenuSelection>(
          value: MenuSelection.duplicate,
          child: DuplicateMenuButton(text: 'Duplicate event'),
        ),
        const PopupMenuItem<MenuSelection>(
          value: MenuSelection.pdfExport,
          child: PdfExportMenuButton(),
        ),
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
        () {
          CollEventServices(ref: ref).deleteCollEvent(widget.collEventId!);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const CollEventViewer(),
            ),
          );
        },
        'Delete this collecting event?',
        context,
      );
    }
  }

  void _deleteAllEvents() {
    final projectUuid = ref.read(projectUuidProvider.notifier).state;
    showDeleteAlertOnMenu(
      () {
        CollEventServices(ref: ref).deleteAllCollEvents(projectUuid);
        ref.invalidate(collEventEntryProvider);
      },
      'Delete all collecting events?\nTHIS ACTION CANNOT BE UNDONE!.',
      context,
    );
  }
}
