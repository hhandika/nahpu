import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

enum MenuSelection { newNote, pdfExport, deleteRecords, deleteAllRecords }

class NewSpecimens extends StatefulWidget {
  const NewSpecimens({Key? key}) : super(key: key);

  @override
  State<NewSpecimens> createState() => _NewSpecimensState();
}

class _NewSpecimensState extends State<NewSpecimens>
    with TickerProviderStateMixin {
  final dateController = TextEditingController();

  late TabController _tabController;
  // final int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text("New Specimens"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NewSpecimens()));
            },
          ),
          PopupMenuButton<MenuSelection>(
              // Callback that sets the selected popup menu item.
              onSelected: _onPopupMenuSelected,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<MenuSelection>>[
                    const PopupMenuItem<MenuSelection>(
                      value: MenuSelection.newNote,
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Card(
            // Specimen data card
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Specimen Data',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Collector',
                          hintText: 'Choose a collector',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'One',
                            child: Text('One'),
                          ),
                          DropdownMenuItem(
                            value: 'Two',
                            child: Text('Two'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {});
                        }),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Collector Number',
                        hintText: 'Enter narrative',
                      ),
                    ),
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Collector',
                          hintText: 'Choose a collector',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'One',
                            child: Text('One'),
                          ),
                          DropdownMenuItem(
                            value: 'Two',
                            child: Text('Two'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {});
                        }),
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Species',
                          hintText: 'Choose a speciess',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'One',
                            child: Text('One'),
                          ),
                          DropdownMenuItem(
                            value: 'Two',
                            child: Text('Two'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {});
                        }),
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Condition',
                          hintText: 'Choose a condition',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Freshy Euthanized',
                            child: Text('Freshy Euthanized'),
                          ),
                          DropdownMenuItem(
                            value: 'Good',
                            child: Text('Good'),
                          ),
                          DropdownMenuItem(
                            value: 'Fair',
                            child: Text('Fair'),
                          ),
                          DropdownMenuItem(
                            value: 'Rotten',
                            child: Text('Rotten'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {});
                        }),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Preparation date',
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
                            dateController.text =
                                DateFormat.yMMMd().format(date);
                          }
                        });
                      },
                    ),
                  ],
                )),
          ),
          Card(
            // Capture record card
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Text(
                  'Capture Records',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Site ID',
                      hintText: 'Choose a site ID',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'One',
                        child: Text('One'),
                      ),
                      DropdownMenuItem(
                        value: 'Two',
                        child: Text('Two'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {});
                    }),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Trap type',
                      hintText: 'Choose a trap type',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'One',
                        child: Text('One'),
                      ),
                      DropdownMenuItem(
                        value: 'Two',
                        child: Text('Two'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {});
                    }),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Capture date',
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
                    labelText: 'Collecting Event ID',
                    hintText: 'Enter narrative',
                  ),
                ),
              ]),
            ),
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Measurements',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Total legnth (mm)',
                      hintText: 'Enter TTL',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Tail length (mm)',
                      hintText: 'Enter TL',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Hind foot length (mm)',
                      hintText: 'Enter HF',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Ear length (mm)',
                      hintText: 'Enter ER',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Weight (grams)',
                      hintText: 'Enter specimen weight',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Sex',
                        hintText: 'Choose one',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Male',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(
                          value: 'Unknown',
                          child: Text('Unknown'),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {});
                      }),
                  DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        hintText: 'Choose one',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Adult',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: 'Subadult',
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(
                          value: 'Juvenile',
                          child: Text('Unknown'),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {});
                      }),
                ],
              ),
            ),
          ),
          Column(
            // Media inputs
            children: [
              DefaultTabController(
                length: 3,
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                        icon: Icon(Icons.photo_album_rounded,
                            color: Theme.of(context).colorScheme.tertiary)),
                    Tab(
                        icon: Icon(Icons.video_library_rounded,
                            color: Theme.of(context).colorScheme.tertiary)),
                    Tab(
                        icon: Icon(Icons.audiotrack_rounded,
                            color: Theme.of(context).colorScheme.tertiary)),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    Text('Photos'),
                    Text('Videos'),
                    Text('Audio'),
                  ],
                ),
              ),
            ],
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
