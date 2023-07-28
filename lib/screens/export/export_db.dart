import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/export.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/export/db_writer.dart';

const String _dbExtension = 'sqlite3';

class ExportDbForm extends ConsumerStatefulWidget {
  const ExportDbForm({super.key});

  @override
  ExportDbFormState createState() => ExportDbFormState();
}

class ExportDbFormState extends ConsumerState<ExportDbForm> {
  DbExportFmt exportFmt = DbExportFmt.sqlite3;
  FileOpCtrModel exportCtr = FileOpCtrModel.empty();
  String _fileStem = 'backup';
  Directory? _selectedDir;
  bool _hasSaved = false;
  bool _isRunning = false;
  bool _isWithProjectData = false;
  late File _savePath;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    exportCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup database'),
        automaticallyImplyLeading: false,
      ),
      body: FileOperationPage(
        children: [
          DropdownButtonFormField(
            value: exportFmt,
            decoration: const InputDecoration(
              labelText: 'Format',
            ),
            items: dbExportFmt.entries
                .map(
                  (e) => DropdownMenuItem(
                    value: e.key,
                    child: Text(e.value),
                  ),
                )
                .toList(),
            onChanged: (DbExportFmt? value) {
              if (value != null) {
                setState(() {
                  exportFmt = value;
                  _hasSaved = false;
                });
              }
            },
          ),
          SwitchField(
              label: 'Include project data',
              value: _isWithProjectData,
              onPressed: (value) {
                setState(() {
                  _isWithProjectData = !_isWithProjectData;
                });
              }),
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
          SelectDirField(
              dirPath: _selectedDir,
              onPressed: () async {
                await _getDir();
              }),
          const SizedBox(height: 10),
          Wrap(
            spacing: 20,
            children: [
              SaveSecondaryButton(hasSaved: _hasSaved),
              !_hasSaved
                  ? ProgressButton(
                      label: 'Save',
                      icon: Icons.save_alt_outlined,
                      isRunning: _isRunning,
                      onPressed: exportCtr.isValid
                          ? () async {
                              setState(() {
                                _isRunning = true;
                              });
                              await _writeDb();
                              _setSuccess();
                            }
                          : null,
                    )
                  : Builder(
                      builder: (context) {
                        return ShareButton(
                          onPressed: () async {
                            await _shareFile(context);
                          },
                        );
                      },
                    ),
            ],
          )
        ],
      ),
    );
  }

  void _setSuccess() {
    setState(() {
      _isRunning = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('File saved as $_savePath'),
      ),
    );
  }

  Future<void> _writeDb() async {
    try {
      _savePath = await AppIOServices(
        dir: _selectedDir,
        fileStem: _fileStem,
        ext: _dbExtension,
      ).getSavePath();
      final currentSavePath = await DbWriter(ref: ref).writeDb(
        _savePath,
        _isWithProjectData,
      );
      setState(() {
        _hasSaved = true;
        _savePath = currentSavePath;
      });
    } on PathNotFoundException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: PathNotFoundText(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: ErrorText(error: e.toString()),
        ),
      );
    }
  }

  Future<void> _shareFile(BuildContext context) async {
    try {
      await FilePickerServices().shareFile(context, _savePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: ErrorText(error: e.toString()),
        ),
      );
    }
  }

  Future<void> _getDir() async {
    final path = await FilePickerServices().selectDir();
    if (path != null) {
      setState(() {
        _selectedDir = path;
      });
    }
  }
}
