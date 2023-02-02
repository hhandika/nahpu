import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/setttings.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/projects/new_project.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/screens/home/home.dart';
import 'package:nahpu/screens/settings/project_settings.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/database.dart';

class ProjectMenuDrawer extends ConsumerWidget {
  const ProjectMenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectUuid = ref.watch(projectUuidProvider);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          MenuAvatar(
            projectUuid: projectUuid,
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
              ref.invalidate(projectListProvider);
              ref.read(databaseProvider).updateProjectEntry(
                    projectUuid,
                    ProjectCompanion(
                        lastModified: db.Value(getSystemDateTime())),
                  );
              Navigator.pushReplacement(
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
              'Delete project',
              style: TextStyle(color: Colors.redAccent),
            ),
            onTap: () async {
              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeleteAlerts(
                    projectUuid: projectUuid,
                    onDelete: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class MenuAvatar extends ConsumerWidget {
  const MenuAvatar({Key? key, required this.projectUuid}) : super(key: key);

  final String projectUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectInfo = ref.watch(projectInfoProvider(projectUuid));
    return projectInfo.when(
      data: (data) {
        return UserAccountsDrawerHeader(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
          accountName: Text(
            data?.name ?? 'No Project',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text(
            data?.uuid ?? '',
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        );
      },
      loading: () => const CommonProgressIndicator(),
      error: (error, stack) => Text(
        error.toString(),
      ),
    );
  }
}
