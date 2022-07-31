import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:nahpu/screens/projects/create_project_form.dart';
import 'package:nahpu/screens/projects/project_menu.dart';
import 'package:provider/provider.dart';
import 'package:nahpu/database/database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _MainMenuState();
}

class _MainMenuState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NAHPU"),
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
        child: FutureBuilder<List<ListProjectResult>>(
          future: _getProjectList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(children: [
                      Text(snapshot.data![index].projectName),
                      Text(snapshot.data![index].projectUuid)
                    ]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProjectMenu()),
                      );
                    },
                  );
                },
              );
            } else {
              return const Text("No project found!");
            }
          },
        ),
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

  Future<List<ListProjectResult>> _getProjectList() async {
    return Provider.of<Database>(context, listen: false).getProjectList();
  }
}
