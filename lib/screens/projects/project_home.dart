import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/providers/project.dart';
import 'package:nahpu/screens/collecting/menu_bar.dart';

import 'package:nahpu/screens/home.dart';

import 'package:nahpu/screens/projects/new_project.dart';
import 'package:nahpu/screens/settings/project_settings.dart';
import 'package:nahpu/screens/shared/navbar.dart';
import 'package:nahpu/screens/sites/menu_bar.dart';
import 'package:nahpu/screens/narrative/menu_bar.dart';
import 'package:nahpu/screens/specimens/menu_bar.dart';
import 'package:nahpu/screens/projects/project_info.dart';

class ProjectHome extends ConsumerStatefulWidget {
  const ProjectHome({
    Key? key,
  }) : super(key: key);

  @override
  ProjectHomeState createState() => ProjectHomeState();
}

class ProjectHomeState extends ConsumerState<ProjectHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectUuid = ref.watch(projectUuidProvider.state).state;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Home"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
        direction: SpeedDialDirection.down,
        children: [
          SpeedDialChild(
              child: Icon(Icons.book_rounded,
                  color: Theme.of(context).colorScheme.onInverseSurface),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              label: 'New Narrative',
              onTap: () async {
                await createNewNarrative(context, ref);
              }),
          SpeedDialChild(
            child: Icon(Icons.place_rounded,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New Sites',
            onTap: () async {
              await createNewSite(context, ref);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.timeline,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New CollEvents',
            onTap: () async {
              await createNewCollEvents(context, ref);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.pets_rounded,
                color: Theme.of(context).colorScheme.onInverseSurface),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New Specimens',
            onTap: () async {
              await createNewSpecimens(context, ref);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              accountName: const Text(
                "Heru Handika",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: const Text(
                "handika@email.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "H",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
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
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.add_box_rounded),
              title: const Text('Bundle records'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_rounded),
              title: const Text('Save project as'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_view_rounded),
              title: const Text('Export to csv/tsv'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_rounded),
              title: const Text('Export to pdf'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectSettings()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text('Close project'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.delete_rounded),
              title: const Text(
                'Delete all records',
                style: TextStyle(color: Colors.redAccent),
              ),
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
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            ProjectOverview(
              projectUuid: projectUuid,
            ),
            const TeamMemberViewer(),
          ],
        )),
      ),
      bottomNavigationBar: const ProjectBottomNavbar(),
    );
  }
}

class ProjectOverview extends ConsumerWidget {
  const ProjectOverview({Key? key, required this.projectUuid})
      : super(key: key);

  final String projectUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: ref.watch(projectInfoProvider(projectUuid)).when(
            data: (data) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: ProjectInfo(
                  projectData: data,
                ),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text(error.toString()),
          ),
    );
  }

  Widget showAlert(BuildContext context, String error) {
    return AlertDialog(
        title: const Text('ERROR!'),
        content: Column(children: [
          Text(
              'Failed fetching data from the database. Check if the project name exists. $error')
        ]));
  }
}

class TeamMemberViewer extends ConsumerStatefulWidget {
  const TeamMemberViewer({Key? key}) : super(key: key);

  @override
  TeamMemberViewerState createState() => TeamMemberViewerState();
}

class TeamMemberViewerState extends ConsumerState<TeamMemberViewer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            'Team Members',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(10),
                height: 200,
                child: const PersonnelList()),
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => _showPersonnelForm());
              },
              child: const Text('Add new member')),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _showPersonnelForm() {
    final nameCtr = TextEditingController();
    final initialCtr = TextEditingController();
    final affilitationCtr = TextEditingController();
    return AlertDialog(
      title: const Text('Add a team member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameCtr,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter a name',
            ),
          ),
          TextFormField(
            controller: initialCtr,
            decoration: const InputDecoration(
              labelText: 'Initials',
              hintText: 'Enter intials',
            ),
          ),
          TextFormField(
            controller: affilitationCtr,
            decoration: const InputDecoration(
              labelText: 'Affiliation',
              hintText: 'Enter Affiliation',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Theme.of(context).colorScheme.onTertiaryContainer,
            primary: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          child: const Text('Add'),
          onPressed: () {
            createPersonnel(
                ref,
                PersonnelCompanion(
                  name: db.Value(nameCtr.text),
                  initial: db.Value(initialCtr.text),
                  affiliation: db.Value(affilitationCtr.text),
                ));
            Navigator.of(context).pop();
            ref.refresh(personnelListProvider);
          },
        ),
      ],
    );
  }
}

class PersonnelList extends ConsumerWidget {
  const PersonnelList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personnels = ref.watch(personnelListProvider);
    return personnels.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.person_rounded),
              title: Text(data[index].name ?? ''),
              subtitle: Text(data[index].id ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () {
                  // ref.read(personnelListProvider.notifier).deletePersonnel(
                  //     data[index].id, data[index].name, data[index].email);
                },
              ),
            );
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}
