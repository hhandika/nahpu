import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/sites/components/habitats.dart';
import 'package:nahpu/screens/sites/components/geography.dart';
import 'package:nahpu/screens/sites/components/site_info.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/photos.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/shared/videos.dart';
import 'package:nahpu/screens/sites/components/coordinates.dart';
import 'package:nahpu/styles/catalogs.dart';

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
    widget.siteFormCtr.dispose();
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
            AdaptiveMainLayout(
              useHorizontalLayout: useHorizontalLayout,
              height: bottomSiteHeight,
              children: [
                Habitat(
                  id: widget.id,
                  useHorizontalLayout: useHorizontalLayout,
                  siteFormCtr: widget.siteFormCtr,
                ),
                CoordinateFields(
                  siteId: widget.id,
                ),
              ],
            ),
            MediaTabBars(
              tabController: _tabController,
              length: 2,
              height: MediaQuery.of(context).size.height * 0.5,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.photo_library_outlined,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.video_library_outlined,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
              children: const [
                PhotoViewer(),
                VideoViewer(),
              ],
            ),
            const BottomPadding()
          ],
        );
      },
    );
  }
}
