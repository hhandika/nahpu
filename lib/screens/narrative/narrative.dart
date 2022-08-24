import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/page_viewer.dart';

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
  bool isVisible = false;
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final narrativeEntries = ref.watch(narrativeEntryProvider);
    ref.watch(pageNavigationProvider);
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
        child: Center(
          child: narrativeEntries.when(
            data: (narrativeEntries) {
              if (narrativeEntries.isEmpty) {
                setState(() {
                  isVisible = false;
                });

                return const Text("No narrative entries");
              } else {
                int narrativeSize = narrativeEntries.length;
                setState(() {
                  if (narrativeSize >= 2) {
                    isVisible = true;
                  }
                  ref.watch(pageNavigationProvider.notifier).state.pageCounts =
                      narrativeSize;
                  // We want to view the last page first.
                  // Dart uses 0-based indexing. Technically, this is out-of-bound.
                  // But, what happens here is that it will trigger the PageView onPageChanged.
                  // It fixes the issues that the curentPage state does not show the current page value.
                  pageController = PageController(initialPage: narrativeSize);
                });
                return PageView.builder(
                  controller: pageController,
                  itemCount: narrativeSize,
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
                  onPageChanged: (value) => setState(() {
                    ref
                        .read(pageNavigationProvider.notifier)
                        .state
                        .currentPage = value + 1;
                  }),
                );
              }
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text(error.toString()),
          ),
        ),
      ),
      bottomSheet: Visibility(
        visible: isVisible,
        child: CustomPageNavButton(
          pageController: pageController,
        ),
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterFloat,
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}
