import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

enum MenuSelection { newNote, pdfExport, deleteRecords, deleteAllRecords }

class NewCollEvent extends StatefulWidget {
  const NewCollEvent({Key? key}) : super(key: key);

  @override
  State<NewCollEvent> createState() => _NewCollEventState();
}

class _NewCollEventState extends State<NewCollEvent>
    with TickerProviderStateMixin {
  final dateController = TextEditingController();

  late TabController _tabController;
  // final int _selectedIndex = 0;

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
        title: const Text("New Coll. Events"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NewCollEvent()));
            },
          ),
          PopupMenuButton<MenuSelection>(
              // Callback that sets the selected popup menu item.
              onSelected: _onPopupMenuSelected,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<MenuSelection>>[
                    const PopupMenuItem<MenuSelection>(
                      value: MenuSelection.newNote,
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
                      child: Text('Delete all note records',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ])
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Date',
              hintText: 'Enter date',
            ),
            controller: dateController,
            onTap: () async {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now())
                  .then((date) {
                if (date != null) {
                  dateController.text = DateFormat.yMMMd().format(date);
                }
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Site ID',
              hintText: 'Enter a new event',
            ),
          ),
          TextFormField(
            maxLines: 10,
            decoration: const InputDecoration(
              labelText: 'CollEvent',
              hintText: 'Enter narrative',
            ),
          ),
        ]),
      )),
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
