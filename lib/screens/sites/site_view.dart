import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/navigation_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/providers/sites.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/navigation.dart';
import 'package:nahpu/screens/sites/components/menu_bar.dart';
import 'package:nahpu/screens/sites/site_form.dart';
import 'package:nahpu/services/database/database.dart';

enum MenuSelection { newSite, pdfExport, deleteRecords, deleteAllRecords }

class SiteViewer extends ConsumerStatefulWidget {
  const SiteViewer({super.key});

  @override
  SiteViewerState createState() => SiteViewerState();
}

class SiteViewerState extends ConsumerState<SiteViewer> {
  bool _isVisible = false;
  final PageNavigation _pageNav = PageNavigation.init();
  final TextEditingController _searchController = TextEditingController();
  int? _siteId;
  bool _isSearching = false;
  @override
  void dispose() {
    _pageNav.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final siteEntries = ref.watch(siteEntryProvider);
    return FalseWillPop(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Sites"),
        automaticallyImplyLeading: false,
        actions: [
          _isSearching
              ? SearchBar(
                  controller: _searchController,
                  constraints:
                      const BoxConstraints(maxHeight: 44, maxWidth: 600),
                  elevation: MaterialStateProperty.all(0),
                  hintText: 'Search sites',
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0.2)),
                  trailing: [
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                    )
                  ],
                  onChanged: (value) {},
                )
              : const SizedBox(),
          IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
              },
              icon: const Icon(Icons.search)),
          const NewSite(),
          SiteMenu(
            siteId: _siteId,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: siteEntries.when(data: (siteEntries) {
            if (siteEntries.isEmpty) {
              setState(() {
                _isVisible = false;
                _siteId = null;
              });
              return const Text("No site entries");
            } else {
              int siteSize = siteEntries.length;
              setState(() {
                if (siteSize >= 2) {
                  _isVisible = true;
                } else {
                  _isVisible = false;
                }
                _pageNav.pageCounts = siteSize;
                _pageNav.updatePageController();
              });
              return SitePages(
                siteEntries: siteEntries,
                pageNav: _pageNav,
                onPageChanged: (index) {
                  setState(() {
                    _siteId = siteEntries[index].id;
                    _updatePageNav(index);
                  });
                },
              );
            }
          }, loading: () {
            return const CommonProgressIndicator();
          }, error: (error, stackTrace) {
            return Text(error.toString());
          }),
        ),
      ),
      bottomSheet: Visibility(
          visible: _isVisible,
          child: PageNavButton(
            pageNav: _pageNav,
          )),
      bottomNavigationBar: const ProjectBottomNavbar(),
    ));
  }

  void _updatePageNav(int value) {
    _pageNav.currentPage = value + 1;
    _pageNav.updatePageNavigation();
    ref.invalidate(siteEntryProvider);
  }
}

class SitePages extends StatelessWidget {
  const SitePages({
    super.key,
    required this.siteEntries,
    required this.pageNav,
    required this.onPageChanged,
  });

  final List<SiteData> siteEntries;
  final PageNavigation pageNav;
  final void Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageNav.pageController,
      itemCount: siteEntries.length,
      itemBuilder: (context, index) {
        final siteForm = _updateController(siteEntries[index]);
        return PageViewer(
          pageNav: pageNav,
          child: SiteForm(
            id: siteEntries[index].id,
            siteFormCtr: siteForm,
          ),
        );
      },
      onPageChanged: onPageChanged,
    );
  }

  SiteFormCtrModel _updateController(SiteData siteEntries) {
    return SiteFormCtrModel.fromData(siteEntries);
  }
}
