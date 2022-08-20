import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as db;

// import 'package:intl/intl.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';
import 'package:nahpu/screens/narrative/narrative_form.dart';

enum MenuSelection { newNote, pdfExport, deleteRecords, deleteAllRecords }

class NewNarrative extends ConsumerStatefulWidget {
  const NewNarrative({Key? key, required this.narrativeId}) : super(key: key);

  final int narrativeId;

  @override
  NewNarrativeState createState() => NewNarrativeState();
}

class NewNarrativeState extends ConsumerState<NewNarrative>
    with TickerProviderStateMixin {
  final dateController = TextEditingController();
  final narrativeController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Narrative"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () async {
              // createNewNarrative(projectUuid, context, ref);
            },
          ),
          PopupMenuButton<MenuSelection>(
              // Callback that sets the selected popup menu item.
              onSelected: _onPopupMenuSelected,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<MenuSelection>>[
                    const PopupMenuItem<MenuSelection>(
                      value: MenuSelection.newNote,
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
                      child: Text('Delete all note records',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ])
        ],
      ),
      body: SafeArea(
        child: NarrativeForm(
          narrativeId: widget.narrativeId,
          dateController: dateController,
          narrativeController: narrativeController,
        ),
      ),
    );
  }

  void _onPopupMenuSelected(MenuSelection item) {
    switch (item) {
      case MenuSelection.newNote:
        setState(() {});
        break;
      case MenuSelection.pdfExport:
        setState(() {});
        break;
      case MenuSelection.deleteRecords:
        setState(() {});
        break;
      case MenuSelection.deleteAllRecords:
        setState(() {});
        break;
    }
  }
}

Future<void> createNewNarrative(BuildContext context, WidgetRef ref) {
  String projectUuid = ref.watch(projectUuidProvider.state).state;
  return ref
      .read(databaseProvider)
      .createNarrative(NarrativeCompanion(
        projectUuid: db.Value(projectUuid),
      ))
      .then((value) => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => NewNarrative(
                narrativeId: value,
              ))));
}
