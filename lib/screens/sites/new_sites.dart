import 'package:flutter/material.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/sites/components/menu_bar.dart';
import 'package:nahpu/screens/sites/site_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/screens/sites/site_view.dart';

enum MenuSelection { newSite, pdfExport, deleteRecords, deleteAllRecords }

class NewSites extends ConsumerStatefulWidget {
  const NewSites({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  NewSitesState createState() => NewSitesState();
}

class NewSitesState extends ConsumerState<NewSites> {
  final siteFormCtrl = SiteFormCtrModel.empty();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Sites"),
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SiteForm(
          id: widget.id,
          siteFormCtr: siteFormCtrl,
        ),
      ),
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
