import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/narrative.dart';
import 'package:nahpu/providers/project.dart';

import 'package:nahpu/screens/narrative/menu_bar.dart';
import 'package:nahpu/screens/narrative/narrative_form.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/navbar.dart';

enum MenuSelection { newNote, pdfExport, deleteRecords, deleteAllRecords }

class Narrative extends ConsumerStatefulWidget {
  const Narrative({Key? key}) : super(key: key);

  @override
  NarrativeState createState() => NarrativeState();
}

class NarrativeState extends ConsumerState<Narrative> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Narrative"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: const [
          NewNarrative(),
          NarrativeMenu(),
        ],
        leading: const ProjectBackButton(),
      ),
      body: SafeArea(
        child: NarrativeViewer(
          pageController: pageController,
        ),
      ),
      floatingActionButton: CustomNavButton(pageController: pageController),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}

class NarrativeViewer extends ConsumerWidget {
  const NarrativeViewer({Key? key, required this.pageController})
      : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final narrativeEntries = ref.watch(narrativeEntryProvider);

    return Center(
      child: narrativeEntries.when(
        data: (narrativeEntries) {
          if (narrativeEntries.isEmpty) {
            return const Text("No narrative entries");
          } else {
            int narrativeSize = narrativeEntries.length;
            ref.watch(pageCountProvider.state).state = narrativeSize;
            return PageView.builder(
              controller: pageController,
              itemCount: narrativeSize,
              itemBuilder: (context, index) {
                return NarrativeForm(
                  narrativeId: narrativeEntries[index].id,
                  dateController:
                      TextEditingController(text: narrativeEntries[index].date),
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
    );
  }
}
