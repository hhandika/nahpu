import 'package:flutter/material.dart';

class SiteFormCtrModel {
  SiteFormCtrModel(
      {required this.siteIDCtr,
      required this.siteTypeCtr,
      required this.countryCtr,
      required this.stateProvinceCtr,
      required this.countyCtr,
      required this.municipalityCtr,
      required this.localityCtr});
  TextEditingController siteIDCtr;
  TextEditingController siteTypeCtr;
  TextEditingController countryCtr;
  TextEditingController stateProvinceCtr;
  TextEditingController countyCtr;
  TextEditingController municipalityCtr;
  TextEditingController localityCtr;

  factory SiteFormCtrModel.empty() => SiteFormCtrModel(
      siteIDCtr: TextEditingController(),
      siteTypeCtr: TextEditingController(),
      countryCtr: TextEditingController(),
      stateProvinceCtr: TextEditingController(),
      countyCtr: TextEditingController(),
      municipalityCtr: TextEditingController(),
      localityCtr: TextEditingController());
}

class CollEventFormCtrModel {
  CollEventFormCtrModel(
      {required this.startDateCtr,
      required this.endDateCtr,
      required this.startTimeCtr,
      required this.endTimeCtr,
      required this.primaryCollMethodCtr});

  TextEditingController startDateCtr;
  TextEditingController endDateCtr;
  TextEditingController startTimeCtr;
  TextEditingController endTimeCtr;
  TextEditingController primaryCollMethodCtr;

  factory CollEventFormCtrModel.empty() => CollEventFormCtrModel(
      startDateCtr: TextEditingController(),
      endDateCtr: TextEditingController(),
      startTimeCtr: TextEditingController(),
      endTimeCtr: TextEditingController(),
      primaryCollMethodCtr: TextEditingController());
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
    required this.conditionCtr,
    required this.prepDateCtr,
    required this.prepTimeCtr,
    required this.captureDateCtr,
    required this.captureTimeCtr,
    required this.trapTypeCtr,
  });

  int? speciesIdCtr;
  String? collectorCtr;
  String? conditionCtr;
  TextEditingController prepDateCtr;
  TextEditingController prepTimeCtr;
  TextEditingController captureDateCtr;
  TextEditingController captureTimeCtr;
  TextEditingController trapTypeCtr;

  factory SpecimenFormCtrModel.empty() => SpecimenFormCtrModel(
      speciesIdCtr: null,
      collectorCtr: null,
      conditionCtr: null,
      prepDateCtr: TextEditingController(),
      prepTimeCtr: TextEditingController(),
      captureDateCtr: TextEditingController(),
      captureTimeCtr: TextEditingController(),
      trapTypeCtr: TextEditingController());
}
