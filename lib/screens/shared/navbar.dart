import 'package:flutter/material.dart';

import 'package:nahpu/screens/narrative/narrative.dart';
import 'package:nahpu/screens/collecting/coll_events.dart';

import 'package:nahpu/screens/sites/sites.dart';
import 'package:nahpu/screens/specimens/specimens.dart';

class ProjectBottomNavbar extends StatefulWidget {
  const ProjectBottomNavbar({Key? key}) : super(key: key);

  @override
  State<ProjectBottomNavbar> createState() => _ProjectBottomNavbarState();
}

class _ProjectBottomNavbarState extends State<ProjectBottomNavbar> {
  final int _defaultIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: 65,
      elevation: 10,
      selectedIndex: _defaultIndex,
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
        setState(() {
          _onItemTapped(index);
        });
      },
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Specimens()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Sites()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CollEvents()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Narrative()),
        );

        break;
    }
  }
}
