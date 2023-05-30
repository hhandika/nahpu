import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/media.dart';

class MediaForms extends ConsumerStatefulWidget {
  const MediaForms({Key? key, required this.specimenUuid}) : super(key: key);

  final String specimenUuid;

  @override
  MediaFormsState createState() => MediaFormsState();
}

class MediaFormsState extends ConsumerState<MediaForms> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaViewer(
      images: const [],
      onAddImage: () {},
      onAccessingCamera: () {},
    );
  }
}
