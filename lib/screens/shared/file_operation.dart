import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';

class FileOperationPage extends StatelessWidget {
  const FileOperationPage({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

class FileNameField extends StatelessWidget {
  const FileNameField(
      {super.key, required this.controller, required this.onChanged});

  final FileOpCtrModel controller;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      controller: controller.fileNameCtr,
      labelText: 'File name',
      hintText: 'Enter file name',
      isLastField: false,
      onChanged: onChanged,
    );
  }
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
