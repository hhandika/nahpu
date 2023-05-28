import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/services/export/db_writer.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:path/path.dart' as p;
import 'package:settings_ui/settings_ui.dart';

class DatabaseSettings extends ConsumerStatefulWidget {
  const DatabaseSettings({super.key});

  @override
  DatabaseSettingsState createState() => DatabaseSettingsState();
}

class DatabaseSettingsState extends ConsumerState<DatabaseSettings> {
  File? _dbPath;
  bool _isBackup = true;
  bool _hasSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Database Settings'),
        ),
        body: SafeArea(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: const SettingTitle(title: 'Database'),
                tiles: [
                  CustomSettingsTile(
                    child: SettingCard(
                      children: [
                        DbFileInputField(
                            dbPath: _dbPath,
                            onPressed: () async {
                              final dbPath =
                                  await FilePickerServices().selectFile(null);
                              if (dbPath != null) {
                                setState(() {
                                  _dbPath = dbPath;
                                  _hasSelected = true;
                                });
                              }
                            },
                            isBackup: _isBackup,
                            onBackupChosen: (bool value) async {
                              _isBackup = value;

                              setState(() {});
                            }),
                        const SizedBox(height: 20),
                        DbReplaceButtons(
                          hasSelected: _hasSelected,
                          onPressed: _replaceDb,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> _replaceDb() async {
    Navigator.of(context).pop();
    try {
      File? backupPath = _isBackup ? await getDbBackUpPath() : null;
      await DbWriter(ref).replaceDb(_dbPath!, backupPath);
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DBReplacedPage(
              dbBackupPath: backupPath,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to replace database!',
          ),
        ),
      );
    }
  }
}

class DbFileInputField extends StatelessWidget {
  const DbFileInputField({
    super.key,
    required this.dbPath,
    required this.isBackup,
    required this.onPressed,
    required this.onBackupChosen,
  });

  final File? dbPath;
  final bool isBackup;
  final VoidCallback onPressed;
  final void Function(bool) onBackupChosen;

  @override
  Widget build(BuildContext context) {
    const double width = 400;
    final maxWith = MediaQuery.of(context).size.width * 0.8;
    return Column(
      children: [
        const SizedBox(height: 10),
        SelectFileField(
          filePath: dbPath,
          width: width,
          onPressed: onPressed,
          maxWidth: maxWith,
        ),
        const SizedBox(height: 10),
        Container(
          width: width,
          constraints: BoxConstraints(maxWidth: maxWith),
          child: SwitchField(
            label: 'Backup current database',
            value: isBackup,
            onPressed: onBackupChosen,
          ),
        )
      ],
    );
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
    return PrimaryButton(
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
    );
  }
}

class DbWarningText extends StatelessWidget {
  const DbWarningText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Are you sure you want to replace the database?',
      textAlign: TextAlign.center,
    );
  }
}

class DBReplacedPage extends StatelessWidget {
  const DBReplacedPage({super.key, required this.dbBackupPath});

  final File? dbBackupPath;

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
                  'Database has been replaced!',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                dbBackupPath == null
                    ? const SizedBox.shrink()
                    : Text('Backup file path:',
                        style: Theme.of(context).textTheme.bodyMedium),
                dbBackupPath == null
                    ? const SizedBox.shrink()
                    : ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Text(
                          Platform.isIOS ? _iOSPath : dbBackupPath!.path,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                const SizedBox(height: 18),
                Text(
                  'Close the app and reopen it to see the changes!',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
        ));
  }

  String get _iOSPath {
    return 'Files app/On my Devices/$nahpuBackupDir/'
        '${p.basename(dbBackupPath != null ? dbBackupPath!.path : '')}';
  }
}
