import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'package:nahpu/models/project.dart';
import 'package:nahpu/screens/projects/new_project.dart';
import 'package:nahpu/screens/projects/project_home.dart';
import 'package:nahpu/screens/projects/project_info.dart';
import 'package:nahpu/database/database.dart';

enum MenuSelection { details, deleteProject }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Uri _helpUrl = Uri(
      scheme: 'https', host: 'www.github.com', path: 'hhandika/nahpu/issues');

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.create_rounded),
              title: const Text('Create a new project'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateProjectForm()),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.settings_rounded),
              title: Text('Settings'),
              // onTap: () {
              //   // Navigator.of(context).pop();
              // },
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.info_rounded),
              title: const Text('About'),
              onTap: () {
                return showAboutDialog(
                  context: context,
                  applicationName: 'Nahpu',
                  applicationVersion: '0.0.1',
                  applicationIcon: const Icon(Icons.info),
                  children: [
                    const Text(
                        'A tool for cataloging natural history specimens.'),
                    const Text('It is a work in progress.'),
                    const Text('Please report any bugs or feature requests'),
                  ],
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_rounded),
              title: const Text('Help and feedback'),
              onTap: () {
                _launchHelpUrl(_helpUrl);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                width: 600,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(children: [
                        Text('Existing projects:',
                            style: Theme.of(context).textTheme.titleLarge),
                      ]),
                      Divider(
                        color: Theme.of(context).colorScheme.onSurface,
                        thickness: 1.5,
                      ),
                      _drawListView(),
                    ]))),
      )),
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

  Widget _drawListView() {
    Future<List<ListProjectResult>> projectList = _getProjectList();
    return Expanded(
      child: FutureBuilder<List<ListProjectResult>>(
        future: projectList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  leading: Icon(
                    Icons.insert_drive_file_rounded,
                    size: 40,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    snapshot // Reverse the list, so the newest projects are at the top.
                        .data![_reverseIndex(index, snapshot.data!.length)]
                        .projectName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    snapshot.data![_reverseIndex(index, snapshot.data!.length)]
                        .projectUuid,
                    style: const TextStyle(fontSize: 8),
                  ),
                  trailing: PopupMenuButton<MenuSelection>(
                      onSelected: _onPopupMenuSelected,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<MenuSelection>>[
                            PopupMenuItem<MenuSelection>(
                              value: MenuSelection.details,
                              child: const Text('Info'),
                              onTap: () async {
                                _getProjectInfo(
                                    context,
                                    snapshot
                                        .data![_reverseIndex(
                                            index, snapshot.data!.length)]
                                        .projectUuid);
                              },
                            ),
                            PopupMenuItem<MenuSelection>(
                              value: MenuSelection.deleteProject,
                              onTap: () async {
                                _deleteProject(
                                    context,
                                    snapshot
                                        .data![_reverseIndex(
                                            index, snapshot.data!.length)]
                                        .projectUuid);
                              },
                              child: const Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProjectHome(
                                projectUuid: snapshot
                                    .data![_reverseIndex(
                                        index, snapshot.data!.length)]
                                    .projectUuid,
                              )),
                    );
                  },
                ));
              },
            );
          }
          return const Center(
            child: Text('No projects found.'),
          );
        },
      ),
    );
  }

  int _reverseIndex(int index, int length) {
    return (length - 1) - index;
  }

  Future<void> _deleteProject(BuildContext context, String projectUuid) async {
    ProjectModel(context: context).deleteProject(projectUuid);
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

  Future<void> _getProjectInfo(BuildContext context, projectUuid) async {
    final projectData = await ProjectModel(context: context).getProjectByUuid(
      projectUuid,
    );

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Project information'),
          content: SingleChildScrollView(
            child: ProjectInfo(
              projectData: projectData,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchHelpUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
