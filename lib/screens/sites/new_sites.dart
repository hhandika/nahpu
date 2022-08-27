import 'package:flutter/material.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/sites/menu_bar.dart';
import 'package:nahpu/screens/sites/site_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/screens/sites/sites.dart';

enum MenuSelection { newSite, pdfExport, deleteRecords, deleteAllRecords }

class NewSites extends ConsumerStatefulWidget {
  const NewSites({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  NewSitesState createState() => NewSitesState();
}

class NewSitesState extends ConsumerState<NewSites>
    with TickerProviderStateMixin {
  final siteIdController = TextEditingController();
  late TabController _tabController;

  final siteFormCtrl = SiteFormModel();

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
        leading: BackButton(
          onPressed: () {
            ref.refresh(pageNavigationProvider);
            ref.refresh(siteEntryProvider);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Sites()));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              createNewSite(context, ref);
            },
          ),
          PopupMenuButton<MenuSelection>(
              // Callback that sets the selected popup menu item.
              onSelected: _onPopupMenuSelected,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<MenuSelection>>[
                    const PopupMenuItem<MenuSelection>(
                      value: MenuSelection.newSite,
                      child: Text('Create a new site'),
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
          child: SiteForm(
              id: widget.id,
              siteIDController: siteFormCtrl.siteIDController,
              siteTypeController: siteFormCtrl.siteTypeController,
              countryController: siteFormCtrl.countryController,
              stateProvinceController: siteFormCtrl.stateProvinceController,
              countyController: siteFormCtrl.countyController,
              municipalityController: siteFormCtrl.municipalityController,
              localityController: siteFormCtrl.localityController)),
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
