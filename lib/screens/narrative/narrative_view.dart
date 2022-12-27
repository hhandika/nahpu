import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/catalogs.dart';
import 'package:nahpu/models/form.dart';

import 'package:nahpu/providers/catalogs.dart';

import 'package:nahpu/screens/narrative/components/menu_bar.dart';
import 'package:nahpu/screens/narrative/narrative_form.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/indicators.dart';
import 'package:nahpu/screens/shared/navbar.dart';
import 'package:nahpu/services/database.dart';

class Narrative extends ConsumerStatefulWidget {
  const Narrative({Key? key}) : super(key: key);

  @override
  NarrativeState createState() => NarrativeState();
}

class NarrativeState extends ConsumerState<Narrative> {
  bool isVisible = false;
  PageController pageController = PageController();
  PageNavigation _pageNav = PageNavigation();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final narrativeEntries = ref.watch(narrativeEntryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Narrative"),
        actions: const [
          NewNarrative(),
          NarrativeMenu(),
        ],
        leading: const ProjectBackButton(),
      ),
      resizeToAvoidBottomInset: false,
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
                  _pageNav.pageCounts = narrativeSize;

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
                    final narrativeCtr =
                        _updateController(narrativeEntries, index);
                    return NarrativeForm(
                      narrativeId: narrativeEntries[index].id,
                      narrativeCtr: narrativeCtr,
                    );
                  },
                  onPageChanged: (value) => setState(() {
                    _pageNav.currentPage = value + 1;
                    _pageNav = updatePageNavigation(_pageNav);
                    ref.invalidate(narrativeEntryProvider);
                  }),
                );
              }
            },
            loading: () => const CommmonProgressIndicator(),
            error: (error, stack) => Text(error.toString()),
          ),
        ),
      ),
      bottomSheet: Visibility(
        visible: isVisible,
        child: CustomPageNavButton(
          pageController: pageController,
          pageNav: _pageNav,
        ),
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }

  NarrativeFormCtrModel _updateController(
      List<NarrativeData> narrativeEntries, int index) {
    return NarrativeFormCtrModel(
      dateCtr: TextEditingController(text: narrativeEntries[index].date),
      siteCtr: TextEditingController(text: narrativeEntries[index].siteID),
      narrativeCtr:
          TextEditingController(text: narrativeEntries[index].narrative),
    );
  }
}
