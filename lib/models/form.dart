import 'package:flutter/material.dart';

class SiteFormCtrModel {
  SiteFormCtrModel({
    required this.siteIDCtr,
    required this.leadStaffCtr,
    required this.siteTypeCtr,
    required this.countryCtr,
    required this.stateProvinceCtr,
    required this.countyCtr,
    required this.municipalityCtr,
    required this.localityCtr,
    required this.remarkCtr,
    required this.habitatTypeCtr,
    required this.habitatDescriptionCtr,
    required this.habitatConditionCtr,
  });
  TextEditingController siteIDCtr;
  String? leadStaffCtr;
  TextEditingController siteTypeCtr;
  TextEditingController countryCtr;
  TextEditingController stateProvinceCtr;
  TextEditingController countyCtr;
  TextEditingController municipalityCtr;
  TextEditingController localityCtr;
  TextEditingController remarkCtr;
  TextEditingController habitatTypeCtr;
  TextEditingController habitatDescriptionCtr;
  TextEditingController habitatConditionCtr;

  factory SiteFormCtrModel.empty() => SiteFormCtrModel(
        siteIDCtr: TextEditingController(),
        leadStaffCtr: null,
        siteTypeCtr: TextEditingController(),
        countryCtr: TextEditingController(),
        stateProvinceCtr: TextEditingController(),
        countyCtr: TextEditingController(),
        municipalityCtr: TextEditingController(),
        localityCtr: TextEditingController(),
        remarkCtr: TextEditingController(),
        habitatTypeCtr: TextEditingController(),
        habitatDescriptionCtr: TextEditingController(),
        habitatConditionCtr: TextEditingController(),
      );
}

class CollEventFormCtrModel {
  CollEventFormCtrModel({
    required this.siteIDCtr,
    required this.eventIDCtr,
    required this.startDateCtr,
    required this.endDateCtr,
    required this.startTimeCtr,
    required this.endTimeCtr,
    required this.primaryCollMethodCtr,
    required this.noteCtr,
  });

  String? siteIDCtr;
  TextEditingController eventIDCtr;
  TextEditingController startDateCtr;
  TextEditingController endDateCtr;
  TextEditingController startTimeCtr;
  TextEditingController endTimeCtr;
  String? primaryCollMethodCtr;
  TextEditingController noteCtr;

  factory CollEventFormCtrModel.empty() => CollEventFormCtrModel(
      siteIDCtr: null,
      eventIDCtr: TextEditingController(),
      startDateCtr: TextEditingController(),
      endDateCtr: TextEditingController(),
      startTimeCtr: TextEditingController(),
      endTimeCtr: TextEditingController(),
      primaryCollMethodCtr: null,
      noteCtr: TextEditingController());
}

class NarrativeFormCtrModel {
  NarrativeFormCtrModel(
      {required this.dateCtr,
      required this.siteCtr,
      required this.narrativeCtr});
  TextEditingController dateCtr;
  String? siteCtr;
  TextEditingController narrativeCtr;

  factory NarrativeFormCtrModel.empty() => NarrativeFormCtrModel(
      dateCtr: TextEditingController(),
      siteCtr: null,
      narrativeCtr: TextEditingController());
}

class SpecimenFormCtrModel {
  SpecimenFormCtrModel({
    required this.speciesIdCtr,
    required this.collectorCtr,
    required this.preparatorCtr,
    required this.conditionCtr,
    required this.prepDateCtr,
    required this.prepTimeCtr,
    required this.captureDateCtr,
    required this.captureTimeCtr,
    required this.trapTypeCtr,
  });

  int? speciesIdCtr;
  String? collectorCtr;
  String? preparatorCtr;
  String? conditionCtr;
  TextEditingController prepDateCtr;
  TextEditingController prepTimeCtr;
  TextEditingController captureDateCtr;
  TextEditingController captureTimeCtr;
  TextEditingController trapTypeCtr;

  factory SpecimenFormCtrModel.empty() => SpecimenFormCtrModel(
        speciesIdCtr: null,
        collectorCtr: null,
        preparatorCtr: null,
        conditionCtr: null,
        prepDateCtr: TextEditingController(),
        prepTimeCtr: TextEditingController(),
        captureDateCtr: TextEditingController(),
        captureTimeCtr: TextEditingController(),
        trapTypeCtr: TextEditingController(),
      );
}

class BirdMeasurementCtrModel {
  BirdMeasurementCtrModel({
    required this.weightCtr,
    required this.wingspanCtr,
    required this.irisCtr,
    required this.billCtr,
    required this.tarsusCtr,
    required this.footCtr,
    required this.wingMoltCtr,
    required this.tailMoltCtr,
    required this.bodyMoltCtr,
    required this.bursaCtr,
    required this.skullOssCtr,
    required this.fatCtr,
    required this.gonadCtr,
    required this.testisCtr,
  });

  TextEditingController weightCtr;
  TextEditingController wingspanCtr;
  TextEditingController irisCtr;
  TextEditingController billCtr;
  TextEditingController tarsusCtr;
  TextEditingController footCtr;
  TextEditingController wingMoltCtr;
  TextEditingController tailMoltCtr;
  TextEditingController bodyMoltCtr;
  TextEditingController bursaCtr;
  TextEditingController skullOssCtr;
  TextEditingController fatCtr;
  TextEditingController gonadCtr;
  TextEditingController testisCtr;

  factory BirdMeasurementCtrModel.empty() => BirdMeasurementCtrModel(
        weightCtr: TextEditingController(),
        wingspanCtr: TextEditingController(),
        irisCtr: TextEditingController(),
        billCtr: TextEditingController(),
        tarsusCtr: TextEditingController(),
        footCtr: TextEditingController(),
        wingMoltCtr: TextEditingController(),
        tailMoltCtr: TextEditingController(),
        bodyMoltCtr: TextEditingController(),
        bursaCtr: TextEditingController(),
        skullOssCtr: TextEditingController(),
        fatCtr: TextEditingController(),
        gonadCtr: TextEditingController(),
        testisCtr: TextEditingController(),
      );
}

class PersonnelFormCtrModel {
  PersonnelFormCtrModel({
    required this.nameCtr,
    required this.initialCtr,
    required this.emailCtr,
    required this.affiliationCtr,
    required this.roleCtr,
    required this.nextCollectorNumCtr,
    required this.photoIdCtr,
    required this.noteCtr,
  });

  TextEditingController nameCtr;
  TextEditingController initialCtr;
  TextEditingController emailCtr;
  TextEditingController affiliationCtr;
  String? roleCtr;
  TextEditingController nextCollectorNumCtr;
  TextEditingController photoIdCtr;
  TextEditingController noteCtr;

  factory PersonnelFormCtrModel.empty() => PersonnelFormCtrModel(
      nameCtr: TextEditingController(),
      initialCtr: TextEditingController(),
      emailCtr: TextEditingController(),
      affiliationCtr: TextEditingController(),
      roleCtr: null,
      nextCollectorNumCtr: TextEditingController(),
      photoIdCtr: TextEditingController(),
      noteCtr: TextEditingController());
}

class TaxonRegistryCtrModel {
  TaxonRegistryCtrModel({
    required this.taxonClassCtr,
    required this.taxonOrderCtr,
    required this.taxonFamilyCtr,
    required this.genusCtr,
    required this.specificEpithetCtr,
    required this.commonNameCtr,
    required this.noteCtr,
  });

  TextEditingController taxonClassCtr;
  TextEditingController taxonOrderCtr;
  TextEditingController taxonFamilyCtr;
  TextEditingController genusCtr;
  TextEditingController specificEpithetCtr;
  TextEditingController commonNameCtr;
  TextEditingController noteCtr;

  factory TaxonRegistryCtrModel.empty() => TaxonRegistryCtrModel(
      taxonClassCtr: TextEditingController(),
      taxonOrderCtr: TextEditingController(),
      taxonFamilyCtr: TextEditingController(),
      genusCtr: TextEditingController(),
      specificEpithetCtr: TextEditingController(),
      commonNameCtr: TextEditingController(),
      noteCtr: TextEditingController());
}
