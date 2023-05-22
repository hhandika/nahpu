import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/providers/validation.dart';
import 'package:nahpu/screens/projects/components/action_buttons.dart';
import 'package:nahpu/screens/projects/components/menu_drawer.dart';
import 'package:nahpu/screens/projects/components/misc_forms.dart';
import 'package:nahpu/screens/projects/components/overview.dart';
import 'package:nahpu/screens/projects/components/personnel.dart';
import 'package:nahpu/screens/projects/components/taxon_registry.dart';
import 'package:nahpu/screens/projects/edit_project.dart';
import 'package:nahpu/screens/shared/navigation.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/styles/catalog_pages.dart';

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
    final projectUuid = ref.watch(projectUuidProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Dashboard"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: const ActionButtons(),
      drawer: const ProjectMenuDrawer(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints c) {
          bool useHorizontalLayout = c.maxWidth > 600;
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AdaptiveMainLayout(
                    useHorizontalLayout: useHorizontalLayout,
                    height: topDashboardHeight,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ProjectOverview(
                            projectUuid: projectUuid,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: IconButton(
                              onPressed: () {
                                ref
                                    .read(projectFormValidation.notifier)
                                    .isEditing();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditProject(projectUuid: projectUuid)));
                              },
                              icon: Icon(
                                Icons.edit_rounded,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const PersonnelViewer(),
                    ],
                  ),
                  AdaptiveMainLayout(
                    useHorizontalLayout: useHorizontalLayout,
                    height: bottomDashboardHeight,
                    children: const [TaxonRegistryViewer(), MiscForm()],
                  )
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
