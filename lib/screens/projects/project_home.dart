import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nahpu/models/project.dart';

import 'package:nahpu/screens/home.dart';
import 'package:nahpu/screens/projects/create_project_form.dart';
import 'package:nahpu/screens/projects/coll_events.dart';
import 'package:nahpu/screens/projects/notes.dart';
import 'package:nahpu/screens/projects/sites.dart';
import 'package:nahpu/screens/projects/specimens.dart';
import 'package:nahpu/database/database.dart';

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
        backgroundColor: const Color(0xFF2457C5),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: const Color(0xFF2457C5),
        direction: SpeedDialDirection.down,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.book, color: Colors.white),
            backgroundColor: const Color.fromRGBO(36, 87, 197, 1),
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
            backgroundColor: const Color.fromRGBO(36, 87, 197, 1),
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
            backgroundColor: const Color.fromRGBO(36, 87, 197, 1),
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
            backgroundColor: const Color.fromRGBO(36, 87, 197, 1),
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
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2457C5)),
              accountName: Text(
                "Heru Handika",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
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
      body: Center(
          child: ProjectOverview(
        projectUuid: widget.projectUuid,
      )),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color(0xFF2457C5),
        style: TabStyle.fixedCircle,
        elevation: 10,
        color: Colors.white,
        initialActiveIndex: _defaultIndex,
        items: const [
          TabItem(
            icon: Icon(
              Icons.book,
              color: Colors.white,
            ),
            title: 'Notes',
          ),
          TabItem(
            icon: Icon(
              Icons.place,
              color: Colors.white,
            ),
            title: 'Sites',
          ),
          TabItem(
            icon: Icon(
              Icons.home,
              color: Color(0xFF2457C5),
              size: 45,
            ),
            title: 'Home',
          ),
          TabItem(
            icon: Icon(
              Icons.timeline,
              color: Colors.white,
            ),
            title: 'CollEvents',
          ),
          TabItem(
            icon: Icon(
              Icons.pets,
              color: Colors.white,
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
        child: Container(
            width: 400,
            height: 400,
            color: Colors.blueGrey,
            child: FutureBuilder(
                future: data,
                builder: (context, AsyncSnapshot<ProjectData> snapshot) =>
                    Column(children: [
                      const Text('Project Overview'),
                      Text('Project UUID: $projectUuid'),
                      Text(
                          'Project Name: ${snapshot.data?.projectName ?? 'Empty!'}'),
                      Text(
                          'Project Descrtion: ${snapshot.data?.projectDescription ?? 'Empty!'}'),
                      Text(
                          'Principal Investigator: ${snapshot.data?.principalInvestigator ?? 'No PI'}'),
                      Text('Collector Name: ${snapshot.data!.collector}'),
                      Text('Collector Email: ${snapshot.data!.collectorEmail}'),
                      Text(
                          'Start collector number at: ${snapshot.data!.catNumStart}'),
                      Text(
                          'End collector number at: ${snapshot.data!.catNumEnd}'),
                    ]))));
  }
}
