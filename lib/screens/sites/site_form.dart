import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/sites/components/habitats.dart';
import 'package:nahpu/screens/sites/components/geography.dart';
import 'package:nahpu/screens/sites/components/site_info.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/photos.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/shared/videos.dart';
import 'package:nahpu/screens/sites/components/coordinates.dart';

class SiteForm extends ConsumerStatefulWidget {
  const SiteForm({Key? key, required this.id, required this.siteFormCtr})
      : super(key: key);

  final int id;
  final SiteFormCtrModel siteFormCtr;

  @override
  SiteFormState createState() => SiteFormState();
}

class SiteFormState extends ConsumerState<SiteForm>
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        bool useHorizontalLayout = c.maxWidth > 600.0;
        return ListView(
          children: [
            SiteInfo(
              id: widget.id,
              useHorizontalLayout: useHorizontalLayout,
              siteFormCtr: widget.siteFormCtr,
            ),
            Geography(
              id: widget.id,
              useHorizontalLayout: useHorizontalLayout,
              siteFormCtr: widget.siteFormCtr,
            ),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: [
                const CoordinateFields(),
                Habitat(
                    id: widget.id,
                    useHorizontalLayout: useHorizontalLayout,
                    siteFormCtr: widget.siteFormCtr),
              ],
            ),
            MediaTabBars(
              tabController: _tabController,
              length: 2,
              tabs: [
                Tab(
                    icon: Icon(Icons.photo_album_rounded,
                        color: Theme.of(context).colorScheme.tertiary)),
                Tab(
                    icon: Icon(Icons.video_library_rounded,
                        color: Theme.of(context).colorScheme.tertiary)),
              ],
              children: const [
                PhotoViewer(),
                VideoViewer(),
              ],
            ),
          ],
        );
      },
    );
  }
}
