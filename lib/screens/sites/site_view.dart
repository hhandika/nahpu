import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/models/page_viewer.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/indicators.dart';
import 'package:nahpu/screens/shared/navbar.dart';
import 'package:nahpu/screens/sites/components/menu_bar.dart';
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
    final pageNotifier = ref.watch(pageNavigationProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sites"),
        leading: const ProjectBackButton(),
        actions: const [
          NewSite(),
          SiteMenu(),
        ],
      ),
      resizeToAvoidBottomInset: false,
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
                  final siteForm = SiteFormCtrModel(
                    siteIDCtr:
                        TextEditingController(text: siteEntries[index].siteID),
                    siteTypeCtr: TextEditingController(
                        text: siteEntries[index].siteType),
                    countryCtr:
                        TextEditingController(text: siteEntries[index].country),
                    stateProvinceCtr: TextEditingController(
                        text: siteEntries[index].stateProvince),
                    countyCtr:
                        TextEditingController(text: siteEntries[index].county),
                    municipalityCtr: TextEditingController(
                        text: siteEntries[index].municipality),
                    localityCtr: TextEditingController(
                        text: siteEntries[index].locality),
                  );
                  return SiteForm(
                    id: siteEntries[index].id,
                    siteFormCtr: siteForm,
                  );
                },
                onPageChanged: (value) => setState(() {
                  pageNotifier.state.currentPage = value + 1;
                  checkPageNavigation(ref);
                  // ref.refresh(siteEntryProvider);
                }),
              );
            }
          }, loading: () {
            return const CommmonProgressIndicator();
          }, error: (error, stackTrace) {
            return Text(error.toString());
          }),
        ),
      ),
      bottomSheet: Visibility(
          visible: isVisible,
          child: CustomPageNavButton(
            pageController: pageController,
          )),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}
