import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nahpu/providers/project.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:nahpu/database/database.dart';
import 'package:nahpu/screens/projects/new_project.dart';
import 'package:nahpu/screens/projects/project_home.dart';
import 'package:nahpu/screens/projects/project_info.dart';

enum MenuSelection { details, deleteProject }

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
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
      drawer: _drawProjectHomeMenu(),
      body: SafeArea(
          child: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 600,
              child: ref.watch(projectListProvider).when(
                data: (data) {
                  return _buildBody(data.reversed.toList());
                },
                loading: () {
                  return const CircularProgressIndicator();
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
              ),
            )),
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

  Widget _drawProjectHomeMenu() {
    return Drawer(
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
                applicationIcon: const Icon(Icons.info_rounded),
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
    );
  }

  Widget _buildBody(List<ListProjectResult> projectList) {
    if (projectList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No projects found!',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Create a new project to get started',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      );
    } else {
      return _buildListView(projectList);
    }
  }

  Widget _buildListView(List<ListProjectResult> projectList) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Row(children: [
        Text('Existing projects:',
            style: Theme.of(context).textTheme.titleLarge),
      ]),
      Divider(
        color: Theme.of(context).colorScheme.onSurface,
        thickness: 1.5,
      ),
      Expanded(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: projectList.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              leading: Icon(
                Icons.insert_drive_file_rounded,
                size: 40,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text(
                projectList[index].projectName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                projectList[index].projectUuid,
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
                            _getProjectInfo(projectList[index].projectUuid);
                          },
                        ),
                        PopupMenuItem<MenuSelection>(
                          value: MenuSelection.deleteProject,
                          onTap: () {
                            ref
                                .read(databaseProvider)
                                .deleteProject(projectList[index].projectUuid);
                            ref.refresh(projectListProvider);
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
                            projectUuid: projectList[index].projectUuid,
                          )),
                );
              },
            ));
          },
        ),
      )
    ]);
  }

  Future<void> _launchHelpUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  void _onPopupMenuSelected(MenuSelection item) {
    switch (item) {
      case MenuSelection.details:
        break;
      case MenuSelection.deleteProject:
        break;
    }
  }

  Future<void> _getProjectInfo(String projectUuid) async {
    // We technically can directly call the projectInfoProvider here,
    // but for the popup menu to work, we need to implement Future.delayed
    // and call the provider from the onTap function of the popup menu.
    // when we tested this, users have to tap twice to get the popup menu to work.
    // This solution works well.
    final projectInfo =
        await ref.read(databaseProvider).getProjectByUuid(projectUuid);
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Project information'),
            content: SingleChildScrollView(
                child: ProjectInfo(projectData: projectInfo)),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
