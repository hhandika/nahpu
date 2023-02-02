import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/services/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/collecting/new_coll_events.dart';
import 'package:nahpu/services/collevent_queries.dart';

enum MenuSelection { newEvent, pdfExport, deleteRecords, deleteAllRecords }

Future<void> createNewCollEvents(BuildContext context, WidgetRef ref) {
  String projectUuid = ref.watch(projectUuidProvider);

  return CollEventQuery(ref.read(databaseProvider))
      .createCollEvent(CollEventCompanion(
    projectUuid: db.Value(projectUuid),
  ))
      .then(
    (value) {
      // Weather data used collect event id as a foreign key
      // so we need to create a new weather data entry
      // for the new collect event
      WeatherDataQuery(ref.read(databaseProvider)).createWeatherData(
        WeatherCompanion(
          eventID: db.Value(value),
        ),
      );
      ref.invalidate(collEventEntryProvider);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => NewCollEventForm(
            collEventId: value,
          ),
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
  const CollEventMenu({Key? key}) : super(key: key);

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
                child: Text('Create a new event'),
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
      case MenuSelection.newEvent:
        createNewCollEvents(context, ref);
        break;
      case MenuSelection.pdfExport:
        break;
      case MenuSelection.deleteRecords:
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
