import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/models/page_viewer.dart';

import 'package:nahpu/providers/page_viewer.dart';

import 'package:nahpu/screens/collecting/coll_event_form.dart';
import 'package:nahpu/screens/collecting/menu_bar.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/navbar.dart';

class CollEvents extends ConsumerStatefulWidget {
  const CollEvents({Key? key}) : super(key: key);

  @override
  CollEventState createState() => CollEventState();
}

class CollEventState extends ConsumerState<CollEvents> {
  bool isVisible = false;
  PageController pageController = PageController();

  final CollEventFormCtrModel _collEventFormController =
      CollEventFormCtrModel.empty();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collEventEntries = ref.watch(collEventEntryProvider);
    final pageNotifier = ref.watch(pageNavigationProvider.notifier);
    ref.watch(pageNavigationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collecting Events"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: const [
          NewCollEvents(),
          CollEventMenu(),
        ],
        leading: const ProjectBackButton(),
      ),
      body: SafeArea(
        child: Center(
          child: collEventEntries.when(
            data: (collEventEntries) {
              if (collEventEntries.isEmpty) {
                setState(() {
                  isVisible = false;
                });

                return const Text("No collecting event entries");
              } else {
                int collEventSize = collEventEntries.length;
                setState(() {
                  if (collEventSize >= 2) {
                    isVisible = true;
                  }
                  ref.watch(pageNavigationProvider.notifier).state.pageCounts =
                      collEventSize;
                  // We want to view the last page first.
                  // Dart uses 0-based indexing. Technically, this is out-of-bound.
                  // But, what happens here is that it will trigger the PageView onPageChanged.
                  // It fixes the issues that the curentPage state does not show the current page value.
                  pageController = PageController(initialPage: collEventSize);
                });
                return PageView.builder(
                  controller: pageController,
                  itemCount: collEventSize,
                  itemBuilder: (context, index) {
                    return CollEventForm(
                      collEventFormController: _collEventFormController,
                    );
                  },
                  onPageChanged: (value) => setState(() {
                    pageNotifier.state.currentPage = value + 1;
                    checkPageNavigation(ref);
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
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}
