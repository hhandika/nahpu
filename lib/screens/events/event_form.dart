import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/screens/events/components/activities.dart';
import 'package:nahpu/screens/events/components/effort.dart';
import 'package:nahpu/screens/events/components/general_info.dart';
import 'package:nahpu/screens/events/components/tab_bar.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/styles/catalog_pages.dart';

class CollEventForm extends ConsumerStatefulWidget {
  const CollEventForm({Key? key, required this.id, required this.collEventCtr})
      : super(key: key);

  final int id;
  final CollEventFormCtrModel collEventCtr;

  @override
  CollEventFormState createState() => CollEventFormState();
}

class CollEventFormState extends ConsumerState<CollEventForm> {
  @override
  void dispose() {
    widget.collEventCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        bool useHorizontalLayout = c.maxWidth > 600;
        return FocusDetectedLayout(
          children: [
            AdaptiveMainLayout(
              useHorizontalLayout: useHorizontalLayout,
              height: topCollEventHeight,
              children: [
                EventInfoField(
                    collEventId: widget.id,
                    useHorizontalLayout: useHorizontalLayout,
                    collEventCtr: widget.collEventCtr),
                CollActivityFields(
                  collEventId: widget.id,
                  collEventCtr: widget.collEventCtr,
                ),
              ],
            ),
            AdaptiveMainLayout(
              useHorizontalLayout: useHorizontalLayout,
              height: bottomCollEventHeight,
              children: [
                CollEffort(
                  collEventId: widget.id,
                ),
                CollEventTabBar(
                  eventID: widget.id,
                  useHorizontalLayout: useHorizontalLayout,
                ),
              ],
            ),
            const BottomPadding()
          ],
        );
      },
    );
  }
}
