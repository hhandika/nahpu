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
    required this.eventIDCtr,
    required this.startDateCtr,
    required this.endDateCtr,
    required this.startTimeCtr,
    required this.endTimeCtr,
    required this.primaryCollMethodCtr,
    required this.noteCtr,
  });

  TextEditingController eventIDCtr;
  TextEditingController startDateCtr;
  TextEditingController endDateCtr;
  TextEditingController startTimeCtr;
  TextEditingController endTimeCtr;
  String? primaryCollMethodCtr;
  TextEditingController noteCtr;

  factory CollEventFormCtrModel.empty() => CollEventFormCtrModel(
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
  TextEditingController siteCtr;
  TextEditingController narrativeCtr;

  factory NarrativeFormCtrModel.empty() => NarrativeFormCtrModel(
      dateCtr: TextEditingController(),
      siteCtr: TextEditingController(),
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
      trapTypeCtr: TextEditingController());
}
