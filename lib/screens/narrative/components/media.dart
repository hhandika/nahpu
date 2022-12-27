import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/photos.dart';
import 'package:nahpu/screens/shared/videos.dart';
import 'package:nahpu/styles/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaForm extends ConsumerStatefulWidget {
  const MediaForm({Key? key}) : super(key: key);

  @override
  MediaFormState createState() => MediaFormState();
}

class MediaFormState extends ConsumerState<MediaForm>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: 2,
          child: TabBar(
            indicatorColor: NahpuColor.tabBarColor(context),
            controller: _tabController,
            tabs: [
              Tab(
                  icon: Icon(Icons.photo_album_rounded,
                      color: Theme.of(context).colorScheme.tertiary)),
              Tab(
                  icon: Icon(Icons.video_library_rounded,
                      color: Theme.of(context).colorScheme.tertiary)),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: TabBarView(
            controller: _tabController,
            children: const [
              PhotoViewer(),
              VideoViewer(),
            ],
          ),
        ),
      ],
    );
  }
}
