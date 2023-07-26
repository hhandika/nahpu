import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/navigation_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/providers/collevents.dart';
import 'package:nahpu/screens/collecting/coll_event_form.dart';
import 'package:nahpu/screens/collecting/components/menu_bar.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/navigation.dart';

class CollEventViewer extends ConsumerStatefulWidget {
  const CollEventViewer({Key? key}) : super(key: key);

  @override
  CollEventViewerState createState() => CollEventViewerState();
}

class CollEventViewerState extends ConsumerState<CollEventViewer> {
  bool _isVisible = false;
  final PageNavigation _pageNav = PageNavigation.init();
  final TextEditingController _searchController = TextEditingController();
  int? _collEvenId;
  bool _isSearching = false;

  @override
  void dispose() {
    _pageNav.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final services = CollEventServices(ref: ref);
    return FalseWillPop(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Collecting Events"),
        actions: [
          _isSearching
              ? ExpandedSearchBar(
                  controller: _searchController,
                  hintText: 'Search collecting events',
                  trailing: [
                    _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                services.invalidateCollEvent();
                              });
                            },
                            icon: const Icon(Icons.clear))
                        : const SizedBox.shrink(),
                  ],
                  onChanged: (value) {
                    ref
                        .read(collEventEntryProvider.notifier)
                        .search(value)
                        .whenComplete(() {
                      setState(() {
                        _updatePageNav(0);
                      });
                    });
                  },
                )
              : const SizedBox.shrink(),
          !_isSearching
              ? IconButton(
                  onPressed: _collEvenId == null
                      ? null
                      : () {
                          setState(() {
                            _isSearching = true;
                            services.invalidateCollEvent();
                          });
                        },
                  icon: const Icon(Icons.search))
              : TextButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                      services.invalidateCollEvent();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => super.widget),
                      );
                    });
                  },
                  child: const Text("Cancel")),
          const NewCollEvents(),
          CollEventMenu(
            collEventId: _collEvenId,
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ref.watch(collEventEntryProvider).when(
                data: (collEventEntries) {
                  if (collEventEntries.isEmpty) {
                    setState(() {
                      _isVisible = false;
                      _collEvenId = null;
                    });

                    return const Text("No collecting event entries");
                  } else {
                    int collEventSize = collEventEntries.length;
                    setState(() {
                      if (collEventSize >= 2) {
                        _isVisible = true;
                      }
                      _pageNav.pageCounts = collEventSize;
                      _pageNav.updatePageController();
                    });
                    return CollEventPages(
                      collEventEntries: collEventEntries,
                      pageNav: _pageNav,
                      onPageChanged: (index) {
                        setState(() {
                          _collEvenId = collEventEntries[index].id;
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
        visible: _isVisible,
        child: PageNavButton(
          pageNav: _pageNav,
        ),
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    ));
  }

  void _updatePageNav(int value) {
    setState(() {
      _pageNav.currentPage = value + 1;
      _pageNav.updatePageNavigation();
      if (!_isSearching) {
        CollEventServices(ref: ref).invalidateCollEvent();
      }
    });
  }
}

class CollEventPages extends StatelessWidget {
  const CollEventPages({
    super.key,
    required this.collEventEntries,
    required this.pageNav,
    required this.onPageChanged,
  });

  final List<CollEventData> collEventEntries;
  final PageNavigation pageNav;
  final void Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageNav.pageController,
      itemCount: collEventEntries.length,
      itemBuilder: (context, index) {
        final collEventForm = _updateController(collEventEntries[index]);

        return PageViewer(
          pageNav: pageNav,
          child: CollEventForm(
            id: collEventEntries[index].id,
            collEventCtr: collEventForm,
          ),
        );
      },
      onPageChanged: onPageChanged,
    );
  }

  CollEventFormCtrModel _updateController(CollEventData collEventData) {
    return CollEventFormCtrModel.fromData(collEventData);
  }
}
