import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/services/writer/db_writer.dart';

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
        children: [
          Icon(
            Icons.warning,
            color: Theme.of(context).colorScheme.error,
            size: 50,
          ),
          Text(
            'Replace Database',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Choose a file: ${_dbPath.path}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.folder),
                onPressed: () async {
                  final dbPath = await _selectFile();
                  if (dbPath != null) {
                    setState(() {
                      _dbPath = dbPath;
                      _hasSelected = true;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 20,
            children: [
              SaveSecondaryButton(hasSaved: _hasSelected),
              PrimaryButton(
                text: 'Replace',
                onPressed: !_hasSelected
                    ? null
                    : () async {
                        // Alert users before replacing database
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Replace Database'),
                            content: const Text('This action is irreversible. '
                                'Are you sure you want to replace the database?'),
                            actions: [
                              PrimaryButton(
                                text: 'Cancel',
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await DbWriter(ref).replaceDb(_dbPath);
                                  ref.invalidate(projectListProvider);
                                  if (context.mounted) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DBReplacedPage(),
                                      ),
                                    );
                                  }
                                },
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
          )
        ],
      ),
    );
  }

  Future<File?> _selectFile() async {
    final result = await _matchPicker();

    if (result != null) {
      if (kDebugMode) {
        print('Selected file: ${result.files.single.path}');
      }
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<FilePickerResult?> _matchPicker() async {
    if (Platform.isIOS || Platform.isAndroid) {
      return await FilePicker.platform.pickFiles();
    } else {
      return await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db', 'sqlite', 'sqlite3'],
      );
    }
  }
}

class DBReplacedPage extends StatelessWidget {
  const DBReplacedPage({super.key});

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
                  'Success',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Database has been replaced! '
                  'Close the app and reopen it to see the changes.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ));
  }
}
