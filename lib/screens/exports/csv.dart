import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/services/export_services.dart';
import 'package:share_plus/share_plus.dart';

class CsvForm extends ConsumerStatefulWidget {
  const CsvForm({super.key, required this.fileName, required this.isDb});

  final String fileName;
  final bool isDb;
  @override
  CsvFormState createState() => CsvFormState();
}

class CsvFormState extends ConsumerState<CsvForm> {
  String selectedDir = '';
  String finalPath = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Choose a directory: $selectedDir',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () async {
                final result = await FilePicker.platform.getDirectoryPath();
                if (result != null) {
                  if (kDebugMode) {
                    print('Selected directory: $result');
                  }
                  setState(() {
                    selectedDir = result;
                    String path = '$selectedDir/${widget.fileName}.csv';
                    if (widget.isDb) {
                      finalPath = '$selectedDir/${widget.fileName}.db';
                    } else {
                      finalPath = '$selectedDir/${widget.fileName}.csv';
                    }
                  });
                }
              },
              icon: const Icon(Icons.folder_open_rounded),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            SecondaryButton(
                text: 'Share',
                onPressed: () async {
                  await _onShare(context);
                }),
            PrimaryButton(
                text: 'Save',
                onPressed: () {
                  widget.isDb ? _writeDb() : _writeCsv();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('File saved as $finalPath'),
                    ),
                  );
                }),
          ],
        )
      ],
    );
  }

  Future<void> _writeDb() async {
    try {
      await DbWriter(ref).writeDb(finalPath);
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

  Future<void> _writeCsv() async {
    try {
      await CsvWriter(ref).writeCsv(finalPath);
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

  Future<void> _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await _writeCsv();
    Share.shareXFiles([XFile(finalPath)],
        text: 'Share',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
