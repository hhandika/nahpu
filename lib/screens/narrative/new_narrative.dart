import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';

import 'package:nahpu/screens/narrative/narrative_form.dart';
import 'package:nahpu/screens/narrative/components/menu_bar.dart';
import 'package:nahpu/screens/narrative/narrative_view.dart';
import 'package:nahpu/services/narrative_services.dart';

import '../../providers/catalogs.dart';
// import 'package:nahpu/providers/page_viewer.dart';

class NewNarrativeForm extends ConsumerStatefulWidget {
  const NewNarrativeForm({Key? key, required this.narrativeId})
      : super(key: key);

  final int narrativeId;

  @override
  NewNarrativeFormState createState() => NewNarrativeFormState();
}

class NewNarrativeFormState extends ConsumerState<NewNarrativeForm> {
  final _narrativeCtr = NarrativeFormCtrModel.empty();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Narrative"),
        actions: const [
          NewNarrative(),
          NarrativeMenu(
            narrativeId: null,
          ),
        ],
        leading: BackButton(
          onPressed: () {
            NarrativeServices(ref).invalidateNarrative();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Narrative()));
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: NarrativeForm(
          narrativeId: widget.narrativeId,
          narrativeCtr: _narrativeCtr,
        ),
      ),
    );
  }
}
