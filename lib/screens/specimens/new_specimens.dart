import 'package:flutter/material.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/specimens/menu_bar.dart';

import 'package:nahpu/screens/specimens/specimen_form.dart';

enum MenuSelection { newNote, pdfExport, deleteRecords, deleteAllRecords }

class NewSpecimenForm extends StatefulWidget {
  const NewSpecimenForm({Key? key, required this.specimenUuid})
      : super(key: key);

  final String specimenUuid;

  @override
  State<NewSpecimenForm> createState() => NewSpecimenFormState();
}

class NewSpecimenFormState extends State<NewSpecimenForm> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  final _specimenCtr = SpecimenFormCtrModel.empty();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Specimens"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: const [
          NewSpecimens(),
          SpecimenMenu(),
        ],
      ),
      body: SpecimenForm(
        specimenUuid: widget.specimenUuid,
        specimenCtr: _specimenCtr,
      ),
    );
  }
}
