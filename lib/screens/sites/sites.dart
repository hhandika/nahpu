import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/navbar.dart';
import 'package:nahpu/screens/sites/menu_bar.dart';
import 'package:nahpu/screens/sites/new_sites.dart';

enum MenuSelection { newSite, pdfExport, deleteRecords, deleteAllRecords }

class Sites extends StatefulWidget {
  const Sites({Key? key}) : super(key: key);

  @override
  State<Sites> createState() => _SitesState();
}

class _SitesState extends State<Sites> {
  PageController pageController = PageController();
  int count = 0;
  int indexPos = 0;

  @override
  Widget build(BuildContext context) {
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
        child: SiteViewer(
          pageController: pageController,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: CustomNavButton(
        pageController: pageController,
        count: count,
        indexPos: indexPos,
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}

class SiteViewer extends ConsumerWidget {
  const SiteViewer({Key? key, required this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Text('');
  }
}
