import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/services/export/db_writer.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:path/path.dart' as p;

class DatabaseSettings extends ConsumerStatefulWidget {
  const DatabaseSettings({super.key});

  @override
  DatabaseSettingsState createState() => DatabaseSettingsState();
}

class DatabaseSettingsState extends ConsumerState<DatabaseSettings> {
  File _dbPath = File('');
  bool _hasSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Settings'),
        automaticallyImplyLeading: false,
      ),
      body: FileOperationPage(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Replace Database',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SettingCard(
            children: [
              SelectFileField(
                path: _dbPath,
                onPressed: () async {
                  final dbPath = await FilePickerServices().selectFile(
                    ['db', 'sqlite', 'sqlite3'],
                  );
                  if (dbPath != null) {
                    setState(() {
                      _dbPath = dbPath;
                      _hasSelected = true;
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              DbReplaceButtons(
                hasSelected: _hasSelected,
                onPressed: _replaceDb,
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _replaceDb() async {
    Navigator.of(context).pop();
    File backupPath = await DbWriter(ref).replaceDb(_dbPath);
    ref.invalidate(projectListProvider);
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DBReplacedPage(
            dbBackupPath: backupPath,
          ),
        ),
      );
    }
  }
}

class DbReplaceButtons extends StatelessWidget {
  const DbReplaceButtons({
    super.key,
    required this.hasSelected,
    required this.onPressed,
  });

  final bool hasSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: [
        SecondaryButton(
          text: 'Cancel',
          onPressed: () => Navigator.of(context).pop(),
        ),
        PrimaryButton(
          text: 'Replace',
          onPressed: !hasSelected
              ? null
              : () async {
                  // Alert users before replacing database
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Replace Database'),
                      content: const DbWarningText(),
                      actions: [
                        PrimaryButton(
                          text: 'Cancel',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          onPressed: onPressed,
                          child: const Text(
                            'Replace',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
        )
      ],
    );
  }
}

class DbWarningText extends StatelessWidget {
  const DbWarningText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'This will replace the current database with the selected one.\n'
      'Are you sure you want to replace the database?',
      textAlign: TextAlign.center,
    );
  }
}

class DBReplacedPage extends StatelessWidget {
  const DBReplacedPage({super.key, required this.dbBackupPath});

  final File dbBackupPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Database Settings'),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.done,
                  color: Colors.green,
                  size: 50,
                ),
                Text(
                  'Success 🎉',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Database has been replaced!\n'
                  'Backup file path:',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Text(
                    Platform.isIOS ? iOSPath : dbBackupPath.path,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '\nClose the app and reopen it to see the changes!',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
        ));
  }

  String get iOSPath {
    return 'Files app/On my Devices/${p.basename(dbBackupPath.path)}';
  }
}
