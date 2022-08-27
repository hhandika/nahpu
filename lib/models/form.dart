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
      {required this.eventIDCtr,
      required this.startDateCtr,
      required this.endDateCtr,
      required this.startTimeCtr,
      required this.endTimeCtr,
      required this.primaryCollMethodCtr});
  TextEditingController eventIDCtr;
  TextEditingController startDateCtr;
  TextEditingController endDateCtr;
  TextEditingController startTimeCtr;
  TextEditingController endTimeCtr;
  TextEditingController primaryCollMethodCtr;

  factory CollEventFormCtrModel.empty() => CollEventFormCtrModel(
      eventIDCtr: TextEditingController(),
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
