import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/narrative_services.dart';
import 'package:nahpu/services/navigation_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/providers/narrative.dart';
import 'package:nahpu/screens/narrative/components/menu_bar.dart';
import 'package:nahpu/screens/narrative/narrative_form.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/navigation.dart';
import 'package:nahpu/services/database/database.dart';

class NarrativeViewer extends ConsumerStatefulWidget {
  const NarrativeViewer({super.key});

  @override
  NarrativeViewerState createState() => NarrativeViewerState();
}

class NarrativeViewerState extends ConsumerState<NarrativeViewer> {
  bool isVisible = false;
  final PageNavigation _pageNav = PageNavigation.init();
  final TextEditingController _searchController = TextEditingController();
  int? _narrativeId;
  bool _isSearching = false;
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
  }

  @override
  void dispose() {
    _pageNav.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final narrativeServices = NarrativeServices(ref: ref);
    return FalseWillPop(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Narrative"),
        actions: [
          _isSearching
              ? ExpandedSearchBar(
                  controller: _searchController,
                  focusNode: _focus,
                  hintText: 'Search narrative',
                  trailing: [
                    _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                narrativeServices.invalidateNarrative();
                              });
                            },
                            icon: const Icon(Icons.clear_rounded))
                        : const SizedBox.shrink(),
                  ],
                  onChanged: (value) {
                    ref.read(narrativeEntryProvider.notifier).search(value);
                  },
                )
              : const SizedBox.shrink(),
          !_isSearching
              ? IconButton(
                  onPressed: _narrativeId == null
                      ? null
                      : () {
                          setState(() {
                            _isSearching = true;
                            narrativeServices.invalidateNarrative();
                          });
                          _focus.requestFocus();
                        },
                  icon: const Icon(Icons.search),
                )
              : TextButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                      narrativeServices.invalidateNarrative();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => super.widget));
                    });
                  },
                  child: const Text('Cancel')),
          !_isSearching ? const NewNarrative() : const SizedBox.shrink(),
          NarrativeMenu(
            narrativeId: _narrativeId,
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ref.watch(narrativeEntryProvider).when(
                data: (narrativeEntries) {
                  if (narrativeEntries.isEmpty) {
                    setState(() {
                      isVisible = false;
                      _narrativeId = null;
                    });

                    return EmptyNarrative(isButtonVisible: !_isSearching);
                  } else {
                    int narrativeSize = narrativeEntries.length;
                    setState(() {
                      if (narrativeSize >= 2) {
                        isVisible = true;
                      } else {
                        isVisible = false;
                      }
                      _pageNav.pageCounts = narrativeSize;
                      _pageNav.updatePageController();
                    });
                    return NarrativePages(
                      narrativeEntries: narrativeEntries,
                      isNavButtonVisible: isVisible,
                      pageNav: _pageNav,
                      onPageChanged: (index) {
                        setState(() {
                          _narrativeId = narrativeEntries[index].id;
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
    ));
  }

  void _updatePageNav(int value) {
    _pageNav.currentPage = value + 1;
    _pageNav.updatePageNavigation();
    if (!_isSearching) {
      NarrativeServices(ref: ref).invalidateNarrative();
    }
  }
}

class NarrativePages extends StatelessWidget {
  const NarrativePages({
    super.key,
    required this.narrativeEntries,
    required this.pageNav,
    required this.isNavButtonVisible,
    required this.onPageChanged,
  });

  final List<NarrativeData> narrativeEntries;
  final PageNavigation pageNav;
  final bool isNavButtonVisible;
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
          isNavButtonVisible: isNavButtonVisible,
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

class EmptyNarrative extends StatelessWidget {
  const EmptyNarrative({
    super.key,
    required this.isButtonVisible,
  });

  final bool isButtonVisible;

  @override
  Widget build(BuildContext context) {
    return CommonEmptyForm(
      iconPath: 'assets/icons/agendas.svg',
      text: 'No narrative found',
      child: Visibility(
        visible: isButtonVisible,
        child: const NewNarrativeTextButton(),
      ),
    );
  }
}
