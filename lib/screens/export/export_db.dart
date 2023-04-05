import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/services/writer/db_writer.dart';

class ExportDbForm extends ConsumerStatefulWidget {
  const ExportDbForm({super.key});

  @override
  ExportDbFormState createState() => ExportDbFormState();
}

class ExportDbFormState extends ConsumerState<ExportDbForm> {
  DbExportFmt exportFmt = DbExportFmt.sqlite3;
  FileOpCtrModel exportCtr = FileOpCtrModel.empty();
  String _fileName = 'backup';
  String _selectedDir = '';
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
                      child: Text(e),
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
                  _fileName = value;
                });
              }
            },
          ),
          SelectDirField(
            dirPath: _selectedDir,
            onChanged: _getDir,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 20,
            children: [
              SaveSecondaryButton(hasSaved: _hasSaved),
              PrimaryButton(
                text: 'Save',
                onPressed: _selectedDir.isEmpty
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
      String savePath = '$_selectedDir/$_fileName.sqlite3';
      await DbWriter(ref).writeDb(savePath);
      setState(() {
        _savePath = savePath;
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

  void _getDir(String? path) {
    if (path != null) {
      setState(() {
        _selectedDir = path;
      });
    }
  }
}
