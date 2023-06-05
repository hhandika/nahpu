import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/services/export/pdf_writer.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/export.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:pdf/pdf.dart';

class ExportPdfForm extends ConsumerStatefulWidget {
  const ExportPdfForm({super.key});

  @override
  ExportPdfFormState createState() => ExportPdfFormState();
}

class ExportPdfFormState extends ConsumerState<ExportPdfForm> {
  FileOpCtrModel exportCtr = FileOpCtrModel.empty();
  Directory? _selectedDir;
  PdfExportType _pdfExportType = PdfExportType.narrative;
  PdfPageFormat _pdfPageFormat = PdfPageFormat.letter;
  String _fileStem = 'export';
  bool _hasSaved = false;
  late File _savePath;
  bool _isRunning = false;

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
              decoration: const InputDecoration(
                labelText: 'Record type',
              ),
              items: pdfExportList
                  .map((e) => DropdownMenuItem(
                        value: PdfExportType.values[pdfExportList.indexOf(e)],
                        child: CommonDropdownText(text: e),
                      ))
                  .toList(),
              onChanged: (PdfExportType? value) {
                if (value != null) {
                  setState(() {
                    _pdfExportType = value;
                    _hasSaved = false;
                  });
                }
              }),
          DropdownButtonFormField(
              value: _pdfPageFormat,
              decoration: const InputDecoration(
                labelText: 'Page format',
              ),
              items: pdfExportPageFormat.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: CommonDropdownText(
                          text: pdfExportPageFormat[e] ?? '',
                        ),
                      ))
                  .toList(),
              onChanged: (PdfPageFormat? value) {
                if (value != null) {
                  setState(() {
                    _pdfPageFormat = value;
                    _hasSaved = false;
                  });
                }
              }),
          FileNameField(
            controller: exportCtr,
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  _fileStem = value;
                  _hasSaved = false;
                });
              }
            },
          ),
          SelectDirField(
            dirPath: _selectedDir,
            onPressed: () {
              _getDir();
              _hasSaved = false;
            },
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
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
                              await _writePdf();
                              setState(() {
                                _isRunning = false;
                              });
                            },
                    )
                  : Builder(
                      builder: (BuildContext context) {
                        return ShareButton(onPressed: () {
                          _shareFile(context);
                        });
                      },
                    ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _writePdf() async {
    try {
      _savePath = await AppIOServices(
              dir: _selectedDir, fileStem: _fileStem, ext: 'pdf')
          .getSavePath();
      await _matchExportTypeToWriter(_savePath);
      setState(() {
        _hasSaved = true;
      });
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
        await NarrativePdfWriter(
          ref: ref,
          pageFormat: _pdfPageFormat,
          filePath: file,
        ).generatePdf();
        break;
      default:
        break;
    }
  }

  Future<void> _shareFile(BuildContext context) async {
    try {
      await FilePickerServices().shareFile(context, _savePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> _getDir() async {
    Directory? path = await FilePickerServices().selectDir();
    if (path != null) {
      setState(() {
        _selectedDir = path;
      });
    }
  }
}
