import 'package:flutter/material.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/sites/components/menu_bar.dart';
import 'package:nahpu/screens/sites/site_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/sites/site_view.dart';

import '../../providers/catalogs.dart';

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
            ref.invalidate(siteEntryProvider);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Sites()));
          },
        ),
        actions: const [
          NewSite(),
          SiteMenu(),
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
}
