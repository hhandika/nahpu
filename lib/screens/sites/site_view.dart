import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/controller/navigation.dart';
import 'package:nahpu/models/catalogs.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/indicators.dart';
import 'package:nahpu/screens/shared/navbar.dart';
import 'package:nahpu/screens/sites/components/menu_bar.dart';
import 'package:nahpu/screens/sites/site_form.dart';
import 'package:nahpu/services/database.dart';

enum MenuSelection { newSite, pdfExport, deleteRecords, deleteAllRecords }

class Sites extends ConsumerStatefulWidget {
  const Sites({Key? key}) : super(key: key);

  @override
  SitesState createState() => SitesState();
}

class SitesState extends ConsumerState<Sites> {
  bool _isVisible = false;
  PageController pageController = PageController();
  PageNavigation _pageNav = PageNavigation();

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
                pageController = PageController(initialPage: siteSize);
              });
              return PageView.builder(
                controller: pageController,
                itemCount: siteSize,
                itemBuilder: (context, index) {
                  final siteForm = _updateController(siteEntries, index);
                  return SiteForm(
                    id: siteEntries[index].id,
                    siteFormCtr: siteForm,
                  );
                },
                onPageChanged: (value) => setState(() {
                  _pageNav.currentPage = value + 1;
                  _pageNav = updatePageNavigation(_pageNav);
                  ref.invalidate(siteEntryProvider);
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
          visible: _isVisible,
          child: CustomPageNavButton(
            pageController: pageController,
            pageNav: _pageNav,
          )),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }

  SiteFormCtrModel _updateController(List<SiteData> siteEntries, int index) {
    return SiteFormCtrModel(
      siteIDCtr: TextEditingController(text: siteEntries[index].siteID),
      leadStaffCtr: siteEntries[index].leadStaffId,
      siteTypeCtr: TextEditingController(text: siteEntries[index].siteType),
      countryCtr: TextEditingController(text: siteEntries[index].country),
      stateProvinceCtr:
          TextEditingController(text: siteEntries[index].stateProvince),
      countyCtr: TextEditingController(text: siteEntries[index].county),
      municipalityCtr:
          TextEditingController(text: siteEntries[index].municipality),
      localityCtr: TextEditingController(text: siteEntries[index].locality),
      remarkCtr: TextEditingController(text: siteEntries[index].remark),
      habitatTypeCtr:
          TextEditingController(text: siteEntries[index].habitatType),
      habitatDescriptionCtr:
          TextEditingController(text: siteEntries[index].habitatDescription),
      habitatConditionCtr:
          TextEditingController(text: siteEntries[index].habitatCondition),
    );
  }
}
