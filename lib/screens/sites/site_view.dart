import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
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
              ? ExpandedSearchBar(
                  controller: _searchController,
                  hintText: 'Search sites',
                  trailing: [
                    _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                ref.invalidate(siteEntryProvider);
                              });
                            },
                            icon: const Icon(Icons.clear))
                        : const SizedBox.shrink(),
                  ],
                  onChanged: (value) {
                    ref
                        .read(siteEntryProvider.notifier)
                        .search(value)
                        .whenComplete(() => setState(() {
                              _updatePageNav(0);
                            }));
                  },
                )
              : const SizedBox.shrink(),
          !_isSearching
              ? IconButton(
                  onPressed: _siteId == null
                      ? null
                      : () {
                          setState(() {
                            _isSearching = true;
                            ref.invalidate(siteEntryProvider);
                          });
                        },
                  icon: const Icon(Icons.search))
              : TextButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                      ref.invalidate(siteEntryProvider);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => super.widget));
                    });
                  },
                  child: const Text('Cancel')),
          !_isSearching ? const NewSite() : const SizedBox.shrink(),
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
              return const EmptySite();
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
    if (!_isSearching) {
      ref.invalidate(siteEntryProvider);
    }
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

class EmptySite extends StatelessWidget {
  const EmptySite({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonEmptyForm(
      iconPath: 'assets/icons/forest.svg',
      text: 'No site found',
      child: NewSiteTextButton(),
    );
  }
}
