import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';

class ExportForm extends ConsumerStatefulWidget {
  const ExportForm({Key? key}) : super(key: key);

  @override
  ExportFormState createState() => ExportFormState();
}

class ExportFormState extends ConsumerState<ExportForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export to spreadsheet'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            children: [
              DropdownButtonFormField<ExportFormat>(
                value: ExportFormat.csv,
                decoration: const InputDecoration(
                  labelText: 'Export format',
                ),
                items: exportFormats
                    .map((e) => DropdownMenuItem(
                          value: ExportFormat.values[exportFormats.indexOf(e)],
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
