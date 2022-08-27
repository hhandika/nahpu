import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';

import 'package:nahpu/screens/narrative/narrative_form.dart';
import 'package:nahpu/screens/narrative/menu_bar.dart';
import 'package:nahpu/screens/narrative/narrative.dart';
import 'package:nahpu/providers/page_viewer.dart';

class NewNarrativeForm extends ConsumerStatefulWidget {
  const NewNarrativeForm({Key? key, required this.narrativeId})
      : super(key: key);

  final int narrativeId;

  @override
  NewNarrativeFormState createState() => NewNarrativeFormState();
}

class NewNarrativeFormState extends ConsumerState<NewNarrativeForm>
    with TickerProviderStateMixin {
  final dateController = TextEditingController();
  final _narrativeCtr = NarrativeFormCtrModel.empty();

  late TabController _tabController;

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
        title: const Text("New Narrative"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: const [
          NewNarrative(),
          NarrativeMenu(),
        ],
        leading: BackButton(
          onPressed: () {
            ref.refresh(pageNavigationProvider);
            ref.refresh(narrativeEntryProvider);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Narrative()));
          },
        ),
      ),
      body: SafeArea(
        child: NarrativeForm(
          narrativeId: widget.narrativeId,
          narrativeCtr: _narrativeCtr,
        ),
      ),
    );
  }
}
