import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/services/writer/csv.dart';

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
  bool _hasSaved = false;
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
            SaveSecondaryButton(hasSaved: _hasSaved),
            PrimaryButton(
              text: 'Save',
              onPressed: widget.dirPath.isEmpty
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

  Future<void> _writeExcel() async {
    await _writeCsv();
  }

  Future<void> _writeCsv() async {
    try {
      String fileName = '${widget.fileName}.csv';
      String savePath = _createSavePath(fileName);
      await CsvWriter(ref).writeCsv(savePath);
      setState(() {
        _hasSaved = true;
        _finalPath = savePath;
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

  // Future<void> _onShare(BuildContext context) async {
  //   final box = context.findRenderObject() as RenderBox?;
  //   await _writeCsv();
  //   Share.shareXFiles([XFile(widget.filePath)],
  //       text: 'Share',
  //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  // }
}

class SaveSecondaryButton extends StatelessWidget {
  const SaveSecondaryButton({
    super.key,
    required this.hasSaved,
  });

  final bool hasSaved;
  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      text: hasSaved ? 'Exit' : 'Cancel',
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Text('Something went wrong: $error');
  }
}

class PathNotFoundText extends StatelessWidget {
  const PathNotFoundText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Please select a directory');
  }
}

class SelectDirField extends ConsumerStatefulWidget {
  const SelectDirField({
    super.key,
    required this.dirPath,
    required this.onChanged,
  });

  final String dirPath;
  final void Function(String?) onChanged;

  @override
  SelectDirFieldState createState() => SelectDirFieldState();
}

class SelectDirFieldState extends ConsumerState<SelectDirField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Choose a directory: ${widget.dirPath}',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.folder),
          onPressed: () async {
            final dir = await _selectDir();
            if (dir != null) {
              widget.onChanged(dir.path);
            }
          },
        ),
      ],
    );
  }

  Future<Directory?> _selectDir() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      if (kDebugMode) {
        print('Selected directory: $result');
      }
      return Directory(result);
    }
    return null;
  }
}
