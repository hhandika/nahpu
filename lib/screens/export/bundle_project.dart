import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/services/export/archive_writer.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/platform_services.dart';

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
  bool _isInaccurateInBrackets = true;

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
          const FileFormatIcon(path: 'assets/icons/zip.svg'),
          FileNameField(
            controller: exportCtr,
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  _fileStem = value;
                  _hasSaved = false;
                });
              }
            },
          ),
          SwitchField(
              value: _isInaccurateInBrackets,
              label: 'Inaccurate in brackets',
              onPressed: (bool value) {
                setState(() {
                  _isInaccurateInBrackets = value;
                  _hasSaved = false;
                });
              }),
          SelectDirField(
            dirPath: _selectedDir,
            onPressed: () {
              _getDir();
              _hasSaved = false;
            },
          ),
          const SizedBox(height: 24),
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
                              try {
                                await _bundleProject();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      e.toString(),
                                    ),
                                  ),
                                );
                              }
                              _finishProcessing();
                            },
                      isRunning: _isRunning,
                      icon: Icons.archive_outlined,
                    )
                  : Builder(builder: (context) {
                      return ShareButton(
                        onPressed: () async {
                          await _shareFile(context);
                        },
                      );
                    })
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
      isInaccurateInBrackets: _isInaccurateInBrackets,
    );
    await archiveServices.createArchive();
  }

  Future<void> _shareFile(BuildContext context) async {
    try {
      await FilePickerServices().shareFile(context, _savePath);
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
              : const Text('Done!'),
          duration: const Duration(seconds: 8),
        ),
      );
      setState(() {
        _hasSaved = true;
        _isRunning = false;
      });
    }
  }
}
