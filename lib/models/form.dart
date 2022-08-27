import 'package:flutter/material.dart';

class SiteFormModel {
  SiteFormModel(
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

  factory SiteFormModel.empty() => SiteFormModel(
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController());
}

class CollEventFormModel {
  CollEventFormModel(this.eventIDCtr, this.startDateCtr, this.endDateCtr,
      this.startTimeCtr, this.endTimeCtr, this.primaryCollMethodCtr);
  TextEditingController eventIDCtr;
  TextEditingController startDateCtr;
  TextEditingController endDateCtr;
  TextEditingController startTimeCtr;
  TextEditingController endTimeCtr;
  TextEditingController primaryCollMethodCtr;

  factory CollEventFormModel.empty() => CollEventFormModel(
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
