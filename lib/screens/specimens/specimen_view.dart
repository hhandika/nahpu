import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/navigation.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/navigation.dart';
import 'package:nahpu/screens/specimens/shared/menu_bar.dart';
import 'package:nahpu/screens/specimens/specimen_form.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/navigation_services.dart';

class SpecimenViewer extends ConsumerStatefulWidget {
  const SpecimenViewer({Key? key}) : super(key: key);

  @override
  SpecimenViewerState createState() => SpecimenViewerState();
}

class SpecimenViewerState extends ConsumerState<SpecimenViewer> {
  bool isVisible = false;
  PageController pageController = PageController();
  PageNavigation _pageNav = PageNavigation();
  String? _specimenUuid;
  CatalogFmt? _catalogFmt;
  TaxonData taxonomy = TaxonData();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Specimen Records",
        ),
        actions: [
          const NewSpecimens(),
          SpecimenMenu(
            specimenUuid: _specimenUuid,
            catalogFmt: _catalogFmt,
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ref.watch(specimenEntryProvider).when(
                data: (specimenEntry) {
                  if (specimenEntry.isEmpty) {
                    setState(() {
                      isVisible = false;
                    });

                    return const Text("No specimen records");
                  } else {
                    int specimenSize = specimenEntry.length;
                    setState(() {
                      if (specimenSize >= 2) {
                        isVisible = true;
                      }
                      _pageNav.pageCounts = specimenSize;
                      // We want to view the last page first.
                      // Dart uses 0-based indexing. Technically, this is out-of-bound.
                      // But, what happens here is that it will trigger the PageView onPageChanged.
                      // It fixes the issues that the currentPage state does not show the current page value.
                      pageController = updatePageCtr(specimenSize);
                    });
                    return PageView.builder(
                      controller: pageController,
                      itemCount: specimenSize,
                      itemBuilder: (context, index) {
                        CatalogFmt catalogFmt = matchTaxonGroupToCatFmt(
                            specimenEntry[index].taxonGroup);
                        final specimenFormCtr =
                            _updateController(specimenEntry[index]);
                        return PageViewer(
                          pageNav: _pageNav,
                          child: SpecimenForm(
                            specimenUuid: specimenEntry[index].uuid,
                            specimenCtr: specimenFormCtr,
                            catalogFmt: catalogFmt,
                          ),
                        );
                      },
                      onPageChanged: (index) {
                        setState(() {
                          _specimenUuid = specimenEntry[index].uuid;
                          _catalogFmt = matchTaxonGroupToCatFmt(
                              specimenEntry[index].taxonGroup);
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
          pageController: pageController,
          pageNav: _pageNav,
        ),
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }

  void _updatePageNav(int value) {
    setState(() {
      _pageNav.currentPage = value + 1;
      _pageNav = updatePageNavigation(_pageNav);
      ref.invalidate(specimenEntryProvider);
    });
  }

  SpecimenFormCtrModel _updateController(SpecimenData specimenEntry) {
    return SpecimenFormCtrModel.fromData(specimenEntry, TaxonData());
  }
}
