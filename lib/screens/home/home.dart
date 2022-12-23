import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/home/menu_drawer.dart';
import 'package:nahpu/screens/home/body.dart';
import 'package:nahpu/screens/projects/new_project.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME", style: Theme.of(context).textTheme.headline6),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (_) => const Search()));
            },
          ),
        ],
      ),
      drawer: const HomeMenuDrawer(),
      body: const HomeBody(),
      floatingActionButton: SpeedDial(
        icon: Icons.add_rounded,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
        children: [
          SpeedDialChild(
            child: Icon(Icons.create_rounded,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.primary,
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
}
