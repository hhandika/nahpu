import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/mammals/measurements.dart';
import 'package:nahpu/screens/specimens/shared/capture_records.dart';
import 'package:nahpu/screens/specimens/shared/collecting_records.dart';
import 'package:nahpu/screens/specimens/shared/media.dart';
import 'package:nahpu/screens/specimens/shared/specimen_parts.dart';
import 'package:nahpu/screens/specimens/shared/taxa.dart';

class MammalForms extends ConsumerStatefulWidget {
  const MammalForms(
      {Key? key,
      required this.specimenUuid,
      required this.specimenCtr,
      this.isBats = false})
      : super(key: key);

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;
  final bool isBats;

  @override
  MammalFormsState createState() => MammalFormsState();
}

class MammalFormsState extends ConsumerState<MammalForms> {
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
                  MammalMeasurementForms(
                    useHorizontalLayout: useHorizontalLayout,
                    specimenUuid: widget.specimenUuid,
                    isBats: widget.isBats,
                  ),
                  PartDataForm(
                    specimenCtr: widget.specimenCtr,
                    catalogFmt: CatalogFmt.generalMammals,
                  ),
                ],
              ),
              MediaForms(
                specimenUuid: widget.specimenUuid,
              ),
              const BottomPadding()
            ],
          ),
        );
      },
    );
  }
}
