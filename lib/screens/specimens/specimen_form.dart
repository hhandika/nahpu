import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/specimens/avian/main_forms.dart';
import 'package:nahpu/screens/specimens/mammalian/main_forms.dart';

class SpecimenForm extends ConsumerStatefulWidget {
  const SpecimenForm(
      {Key? key,
      required this.specimenUuid,
      required this.specimenCtr,
      required this.catalogFmt})
      : super(key: key);

  final String specimenUuid;
  final SpecimenFormCtrModel specimenCtr;
  final CatalogFmt catalogFmt;

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
    widget.specimenCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.catalogFmt) {
      case CatalogFmt.birds:
        return BirdForms(
            specimenUuid: widget.specimenUuid, specimenCtr: widget.specimenCtr);
      case CatalogFmt.generalMammals:
        return MammalForms(
            specimenUuid: widget.specimenUuid, specimenCtr: widget.specimenCtr);
      case CatalogFmt.bats:
        return MammalForms(
            specimenUuid: widget.specimenUuid,
            specimenCtr: widget.specimenCtr,
            isBats: true);
      default:
        return MammalForms(
            specimenUuid: widget.specimenUuid, specimenCtr: widget.specimenCtr);
    }
  }
}
