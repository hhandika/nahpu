import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/specimens.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/avian/measurements.dart';
import 'package:nahpu/screens/specimens/shared/capture_records.dart';
import 'package:nahpu/screens/specimens/shared/general_records.dart';
import 'package:nahpu/screens/specimens/shared/media.dart';
import 'package:nahpu/screens/specimens/shared/specimen_parts.dart';
import 'package:nahpu/screens/specimens/shared/taxa.dart';
import 'package:nahpu/styles/catalog_pages.dart';

class BirdForms extends ConsumerStatefulWidget {
  const BirdForms({
    super.key,
    required this.specimenUuid,
    required this.specimenCtr,
  });

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  BirdFormsState createState() => BirdFormsState();
}

class BirdFormsState extends ConsumerState<BirdForms> {
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        bool useHorizontalLayout = c.maxWidth > 600;
        return FocusDetectedLayout(
          children: [
            AdaptiveMainLayout(
              useHorizontalLayout: useHorizontalLayout,
              height: topSpecimenRecordHeight,
              children: [
                GeneralRecordField(
                  specimenUuid: widget.specimenUuid,
                  specimenCtr: widget.specimenCtr,
                  useHorizontalLayout: useHorizontalLayout,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TaxonomicForm(
                      useHorizontalLayout: useHorizontalLayout,
                      specimenUuid: widget.specimenUuid,
                    ),
                    CaptureRecordFields(
                      specimenUuid: widget.specimenUuid,
                      useHorizontalLayout: useHorizontalLayout,
                      specimenCtr: widget.specimenCtr,
                    ),
                  ],
                ),
              ],
            ),
            AdaptiveMainLayout(
              useHorizontalLayout: useHorizontalLayout,
              height: bottomSpecimenRecordHeight,
              children: [
                BirdMeasurementForms(
                    useHorizontalLayout: useHorizontalLayout,
                    specimenUuid: widget.specimenUuid),
                PartDataForm(
                  specimenUuid: widget.specimenUuid,
                  catalogFmt: CatalogFmt.birds,
                ),
              ],
            ),
            SpecimenMediaForm(
              specimenUuid: widget.specimenUuid,
            ),
            const BottomPadding(),
          ],
        );
      },
    );
  }
}
