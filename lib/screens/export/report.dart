import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/services/export/report_writer.dart';
import 'package:nahpu/services/utility_services.dart';

class ReportForm extends ConsumerStatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  ReportFormState createState() => ReportFormState();
}

class ReportFormState extends ConsumerState<ReportForm> {
  ReportFmt reportFmt = ReportFmt.csv;
  ReportType _reportType = ReportType.speciesCount;
  FileOpCtrModel exportCtr = FileOpCtrModel.empty();
  String _fileStem = 'export';
  Directory? _selectedDir;
  late File _savePath;
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
                  _fileStem = value;
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
              !_hasSaved
                  ? PrimaryButton(
                      text: 'Save',
                      onPressed: !exportCtr.isValid
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
                    )
                  : ShareButton(
                      onPressed: () async {
                        await _shareFile();
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
      _savePath = await AppIOServices(
        dir: _selectedDir,
        fileStem: _fileStem,
        ext: 'csv',
      ).getSavePath();

      await ReportServices(ref: ref).writeReport(_savePath, _reportType);
      setState(() {
        _hasSaved = true;
      });
      if (systemPlatform == PlatformType.mobile) {
        await _shareFile();
      }
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

  Future<void> _shareFile() async {
    try {
      await FilePickerServices()
          .shareFile(_savePath, context.findRenderObject() as RenderBox?);
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
