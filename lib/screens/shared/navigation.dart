import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/narrative/narrative_view.dart';
import 'package:nahpu/screens/collecting/coll_event_view.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/sites/site_view.dart';
import 'package:nahpu/screens/specimens/specimen_view.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/models/navigation.dart';

class ProjectBottomNavbar extends ConsumerStatefulWidget {
  const ProjectBottomNavbar({Key? key}) : super(key: key);

  @override
  ProjectBottomNavbarState createState() => ProjectBottomNavbarState();
}

class ProjectBottomNavbarState extends ConsumerState<ProjectBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = ref.watch(projectNavbarIndexProvider);
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      backgroundColor: Color.lerp(Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.secondary, 0.1),
      elevation: 10,
      animationDuration: const Duration(seconds: 3),
      selectedIndex: selectedIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.dashboard_rounded,
          ),
          label: 'Dashboard',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.place_rounded,
          ),
          label: 'Sites',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.timeline,
          ),
          label: 'CollEvents',
          tooltip: 'Collection Events',
        ),
        NavigationDestination(
          icon: SpecimenIcons(),
          label: 'Specimens',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.book_rounded,
          ),
          label: 'Narrative',
        ),
      ],
      onDestinationSelected: (int index) {
        ref.read(projectNavbarIndexProvider.notifier).state = index;
        _onItemTapped(index);
      },
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        _invalidateAll();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );

        break;
      case 1:
        ref.invalidate(siteEntryProvider);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Sites()),
        );
        break;
      case 2:
        ref.invalidate(siteEntryProvider);
        ref.invalidate(collEventEntryProvider);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CollEvents()),
        );
        break;
      case 3:
        ref.invalidate(collEventEntryProvider);
        ref.invalidate(specimenEntryProvider);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Specimens()),
        );
        break;
      case 4:
        ref.invalidate(siteEntryProvider);
        ref.invalidate(narrativeEntryProvider);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Narrative()),
        );
        break;
    }
  }

  void _invalidateAll() {
    ref.invalidate(siteEntryProvider);
    ref.invalidate(weatherDataProvider);
    ref.invalidate(collEventEntryProvider);
    ref.invalidate(specimenEntryProvider);
    ref.invalidate(narrativeEntryProvider);
  }
}

class PageNavButton extends ConsumerWidget {
  final Curve _curve = Curves.easeInOut;

  const PageNavButton({
    Key? key,
    required this.pageController,
    required this.pageNav,
  }) : super(key: key);

  final PageController pageController;
  final PageNavigation pageNav;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: pageNav.isFirstPage
                ? null
                : () {
                    if (pageController.hasClients) {
                      pageController.jumpToPage(0);
                    }
                  },
            child: const Icon(Icons.keyboard_double_arrow_left),
          ),
          TextButton(
            onPressed: pageNav.isFirstPage
                ? null
                : () {
                    if (pageController.hasClients) {
                      pageController.previousPage(
                          duration: kTabScrollDuration, curve: _curve);
                    }
                  },
            child: const Icon(Icons.navigate_before),
          ),
          FittedBox(
            child: Text(
              'Page ${pageNav.currentPage} of ${pageNav.pageCounts}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          TextButton(
            onPressed: pageNav.isLastPage
                ? null
                : () {
                    if (pageController.hasClients) {
                      pageController.nextPage(
                          duration: kTabScrollDuration, curve: _curve);
                    }
                  },
            child: const Icon(Icons.navigate_next),
          ),
          TextButton(
            onPressed: pageNav.isLastPage
                ? null
                : () {
                    if (pageController.hasClients) {
                      pageController.jumpToPage(pageNav.pageCounts - 1);
                    }
                  },
            child: const Icon(Icons.keyboard_double_arrow_right),
          )
        ],
      ),
    );
  }
}

class SpecimenIcons extends ConsumerWidget {
  const SpecimenIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CatalogFmt catalogFmt = ref.watch(catalogFmtNotifier);
    return Icon(matchCatFmtToIcon(catalogFmt));
  }
}
