import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/models/page_viewer.dart';

import 'package:nahpu/providers/page_viewer.dart';

import 'package:nahpu/screens/collecting/coll_event_form.dart';
import 'package:nahpu/screens/collecting/menu_bar.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/indicators.dart';
import 'package:nahpu/screens/shared/navbar.dart';

class CollEvents extends ConsumerStatefulWidget {
  const CollEvents({Key? key}) : super(key: key);

  @override
  CollEventsState createState() => CollEventsState();
}

class CollEventsState extends ConsumerState<CollEvents> {
  bool isVisible = false;
  PageController pageController = PageController();

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
        actions: const [
          NewCollEvents(),
          CollEventMenu(),
        ],
        leading: const ProjectBackButton(),
      ),
      resizeToAvoidBottomInset: false,
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
                    final collEventForm = CollEventFormCtrModel(
                      startDateCtr: TextEditingController(
                          text: collEventEntries[index].startDate),
                      endDateCtr: TextEditingController(
                          text: collEventEntries[index].endDate),
                      startTimeCtr: TextEditingController(
                          text: collEventEntries[index].startTime),
                      endTimeCtr: TextEditingController(
                          text: collEventEntries[index].endTime),
                      primaryCollMethodCtr: TextEditingController(
                          text: collEventEntries[index].primaryCollMethod),
                    );

                    return CollEventForm(
                      id: collEventEntries[index].id,
                      collEventCtr: collEventForm,
                    );
                  },
                  onPageChanged: (value) => setState(() {
                    pageNotifier.state.currentPage = value + 1;
                    checkPageNavigation(ref);
                    ref.refresh(narrativeEntryProvider);
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
        ),
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}
