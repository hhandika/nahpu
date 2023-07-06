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
import 'package:nahpu/services/platform_services.dart';

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
  bool _isRunning = false;

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
                  _hasSaved = false;
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
                  _hasSaved = false;
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
            onPressed: () async {
              await _getDir();
            },
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 10,
            children: [
              SaveSecondaryButton(hasSaved: _hasSaved),
              !_hasSaved
                  ? ProgressButton(
                      label: 'Save',
                      isRunning: _isRunning,
                      icon: Icons.save_alt_outlined,
                      onPressed: !exportCtr.isValid
                          ? null
                          : () async {
                              setState(() {
                                _isRunning = true;
                              });
                              await _createReport();
                              setState(() {
                                _isRunning = false;
                              });
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      systemPlatform == PlatformType.desktop
                                          ? 'Report saved to $_savePath'
                                          : 'Report saved!',
                                    ),
                                  ),
                                );
                              }
                            },
                    )
                  : Builder(builder: (context) {
                      return ShareButton(
                        onPressed: () async {
                          await _shareFile(context);
                        },
                      );
                    }),
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

  Future<void> _shareFile(BuildContext context) async {
    try {
      await FilePickerServices().shareFile(context, _savePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
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
