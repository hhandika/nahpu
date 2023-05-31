import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/services/export/archive_writer.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/controllers.dart';

class BundleProjectForm extends ConsumerStatefulWidget {
  const BundleProjectForm({Key? key}) : super(key: key);

  @override
  BundleProjectFormState createState() => BundleProjectFormState();
}

class BundleProjectFormState extends ConsumerState<BundleProjectForm> {
  FileOpCtrModel exportCtr = FileOpCtrModel.empty();
  Directory? _selectedDir;
  String _fileStem = 'export';
  final bool _hasSaved = false;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bundle Project"),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: FileOperationPage(
        children: [
          FileNameField(
            controller: exportCtr,
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  _fileStem = value;
                });
              }
            },
          ),
          SelectDirField(
            dirPath: _selectedDir,
            onPressed: () {
              _getDir();
            },
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 20,
            children: [
              SecondaryButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              ProgressButton(
                label: 'Bundle',
                onPressed: () async {
                  setState(() {
                    _isRunning = true;
                  });
                  await _bundleProject();
                  setState(() {
                    _hasSaved;
                    _isRunning = false;
                  });
                },
                isRunning: _isRunning,
                icon: Icons.archive_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _bundleProject() async {
    final outputFile = await AppIOServices(
      dir: _selectedDir,
      fileStem: _fileStem,
      ext: 'zip',
    ).getSavePath();
    final archiveServices = ArchiveServices(
      ref: ref,
      outputFile: outputFile,
    );
    await archiveServices.createArchive();
  }

  Future<void> _getDir() async {
    final Directory? dir = await FilePickerServices().selectDir();
    if (dir != null) {
      setState(() {
        _selectedDir = dir;
      });
    }
  }
}
