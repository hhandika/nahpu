import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/controller/navigation.dart';
import 'package:nahpu/models/catalogs.dart';
import 'package:nahpu/models/form.dart';

import 'package:nahpu/providers/catalogs.dart';

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
  bool _isVisible = false;
  PageController pageController = PageController();
  PageNavigation _pageNav = PageNavigation();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: ref.watch(collEventEntryProvider).when(
                data: (collEventEntries) {
                  if (collEventEntries.isEmpty) {
                    setState(() {
                      _isVisible = false;
                    });

                    return const Text("No collecting event entries");
                  } else {
                    int collEventSize = collEventEntries.length;
                    setState(() {
                      if (collEventSize >= 2) {
                        _isVisible = true;
                      }
                      _pageNav.pageCounts = collEventSize;
                      // We want to view the last page first.
                      // Dart uses 0-based indexing. Technically, this is out-of-bound.
                      // But, what happens here is that it will trigger the PageView onPageChanged.
                      // It fixes the issues that the curentPage state does not show the current page value.
                      pageController =
                          PageController(initialPage: collEventSize);
                    });
                    return PageView.builder(
                      controller: pageController,
                      itemCount: collEventSize,
                      itemBuilder: (context, index) {
                        final collEventForm = CollEventFormCtrModel(
                          eventIDCtr: TextEditingController(
                              text: collEventEntries[index].eventID),
                          startDateCtr: TextEditingController(
                              text: collEventEntries[index].startDate),
                          endDateCtr: TextEditingController(
                              text: collEventEntries[index].endDate),
                          startTimeCtr: TextEditingController(
                              text: collEventEntries[index].startTime),
                          endTimeCtr: TextEditingController(
                              text: collEventEntries[index].endTime),
                          primaryCollMethodCtr:
                              collEventEntries[index].primaryCollMethod,
                          noteCtr: TextEditingController(
                              text: collEventEntries[index].collMethodNotes),
                        );

                        return CollEventForm(
                          id: collEventEntries[index].id,
                          collEventCtr: collEventForm,
                        );
                      },
                      onPageChanged: (value) => setState(() {
                        _pageNav.currentPage = value + 1;
                        _pageNav = updatePageNavigation(_pageNav);
                        ref.invalidate(collEventEntryProvider);
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
        visible: _isVisible,
        child: CustomPageNavButton(
          pageController: pageController,
          pageNav: _pageNav,
        ),
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}
