import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/export/forms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:nahpu/screens/shared/fields.dart';

class ExportForm extends ConsumerStatefulWidget {
  const ExportForm({Key? key}) : super(key: key);

  @override
  ExportFormState createState() => ExportFormState();
}

class ExportFormState extends ConsumerState<ExportForm> {
  ExportFmt exportFmt = ExportFmt.excel;
  ExportCtrModel exportCtr = ExportCtrModel.empty();
  String fileName = 'export';
  String selectedDir = '';

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
        title: const Text('Export to ...'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            children: [
              DropdownButtonFormField<ExportFmt>(
                value: exportFmt,
                decoration: const InputDecoration(
                  labelText: 'Format',
                ),
                items: exportFormats
                    .map((e) => DropdownMenuItem(
                          value: ExportFmt.values[exportFormats.indexOf(e)],
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (ExportFmt? value) {
                  if (value != null) {
                    setState(() {
                      exportFmt = value;
                    });
                  }
                },
              ),
              CommonTextField(
                controller: exportCtr.fileNameCtr,
                labelText: 'File name',
                hintText: 'Enter file name',
                isLastField: false,
              ),
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
                      final result =
                          await FilePicker.platform.getDirectoryPath();
                      if (result != null) {
                        if (kDebugMode) {
                          print('Selected directory: $result');
                        }
                        setState(() {
                          selectedDir = result;
                        });
                      }
                    },
                    icon: const Icon(Icons.folder_open_rounded),
                  ),
                ],
              ),
              CommonExportForm(
                exportFmt: exportFmt,
                dirPath: selectedDir,
                fileName: exportCtr.fileNameCtr.text.isEmpty
                    ? fileName
                    : exportCtr.fileNameCtr.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
