import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/navigation_services.dart';
import 'package:nahpu/models/navigation.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/collecting/coll_event_form.dart';
import 'package:nahpu/screens/collecting/components/menu_bar.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/navigation.dart';

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
        automaticallyImplyLeading: false,
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
                        final collEventForm = CollEventFormCtrModel.fromData(
                          collEventEntries[index],
                        );

                        return CollEventForm(
                          id: collEventEntries[index].id,
                          collEventCtr: collEventForm,
                        );
                      },
                      onPageChanged: (value) => setState(() {
                        _pageNav.currentPage = value + 1;
                        _pageNav = updatePageNavigation(_pageNav);
                        CollEventServices(ref).invalidateCollEvent();
                      }),
                    );
                  }
                },
                loading: () => const CommonProgressIndicator(),
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