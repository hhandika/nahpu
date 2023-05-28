import 'package:flutter/material.dart';

class VideoForm extends StatefulWidget {
  const VideoForm({Key? key}) : super(key: key);

  @override
  State<VideoForm> createState() => _VideoFormState();
}

class _VideoFormState extends State<VideoForm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Videos'),
      content: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ElevatedButton(onPressed: null, child: Text('Browse Files')),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'File name',
              hintText: 'Enter file name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Caption',
              hintText: 'Enter caption',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Date taken',
              hintText: 'Enter date taken',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      )),
      actions: [
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          child: const Text('Add'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
