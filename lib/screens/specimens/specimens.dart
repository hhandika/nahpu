import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/models/page_viewer.dart';

import 'package:nahpu/providers/page_viewer.dart';

import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/navbar.dart';
import 'package:nahpu/screens/specimens/menu_bar.dart';
import 'package:nahpu/screens/specimens/specimen_form.dart';

class Specimens extends ConsumerStatefulWidget {
  const Specimens({Key? key}) : super(key: key);

  @override
  SpecimensState createState() => SpecimensState();
}

class SpecimensState extends ConsumerState<Specimens> {
  bool isVisible = false;
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final specimenEntries = ref.watch(specimenEntryProvider);
    final pageNotifier = ref.watch(pageNavigationProvider.notifier);
    ref.watch(pageNavigationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Specimen Records"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: const [NewSpecimens(), SpecimenMenu()],
        leading: const ProjectBackButton(),
      ),
      body: SafeArea(
        child: Center(
          child: specimenEntries.when(
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
                  ref.watch(pageNavigationProvider.notifier).state.pageCounts =
                      specimenSize;
                  // We want to view the last page first.
                  // Dart uses 0-based indexing. Technically, this is out-of-bound.
                  // But, what happens here is that it will trigger the PageView onPageChanged.
                  // It fixes the issues that the curentPage state does not show the current page value.
                  pageController = PageController(initialPage: specimenSize);
                });
                return PageView.builder(
                  controller: pageController,
                  itemCount: specimenSize,
                  itemBuilder: (context, index) {
                    final specimenFormCtr = SpecimenFormCtrModel(
                      conditionCtr: specimenEntry[index].condition,
                      prepDateCtr: TextEditingController(
                          text: specimenEntry[index].prepDate),
                      prepTimeCtr: TextEditingController(
                          text: specimenEntry[index].prepTime),
                      captureDateCtr: TextEditingController(
                          text: specimenEntry[index].captureDate),
                      captureTimeCtr: TextEditingController(
                          text: specimenEntry[index].captureTime),
                      trapTypeCtr: TextEditingController(
                          text: specimenEntry[index].trapType),
                    );

                    return SpecimenForm(
                        specimenUuid: specimenEntry[index].specimenUuid,
                        specimenCtr: specimenFormCtr);
                  },
                  onPageChanged: (value) => setState(() {
                    pageNotifier.state.currentPage = value + 1;
                    checkPageNavigation(ref);
                  }),
                );
              }
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text(error.toString()),
          ),
        ),
      ),
      bottomSheet: Visibility(
        visible: isVisible,
        child: CustomPageNavButton(
          pageController: pageController,
        ),
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}
