import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/home/home.dart';
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
        automaticallyImplyLeading: true,
      ),
      body: FileOperationPage(
        children: [
          Text(
            'Replace Database',
            style: Theme.of(context).textTheme.titleMedium,
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
                        await DbWriter(ref).replaceDb(_dbPath);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('File has been replaced!'),
                            ),
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        }
                      },
              )
            ],
          )
        ],
      ),
    );
  }

  Future<File?> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['db', 'sqlite', 'sqlite3'],
    );

    if (result != null) {
      if (kDebugMode) {
        print('Selected file: ${result.files.single.path}');
      }
      return File(result.files.single.path!);
    }
    return null;
  }
}
