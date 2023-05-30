import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:path/path.dart';

const int imageSize = 300;

class AudioVisualForm extends StatefulWidget {
  const AudioVisualForm({
    super.key,
    required this.images,
    required this.onAddImage,
    required this.onAccessingCamera,
  });

  final List<File> images;
  final VoidCallback onAddImage;
  final VoidCallback onAccessingCamera;

  @override
  State<AudioVisualForm> createState() => _AudioVisualFormState();
}

class _AudioVisualFormState extends State<AudioVisualForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                    onPressed: widget.onAddImage,
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
                    onPressed: widget.onAccessingCamera,
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
            child: widget.images.isEmpty
                ? const Text('No images selected')
                : MediaViewer(images: widget.images),
          ),
        ),
      ],
    );
  }
}

class MediaViewer extends StatelessWidget {
  const MediaViewer({
    super.key,
    required this.images,
  });

  final List<File> images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        crossAxisCount: _getCrossAxisCount(MediaQuery.of(context).size.width),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(images.length, (index) {
          return MediaCard(mediaPath: images[index]);
        }),
      ),
    );
  }

  int _getCrossAxisCount(double width) {
    int crossAxisCount = 1;
    double safeWidth = width - 24;
    while (safeWidth > imageSize) {
      crossAxisCount++;
      safeWidth -= imageSize;
    }
    return crossAxisCount;
  }
}

class MediaCard extends StatelessWidget {
  const MediaCard({
    super.key,
    required this.mediaPath,
  });

  final File mediaPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        footer: GridTileBar(
            leading: Icon(
              Icons.image_outlined,
              size: 35,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            backgroundColor: Color.lerp(
              Theme.of(context).colorScheme.secondaryContainer,
              Theme.of(context).colorScheme.surface,
              0.2,
            ),
            title: Text(
              basename(mediaPath.path),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            subtitle: Text(
              'Caption',
              style: Theme.of(context).textTheme.labelSmall,
            )),
        child: Image.file(mediaPath, fit: BoxFit.cover),
      ),
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
