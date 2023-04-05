import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/screens/export/common.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';

class ExportPdfForm extends ConsumerStatefulWidget {
  const ExportPdfForm({super.key});

  @override
  ExportPdfFormState createState() => ExportPdfFormState();
}

class ExportPdfFormState extends ConsumerState<ExportPdfForm> {
  ExportCtrModel exportCtr = ExportCtrModel.empty();
  String _selectedDir = '';
  // String _fileName = 'export';
  final bool _hasSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export to PDF"),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  CommonTextField(
                    controller: exportCtr.fileNameCtr,
                    labelText: 'File name',
                    hintText: 'Enter file name',
                    isLastField: false,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          // _fileName = value;
                        });
                      }
                    },
                  ),
                  SelectDirField(
                    dirPath: _selectedDir,
                    onChanged: _getDir,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 20,
                    children: [
                      SaveSecondaryButton(hasSaved: _hasSaved),
                      const PrimaryButton(
                        text: 'Save',
                        onPressed: null,
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  void _getDir(String? path) {
    if (path != null) {
      setState(() {
        _selectedDir = path;
      });
    }
  }
}
