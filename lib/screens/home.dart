import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:nahpu/screens/projects/create_project_form.dart';
import 'package:nahpu/screens/projects/project_menu.dart';
import 'package:provider/provider.dart';
import 'package:nahpu/database/database.dart';

enum MenuSelection { details, deleteProject }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _MainMenuState();
}

class _MainMenuState extends State<Home> {
  String _projectUuid = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        backgroundColor: const Color(0xFF2457C5),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (_) => const Search()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2457C5),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
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
            const ListTile(
              leading: Icon(Icons.settings),
              title:
                  Align(alignment: Alignment(-1.3, 0), child: Text('Settings')),
              // onTap: () {
              //   // Navigator.of(context).pop();
              // },
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Align(
                  alignment: Alignment(-1.3, 0), child: Text('About')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Align(
                  alignment: Alignment(-1.55, 0),
                  child: Text('Help and feedback')),
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
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                width: 600,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(children: const [
                        Text(
                          'Existing projects:',
                          style: TextStyle(fontSize: 18),
                        ),
                      ]),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                      _drawListView(),
                    ]))),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: const Color(0xFF2457C5),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.create, color: Colors.white),
            backgroundColor: const Color(0xFF2457C5),
            label: 'New Project',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateProjectForm()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _drawListView() {
    Future<List<ListProjectResult>> projectList = _getProjectList();
    return Expanded(
      child: FutureBuilder<List<ListProjectResult>>(
        future: projectList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  leading: const Icon(
                    Icons.insert_drive_file_outlined,
                    size: 40,
                    color: Colors.blueGrey,
                  ),
                  title: Text(
                    snapshot.data![index].projectName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    snapshot.data![index].projectUuid,
                    style: const TextStyle(fontSize: 8),
                  ),
                  trailing: PopupMenuButton<MenuSelection>(
                      onSelected: _onPopupMenuSelected,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<MenuSelection>>[
                            const PopupMenuItem<MenuSelection>(
                              value: MenuSelection.details,
                              child: Text('Details'),
                            ),
                            const PopupMenuItem<MenuSelection>(
                              value: MenuSelection.deleteProject,
                              child: Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProjectHome()),
                    );
                  },
                ));
              },
            );
          }
          return const Text("No project found!");
        },
      ),
    );
  }

  void _onPopupMenuSelected(MenuSelection item) {
    switch (item) {
      case MenuSelection.details:
        setState(() {});
        break;
      case MenuSelection.deleteProject:
        setState(() {});
        break;
    }
  }

  Future<List<ListProjectResult>> _getProjectList() async {
    return Provider.of<Database>(context, listen: false).getProjectList();
  }
}
