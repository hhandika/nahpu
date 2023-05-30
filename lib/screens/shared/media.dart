import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/media_services.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:path/path.dart';
import 'package:drift/drift.dart' as db;

const int imageSize = 300;

class MediaViewer extends StatefulWidget {
  const MediaViewer({
    super.key,
    required this.images,
    required this.onAddImage,
    required this.onAccessingCamera,
  });

  final List<MediaData> images;
  final VoidCallback onAddImage;
  final VoidCallback onAccessingCamera;

  @override
  State<MediaViewer> createState() => _MediaViewerState();
}

class _MediaViewerState extends State<MediaViewer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 18, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TitleForm(text: 'Media', isCentered: false),
              MediaButton(
                onAddImage: widget.onAddImage,
                onAccessingCamera: widget.onAccessingCamera,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
            child: widget.images.isEmpty
                ? const Text('No images selected')
                : MediaViewerBuilder(images: widget.images),
          ),
        ),
      ],
    );
  }
}

/// Display option to pick image from gallery or camera
/// On mobile, display both options
/// On desktop, display only gallery option
class MediaButton extends StatelessWidget {
  const MediaButton({
    super.key,
    required this.onAddImage,
    required this.onAccessingCamera,
  });

  final VoidCallback onAddImage;
  final VoidCallback onAccessingCamera;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 8,
      children: [
        systemPlatform == PlatformType.mobile
            ? IconButton(
                onPressed: onAddImage,
                icon: const Icon(Icons.add),
              )
            : const SizedBox.shrink(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            elevation: 0,
          ),
          onPressed: systemPlatform == PlatformType.mobile
              ? onAccessingCamera
              : onAddImage,
          child: systemPlatform == PlatformType.mobile
              ? const Icon(Icons.camera_alt_outlined)
              : const Icon(Icons.add_photo_alternate_outlined),
        ),
      ],
    );
  }
}

class MediaViewerBuilder extends StatelessWidget {
  const MediaViewerBuilder({
    super.key,
    required this.images,
  });

  final List<MediaData> images;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return CommonScrollbar(
        scrollController: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.count(
            controller: scrollController,
            crossAxisCount:
                _getCrossAxisCount(MediaQuery.of(context).size.width),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(images.length, (index) {
              return MediaCard(data: images[index]);
            }),
          ),
        ));
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

class MediaCard extends ConsumerWidget {
  const MediaCard({
    super.key,
    required this.data,
  });

  final MediaData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withOpacity(0.9),
            trailing: MediaPopUpMenu(data: data),
            title: Text(
              data.filePath != null ? basename(data.filePath!) : 'No file name',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            subtitle: Text(
              data.caption ?? 'No caption',
              style: Theme.of(context).textTheme.labelSmall,
              overflow: TextOverflow.ellipsis,
            )),
        child: data.filePath != null
            ? Image.file(
                File(data.filePath!),
                fit: BoxFit.cover,
              )
            : const Center(
                child: Text('No image'),
              ),
      ),
    );
  }
}

class MediaPopUpMenu extends ConsumerStatefulWidget {
  const MediaPopUpMenu({
    super.key,
    required this.data,
  });

  final MediaData data;

  @override
  MediaPopUpMenuState createState() => MediaPopUpMenuState();
}

class MediaPopUpMenuState extends ConsumerState<MediaPopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MediaPopUpMenu>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit details'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return PhotoForm(
                      mediaId: widget.data.primaryId!,
                      category: widget.data.category!,
                    );
                  },
                );
              },
            ),
          ),
          const PopupMenuItem(
              child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Details'),
          )),
          const PopupMenuDivider(),
          PopupMenuItem(
            onTap: () async {
              await MediaServices(ref).deleteMedia(
                widget.data.primaryId!,
                widget.data.category!,
              );
              setState(() {});
            },
            child: const ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ),
        ];
      },
    );
  }
}

class PhotoForm extends ConsumerStatefulWidget {
  const PhotoForm({
    super.key,
    required this.mediaId,
    required this.category,
  });

  final int mediaId;
  final String category;

  @override
  PhotoFormState createState() => PhotoFormState();
}

class PhotoFormState extends ConsumerState<PhotoForm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Details'),
      content: PhotoDetailForm(
        mediaId: widget.mediaId,
        category: widget.category,
      ),
      actions: [
        SecondaryButton(
          text: 'Cancel',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        PrimaryButton(
            text: 'Update',
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}

class PhotoDetailForm extends ConsumerWidget {
  const PhotoDetailForm({
    super.key,
    required this.mediaId,
    required this.category,
  });

  final int mediaId;
  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonTextField(
            labelText: 'Caption',
            hintText: 'Enter caption',
            isLastField: false,
            maxLines: 5,
            onChanged: (value) {
              if (value != null && value.isNotEmpty) {
                MediaServices(ref).updateMedia(
                    mediaId,
                    category,
                    MediaCompanion(
                      caption: db.Value(value),
                    ));
              }
            },
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Photographer',
              hintText: 'Select Personnel',
            ),
            items: ref.watch(personnelListProvider).when(
                  data: (value) => value
                      .map((person) => DropdownMenuItem(
                            value: person.uuid,
                            child: CommonDropdownText(
                              text: person.name ?? '',
                            ),
                          ))
                      .toList(),
                  loading: () => const [],
                  error: (error, stack) => const [],
                ),
            onChanged: (String? value) {},
          ),
          const CommonTextField(
            enabled: false,
            labelText: 'Category',
            hintText: 'Enter Category',
            isLastField: false,
          ),
        ],
      ),
    );
  }
}
