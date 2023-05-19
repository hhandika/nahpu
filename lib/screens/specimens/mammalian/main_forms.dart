import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/mammalian/measurements.dart';
import 'package:nahpu/screens/specimens/shared/capture_records.dart';
import 'package:nahpu/screens/specimens/shared/collecting_records.dart';
import 'package:nahpu/screens/specimens/shared/media.dart';
import 'package:nahpu/screens/specimens/shared/specimen_parts.dart';
import 'package:nahpu/screens/specimens/shared/taxa.dart';
import 'package:nahpu/styles/catalogs.dart';

class MammalForms extends ConsumerStatefulWidget {
  const MammalForms({
    super.key,
    required this.specimenUuid,
    required this.specimenCtr,
    this.isBats = false,
  });

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
              AdaptiveMainLayout(
                useHorizontalLayout: useHorizontalLayout,
                height: topSpecimenRecordHeight,
                children: [
                  CollectingRecordField(
                    specimenUuid: widget.specimenUuid,
                    specimenCtr: widget.specimenCtr,
                    useHorizontalLayout: useHorizontalLayout,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
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
                    specimenUuid: widget.specimenUuid,
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
