import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/sites/components/habitats.dart';
import 'package:nahpu/screens/sites/components/geography.dart';
import 'package:nahpu/screens/sites/components/site_info.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/screens/shared/media.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/sites/components/coordinates.dart';
import 'package:nahpu/styles/catalog_pages.dart';

class SiteForm extends ConsumerStatefulWidget {
  const SiteForm({Key? key, required this.id, required this.siteFormCtr})
      : super(key: key);

  final int id;
  final SiteFormCtrModel siteFormCtr;

  @override
  SiteFormState createState() => SiteFormState();
}

class SiteFormState extends ConsumerState<SiteForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
            AudioVisualForm(
              images: const [],
              onAddImage: () {},
              onAccessingCamera: () {},
            ),
            const BottomPadding()
          ],
        );
      },
    );
  }
}
