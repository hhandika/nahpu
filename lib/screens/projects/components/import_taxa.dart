import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/import/taxon_reader.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/types/taxon_entry.dart';
import 'package:nahpu/services/types/types.dart';

class TaxonImportForm extends ConsumerStatefulWidget {
  const TaxonImportForm({super.key});

  @override
  TaxonImportFormState createState() => TaxonImportFormState();
}

class TaxonImportFormState extends ConsumerState<TaxonImportForm> {
  TaxonImportFmt _fmt = TaxonImportFmt.csv;
  File? _filePath;
  List<String> _problems = [];
  late CsvData _csvData;
  bool _hasData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Taxon'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ScrollableLayout(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InputFormatField(
                  inputFmt: _fmt,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _fmt = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 18),
                SelectFileField(
                  filePath: _filePath,
                  width: 500,
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                  onPressed: () {
                    _getFile();
                  },
                ),
                const SizedBox(height: 18),
                _hasData ? const ColumnRowTitle() : const SizedBox.shrink(),
                _hasData
                    ? Column(
                        children: _buildCsvHeaderField(),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 8),
                _problems.isNotEmpty
                    ? Column(
                        children: [
                          const Text(
                            'Parsing Issues:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _problems.join(', '),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    SecondaryButton(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    PrimaryButton(
                      text: 'Import',
                      onPressed: _problems.isNotEmpty ? null : () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCsvHeaderField() {
    List<Widget> headerFields = _csvData.header
        .map((e) => HeaderInputField(
              header: _csvData.header[_csvData.header.indexOf(e)],
              value: _csvData.headerMap[_csvData.header.indexOf(e)],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _csvData.headerMap[_csvData.header.indexOf(e)] = value;
                    _problems =
                        TaxonEntryReader(ref).findProblems(_csvData.headerMap);
                  });
                }
              },
            ))
        .toList();
    return headerFields;
  }

  Future<void> _getFile() async {
    File? file = await FilePickerServices().selectFile([
      'csv',
    ]);
    if (file != null) {
      setState(() {
        _filePath = file;
        _parseFile();
      });
    }
  }

  Future<void> _parseFile() async {
    if (_filePath != null) {
      TaxonEntryReader reader = TaxonEntryReader(ref);
      try {
        _csvData = await reader.parseCsv(_filePath!);
        _problems = reader.findProblems(_csvData.headerMap);
        setState(() {
          _hasData = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }
}

class InputFormatField extends StatelessWidget {
  const InputFormatField({
    super.key,
    required this.inputFmt,
    required this.onChanged,
  });

  final TaxonImportFmt inputFmt;
  final void Function(TaxonImportFmt?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Input Format',
      ),
      value: inputFmt,
      items: taxonImportFmtList
          .map((e) => DropdownMenuItem(
                value: TaxonImportFmt.values[taxonImportFmtList.indexOf(e)],
                child: Text(e),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}

class ColumnRowTitle extends StatelessWidget {
  const ColumnRowTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Column names',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 200,
          ),
          child: Text(
            'Taxon Rank',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class HeaderInputField extends StatelessWidget {
  const HeaderInputField({
    super.key,
    required this.header,
    required this.value,
    required this.onChanged,
  });

  final String header;
  final TaxonEntryHeader? value;
  final void Function(TaxonEntryHeader?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(header.toSentenceCase()),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 200,
          ),
          child: DropdownButton<TaxonEntryHeader>(
            value: value,
            items: headerList
                .map((e) => DropdownMenuItem(
                      value: TaxonEntryHeader.values[headerList.indexOf(e)],
                      child: CommonDropdownText(text: e),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
