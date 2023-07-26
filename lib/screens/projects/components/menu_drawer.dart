import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/export/bundle_project.dart';
import 'package:nahpu/screens/export/export_db.dart';
import 'package:nahpu/screens/export/export_pdf.dart';
import 'package:nahpu/screens/export/export_records.dart';
import 'package:nahpu/screens/export/report.dart';
import 'package:nahpu/screens/projects/new_project.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/screens/home/home.dart';
import 'package:nahpu/screens/settings/settings.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/project_services.dart';
import 'package:nahpu/services/utility_services.dart';

class ProjectMenuDrawer extends ConsumerStatefulWidget {
  const ProjectMenuDrawer({super.key});

  @override
  ProjectMenuDrawerState createState() => ProjectMenuDrawerState();
}

class ProjectMenuDrawerState extends ConsumerState<ProjectMenuDrawer> {
  @override
  Widget build(BuildContext context) {
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
            title: const Text('Create project'),
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
            leading: const Icon(Icons.table_view_rounded),
            title: const Text('Create report'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportForm()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.archive_rounded),
            title: const Text('Bundle project'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BundleProjectForm()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf_rounded),
            title: const Text('Export to pdf'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExportPdfForm()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.adaptive.share_rounded),
            title: const Text('Export records'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExportForm()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.storage_rounded),
            title: const Text('Backup database'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExportDbForm()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AppSettings()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text('Close project'),
            onTap: () {
              ProjectServices(ref: ref).updateProject(
                projectUuid,
                ProjectCompanion(
                  lastAccessed: db.Value(
                    getSystemDateTime(),
                  ),
                ),
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
            leading: Icon(Icons.delete_rounded,
                color: Theme.of(context).colorScheme.error),
            title: Text(
              'Delete project',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () async {
              return showDeleteAlertOnMenu(
                  context: context,
                  title: 'Delete project?',
                  deletePrompt: 'You will delete the project and all its data',
                  onDelete: () async {
                    try {
                      await ProjectServices(ref: ref)
                          .deleteProject(projectUuid);
                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      }
                    } catch (e) {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                  'Error',
                                ),
                                content: Text(
                                  e.toString().contains('FOREIGN KEY')
                                      ? 'Cannot delete project with records.\n'
                                          'Delete all records first'
                                      : e.toString(),
                                ),
                              ));
                    }
                  });
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
