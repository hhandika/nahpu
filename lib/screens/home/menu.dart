import 'package:flutter/material.dart';
import 'package:nahpu/screens/export/export_db.dart';
import 'package:nahpu/screens/projects/new_project.dart';
import 'package:nahpu/screens/settings/settings.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
          title: const Text('Create project'),
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
          onTap: () async {
            return showDialog(
              context: context,
              builder: (context) {
                return const AppAbout();
              },
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
        const SizedBox(height: 32),
        const DocQrCode(),
      ],
    );
  }

  Future<void> _launchHelpUrl() async {
    final Uri url = Uri.parse('https://docs.nahpu.app/en');
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}

class AppAbout extends StatelessWidget {
  const AppAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return AboutDialog(
          applicationName: snapshot.data?.appName ?? '',
          applicationVersion: snapshot.data?.version ?? '',
          applicationIcon: const Icon(Icons.info_rounded),
          children: [
            Text(
              'Rethinking species inventory in the digital age',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            const Text(
              'Nahpu is a field cataloging app for natural history projects.'
              ' Developed by museum scientists '
              'for museum scientists.',
            ),
          ],
        );
      },
      future: PackageInfo.fromPlatform(),
    );
  }
}

class DocQrCode extends StatelessWidget {
  const DocQrCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: QrImageView(
        data: 'https://docs.nahpu.app/en',
        version: QrVersions.auto,
        size: 120,
      ),
    );
  }
}
