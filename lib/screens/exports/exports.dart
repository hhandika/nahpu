import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/exports/csv.dart';
import 'package:nahpu/screens/shared/fields.dart';

class ExportForm extends ConsumerStatefulWidget {
  const ExportForm({Key? key}) : super(key: key);

  @override
  ExportFormState createState() => ExportFormState();
}

class ExportFormState extends ConsumerState<ExportForm> {
  ExportFormat exportFormat = ExportFormat.excel;
  ExportCtrModel exportCtr = ExportCtrModel.empty();
  String fileName = 'export';

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
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            children: [
              CommonTextField(
                controller: exportCtr.fileNameCtr,
                labelText: 'File name',
                hintText: 'Enter file name',
                isLastField: false,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      fileName = value;
                    });
                  }
                },
              ),
              DropdownButtonFormField<ExportFormat>(
                value: exportFormat,
                decoration: const InputDecoration(
                  labelText: 'Format',
                ),
                items: exportFormats
                    .map((e) => DropdownMenuItem(
                          value: ExportFormat.values[exportFormats.indexOf(e)],
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (ExportFormat? value) {
                  if (value != null) {
                    setState(() {
                      exportFormat = value;
                    });
                  }
                },
              ),
              CsvForm(
                fileName: fileName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
