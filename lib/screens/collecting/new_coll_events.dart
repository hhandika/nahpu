import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/screens/collecting/coll_event_form.dart';
import 'package:nahpu/screens/collecting/coll_event_view.dart';
import 'package:nahpu/screens/collecting/components/menu_bar.dart';
import 'package:nahpu/services/collevent_services.dart';

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

class NewCollEventFormState extends ConsumerState<NewCollEventForm> {
  final _collEventCtr = CollEventFormCtrModel.empty();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Coll. Events"),
        leading: BackButton(
          onPressed: () {
            CollEventServices(ref).invalidateCollEvent();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const CollEvents()));
          },
        ),
        actions: const [
          NewCollEvents(),
          CollEventMenu(),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:
            CollEventForm(id: widget.collEventId, collEventCtr: _collEventCtr),
      ),
    );
  }
}
