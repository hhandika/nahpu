import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/navbar.dart';
import 'package:nahpu/screens/sites/menu_bar.dart';
import 'package:nahpu/screens/sites/site_form.dart';

enum MenuSelection { newSite, pdfExport, deleteRecords, deleteAllRecords }

class Sites extends ConsumerStatefulWidget {
  const Sites({Key? key}) : super(key: key);

  @override
  SitesState createState() => SitesState();
}

class SitesState extends ConsumerState<Sites> {
  bool isVisible = false;
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final siteEntries = ref.watch(siteEntryProvider);
    ref.watch(pageNavigationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sites"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: const ProjectBackButton(),
        actions: const [
          NewSite(),
          SiteMenu(),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: siteEntries.when(data: (siteEntries) {
            if (siteEntries.isEmpty) {
              setState(() {
                isVisible = false;
              });
              return const Text("No site entries");
            } else {
              int siteSize = siteEntries.length;
              setState(() {
                if (siteSize >= 2) {
                  isVisible = true;
                }
                ref.watch(pageNavigationProvider.notifier).state.pageCounts =
                    siteSize;
                pageController = PageController(initialPage: siteSize);
              });
              return PageView.builder(
                controller: pageController,
                itemCount: siteSize,
                itemBuilder: (context, index) {
                  return SiteForm(
                    id: siteEntries[index].id,
                    siteIDController:
                        TextEditingController(text: siteEntries[index].siteID),
                    siteTypeController: TextEditingController(
                        text: siteEntries[index].siteType),
                    countryController:
                        TextEditingController(text: siteEntries[index].country),
                    stateProvinceController: TextEditingController(
                        text: siteEntries[index].stateProvince),
                    countyController:
                        TextEditingController(text: siteEntries[index].county),
                    municipalityController: TextEditingController(
                        text: siteEntries[index].municipality),
                    localityController: TextEditingController(
                        text: siteEntries[index].locality),
                  );
                },
                onPageChanged: (value) => ref
                    .watch(pageNavigationProvider.notifier)
                    .state
                    .currentPage = value,
              );
            }
          }, loading: () {
            return const CircularProgressIndicator();
          }, error: (error, stackTrace) {
            return Text(error.toString());
          }),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Visibility(
          visible: isVisible,
          child: CustomPageNavButton(
            pageController: pageController,
          )),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}
