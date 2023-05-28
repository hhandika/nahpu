import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/types.dart';
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
  String _savePath = '';
  bool _hasSaved = false;

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
            items: dbExportFmtList
                .map((e) => DropdownMenuItem(
                      value: DbExportFmt.values[dbExportFmtList.indexOf(e)],
                      child: CommonDropdownText(text: e),
                    ))
                .toList(),
            onChanged: (DbExportFmt? value) {
              if (value != null) {
                setState(() {
                  exportFmt = value;
                });
              }
            },
          ),
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
              onPressed: () async {
                await _getDir();
              }),
          const SizedBox(height: 10),
          Wrap(
            spacing: 20,
            children: [
              SaveSecondaryButton(hasSaved: _hasSaved),
              PrimaryButton(
                text: 'Save',
                onPressed: _selectedDir == null
                    ? null
                    : () async {
                        await _writeDb();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('File saved as $_savePath'),
                            ),
                          );
                        }
                      },
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _writeDb() async {
    try {
      File file = await AppIOServices(
        dir: _selectedDir,
        fileStem: _fileStem,
        ext: _dbExtension,
      ).getSavePath();
      await DbWriter(ref).writeDb(file);
      setState(() {
        _savePath = file.path;
        _hasSaved = true;
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

  Future<void> _getDir() async {
    final path = await FilePickerServices().selectDir();
    if (path != null) {
      setState(() {
        _selectedDir = path;
      });
    }
  }
}
