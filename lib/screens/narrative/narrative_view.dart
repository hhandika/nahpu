import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/narrative_services.dart';
import 'package:nahpu/services/navigation_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/providers/narrative.dart';
import 'package:nahpu/screens/narrative/components/menu_bar.dart';
import 'package:nahpu/screens/narrative/narrative_form.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/navigation.dart';
import 'package:nahpu/services/database/database.dart';

class NarrativeViewer extends ConsumerStatefulWidget {
  const NarrativeViewer({Key? key}) : super(key: key);

  @override
  NarrativeViewerState createState() => NarrativeViewerState();
}

class NarrativeViewerState extends ConsumerState<NarrativeViewer> {
  bool isVisible = false;
  final PageNavigation _pageNav = PageNavigation.init();
  int? narrativeId;

  @override
  void dispose() {
    _pageNav.dispose();
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
                      _pageNav.updatePageController();
                    });
                    return NarrativePages(
                      narrativeEntries: narrativeEntries,
                      pageNav: _pageNav,
                      onPageChanged: (index) {
                        setState(() {
                          narrativeId = narrativeEntries[index].id;
                          _updatePageNav(index);
                        });
                      },
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
          pageNav: _pageNav,
        ),
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }

  void _updatePageNav(int value) {
    _pageNav.currentPage = value + 1;
    _pageNav.updatePageNavigation();
    NarrativeServices(ref: ref).invalidateNarrative();
  }
}

class NarrativePages extends StatelessWidget {
  const NarrativePages({
    super.key,
    required this.narrativeEntries,
    required this.pageNav,
    required this.onPageChanged,
  });

  final List<NarrativeData> narrativeEntries;
  final PageNavigation pageNav;
  final void Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageNav.pageController,
      itemCount: narrativeEntries.length,
      itemBuilder: (context, index) {
        final narrativeCtr = _updateController(narrativeEntries, index);
        return PageViewer(
          pageNav: pageNav,
          child: NarrativeForm(
            narrativeId: narrativeEntries[index].id,
            narrativeCtr: narrativeCtr,
          ),
        );
      },
      onPageChanged: onPageChanged,
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
