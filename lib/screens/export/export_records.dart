import 'dart:io';
import 'package:nahpu/models/export.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/writer/coll_event_writer.dart';
import 'package:nahpu/services/writer/narrative_writer.dart';
import 'package:nahpu/services/writer/mammal_record_writer.dart';
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
  MammalianRecordType _recordType = MammalianRecordType.narrative;
  String _fileStem = 'export';
  String _selectedDir = '';
  bool _hasSaved = false;
  String _finalPath = '';

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
        title: const Text('Export records'),
        automaticallyImplyLeading: false,
      ),
      body: FileOperationPage(
        children: [
          DropdownButtonFormField<MammalianRecordType>(
            value: _recordType,
            decoration: const InputDecoration(
              labelText: 'Record type',
            ),
            items: mammalianRecordTypeList
                .map((e) => DropdownMenuItem(
                    value: MammalianRecordType
                        .values[mammalianRecordTypeList.indexOf(e)],
                    child: Text(e)))
                .toList(),
            onChanged: (MammalianRecordType? value) {
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
                  _fileStem = value;
                });
              }
            },
          ),
          SelectDirField(dirPath: _selectedDir, onChanged: _getDir),
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
      ),
    );
  }

  Future<void> _exportFile() async {
    final dir = Directory(_selectedDir);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    switch (exportFmt) {
      case ExportFmt.csv:
        await _writeDelimited(true);
        break;
      // case ExportFmt.excel:
      //   await _writeExcel();
      //   break;
      case ExportFmt.tsv:
        await _writeDelimited(false);
        break;
      default:
        await _writeDelimited(true);
        break;
    }
  }

  // Future<void> _writeExcel() async {
  //   await _writeDelimited(true);
  // }

  Future<void> _writeDelimited(bool isCsv) async {
    String ext = isCsv ? 'csv' : 'tsv';
    try {
      File file = AppIOServices(
        dir: _selectedDir,
        fileStem: _fileStem,
        ext: ext,
      ).getFilename();
      await _matchRecordTypeToWriter(file, isCsv);
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

  Future<void> _matchRecordTypeToWriter(File file, bool isCsv) async {
    switch (_recordType) {
      case MammalianRecordType.narrative:
        await NarrativeRecordWriter(ref).writeNarrativeDelimited(file, isCsv);
        break;
      case MammalianRecordType.collEvent:
        await CollEventRecordWriter(ref).writeCollEventDelimited(file, isCsv);
        break;
      case MammalianRecordType.mammalianSpecimen:
        await MammalRecordWriter(ref).writeRecordDelimited(file, isCsv);
        break;
      default:
        await MammalRecordWriter(ref).writeRecordDelimited(file, isCsv);
        break;
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
