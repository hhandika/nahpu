import 'package:flutter/material.dart';
import 'package:nahpu/screens/export/export_db.dart';
import 'package:nahpu/screens/projects/new_project.dart';
import 'package:nahpu/screens/settings/settings.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMenuDrawer extends StatelessWidget {
  const HomeMenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Image.asset(
            'assets/images/logo_nobg.png',
            fit: BoxFit.contain,
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
        const CommonLineDivider(),
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
        // const Divider(color: Colors.grey),
        ListTile(
          leading: const Icon(Icons.settings_rounded),
          title: const Text('Settings'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AppSettings()),
            );
          },
        ),
        const CommonLineDivider(),
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
                const Text('A tool for cataloging natural history specimens.'),
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
            _launchHelpUrl();
          },
        ),
      ],
    );
  }

  Future<void> _launchHelpUrl() async {
    final Uri url = Uri.parse('https://docs.nahpu.app/EN');
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
