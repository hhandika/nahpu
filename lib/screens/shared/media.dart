import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/import/multimedia.dart';
import 'package:nahpu/services/media_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/utility_services.dart';
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
                ? const Text('No media added')
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
        child: GridView.builder(
          controller: scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(
              MediaQuery.of(context).size.width,
            ),
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return MediaCard(
              ctr: MediaFormCtr.fromData(images[index]),
            );
          },
        ),
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

class MediaCard extends ConsumerStatefulWidget {
  const MediaCard({
    super.key,
    required this.ctr,
  });

  final MediaFormCtr ctr;

  @override
  MediaCardState createState() => MediaCardState();
}

class MediaCardState extends ConsumerState<MediaCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: widget.ctr.fileNameCtr != null
              ? FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.file(
                        width: imageSize.toDouble(),
                        height: imageSize.toDouble(),
                        snapshot.data as File,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  future: _getMediaPath(),
                  initialData: null)
              : const Center(
                  child: Text('No image'),
                ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    widget.ctr.fileNameCtr ?? 'No image',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  subtitle: Text(
                    widget.ctr.captionCtr.text,
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: MediaPopUpMenu(ctr: widget.ctr),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<File> _getMediaPath() async {
    MediaCategory category =
        matchMediaCategoryString(widget.ctr.categoryCtr.text);
    File path = await ImageServices(ref: ref, category: category)
        .getMediaPath(widget.ctr.fileNameCtr!);

    return path;
  }
}

class MediaPopUpMenu extends ConsumerStatefulWidget {
  const MediaPopUpMenu({
    super.key,
    required this.ctr,
  });

  final MediaFormCtr ctr;

  @override
  MediaPopUpMenuState createState() => MediaPopUpMenuState();
}

class MediaPopUpMenuState extends ConsumerState<MediaPopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MediaPopUpMenu>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      itemBuilder: (context) {
        return <PopupMenuEntry<MediaPopUpMenu>>[
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit details'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Update Details'),
                      content: PhotoDetailForm(ctr: widget.ctr),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(
                MdiIcons.imageEditOutline,
              ),
              title: const Text(
                'Rename',
              ),
              onTap: () {},
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            onTap: () async {
              await MediaServices(ref: ref).deleteMedia(
                widget.ctr.primaryId!,
                widget.ctr.categoryCtr.text,
              );
            },
            child: const ListTile(
              leading: Icon(Icons.delete_outline, color: Colors.red),
              title: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ),
        ];
      },
    );
  }
}

class PhotoDetailForm extends ConsumerWidget {
  const PhotoDetailForm({
    super.key,
    required this.ctr,
  });

  final MediaFormCtr ctr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: ctr.captionCtr,
          decoration: InputDecoration(
            labelText: 'Caption',
            hintText: 'Enter caption',
            suffix: IconButton(
              icon: Icon(
                Icons.clear,
                color: Theme.of(context).disabledColor,
              ),
              onPressed: () {
                ctr.captionCtr.clear();
              },
            ),
          ),
          keyboardType: TextInputType.text,
          maxLines: 3,
          onChanged: (value) {
            if (value.isNotEmpty) {
              MediaServices(ref: ref).updateMedia(
                  ctr.primaryId!,
                  ctr.categoryCtr.text,
                  MediaCompanion(
                    caption: db.Value(value),
                  ));
            }
          },
        ),
        DropdownButtonFormField<String>(
          value: ctr.photographerCtr,
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
          onChanged: (String? value) {
            if (value != null) {
              MediaServices(ref: ref).updateMedia(
                  ctr.primaryId!,
                  ctr.categoryCtr.text,
                  MediaCompanion(
                    personnelId: db.Value(value),
                  ));
            }
          },
        ),
        CommonTextField(
          controller: ctr.categoryCtr,
          enabled: false,
          labelText: 'Category',
          hintText: 'Enter Category',
          isLastField: false,
        ),
      ],
    ));
  }
}
