import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/narrative_services.dart';
import 'package:nahpu/services/navigation_services.dart';
import 'package:nahpu/models/navigation.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/narrative/components/menu_bar.dart';
import 'package:nahpu/screens/narrative/narrative_form.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/navigation.dart';
import 'package:nahpu/services/database/database.dart';

class Narrative extends ConsumerStatefulWidget {
  const Narrative({Key? key}) : super(key: key);

  @override
  NarrativeState createState() => NarrativeState();
}

class NarrativeState extends ConsumerState<Narrative> {
  bool isVisible = false;
  PageController pageController = PageController();
  PageNavigation _pageNav = PageNavigation();
  int? narrativeId;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Narrative"),
        actions: [
          const NewNarrative(),
          NarrativeMenu(
            narrativeId: narrativeId,
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: ref.watch(narrativeEntryProvider).when(
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
                      // It fixes the issues that the currentPage state does not show the current page value.
                      pageController = PageController(
                          initialPage: narrativeSize + 1, keepPage: false);
                    });
                    return PageView.builder(
                      controller: pageController,
                      itemCount: narrativeSize,
                      itemBuilder: (context, index) {
                        final narrativeCtr =
                            _updateController(narrativeEntries, index);
                        return Viewer(
                          pageNav: _pageNav,
                          child: NarrativeForm(
                            narrativeId: narrativeEntries[index].id,
                            narrativeCtr: narrativeCtr,
                          ),
                        );
                      },
                      onPageChanged: (value) => setState(() {
                        _pageNav.currentPage = value + 1;
                        _pageNav = updatePageNavigation(_pageNav);
                        NarrativeServices(ref).invalidateNarrative();
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
        visible: isVisible,
        child: PageNavButton(
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
      siteCtr: narrativeEntries[index].siteID,
      narrativeCtr:
          TextEditingController(text: narrativeEntries[index].narrative),
    );
  }
}

// View page number
class Viewer extends StatelessWidget {
  const Viewer({super.key, required this.pageNav, required this.child});

  final PageNavigation pageNav;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 50,
          right: 0,
          child: Container(
            height: 40,
            width: 100,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Page ${pageNav.currentPage} of ${pageNav.pageCounts}",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
