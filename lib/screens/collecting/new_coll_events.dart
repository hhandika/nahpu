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
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  final DateTime _initialStartDate =
      DateTime.now().subtract(const Duration(days: 1));
  final DateTime _initialEndDate = DateTime.now();
  final TimeOfDay _initialStartTime = const TimeOfDay(hour: 8, minute: 0);

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
              child: Column(
        children: [
          _drawCollectingFields(),
          _drawActivityFields(),
          _drawTrappingFields(),
          _drawMediaFields(),
        ],
      ))),
    );
  }

  Widget _drawCollectingFields() {
    return Card(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Text(
                'Collecting Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Site ID',
                  hintText: 'Enter a new event',
                ),
              ),
              Row(children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      hintText: 'Enter date',
                    ),
                    controller: startDateController,
                    onTap: () async {
                      showDatePicker(
                              context: context,
                              initialDate: _initialStartDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now())
                          .then((date) {
                        if (date != null) {
                          startDateController.text =
                              DateFormat.yMMMd().format(date);
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Start time',
                      hintText: 'Enter date',
                    ),
                    controller: startTimeController,
                    onTap: () async {
                      showTimePicker(
                              context: context, initialTime: _initialStartTime)
                          .then((time) {
                        if (time != null) {
                          startTimeController.text = time.format(context);
                        }
                      });
                    },
                  ),
                ),
              ]),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      hintText: 'Enter date',
                    ),
                    controller: endDateController,
                    onTap: () async {
                      showDatePicker(
                              context: context,
                              initialDate: _initialEndDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now())
                          .then((date) {
                        if (date != null) {
                          endDateController.text =
                              DateFormat.yMMMd().format(date);
                        }
                      });
                    },
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'End time',
                      hintText: 'Enter date',
                    ),
                    controller: endTimeController,
                    onTap: () async {
                      showTimePicker(
                              context: context, initialTime: _initialStartTime)
                          .then((time) {
                        if (time != null) {
                          endTimeController.text = time.format(context);
                        }
                      });
                    },
                  )),
                ],
              ),
            ])));
  }

  Widget _drawActivityFields() {
    return Card(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Text(
                'Collecting Activities',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Primary collection method',
                    hintText: 'Choose a method',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Trapping',
                      child: Text('Trapping'),
                    ),
                    DropdownMenuItem(
                      value: 'Song meter',
                      child: Text('Song meter'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {});
                  }),
              TextFormField(
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Collecting method notes',
                  hintText: 'Enter notes',
                ),
              ),
            ])));
  }

  Widget _drawTrappingFields() {
    return Card(
        child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Text(
          'Collecting Effort',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Live traps',
            hintText: 'Enter count',
          ),
          keyboardType: TextInputType.number,
        ),
      ]),
    ));
  }

  Widget _drawMediaFields() {
    return Column(
      // Media inputs
      children: [
        DefaultTabController(
          length: 2,
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                  icon: Icon(Icons.wb_sunny_rounded,
                      color: Theme.of(context).colorScheme.tertiary)),
              Tab(
                  icon: Icon(Icons.camera_alt_rounded,
                      color: Theme.of(context).colorScheme.tertiary)),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: TabBarView(
            controller: _tabController,
            children: const [
              Text('Environment Data'),
              Text('Camera'),
            ],
          ),
        ),
      ],
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
