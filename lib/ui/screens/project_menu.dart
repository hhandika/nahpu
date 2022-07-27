import 'package:flutter/material.dart';

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
        unselectedItemColor: Colors.grey,
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
