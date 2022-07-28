import 'package:flutter/material.dart';

enum MenuSelection { newEvent, pdfExport, deleteRecords, deleteAllRecords }

class CollEvents extends StatefulWidget {
  const CollEvents({Key? key}) : super(key: key);

  @override
  State<CollEvents> createState() => _CollEventsState();
}

class _CollEventsState extends State<CollEvents> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collecting Events"),
        backgroundColor: const Color(0xFF2457C5),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (_) => const Search()));
            },
          ),
          PopupMenuButton<MenuSelection>(
              // Callback that sets the selected popup menu item.
              onSelected: _onPopupMenuSelected,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<MenuSelection>>[
                    const PopupMenuItem<MenuSelection>(
                      value: MenuSelection.newEvent,
                      child: Text('Create a new record'),
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
      case MenuSelection.newEvent:
        setState(() {
          _selectedMenu = 'Create a new record';
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
