import 'dart:io';
import 'package:nahpu/services/types/export.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/export/coll_event_writer.dart';
import 'package:nahpu/services/export/narrative_writer.dart';
import 'package:nahpu/services/export/record_writer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/types.dart';
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
  SpecimenRecordType _taxonRecordType = SpecimenRecordType.mammalian;
  ExportRecordType? _recordType = ExportRecordType.narrative;
  String _fileStem = 'export';
  Directory? _selectedDir;
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
          DropdownButtonFormField<SpecimenRecordType?>(
            value: _taxonRecordType,
            decoration: const InputDecoration(
              labelText: 'Taxon group',
            ),
            items: specimenRecordTypeList
                .map((e) => DropdownMenuItem(
                      value: SpecimenRecordType
                          .values[specimenRecordTypeList.indexOf(e)],
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (SpecimenRecordType? value) {
              if (value != null) {
                setState(() {
                  _recordType = null;
                  _taxonRecordType = value;
                });
              }
            },
          ),
          DropdownButtonFormField<ExportRecordType>(
            value: _recordType,
            decoration: const InputDecoration(
              labelText: 'Record type',
            ),
            items: _matchRecordTypeToTaxonGroup(),
            onChanged: (ExportRecordType? value) {
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
          SelectDirField(
            dirPath: _selectedDir,
            onPressed: () async => await _getDir(),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 20,
            children: [
              SaveSecondaryButton(hasSaved: _hasSaved),
              PrimaryButton(
                text: 'Save',
                onPressed: !exportCtr.isValid()
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

  List<DropdownMenuItem<ExportRecordType>> _matchRecordTypeToTaxonGroup() {
    switch (_taxonRecordType) {
      case SpecimenRecordType.mammalian:
        return _recordDropdown(mammalianRecordTypeList);
      case SpecimenRecordType.avian:
        return _recordDropdown(avianRecordTypeList);
      case SpecimenRecordType.allMammals:
        return _recordDropdown(mammalianRecordTypeList);
      case SpecimenRecordType.chiropteran:
        return _recordDropdown(mammalianRecordTypeList);
      default:
        return _recordDropdown(mammalianRecordTypeList);
    }
  }

  List<DropdownMenuItem<ExportRecordType>> _recordDropdown(
      List<String> recordTypeList) {
    return recordTypeList
        .map((e) => DropdownMenuItem(
              value: ExportRecordType.values[recordTypeList.indexOf(e)],
              child: Text(e),
            ))
        .toList();
  }

  Future<void> _exportFile() async {
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
      File file = await AppIOServices(
        dir: _selectedDir,
        fileStem: _fileStem,
        ext: ext,
      ).getSavePath();
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
      case ExportRecordType.narrative:
        await NarrativeRecordWriter(ref).writeNarrativeDelimited(file, isCsv);
        break;
      case ExportRecordType.collEvent:
        await CollEventRecordWriter(ref).writeCollEventDelimited(file, isCsv);
        break;
      case ExportRecordType.specimenRecord:
        await SpecimenRecordWriter(ref: ref, recordType: _taxonRecordType)
            .writeRecordDelimited(file, isCsv);
        break;
      default:
        await NarrativeRecordWriter(ref).writeNarrativeDelimited(file, isCsv);
        break;
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
