import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:share_plus/share_plus.dart';

class CsvForm extends ConsumerStatefulWidget {
  const CsvForm({super.key});

  @override
  CsvFormState createState() => CsvFormState();
}

class CsvFormState extends ConsumerState<CsvForm> {
  String selectedDir = '...';
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
                onPressed: () {
                  Share.share('Hello World');
                }),
            PrimaryButton(text: 'Save', onPressed: () {}),
          ],
        )
      ],
    );
  }
}
