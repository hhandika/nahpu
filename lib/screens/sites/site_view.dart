import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/navigation_services.dart';
import 'package:nahpu/models/navigation.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/providers/catalogs.dart';
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
  PageController pageController = PageController();
  PageNavigation _pageNav = PageNavigation();
  int? _siteId;
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final siteEntries = ref.watch(siteEntryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sites"),
        automaticallyImplyLeading: false,
        actions: [
          const NewSite(),
          SiteMenu(
            siteId: _siteId,
          ),
        ],
      ),
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: siteEntries.when(data: (siteEntries) {
            if (siteEntries.isEmpty) {
              setState(() {
                _isVisible = false;
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
                pageController = updatePageCtr(siteSize);
              });
              return PageView.builder(
                controller: pageController,
                itemCount: siteSize,
                itemBuilder: (context, index) {
                  final siteForm = _updateController(siteEntries[index]);
                  return PageViewer(
                    pageNav: _pageNav,
                    child: SiteForm(
                      id: siteEntries[index].id,
                      siteFormCtr: siteForm,
                    ),
                  );
                },
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
            pageController: pageController,
            pageNav: _pageNav,
          )),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }

  void _updatePageNav(int value) {
    _pageNav.currentPage = value + 1;
    _pageNav = updatePageNavigation(_pageNav);
    ref.invalidate(siteEntryProvider);
  }

  SiteFormCtrModel _updateController(SiteData siteEntries) {
    return SiteFormCtrModel.fromData(siteEntries);
  }
}
