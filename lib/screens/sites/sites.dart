import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/navbar.dart';
import 'package:nahpu/screens/sites/menu_bar.dart';
import 'package:nahpu/screens/sites/new_sites.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const NewSites()));
            },
          ),
          const SiteMenu(),
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
                  return Column(
                    children: [
                      Text(siteEntries[index].id.toString()),
                    ],
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
