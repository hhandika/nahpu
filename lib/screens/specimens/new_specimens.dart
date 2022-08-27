import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/specimens/menu_bar.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/screens/specimens/specimen_form.dart';
import 'package:nahpu/screens/specimens/specimens.dart';

enum MenuSelection { newNote, pdfExport, deleteRecords, deleteAllRecords }

class NewSpecimenForm extends ConsumerStatefulWidget {
  const NewSpecimenForm({Key? key, required this.specimenUuid})
      : super(key: key);

  final String specimenUuid;

  @override
  NewSpecimenFormState createState() => NewSpecimenFormState();
}

class NewSpecimenFormState extends ConsumerState<NewSpecimenForm> {
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
        leading: BackButton(
          onPressed: () {
            ref.refresh(pageNavigationProvider);
            ref.refresh(specimenEntryProvider);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Specimens()));
          },
        ),
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
