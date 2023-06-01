import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nahpu/providers/validation.dart';
import 'package:nahpu/services/import/multimedia.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/import.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:path/path.dart';

class PersonnelAvatar extends ConsumerStatefulWidget {
  const PersonnelAvatar({
    super.key,
    required this.ctr,
  });

  final PersonnelFormCtrModel ctr;

  @override
  PersonnelAvatarState createState() => PersonnelAvatarState();
}

class PersonnelAvatarState extends ConsumerState<PersonnelAvatar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        children: [
          Positioned.fill(
            child: AvatarViewer(
              filePath: widget.ctr.photoPathCtr,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 8,
            child: systemPlatform == PlatformType.mobile
                ? ImageSpeedDials(
                    onSelectPhoto: _selectPhoto,
                    onTakePhoto: _takePhoto,
                  )
                : ImageButton(
                    onPressed: _selectPhoto,
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectPhoto() async {
    final image = await ImageServices(
      ref: ref,
      category: MediaCategory.personnel,
    ).pickImageSingle();
    if (image.isNotEmpty) {
      _validateEditing();
      setState(() {
        widget.ctr.photoPathCtr.text = basename(image);
      });
    }
  }

  Future<void> _takePhoto() async {
    final image = await ImageServices(
      ref: ref,
      category: MediaCategory.personnel,
    ).accessCamera();
    if (image != null) {
      _validateEditing();
      setState(() {
        widget.ctr.photoPathCtr.text = basename(image);
      });
    }
  }

  void _validateEditing() {
    ref.read(personnelFormValidatorProvider.notifier).validateAll(widget.ctr);
    PersonnelServices(ref: ref).invalidatePersonnel();
  }
}

class AvatarViewer extends ConsumerStatefulWidget {
  const AvatarViewer({
    super.key,
    required this.filePath,
  });

  final TextEditingController filePath;

  @override
  AvatarViewerState createState() => AvatarViewerState();
}

class AvatarViewerState extends ConsumerState<AvatarViewer> {
  @override
  void initState() {
    _getImagePath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.filePath.text.startsWith(avatarPath)
        ? CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            child: Image.asset(
              widget.filePath.text,
              fit: BoxFit.cover,
            ))
        : FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceVariant,
                    foregroundImage: FileImage(
                      snapshot.data as File,
                    ));
              } else {
                return const Center(
                  child: Text('Image not found'),
                );
              }
            },
            future: _getMediaPath());
  }

  void _getImagePath() {
    if (widget.filePath.text.isEmpty) {
      String asset = PersonnelImageService().imageAssets;
      widget.filePath.text = asset;
    }
  }

  Future<File> _getMediaPath() async {
    File path = await ImageServices(
      ref: ref,
      category: MediaCategory.personnel,
    ).getMediaPath(widget.filePath.text);
    return path;
  }
}

class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          Icons.add_a_photo_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {},
      ),
    );
  }
}

class ImageSpeedDials extends StatelessWidget {
  const ImageSpeedDials({
    super.key,
    required this.onSelectPhoto,
    required this.onTakePhoto,
  });

  final VoidCallback onSelectPhoto;
  final VoidCallback onTakePhoto;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add_a_photo_outlined,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      foregroundColor: Theme.of(context).colorScheme.primary,
      direction: SpeedDialDirection.down,
      children: [
        SpeedDialChild(
          child: Icon(Icons.camera_alt_outlined,
              color: Theme.of(context).colorScheme.onSecondary),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          label: 'Take Photo',
          onTap: onTakePhoto,
        ),
        SpeedDialChild(
          child: Icon(Icons.photo_library_outlined,
              color: Theme.of(context).colorScheme.onSecondary),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          label: 'Select Photo',
          onTap: onSelectPhoto,
        ),
      ],
    );
  }
}
