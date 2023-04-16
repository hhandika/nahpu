import 'dart:io';
import 'package:nahpu/services/writer/record_writer.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/buttons.dart';
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
          ExportButtons(
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

class ExportButtons extends ConsumerStatefulWidget {
  const ExportButtons({
    super.key,
    required this.dirPath,
    required this.fileName,
    required this.exportFmt,
  });

  final String dirPath;
  final String fileName;
  final ExportFmt exportFmt;

  @override
  ExportButtonState createState() => ExportButtonState();
}

class ExportButtonState extends ConsumerState<ExportButtons> {
  bool _hasSaved = false;
  String _finalPath = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Wrap(
          spacing: 20,
          children: [
            SaveSecondaryButton(hasSaved: _hasSaved),
            PrimaryButton(
              text: 'Save',
              onPressed: widget.dirPath.isEmpty
                  ? null
                  : () async {
                      await _exportFile();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('File saved as $_finalPath'),
                          ),
                        );
                      }
                    },
            ),
          ],
        )
      ],
    );
  }

  Future<void> _exportFile() async {
    final dir = Directory(widget.dirPath);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    switch (widget.exportFmt) {
      case ExportFmt.csv:
        await _writeDelimited(true);
        break;
      case ExportFmt.excel:
        await _writeExcel();
        break;
      case ExportFmt.tsv:
        await _writeDelimited(false);
        break;
      default:
        await _writeDelimited(true);
        break;
    }
  }

  File _createSavePath(String fileName) {
    String finalPath = path.join(widget.dirPath, fileName);
    return File(finalPath);
  }

  Future<void> _writeExcel() async {
    await _writeDelimited(true);
  }

  Future<void> _writeDelimited(bool isCsv) async {
    String ext = isCsv ? 'csv' : 'tsv';
    try {
      String fileName = '${widget.fileName}.$ext';
      // Check if file exists
      File file = _createSavePath(fileName);
      if (file.existsSync()) {
        int i = 1;
        while (file.existsSync()) {
          fileName = '${widget.fileName}($i).$ext';
          file = _createSavePath(fileName);
          i++;
        }
      }
      await SpecimenRecordWriter(ref).writeRecordDelimited(file, isCsv);
      setState(() {
        _hasSaved = true;
        _finalPath = file.path;
      });
    } on PathNotFoundException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: PathNotFoundText(),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: ErrorText(error: e.toString()),
        ),
      );
    }
  }

  // Future<void> _onShare(BuildContext context) async {
  //   final box = context.findRenderObject() as RenderBox?;
  //   await _writeCsv();
  //   Share.shareXFiles([XFile(widget.filePath)],
  //       text: 'Share',
  //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  // }
}
