import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/export/common.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/services/writer/report_writer.dart';

class ReportForm extends ConsumerStatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  ReportFormState createState() => ReportFormState();
}

class ReportFormState extends ConsumerState<ReportForm> {
  ReportFmt reportFmt = ReportFmt.csv;
  ReportType _reportType = ReportType.speciesCount;
  ExportCtrModel exportCtr = ExportCtrModel.empty();
  String _fileName = 'export';
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
        title: const Text('Create a report'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              DropdownButtonFormField<ReportType>(
                value: _reportType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                ),
                items: reportTypeList
                    .map((e) => DropdownMenuItem(
                          value: ReportType.values[reportTypeList.indexOf(e)],
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (ReportType? value) {
                  if (value != null) {
                    setState(() {
                      _reportType = value;
                    });
                  }
                },
              ),
              DropdownButtonFormField<ReportFmt>(
                value: reportFmt,
                decoration: const InputDecoration(
                  labelText: 'Format',
                ),
                items: reportFmtList
                    .map((e) => DropdownMenuItem(
                          value: ReportFmt.values[reportFmtList.indexOf(e)],
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (ReportFmt? value) {
                  if (value != null) {
                    setState(() {
                      reportFmt = value;
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
              SelectDirField(
                dirPath: _selectedDir,
                onChanged: _getDir,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  SaveSecondaryButton(hasSaved: _hasSaved),
                  PrimaryButton(
                    text: 'Save',
                    onPressed: _selectedDir.isEmpty
                        ? null
                        : () async {
                            await _createReport();
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createReport() async {
    try {
      String savePath = '$_selectedDir/$_fileName.csv';
      await _writeReport(savePath);
      setState(() {
        _hasSaved = true;
        _savePath = savePath;
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

  Future<void> _writeReport(String savePath) async {
    switch (_reportType) {
      case ReportType.speciesCount:
        await SpeciesListWriter(ref).writeSpeciesListCompact(savePath);
        break;
      default:
        await SpeciesListWriter(ref).writeSpeciesListCompact(savePath);
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
