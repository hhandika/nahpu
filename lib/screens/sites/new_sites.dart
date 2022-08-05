import 'package:flutter/material.dart';

enum MenuSelection { newSite, pdfExport, deleteRecords, deleteAllRecords }

class NewSites extends StatefulWidget {
  const NewSites({Key? key}) : super(key: key);

  @override
  State<NewSites> createState() => _NewSitesState();
}

class _NewSitesState extends State<NewSites> with TickerProviderStateMixin {
  // String _selectedMenu = '';

  final siteIdController = TextEditingController();
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
        title: const Text("New Sites"),
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                      value: MenuSelection.newSite,
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
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Site ID',
              hintText: 'Enter a site',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Lead staff',
              hintText: 'Enter a name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Site Name',
              hintText: 'Enter a site name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Site Type',
              hintText: 'Enter a site type, e.g. "Camp", "City", "etc."',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Country',
              hintText: 'Enter a country location',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'State/province',
              hintText: 'Enter a state/province location',
            ),
          ),
          TextFormField(
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Precise locality',
              hintText:
                  'Enter a complete locality, excluding country and state/province',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Habitat',
              hintText: 'Enter a habitat type',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Habitat condition',
              hintText:
                  'Enter habitat condition, e.g. "Prestine", "Disturbed", "etc."',
            ),
          ),
          TextFormField(
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Site description',
              hintText:
                  'Describe the site, e.g. "A camp site in the middle of the forest."',
            ),
          ),
          Column(
            children: [
              DefaultTabController(
                length: 2,
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                        icon: Icon(Icons.photo_album_rounded,
                            color: Theme.of(context).colorScheme.tertiary)),
                    Tab(
                        icon: Icon(Icons.video_library_rounded,
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
      case MenuSelection.newSite:
        setState(() {
          // _selectedMenu = 'Create a new record';
        });
        break;
      case MenuSelection.pdfExport:
        setState(() {
          // _selectedMenu = 'Export to pdf';
        });
        break;
      case MenuSelection.deleteRecords:
        setState(() {
          // _selectedMenu = 'Delete current note record';
        });
        break;
      case MenuSelection.deleteAllRecords:
        setState(() {
          // _selectedMenu = 'Delete all note records';
        });
        break;
    }
  }
}
