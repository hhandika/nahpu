import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:nahpu/ui/screens/main_menu.dart';
import 'package:nahpu/ui/screens/projects/new_project_form.dart';
import './notes.dart';

class ProjectMenu extends StatefulWidget {
  const ProjectMenu({Key? key}) : super(key: key);

  @override
  State<ProjectMenu> createState() => _ProjectMenuState();
}

class _ProjectMenuState extends State<ProjectMenu> {
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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2457C5),
              ),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
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
                      builder: (context) => const NewProjectForm()),
                );
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Align(
                  alignment: Alignment(-1.45, 0),
                  child: Text('Save project as')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainMenu()),
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
                  MaterialPageRoute(builder: (context) => const MainMenu()),
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
                  MaterialPageRoute(builder: (context) => const MainMenu()),
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
                  MaterialPageRoute(builder: (context) => const MainMenu()),
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
                  MaterialPageRoute(builder: (context) => const MainMenu()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Nahpu Project'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2457C5),
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        currentIndex: _defaultIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Sites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'CollEvents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Specimens',
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
          MaterialPageRoute(builder: (context) => const Notes()),
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Notes()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Notes()),
        );
        break;
    }
  }
}
