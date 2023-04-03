import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/exports/csv_export.dart';
import 'package:nahpu/screens/shared/fields.dart';

class ReportForm extends ConsumerStatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  ReportFormState createState() => ReportFormState();
}

class ReportFormState extends ConsumerState<ReportForm> {
  ExportFormat exportFormat = ExportFormat.csv;
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
        title: const Text('Create a report'),
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
