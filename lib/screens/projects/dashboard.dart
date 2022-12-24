import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/project.dart';
import 'package:nahpu/screens/collecting/menu_bar.dart';
import 'package:nahpu/screens/projects/components/menu_drawer.dart';
import 'package:nahpu/screens/projects/components/overview.dart';
import 'package:nahpu/screens/projects/components/personnel.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/navbar.dart';
import 'package:nahpu/screens/sites/components/menu_bar.dart';
import 'package:nahpu/screens/narrative/menu_bar.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/new_specimens.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends ConsumerState<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectUuid = ref.watch(projectUuidProvider.state).state;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Dashboard"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
        direction: SpeedDialDirection.down,
        children: [
          SpeedDialChild(
              child: Icon(Icons.book_rounded,
                  color: Theme.of(context).colorScheme.onInverseSurface),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              label: 'New Narrative',
              onTap: () async {
                await createNewNarrative(context, ref);
              }),
          SpeedDialChild(
            child: Icon(Icons.place_rounded,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New Sites',
            onTap: () async {
              await createNewSite(context, ref);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.timeline,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New CollEvents',
            onTap: () async {
              await createNewCollEvents(context, ref);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.pets_rounded,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New Specimens',
            onTap: () async {
              await createNewSpecimens(context, ref);
            },
          ),
        ],
      ),
      drawer: const ProjectMenuDrawer(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints c) {
          bool useHorizontalLayout = c.maxWidth > 600;
          return SafeArea(
            child: SingleChildScrollView(
              child: AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  FormCard(
                    title: 'Project Overview',
                    isPrimary: true,
                    child: ProjectOverview(
                      projectUuid: projectUuid,
                    ),
                  ),
                  const FormCard(
                    title: 'Personnel',
                    child: PersonnelViewer(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}
