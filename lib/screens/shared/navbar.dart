import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/configs/colors.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalog.dart';
import 'package:nahpu/providers/project.dart';
import 'package:nahpu/screens/narrative/narrative_view.dart';
import 'package:nahpu/screens/collecting_events/coll_event_view.dart';
import 'package:nahpu/providers/page_viewer.dart';
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
    int selectedIndex = ref.watch(projectNavbarIndexProvider.state).state;
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
            builder: (context) => const Dashboard(),
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
        ref.refresh(collEventEntryProvider);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CollEvents()),
        );
        break;
      case 3:
        ref.refresh(specimenEntryProvider);
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

class SpecimenIcons extends ConsumerWidget {
  const SpecimenIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CatalogFmt catalogFmt = ref.watch(catalogFmtProvider);
    switch (catalogFmt) {
      case CatalogFmt.birds:
        return const Icon(MdiIcons.feather);
      case CatalogFmt.generalMammals:
        return const Icon(MdiIcons.paw);
      case CatalogFmt.bats:
        return const Icon(MdiIcons.bat);
      default:
        return const Icon(MdiIcons.paw);
    }
  }
}
