import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:path/path.dart' as p;

class FileOperationPage extends StatelessWidget {
  const FileOperationPage({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
  });

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: ScrollableConstrainedLayout(
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      )),
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
    return TextField(
      controller: controller.fileNameCtr,
      decoration: InputDecoration(
          labelText: 'File name',
          hintText: 'Enter file name',
          suffix: controller.fileNameCtr.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(
                    Icons.clear,
                  ),
                  onPressed: () {
                    controller.fileNameCtr.clear();
                  },
                )),
      keyboardType: TextInputType.text,
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
                  dirPath == null ? 'Please select a directory' : dirPath!.path,
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
    required this.filePath,
    required this.onPressed,
    required this.width,
    required this.maxWidth,
  });

  final File? filePath;
  final VoidCallback onPressed;
  final double width;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(20),
      color: Theme.of(context).dividerColor,
      strokeWidth: 2,
      child: Container(
        width: width,
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TertiaryButton(
              onPressed: onPressed,
              text: 'Select file',
            ),
            const Text(' ··· '),
            const SizedBox(height: 10),
            Visibility(
              visible: filePath != null,
              child: RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.file_present),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    TextSpan(
                      text:
                          ' ${p.basename(filePath == null ? '' : filePath!.path)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
