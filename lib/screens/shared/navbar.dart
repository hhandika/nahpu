import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/project.dart';

import 'package:nahpu/screens/narrative/narrative.dart';
import 'package:nahpu/screens/collecting/coll_events.dart';
import 'package:nahpu/providers/page_viewer.dart';

import 'package:nahpu/screens/sites/sites.dart';
import 'package:nahpu/screens/specimens/specimens.dart';
import 'package:nahpu/screens/projects/project_home.dart';

class ProjectBottomNavbar extends ConsumerStatefulWidget {
  const ProjectBottomNavbar({Key? key}) : super(key: key);

  @override
  ProjectBottomNavbarState createState() => ProjectBottomNavbarState();
}

class ProjectBottomNavbarState extends ConsumerState<ProjectBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = ref.watch(projectNavbarIndexProvider.state).state;
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      elevation: 10,
      animationDuration: const Duration(seconds: 3),
      selectedIndex: selectedIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.home_rounded,
          ),
          label: 'Home',
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
          icon: Icon(
            Icons.pets_rounded,
          ),
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
        ref.read(projectNavbarIndexProvider.state).state = index;
        ref.refresh(pageNavigationProvider);
        _onItemTapped(index);
      },
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProjectHome(),
          ),
        );

        break;
      case 1:
        ref.refresh(siteEntryProvider);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Sites()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CollEvents()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Specimens()),
        );
        break;
      case 4:
        ref.refresh(narrativeEntryProvider);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Narrative()),
        );
        break;
    }
  }
}
