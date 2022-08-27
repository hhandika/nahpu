import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/database/database.dart';

import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/screens/collecting/coll_event_form.dart';
import 'package:nahpu/screens/collecting/coll_events.dart';
import 'package:nahpu/screens/collecting/menu_bar.dart';

enum MenuSelection { newNote, pdfExport, deleteRecords, deleteAllRecords }

class NewCollEventForm extends ConsumerStatefulWidget {
  const NewCollEventForm({
    Key? key,
    required this.collEventId,
  }) : super(key: key);

  final int collEventId;
  @override
  NewCollEventFormState createState() => NewCollEventFormState();
}

class NewCollEventFormState extends ConsumerState<NewCollEventForm>
    with TickerProviderStateMixin {
  final _collEventCtr = CollEventFormCtrModel.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Coll. Events"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: BackButton(
          onPressed: () {
            ref.refresh(pageNavigationProvider);
            ref.refresh(collEventEntryProvider);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CollEvents()));
          },
        ),
        actions: const [
          NewCollEvents(),
          CollEventMenu(),
        ],
      ),
      body: SafeArea(
        child:
            CollEventForm(id: widget.collEventId, collEventCtr: _collEventCtr),
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
