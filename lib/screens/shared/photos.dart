import 'package:flutter/material.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({Key? key}) : super(key: key);

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                elevation: 0,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PhotoForm();
                    });
              },
              child: const Text(
                'Add photos',
              ),
            ),
          ],
        ));
  }
}

class PhotoForm extends StatefulWidget {
  const PhotoForm({Key? key}) : super(key: key);

  @override
  State<PhotoForm> createState() => _PhotoFormState();
}

class _PhotoFormState extends State<PhotoForm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Photos'),
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
