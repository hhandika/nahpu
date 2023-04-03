import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/export/common.dart';
import 'package:nahpu/screens/shared/fields.dart';

class ExportForm extends ConsumerStatefulWidget {
  const ExportForm({super.key});

  @override
  ExportFormState createState() => ExportFormState();
}

class ExportFormState extends ConsumerState<ExportForm> {
  ExportFmt exportFmt = ExportFmt.excel;
  ExportCtrModel exportCtr = ExportCtrModel.empty();
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            children: [
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
              CommonTextField(
                controller: exportCtr.fileNameCtr,
                labelText: 'File name',
                hintText: 'Enter file name',
                isLastField: false,
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
        ),
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
