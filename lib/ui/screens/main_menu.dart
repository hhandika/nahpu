import 'package:flutter/material.dart';
import 'package:nahpu/ui/screens/new_project_form.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import './new_project_form.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
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
      drawer: const Drawer(),
      body: const Center(
        child: Text('Nahpu Project'),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: const Color(0xFF2457C5),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.create),
            backgroundColor: const Color(0xFF2457C5),
            label: 'New Project',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewProjectForm()),
              );
            },
          ),
        ],
      ),
    );
  }
}
