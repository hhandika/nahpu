import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/mammals/measurements.dart';
import 'package:nahpu/screens/specimens/shared/capture_records.dart';
import 'package:nahpu/screens/specimens/shared/collecting_records.dart';
import 'package:nahpu/screens/specimens/shared/media.dart';
import 'package:nahpu/screens/specimens/shared/specimen_parts.dart';
import 'package:nahpu/screens/specimens/shared/taxonomy.dart';

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
                  CollectingRecordFields(
                      specimenUuid: widget.specimenUuid,
                      specimenCtr: widget.specimenCtr),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TaxonomicForm(
                        useHorizontalLayout: useHorizontalLayout,
                        taxonClass: 'Mammalia',
                        taxonOrder: widget.isBats ? 'Chiroptera' : 'Rodentia',
                        taxonFamily:
                            widget.isBats ? 'Vespertilionidae' : 'Muridae',
                      ),
                      CaptureRecordFields(specimenCtr: widget.specimenCtr),
                    ],
                  ),
                ],
              ),
              AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  MammalMeasurementForms(
                    useHorizontalLayout: useHorizontalLayout,
                    isBats: widget.isBats,
                  ),
                  SpecimenPartFields(specimenCtr: widget.specimenCtr),
                ],
              ),
              MediaForms(
                specimenUuid: widget.specimenUuid,
              ),
            ],
          ),
        );
      },
    );
  }
}
