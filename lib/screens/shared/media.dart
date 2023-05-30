import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/import/multimedia.dart';

class AudioVisualForm extends StatefulWidget {
  const AudioVisualForm({super.key});

  @override
  State<AudioVisualForm> createState() => _AudioVisualFormState();
}

class _AudioVisualFormState extends State<AudioVisualForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TitleForm(text: 'Audio/Visual', isCentered: false),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 8,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      elevation: 0,
                    ),
                    onPressed: () async {
                      List<String> images = await ImageServices().pickImages();
                      if (images.isNotEmpty) {
                        if (kDebugMode) {
                          for (var image in images) {
                            print(image);
                          }
                        }
                      }
                    },
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: const Center(
            child: Text('No media added'),
          ),
        ),
      ],
    );
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
