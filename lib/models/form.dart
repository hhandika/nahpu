import 'package:flutter/material.dart';

class SiteFormCtrModel {
  SiteFormCtrModel(
      this.siteIDCtr,
      this.siteTypeCtr,
      this.countryCtr,
      this.stateProvinceCtr,
      this.countyCtr,
      this.municipalityCtr,
      this.localityCtr);
  TextEditingController siteIDCtr;
  TextEditingController siteTypeCtr;
  TextEditingController countryCtr;
  TextEditingController stateProvinceCtr;
  TextEditingController countyCtr;
  TextEditingController municipalityCtr;
  TextEditingController localityCtr;

  factory SiteFormCtrModel.empty() => SiteFormCtrModel(
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController());
}

class CollEventFormCtrModel {
  CollEventFormCtrModel(this.eventIDCtr, this.startDateCtr, this.endDateCtr,
      this.startTimeCtr, this.endTimeCtr, this.primaryCollMethodCtr);
  TextEditingController eventIDCtr;
  TextEditingController startDateCtr;
  TextEditingController endDateCtr;
  TextEditingController startTimeCtr;
  TextEditingController endTimeCtr;
  TextEditingController primaryCollMethodCtr;

  factory CollEventFormCtrModel.empty() => CollEventFormCtrModel(
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController());
}

class NarrativeFormCtrModel {
  NarrativeFormCtrModel(this.dateCtr, this.siteCtr, this.narrativeCtr);
  TextEditingController dateCtr;
  TextEditingController siteCtr;
  TextEditingController narrativeCtr;

  factory NarrativeFormCtrModel.empty() => NarrativeFormCtrModel(
      TextEditingController(),
      TextEditingController(),
      TextEditingController());
}
