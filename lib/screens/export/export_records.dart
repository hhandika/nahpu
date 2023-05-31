import 'dart:io';
import 'package:nahpu/screens/shared/fields.dart';
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
  FileOpCtrModel exportCtr = FileOpCtrModel.empty();
  ExportRecordType? _recordType = ExportRecordType.narrative;
  TaxonRecordType? _taxonRecordType;
  SpecimenRecordType _specimenRecordType = SpecimenRecordType.generalMammals;
  MammalRecordType _mammalRecordType = MammalRecordType.excludeBats;
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
          DropdownButtonFormField<TaxonRecordType?>(
            value: _taxonRecordType,
            decoration: const InputDecoration(
              labelText: 'Taxon group',
            ),
            items: taxonRecordTypeList
                .map((e) => DropdownMenuItem(
                      value: TaxonRecordType
                          .values[taxonRecordTypeList.indexOf(e)],
                      child: CommonDropdownText(text: e),
                    ))
                .toList(),
            onChanged: (TaxonRecordType? value) {
              if (value != null) {
                setState(() {
                  _recordType = null;
                  _taxonRecordType = value;
                  _matchTaxonToRecordType();
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
          Visibility(
            visible: _isMammalSpecimenRecord(),
            child: DropdownButtonFormField<MammalRecordType>(
              value: _mammalRecordType,
              decoration: const InputDecoration(
                labelText: 'Mammal group',
              ),
              items: mammalGroupList
                  .map((e) => DropdownMenuItem(
                        value:
                            MammalRecordType.values[mammalGroupList.indexOf(e)],
                        child: CommonDropdownText(text: e),
                      ))
                  .toList(),
              onChanged: (MammalRecordType? value) {
                if (value != null) {
                  setState(() {
                    _mammalRecordType = value;
                    _matchTaxonToRecordType();
                  });
                }
              },
            ),
          ),
          DropdownButtonFormField<ExportFmt>(
            value: exportCtr.exportFmtCtr,
            decoration: const InputDecoration(
              labelText: 'Format',
            ),
            items: exportFormats
                .map((e) => DropdownMenuItem(
                      value: ExportFmt.values[exportFormats.indexOf(e)],
                      child: CommonDropdownText(text: e),
                    ))
                .toList(),
            onChanged: (ExportFmt? value) {
              if (value != null) {
                setState(() {
                  exportCtr.exportFmtCtr = value;
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
                      },
              ),
            ],
          )
        ],
      ),
    );
  }

  bool _isMammalSpecimenRecord() {
    return _recordType == ExportRecordType.specimenRecord &&
        _taxonRecordType == TaxonRecordType.mammals;
  }

  List<DropdownMenuItem<ExportRecordType>> _matchRecordTypeToTaxonGroup() {
    switch (_specimenRecordType) {
      case SpecimenRecordType.generalMammals:
        return _recordDropdown(mammalianRecordTypeList);
      case SpecimenRecordType.birds:
        return _recordDropdown(avianRecordTypeList);
      case SpecimenRecordType.bats:
        return _recordDropdown(mammalianRecordTypeList);
      case SpecimenRecordType.allMammals:
        return _recordDropdown(mammalianRecordTypeList);
      default:
        return _recordDropdown(mammalianRecordTypeList);
    }
  }

  void _matchTaxonToRecordType() {
    if (_taxonRecordType == TaxonRecordType.birds) {
      _specimenRecordType = SpecimenRecordType.birds;
    } else {
      switch (_mammalRecordType) {
        case MammalRecordType.excludeBats:
          _specimenRecordType = SpecimenRecordType.generalMammals;
          break;
        case MammalRecordType.onlyBats:
          _specimenRecordType = SpecimenRecordType.bats;
          break;
        default:
          _specimenRecordType = SpecimenRecordType.allMammals;
          break;
      }
    }
  }

  List<DropdownMenuItem<ExportRecordType>> _recordDropdown(
      List<String> recordTypeList) {
    return recordTypeList
        .map((e) => DropdownMenuItem(
              value: ExportRecordType.values[recordTypeList.indexOf(e)],
              child: CommonDropdownText(text: e),
            ))
        .toList();
  }

  Future<void> _exportFile() async {
    switch (exportCtr.exportFmtCtr) {
      case ExportFmt.csv:
        await _writeDelimited(true);
        break;
      case ExportFmt.tsv:
        await _writeDelimited(false);
        break;
      default:
        await _writeDelimited(true);
        break;
    }
  }

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
      _showSavedPath();
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

  void _showSavedPath() {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File saved as $_finalPath'),
        ),
      );
    }
  }

  Future<void> _matchRecordTypeToWriter(File file, bool isCsv) async {
    switch (_recordType) {
      case ExportRecordType.narrative:
        await NarrativeRecordWriter(ref: ref)
            .writeNarrativeDelimited(file, isCsv);
        break;
      case ExportRecordType.collEvent:
        await CollEventRecordWriter(ref: ref)
            .writeCollEventDelimited(file, isCsv);
        break;
      case ExportRecordType.specimenRecord:
        await SpecimenRecordWriter(ref: ref, recordType: _specimenRecordType)
            .writeRecordDelimited(file, isCsv);
        break;
      default:
        await NarrativeRecordWriter(ref: ref)
            .writeNarrativeDelimited(file, isCsv);
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
