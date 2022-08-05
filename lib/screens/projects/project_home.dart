import 'package:flutter/material.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:nahpu/models/project.dart';
import 'package:nahpu/screens/home.dart';
import 'package:nahpu/screens/narrative/new_narrative.dart';
import 'package:nahpu/screens/projects/new_project.dart';
import 'package:nahpu/screens/collecting/coll_events.dart';
import 'package:nahpu/screens/narrative/narrative.dart';
import 'package:nahpu/screens/sites/new_sites.dart';
import 'package:nahpu/screens/sites/sites.dart';
import 'package:nahpu/screens/specimens/new_specimens.dart';
import 'package:nahpu/screens/specimens/specimens.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/screens/projects/project_info.dart';

class ProjectHome extends StatefulWidget {
  const ProjectHome({Key? key, required this.projectUuid}) : super(key: key);

  final String projectUuid;

  @override
  State<ProjectHome> createState() => _ProjectHomeState();
}

class _ProjectHomeState extends State<ProjectHome> {
  final int _defaultIndex = 2;

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewNarrative()),
              );
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
            child: Icon(Icons.timeline_rounded,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New CollEvents',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewSpecimens()),
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
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        style: TabStyle.fixedCircle,
        elevation: 10,
        color: Theme.of(context).colorScheme.surface,
        initialActiveIndex: _defaultIndex,
        items: [
          TabItem(
            icon: Icon(
              Icons.book_rounded,
              color: Theme.of(context).colorScheme.surface,
            ),
            title: 'Narrative',
          ),
          TabItem(
            icon: Icon(
              Icons.place_rounded,
              color: Theme.of(context).colorScheme.surface,
            ),
            title: 'Sites',
          ),
          TabItem(
            icon: Icon(
              Icons.home_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 45,
            ),
            title: 'Home',
          ),
          TabItem(
            icon: Icon(
              Icons.timeline_rounded,
              color: Theme.of(context).colorScheme.surface,
            ),
            title: 'CollEvents',
          ),
          TabItem(
            icon: Icon(
              Icons.pets_rounded,
              color: Theme.of(context).colorScheme.surface,
            ),
            title: 'Specimens',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Narrative()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Sites()),
        );
        break;
      case 2:
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
          MaterialPageRoute(builder: (context) => const Specimens()),
        );
        break;
    }
  }
}

class ProjectOverview extends StatelessWidget {
  const ProjectOverview({Key? key, required this.projectUuid})
      : super(key: key);

  final String projectUuid;

  @override
  Widget build(BuildContext context) {
    final data = ProjectModel(context: context).getProjectByUuid(
      projectUuid,
    );
    return Card(
        color: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
            child: FutureBuilder(
                future: data,
                builder: (context, AsyncSnapshot<ProjectData> snapshot) {
                  if (snapshot.hasError) {
                    return showAlert(context, 'Error: ${snapshot.error}');
                  } else {
                    return ListTile(
                        title: const Text('Project Overview'),
                        subtitle: ProjectInfo(projectData: snapshot.data));
                  }
                })));
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
