import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/birds/measurements.dart';
import 'package:nahpu/screens/specimens/shared/capture_records.dart';
import 'package:nahpu/screens/specimens/shared/collecting_records.dart';
import 'package:nahpu/screens/specimens/shared/media.dart';
import 'package:nahpu/screens/specimens/shared/specimen_parts.dart';
import 'package:nahpu/screens/specimens/shared/taxa.dart';

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
        return SingleChildScrollView(
          child: Column(
            children: [
              AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  CollectingRecordField(
                      specimenUuid: widget.specimenUuid,
                      specimenCtr: widget.specimenCtr),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
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
              MediaForms(
                specimenUuid: widget.specimenUuid,
              ),
              const BottomPadding(),
            ],
          ),
        );
      },
    );
  }
}
