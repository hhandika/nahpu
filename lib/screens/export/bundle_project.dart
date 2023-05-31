import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/services/export/archive_writer.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:share_plus/share_plus.dart';

class BundleProjectForm extends ConsumerStatefulWidget {
  const BundleProjectForm({Key? key}) : super(key: key);

  @override
  BundleProjectFormState createState() => BundleProjectFormState();
}

class BundleProjectFormState extends ConsumerState<BundleProjectForm> {
  FileOpCtrModel exportCtr = FileOpCtrModel.empty();
  Directory? _selectedDir;
  String _fileStem = 'export';
  bool _hasSaved = false;
  bool _isRunning = false;
  late File _savePath;

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
              SaveSecondaryButton(
                hasSaved: _hasSaved,
              ),
              !_hasSaved
                  ? ProgressButton(
                      label: 'Bundle',
                      onPressed: !exportCtr.isValid
                          ? null
                          : () async {
                              setState(() {
                                _isRunning = true;
                              });
                              await _bundleProject();
                              _finishProcessing();
                            },
                      isRunning: _isRunning,
                      icon: Icons.archive_outlined,
                    )
                  : ShareButton(
                      onPressed: () async {
                        await _shareFile();
                      },
                    )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _bundleProject() async {
    _savePath = await AppIOServices(
      dir: _selectedDir,
      fileStem: _fileStem,
      ext: 'zip',
    ).getSavePath();
    final archiveServices = ArchiveServices(
      ref: ref,
      outputFile: _savePath,
    );
    await archiveServices.createArchive();
    if (systemPlatform == PlatformType.mobile) {
      await _shareFile();
    }
  }

  Future<void> _shareFile() async {
    try {
      await Share.shareXFiles([XFile(_savePath.path)]);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: const Duration(seconds: 8),
        ),
      );
    }
  }

  Future<void> _getDir() async {
    final Directory? dir = await FilePickerServices().selectDir();
    if (dir != null) {
      setState(() {
        _selectedDir = dir;
      });
    }
  }

  void _finishProcessing() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: systemPlatform == PlatformType.desktop
              ? Text('Done!\n'
                  '$_savePath')
              : const Text('Done!\n'),
          duration: const Duration(seconds: 8),
        ),
      );
      setState(() {
        _hasSaved = true;
        _isRunning = false;
        exportCtr.fileNameCtr.clear();
      });
    }
  }
}
