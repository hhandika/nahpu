import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/screens/narrative/narrative_form.dart';
import 'package:nahpu/screens/narrative/menu_bar.dart';
import 'package:nahpu/screens/narrative/narrative.dart';
import 'package:nahpu/providers/narrative.dart';

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
  final narrativeController = TextEditingController();
  final siteController = TextEditingController();

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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Narrative()));
            ref.refresh(narrativeEntryProvider);
          },
        ),
      ),
      body: SafeArea(
        child: NarrativeForm(
          narrativeId: widget.narrativeId,
          dateController: dateController,
          siteController: siteController,
          narrativeController: narrativeController,
        ),
      ),
    );
  }
}
