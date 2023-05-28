import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/media.dart';

class MediaForm extends ConsumerStatefulWidget {
  const MediaForm({Key? key}) : super(key: key);

  @override
  MediaFormState createState() => MediaFormState();
}

class MediaFormState extends ConsumerState<MediaForm> {
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
    return const AudioVisualForm();
  }
}
