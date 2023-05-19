import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/services/io_services.dart';

class ExportPdfForm extends ConsumerStatefulWidget {
  const ExportPdfForm({super.key});

  @override
  ExportPdfFormState createState() => ExportPdfFormState();
}

class ExportPdfFormState extends ConsumerState<ExportPdfForm> {
  FileOpCtrModel exportCtr = FileOpCtrModel.empty();
  Directory? _selectedDir;
  PdfExportType _pdfExportType = PdfExportType.narrative;
  String _fileStem = 'export';
  final bool _hasSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export to PDF"),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: FileOperationPage(
        children: [
          DropdownButtonFormField(
              value: PdfExportType.narrative,
              items: pdfExportList
                  .map((e) => DropdownMenuItem(
                        value: PdfExportType.values[pdfExportList.indexOf(e)],
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (PdfExportType? value) {
                if (value != null) {
                  setState(() {
                    _pdfExportType = value;
                  });
                }
              }),
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
            onPressed: () {
              _getDir();
            },
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 20,
            children: [
              SaveSecondaryButton(hasSaved: _hasSaved),
              PrimaryButton(
                text: 'Save',
                onPressed: () async {
                  _writePdf();
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _getDir() async {
    Directory? path = await FilePickerServices().selectDir();
    if (path != null) {
      setState(() {
        _selectedDir = path;
      });
    }
  }

  Future<void> _writePdf() async {
    try {
      File savePath = await AppIOServices(
              dir: _selectedDir, fileStem: _fileStem, ext: 'pdf')
          .getSavePath();
      await _matchExportTypeToWriter(savePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> _matchExportTypeToWriter(File file) async {
    switch (_pdfExportType) {
      case PdfExportType.narrative:
        break;
      default:
        break;
    }
  }
}
