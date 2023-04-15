import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/file_operation.dart';

class ExportForm extends ConsumerStatefulWidget {
  const ExportForm({super.key});

  @override
  ExportFormState createState() => ExportFormState();
}

class ExportFormState extends ConsumerState<ExportForm> {
  ExportFmt exportFmt = ExportFmt.csv;
  FileOpCtrModel exportCtr = FileOpCtrModel.empty();
  RecordType _recordType = RecordType.specimen;
  String _fileName = 'export';
  String _selectedDir = '';

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
        title: const Text('Export to ...'),
        automaticallyImplyLeading: false,
      ),
      body: FileOperationPage(
        children: [
          DropdownButtonFormField<RecordType>(
            value: _recordType,
            decoration: const InputDecoration(
              labelText: 'Record type',
            ),
            items: recordTypeList
                .map((e) => DropdownMenuItem(
                    value: RecordType.values[recordTypeList.indexOf(e)],
                    child: Text(e)))
                .toList(),
            onChanged: (RecordType? value) {
              if (value != null) {
                setState(() {
                  _recordType = value;
                });
              }
            },
          ),
          DropdownButtonFormField<ExportFmt>(
            value: exportFmt,
            decoration: const InputDecoration(
              labelText: 'Format',
            ),
            items: exportFormats
                .map((e) => DropdownMenuItem(
                      value: ExportFmt.values[exportFormats.indexOf(e)],
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (ExportFmt? value) {
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
          SelectDirField(dirPath: _selectedDir, onChanged: _getDir),
          CommonExportForm(
            exportFmt: exportFmt,
            dirPath: _selectedDir,
            fileName: _fileName,
          ),
        ],
      ),
    );
  }

  void _getDir(String? path) {
    if (path != null) {
      setState(() {
        _selectedDir = path;
      });
    }
  }
}
