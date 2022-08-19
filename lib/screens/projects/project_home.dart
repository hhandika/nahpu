import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/project.dart';
import 'package:drift/drift.dart' as db;

import 'package:nahpu/screens/collecting/new_coll_events.dart';
import 'package:nahpu/screens/home.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/screens/narrative/new_narrative.dart';
import 'package:nahpu/screens/projects/new_project.dart';
import 'package:nahpu/screens/collecting/coll_events.dart';
import 'package:nahpu/screens/sites/new_sites.dart';
import 'package:nahpu/screens/sites/sites.dart';
import 'package:nahpu/screens/specimens/new_specimens.dart';
import 'package:nahpu/screens/specimens/specimens.dart';
import 'package:nahpu/screens/projects/project_info.dart';

class ProjectHome extends ConsumerStatefulWidget {
  const ProjectHome({Key? key, required this.projectUuid}) : super(key: key);

  final String projectUuid;

  @override
  ProjectHomeState createState() => ProjectHomeState();
}

class ProjectHomeState extends ConsumerState<ProjectHome> {
  final int _defaultIndex = 0;
  late String _projectUuid;

  @override
  void initState() {
    _projectUuid = widget.projectUuid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Home"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
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
              ref
                  .read(databaseProvider)
                  .createNarrative(NarrativeCompanion(
                    projectUuid: db.Value(_projectUuid),
                  ))
                  .then((value) => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => NewNarrative(
                            narrativeId: value,
                          ))));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const NewNarrative()),
              // );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.place_rounded,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New Sites',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewSites()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.timeline,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New CollEvents',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewCollEvent()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.pets_rounded,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New Specimens',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewSpecimens()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              accountName: const Text(
                "Heru Handika",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: const Text(
                "handika@email.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "H",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.create_rounded),
              title: const Text('Create a new project'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateProjectForm()),
                );
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.add_box_rounded),
              title: const Text('Bundle records'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_rounded),
              title: const Text('Save project as'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_view_rounded),
              title: const Text('Export to csv/tsv'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_rounded),
              title: const Text('Export to pdf'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            const Divider(color: Colors.grey),
            const ListTile(
              leading: Icon(Icons.settings_rounded),
              title: Text('Settings'),
              // onTap: () {
              //   // Navigator.of(context).pop();
              // },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text('Close project'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.delete_rounded),
              title: const Text(
                'Delete all records',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
          ],
        ),
      ),
      body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.0,
          ),
          children: [
            ProjectOverview(
              projectUuid: widget.projectUuid,
            )
          ]),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 60,
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
      ),
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Narrative()),
        // );

        break;
    }
  }
}

class ProjectOverview extends ConsumerWidget {
  const ProjectOverview({Key? key, required this.projectUuid})
      : super(key: key);

  final String projectUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        child: Card(
      color: Theme.of(context).colorScheme.surface,
      child: ref.watch(projectInfoProvider(projectUuid)).when(
            data: (data) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: ProjectInfo(
                  projectData: data,
                ),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text(error.toString()),
          ),
    ));
  }

  Widget showAlert(BuildContext context, String error) {
    return AlertDialog(
        title: const Text('ERROR!'),
        content: Column(children: [
          Text(
              'Failed fetching data from the database. Check if the project name exists. $error')
        ]));
  }
}
