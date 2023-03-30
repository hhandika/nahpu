import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/navigation.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/navigation.dart';
import 'package:nahpu/screens/specimens/new_specimens.dart';
import 'package:nahpu/screens/specimens/shared/menu_bar.dart';
import 'package:nahpu/screens/specimens/specimen_form.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/navigation_services.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';

class Specimens extends ConsumerStatefulWidget {
  const Specimens({Key? key}) : super(key: key);

  @override
  SpecimensState createState() => SpecimensState();
}

class SpecimensState extends ConsumerState<Specimens> {
  bool isVisible = false;
  PageController pageController = PageController();
  PageNavigation _pageNav = PageNavigation();

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
        actions: const [NewSpecimens(), SpecimenMenu()],
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
                      pageController =
                          PageController(initialPage: specimenSize);
                    });
                    return PageView.builder(
                      controller: pageController,
                      itemCount: specimenSize,
                      itemBuilder: (context, index) {
                        int? speciesId = specimenEntry[index].speciesID;
                        if (speciesId != null) {
                          TaxonomyQuery(ref.read(databaseProvider))
                              .getTaxonById(speciesId)
                              .then((value) {
                            taxonomy = TaxonData.fromTaxonomyData(value);
                          });
                        }
                        final specimenFormCtr =
                            _updateController(specimenEntry[index]);
                        return SpecimenForm(
                          specimenUuid: specimenEntry[index].uuid,
                          specimenCtr: specimenFormCtr,
                          catalogFmt: matchTaxonGroupToCatFmt(
                              specimenEntry[index].taxonGroup),
                        );
                      },
                      onPageChanged: (value) => setState(() {
                        _pageNav.currentPage = value + 1;
                        _pageNav = updatePageNavigation(_pageNav);
                        ref.invalidate(specimenEntryProvider);
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
        child: CustomPageNavButton(
          pageController: pageController,
          pageNav: _pageNav,
        ),
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }

  SpecimenFormCtrModel _updateController(SpecimenData specimenEntry) {
    return SpecimenFormCtrModel.fromData(specimenEntry, TaxonData());
  }
}