import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/services/export/report_writer.dart';

class ReportForm extends ConsumerStatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  ReportFormState createState() => ReportFormState();
}

class ReportFormState extends ConsumerState<ReportForm> {
  ReportFmt reportFmt = ReportFmt.csv;
  ReportType _reportType = ReportType.speciesCount;
  FileOpCtrModel exportCtr = FileOpCtrModel.empty();
  String _fileName = 'export';
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
        title: const Text('Create a report'),
        automaticallyImplyLeading: false,
      ),
      body: FileOperationPage(
        children: [
          DropdownButtonFormField<ReportType>(
            value: _reportType,
            decoration: const InputDecoration(
              labelText: 'Type',
            ),
            items: reportTypeList
                .map((e) => DropdownMenuItem(
                      value: ReportType.values[reportTypeList.indexOf(e)],
                      child: CommonDropdownText(text: e),
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
                      child: CommonDropdownText(text: e),
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
            onPressed: () async {
              await _getDir();
            },
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: [
              SaveSecondaryButton(hasSaved: _hasSaved),
              PrimaryButton(
                text: 'Save',
                onPressed: !exportCtr.isValid()
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
        await SpeciesListWriter(ref: ref).writeSpeciesListCompact(savePath);
        break;
      default:
        await SpeciesListWriter(ref: ref).writeSpeciesListCompact(savePath);
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
