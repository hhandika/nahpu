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

class SpecimenForm extends ConsumerStatefulWidget {
  const SpecimenForm(
      {Key? key, required this.specimenUuid, required this.specimenCtr})
      : super(key: key);

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;

  @override
  SpecimenFormState createState() => SpecimenFormState();
}

class SpecimenFormState extends ConsumerState<SpecimenForm> {
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
                          taxonOrder: 'Rodentia',
                          taxonFamily: 'Muridae'),
                      CaptureRecordFields(specimenCtr: widget.specimenCtr),
                    ],
                  ),
                ],
              ),
              AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  MammalMeasurementForms(
                      useHorizontalLayout: useHorizontalLayout),
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
