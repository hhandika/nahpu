import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/collecting/components/collecting_activities.dart';
import 'package:nahpu/screens/collecting/components/collecting_effort.dart';
import 'package:nahpu/screens/collecting/components/collecting_info.dart';
import 'package:nahpu/screens/collecting/components/tab_bar.dart';
import 'package:nahpu/screens/shared/layout.dart';

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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        bool useHorizontalLayout = c.maxWidth > 600;
        return ListView(
          children: [
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: [
                CollectingInfoFields(
                    collEventId: widget.id,
                    useHorizontalLayout: useHorizontalLayout,
                    collEventCtr: widget.collEventCtr),
                CollActivityFields(
                  collEventId: widget.id,
                  collEventCtr: widget.collEventCtr,
                ),
              ],
            ),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: [
                CollectingEffortFrom(
                  collEventId: widget.id,
                ),
                CollEventTabBar(useHorizontalLayout: useHorizontalLayout),
              ],
            ),
          ],
        );
      },
    );
  }
}
