import 'package:flutter/material.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/collecting/coll_event_view.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/collevent_queries.dart';

enum MenuSelection {
  newEvent,
  duplicate,
  pdfExport,
  deleteRecords,
  deleteAllRecords
}

Future<void> createNewCollEvents(BuildContext context, WidgetRef ref) {
  CollEventServices services = CollEventServices(ref);

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
        // Callback that sets the selected popup menu item.
        onSelected: _onPopupMenuSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuSelection>>[
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.newEvent,
                child: CreateMenuButton(text: 'Create event'),
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
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.deleteRecords,
                child: DeleteMenuButton(deleteAll: false),
              ),
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.deleteAllRecords,
                child: DeleteMenuButton(deleteAll: true),
              ),
            ]);
  }

  void _onPopupMenuSelected(MenuSelection item) {
    switch (item) {
      case MenuSelection.newEvent:
        createNewCollEvents(context, ref);
        break;
      case MenuSelection.duplicate:
        break;
      case MenuSelection.pdfExport:
        break;

      case MenuSelection.deleteRecords:
        if (widget.collEventId != null) {
          CollEventServices(ref).deleteCollEvent(widget.collEventId!);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const CollEventViewer(),
            ),
          );
        }
        break;
      case MenuSelection.deleteAllRecords:
        // TODO: Prevent deleting all records if there are being used.
        final projectUuid = ref.read(projectUuidProvider.notifier).state;
        CollEventQuery(ref.read(databaseProvider))
            .deleteAllCollEvents(projectUuid);
        ref.invalidate(collEventEntryProvider);
        break;
    }
  }
}
