import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  const SpecimenViewer({super.key});

  @override
  SpecimenViewerState createState() => SpecimenViewerState();
}

class SpecimenViewerState extends ConsumerState<SpecimenViewer> {
  bool isVisible = false;
  final PageNavigation _pageNav = PageNavigation.init();
  String? _specimenUuid;
  CatalogFmt? _catalogFmt;
  TaxonData taxonomy = TaxonData();

  @override
  void dispose() {
    _pageNav.dispose();
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
                    } else {
                      isVisible = false;
                    }
                    _pageNav.pageCounts = specimenSize;
                    _pageNav.updatePageController();
                  });
                  return SpecimenPages(
                    pageNav: _pageNav,
                    specimenEntry: specimenEntry,
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
    setState(() {
      _pageNav.currentPage = value + 1;
      _pageNav.updatePageNavigation();
      ref.invalidate(specimenEntryProvider);
    });
  }
}

class SpecimenPages extends ConsumerStatefulWidget {
  const SpecimenPages({
    super.key,
    required this.onPageChanged,
    required this.specimenEntry,
    required this.pageNav,
  });

  final void Function(int) onPageChanged;
  final List<SpecimenData> specimenEntry;
  final PageNavigation pageNav;

  @override
  SpecimenPagesState createState() => SpecimenPagesState();
}

class SpecimenPagesState extends ConsumerState<SpecimenPages> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageNav.pageController,
      itemCount: widget.specimenEntry.length,
      itemBuilder: (context, index) {
        CatalogFmt catalogFmt =
            matchTaxonGroupToCatFmt(widget.specimenEntry[index].taxonGroup);
        final specimenFormCtr = _updateController(widget.specimenEntry[index]);
        return PageViewer(
          pageNav: widget.pageNav,
          child: SpecimenForm(
            specimenUuid: widget.specimenEntry[index].uuid,
            specimenCtr: specimenFormCtr,
            catalogFmt: catalogFmt,
          ),
        );
      },
      onPageChanged: widget.onPageChanged,
    );
  }

  SpecimenFormCtrModel _updateController(SpecimenData specimenEntry) {
    return SpecimenFormCtrModel.fromData(specimenEntry);
  }
}
