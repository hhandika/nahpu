import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nahpu/models/project.dart';

import 'package:nahpu/screens/home.dart';
import 'package:nahpu/screens/projects/new_project.dart';
import 'package:nahpu/screens/projects/coll_events.dart';
import 'package:nahpu/screens/projects/notes.dart';
import 'package:nahpu/screens/projects/sites.dart';
import 'package:nahpu/screens/projects/specimens.dart';
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
        direction: SpeedDialDirection.down,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.book, color: Colors.white),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New Notes',
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const NewProjectForm()),
              // );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.place, color: Colors.white),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New Sites',
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const NewProjectForm()),
              // );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.timeline, color: Colors.white),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New CollEvents',
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const NewProjectForm()),
              // );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.pets, color: Colors.white),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New Specimens',
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const NewProjectForm()),
              // );
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
              leading: const Icon(Icons.create),
              title: const Align(
                  alignment: Alignment(-1.65, 0),
                  child: Text('Create a new project')),
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
              leading: const Icon(Icons.add_box),
              title: const Align(
                  alignment: Alignment(-1.45, 0),
                  child: Text('Bundle records')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Align(
                  alignment: Alignment(-1.45, 0),
                  child: Text('Save project as')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_view),
              title: const Align(
                  alignment: Alignment(-1.5, 0),
                  child: Text('Export to csv/tsv')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Align(
                  alignment: Alignment(-1.4, 0), child: Text('Export to pdf')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            const Divider(color: Colors.grey),
            const ListTile(
              leading: Icon(Icons.settings),
              title:
                  Align(alignment: Alignment(-1.3, 0), child: Text('Settings')),
              // onTap: () {
              //   // Navigator.of(context).pop();
              // },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Align(
                  alignment: Alignment(-1.4, 0), child: Text('Close project')),
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
              leading: const Icon(Icons.delete),
              title: const Align(
                  alignment: Alignment(-1.4, 0),
                  child: Text(
                    'Delete all records',
                    style: TextStyle(color: Colors.redAccent),
                  )),
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
              Icons.book,
              color: Theme.of(context).colorScheme.surface,
            ),
            title: 'Notes',
          ),
          TabItem(
            icon: Icon(
              Icons.place,
              color: Theme.of(context).colorScheme.surface,
            ),
            title: 'Sites',
          ),
          TabItem(
            icon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.primary,
              size: 45,
            ),
            title: 'Home',
          ),
          TabItem(
            icon: Icon(
              Icons.timeline,
              color: Theme.of(context).colorScheme.surface,
            ),
            title: 'CollEvents',
          ),
          TabItem(
            icon: Icon(
              Icons.pets,
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
          MaterialPageRoute(builder: (context) => const Notes()),
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
              'Failed fetching data from the database. Check if the project name exists. Error: $error')
        ]));
  }
}
