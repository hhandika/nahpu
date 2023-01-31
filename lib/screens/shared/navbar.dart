import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/styles/colors.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/narrative/narrative_view.dart';
import 'package:nahpu/screens/collecting/coll_event_view.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/sites/site_view.dart';
import 'package:nahpu/screens/specimens/specimen_view.dart';
import 'package:nahpu/screens/projects/dashboard.dart';

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
      backgroundColor: NahpuColor.navColor(context),
      elevation: 10,
      animationDuration: const Duration(seconds: 3),
      selectedIndex: selectedIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.dashboard_rounded,
          ),
          label: 'Dahsboard',
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );

        break;
      case 1:
        ref.invalidate(siteEntryProvider);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Sites()),
        );
        break;
      case 2:
        ref.invalidate(siteEntryProvider);
        ref.invalidate(collEventEntryProvider);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CollEvents()),
        );
        break;
      case 3:
        ref.invalidate(collEventEntryProvider);
        ref.invalidate(specimenEntryProvider);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Specimens()),
        );
        break;
      case 4:
        ref.invalidate(siteEntryProvider);
        ref.invalidate(narrativeEntryProvider);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Narrative()),
        );
        break;
    }
  }

  void _invalidateAll() {
    ref.invalidate(siteEntryProvider);
    ref.invalidate(collEventEntryProvider);
    ref.invalidate(specimenEntryProvider);
    ref.invalidate(narrativeEntryProvider);
  }
}

class SpecimenIcons extends ConsumerWidget {
  const SpecimenIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CatalogFmt catalogFmt = ref.watch(catalogFmtNotifier);
    return matchCatFmtToIcon(catalogFmt);
  }
}
