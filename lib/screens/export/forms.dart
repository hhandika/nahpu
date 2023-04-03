import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/services/exports/csv_export.dart';

class CommonExportForm extends ConsumerStatefulWidget {
  const CommonExportForm({
    super.key,
    required this.dirPath,
    required this.fileName,
    required this.exportFmt,
  });

  final String dirPath;
  final String fileName;
  final ExportFmt exportFmt;

  @override
  CsvFormState createState() => CsvFormState();
}

class CsvFormState extends ConsumerState<CommonExportForm> {
  bool hasSaved = false;
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
          spacing: 10,
          children: [
            SecondaryButton(
              text: hasSaved ? 'Exit' : 'Cancel',
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            PrimaryButton(
                text: 'Save',
                onPressed: () async {
                  await _exportFile();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('File saved as $_finalPath'),
                      ),
                    );
                  }
                }),
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
        await _writeCsv();
        break;
      case ExportFmt.excel:
        await _writeExcel();
        break;
      default:
        await _writeCsv();
        break;
    }
  }

  String _createSavePath(String fileName) {
    return path.join(widget.dirPath, fileName);
  }

  // Future<void> _writeDb() async {
  //   try {
  //     await DbWriter(ref).writeDb(widget.filePath);
  //   } on PathNotFoundException {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please select a directory'),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Something went wrong: $e'),
  //       ),
  //     );
  //   }
  // }

  Future<void> _writeExcel() async {
    await _writeCsv();
  }

  Future<void> _writeCsv() async {
    try {
      String fileName = '${widget.fileName}.csv';
      String savePath = _createSavePath(fileName);
      await CsvWriter(ref).writeCsv(savePath);
      setState(() {
        hasSaved = true;
        _finalPath = savePath;
      });
    } on PathNotFoundException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a directory'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong: $e'),
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
