import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/home/menu.dart';
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
        title: Text("HOME", style: Theme.of(context).textTheme.titleLarge),
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
      resizeToAvoidBottomInset: false,
      drawer: const HomeMenuDrawer(),
      body: const HomeBody(),
      floatingActionButton: SpeedDial(
        icon: Icons.add_rounded,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        children: [
          SpeedDialChild(
            child: Icon(Icons.create_rounded,
                color: Theme.of(context).colorScheme.onSecondary),
            backgroundColor: Theme.of(context).colorScheme.secondary,
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
