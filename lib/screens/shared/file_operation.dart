import 'dart:io';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/buttons.dart';

class FileOperationPage extends StatelessWidget {
  const FileOperationPage({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ScrollableLayout(
          child: Column(
            children: children,
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

class SelectDirField extends StatelessWidget {
  const SelectDirField({
    super.key,
    required this.dirPath,
    required this.onPressed,
  });

  final Directory? dirPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const SizedBox.shrink()
        : Row(
            children: [
              Expanded(
                child: Text(
                  'Choose a directory: ${dirPath == null ? '' : dirPath!.path}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.folder),
                onPressed: onPressed,
              ),
            ],
          );
  }
}

class SelectFileField extends StatelessWidget {
  const SelectFileField({
    super.key,
    required this.path,
    required this.onPressed,
  });

  final File path;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Choose a file: ${path.path}',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.folder),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
