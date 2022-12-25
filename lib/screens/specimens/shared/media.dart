import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/screens/shared/associated_data.dart';
import 'package:nahpu/screens/shared/audios.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/photos.dart';
import 'package:nahpu/screens/shared/videos.dart';

class MediaForms extends ConsumerStatefulWidget {
  const MediaForms({Key? key, required this.specimenUuid}) : super(key: key);

  final String specimenUuid;

  @override
  MediaFormsState createState() => MediaFormsState();
}

class MediaFormsState extends ConsumerState<MediaForms>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final int _length = 4;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaTabBars(
      tabController: _tabController,
      length: _length,
      tabs: [
        Tab(
            icon: Icon(Icons.photo_library_rounded,
                color: Theme.of(context).colorScheme.tertiary)),
        Tab(
            icon: Icon(Icons.video_library_rounded,
                color: Theme.of(context).colorScheme.tertiary)),
        Tab(
            icon: Icon(Icons.audiotrack_rounded,
                color: Theme.of(context).colorScheme.tertiary)),
        Tab(
            icon: Icon(MdiIcons.database,
                color: Theme.of(context).colorScheme.tertiary))
      ],
      children: const [
        PhotoViewer(),
        VideoViewer(),
        AudioViewer(),
        AssociatedDataViewer(),
      ],
    );
  }
}
