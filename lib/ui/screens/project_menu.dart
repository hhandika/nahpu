import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:nahpu/ui/screens/main_menu.dart';

class ProjectMenu extends StatefulWidget {
  const ProjectMenu({Key? key}) : super(key: key);

  @override
  State<ProjectMenu> createState() => _ProjectMenuState();
}

class _ProjectMenuState extends State<ProjectMenu> {
  final int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Menu"),
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
              title: Align(
                  alignment: const Alignment(-1.4, 0),
                  child: Text(
                    'Close project',
                    style: TextStyle(color: Colors.red[500]),
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
        currentIndex: _selectedIndex,
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
      ),
    );
  }
}
