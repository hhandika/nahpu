import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/narrative.dart';
import 'package:nahpu/screens/narrative/menu_bar.dart';
import 'package:nahpu/screens/narrative/narrative_form.dart';

enum MenuSelection { newNote, pdfExport, deleteRecords, deleteAllRecords }

class Narrative extends ConsumerStatefulWidget {
  const Narrative({Key? key}) : super(key: key);

  @override
  NarrativeState createState() => NarrativeState();
}

class NarrativeState extends ConsumerState<Narrative> {
  @override
  Widget build(BuildContext context) {
    final narrativeEntries = ref.watch(narrativeEntryProvider);

    final PageController pageController = PageController();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Narrative"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: const [
            NewNarrative(),
            NarrativeMenu(),
          ],
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
              ref.refresh(narrativeEntryProvider);
            },
          ),
        ),
        body: SafeArea(
          child: Center(
            child: narrativeEntries.when(
              data: (narrativeEntries) {
                if (narrativeEntries.isEmpty) {
                  return const Text("No narrative entries");
                } else {
                  return PageView.builder(
                    controller: pageController,
                    itemCount: narrativeEntries.length,
                    itemBuilder: (context, index) {
                      return NarrativeForm(
                        narrativeId: narrativeEntries[index].id,
                        dateController: TextEditingController(
                            text: narrativeEntries[index].date),
                        siteController: TextEditingController(
                            text: narrativeEntries[index].siteID),
                        narrativeController: TextEditingController(
                            text: narrativeEntries[index].narrative),
                      );
                    },
                  );
                }
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text(error.toString()),
            ),
          ),
        ));
  }
}
