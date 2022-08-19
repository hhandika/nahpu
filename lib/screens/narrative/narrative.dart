import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import 'package:nahpu/screens/narrative/new_narrative.dart';

enum MenuSelection { newNote, pdfExport, deleteRecords, deleteAllRecords }

class Narrative extends ConsumerStatefulWidget {
  const Narrative({Key? key}) : super(key: key);

  @override
  NarrativeState createState() => NarrativeState();
}

class NarrativeState extends ConsumerState<Narrative> {
  String _selectedMenu = '';

  // @override
  // void initState() {
  //   _narrativeId = widget.
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Narrative"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // await createNewNarrative(proj);
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
      body: Center(
        child: Text('Test popup menu: $_selectedMenu'),
      ),
    );
  }

  void _onPopupMenuSelected(MenuSelection item) {
    switch (item) {
      case MenuSelection.newNote:
        setState(() {
          _selectedMenu = 'Create a new note';
        });
        break;
      case MenuSelection.pdfExport:
        setState(() {
          _selectedMenu = 'Export to pdf';
        });
        break;
      case MenuSelection.deleteRecords:
        setState(() {
          _selectedMenu = 'Delete current note record';
        });
        break;
      case MenuSelection.deleteAllRecords:
        setState(() {
          _selectedMenu = 'Delete all note records';
        });
        break;
    }
  }
}
