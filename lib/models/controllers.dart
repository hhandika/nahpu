import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/services/database.dart';

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

  factory SiteFormCtrModel.fromData(SiteData site) => SiteFormCtrModel(
        siteIDCtr: TextEditingController(text: site.siteID),
        leadStaffCtr: site.leadStaffId,
        siteTypeCtr: TextEditingController(text: site.siteType),
        countryCtr: TextEditingController(text: site.country),
        stateProvinceCtr: TextEditingController(text: site.stateProvince),
        countyCtr: TextEditingController(text: site.county),
        municipalityCtr: TextEditingController(text: site.municipality),
        localityCtr: TextEditingController(text: site.locality),
        remarkCtr: TextEditingController(text: site.remark),
        habitatTypeCtr: TextEditingController(text: site.habitatType),
        habitatDescriptionCtr:
            TextEditingController(text: site.habitatDescription),
        habitatConditionCtr: TextEditingController(text: site.habitatCondition),
      );

  void dispose() {
    siteIDCtr.dispose();
    siteTypeCtr.dispose();
    countryCtr.dispose();
    stateProvinceCtr.dispose();
    countyCtr.dispose();
    municipalityCtr.dispose();
    localityCtr.dispose();
    remarkCtr.dispose();
    habitatTypeCtr.dispose();
    habitatDescriptionCtr.dispose();
    habitatConditionCtr.dispose();
  }
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

  int? siteIDCtr;
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
        noteCtr: TextEditingController(),
      );

  factory CollEventFormCtrModel.fromData(CollEventData collEvent) =>
      CollEventFormCtrModel(
        siteIDCtr: collEvent.siteID,
        eventIDCtr: TextEditingController(text: collEvent.eventID),
        startDateCtr: TextEditingController(text: collEvent.startDate),
        endDateCtr: TextEditingController(text: collEvent.endDate),
        startTimeCtr: TextEditingController(text: collEvent.startTime),
        endTimeCtr: TextEditingController(text: collEvent.endTime),
        primaryCollMethodCtr: collEvent.primaryCollMethod,
        noteCtr: TextEditingController(text: collEvent.collMethodNotes),
      );

  void dispose() {
    eventIDCtr.dispose();
    startDateCtr.dispose();
    endDateCtr.dispose();
    startTimeCtr.dispose();
    endTimeCtr.dispose();
    noteCtr.dispose();
  }
}

class NarrativeFormCtrModel {
  NarrativeFormCtrModel(
      {required this.dateCtr,
      required this.siteCtr,
      required this.narrativeCtr});
  TextEditingController dateCtr;
  int? siteCtr;
  TextEditingController narrativeCtr;

  factory NarrativeFormCtrModel.empty() => NarrativeFormCtrModel(
      dateCtr: TextEditingController(),
      siteCtr: null,
      narrativeCtr: TextEditingController());

  void dispose() {
    dateCtr.dispose();
    narrativeCtr.dispose();
  }
}

class SpecimenFormCtrModel {
  SpecimenFormCtrModel({
    required this.taxonDataCtr,
    required this.catalogerCtr,
    required this.collectorNumberCtr,
    required this.collEventIDCtr,
    required this.collPersonnelCtr,
    required this.captureMethodCtr,
    required this.preparatorCtr,
    required this.conditionCtr,
    required this.prepDateCtr,
    required this.prepTimeCtr,
    required this.captureDateCtr,
    required this.captureTimeCtr,
    required this.trapTypeCtr,
  });

  String? catalogerCtr;
  String? preparatorCtr;
  String? conditionCtr;
  TaxonData taxonDataCtr;
  int? collEventIDCtr;
  int? collPersonnelCtr;
  int? captureMethodCtr;
  TextEditingController collectorNumberCtr;
  TextEditingController prepDateCtr;
  TextEditingController prepTimeCtr;
  TextEditingController captureDateCtr;
  TextEditingController captureTimeCtr;
  TextEditingController trapTypeCtr;

  factory SpecimenFormCtrModel.empty() => SpecimenFormCtrModel(
        catalogerCtr: null,
        preparatorCtr: null,
        conditionCtr: null,
        collEventIDCtr: null,
        collPersonnelCtr: null,
        captureMethodCtr: null,
        collectorNumberCtr: TextEditingController(),
        taxonDataCtr: TaxonData(),
        prepDateCtr: TextEditingController(),
        prepTimeCtr: TextEditingController(),
        captureDateCtr: TextEditingController(),
        captureTimeCtr: TextEditingController(),
        trapTypeCtr: TextEditingController(),
      );

  factory SpecimenFormCtrModel.fromData(
          SpecimenData specimen, TaxonData taxonData) =>
      SpecimenFormCtrModel(
        catalogerCtr: specimen.catalogerID,
        preparatorCtr: specimen.preparatorID,
        conditionCtr: specimen.condition,
        collEventIDCtr: specimen.collEventID,
        collPersonnelCtr: specimen.collPersonnelID,
        captureMethodCtr: specimen.collMethodID,
        collectorNumberCtr:
            TextEditingController(text: specimen.fieldNumber?.toString() ?? ''),
        taxonDataCtr: taxonData,
        prepDateCtr: TextEditingController(text: specimen.prepDate),
        prepTimeCtr: TextEditingController(text: specimen.prepTime),
        captureDateCtr: TextEditingController(text: specimen.captureDate),
        captureTimeCtr: TextEditingController(text: specimen.captureTime),
        trapTypeCtr: TextEditingController(text: specimen.trapType),
      );

  void dispose() {
    collectorNumberCtr.dispose();
    prepDateCtr.dispose();
    prepTimeCtr.dispose();
    captureDateCtr.dispose();
    captureTimeCtr.dispose();
    trapTypeCtr.dispose();
  }
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

  void dispose() {
    weightCtr.dispose();
    wingspanCtr.dispose();
    irisCtr.dispose();
    billCtr.dispose();
    tarsusCtr.dispose();
    footCtr.dispose();
    wingMoltCtr.dispose();
    tailMoltCtr.dispose();
    bodyMoltCtr.dispose();
    bursaCtr.dispose();
    skullOssCtr.dispose();
    fatCtr.dispose();
    gonadCtr.dispose();
    testisCtr.dispose();
  }
}

class PersonnelFormCtrModel {
  PersonnelFormCtrModel({
    required this.nameCtr,
    required this.initialCtr,
    required this.emailCtr,
    required this.phoneCtr,
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
  TextEditingController phoneCtr;
  TextEditingController photoIdCtr;
  TextEditingController noteCtr;

  factory PersonnelFormCtrModel.empty() => PersonnelFormCtrModel(
      nameCtr: TextEditingController(),
      initialCtr: TextEditingController(),
      emailCtr: TextEditingController(),
      phoneCtr: TextEditingController(),
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

  void dispose() {
    taxonClassCtr.dispose();
    taxonOrderCtr.dispose();
    taxonFamilyCtr.dispose();
    genusCtr.dispose();
    specificEpithetCtr.dispose();
    commonNameCtr.dispose();
    noteCtr.dispose();
  }
}

class CoordinateCtrModel {
  CoordinateCtrModel({
    required this.nameIdCtr,
    required this.latitudeCtr,
    required this.longitudeCtr,
    required this.elevationCtr,
    required this.datumCtr,
    required this.uncertaintyCtr,
    required this.gpsUnitCtr,
    required this.noteCtr,
  });

  TextEditingController nameIdCtr;
  TextEditingController latitudeCtr;
  TextEditingController longitudeCtr;
  TextEditingController elevationCtr;
  TextEditingController datumCtr;
  TextEditingController uncertaintyCtr;
  TextEditingController gpsUnitCtr;
  TextEditingController noteCtr;

  factory CoordinateCtrModel.empty() => CoordinateCtrModel(
      nameIdCtr: TextEditingController(),
      latitudeCtr: TextEditingController(),
      longitudeCtr: TextEditingController(),
      elevationCtr: TextEditingController(),
      datumCtr: TextEditingController(),
      uncertaintyCtr: TextEditingController(),
      gpsUnitCtr: TextEditingController(),
      noteCtr: TextEditingController());

  factory CoordinateCtrModel.fromData(CoordinateData data) =>
      CoordinateCtrModel(
        nameIdCtr: TextEditingController(text: data.nameId ?? ''),
        latitudeCtr:
            TextEditingController(text: data.decimalLatitude.toString()),
        longitudeCtr:
            TextEditingController(text: data.decimalLongitude.toString()),
        elevationCtr:
            TextEditingController(text: data.elevationInMeter.toString()),
        datumCtr: TextEditingController(text: data.datum ?? ''),
        uncertaintyCtr:
            TextEditingController(text: data.uncertaintyInMeters.toString()),
        gpsUnitCtr: TextEditingController(text: data.gpsUnit ?? ''),
        noteCtr: TextEditingController(text: data.notes ?? ''),
      );

  void dispose() {
    nameIdCtr.dispose();
    latitudeCtr.dispose();
    longitudeCtr.dispose();
    elevationCtr.dispose();
    datumCtr.dispose();
    uncertaintyCtr.dispose();
    gpsUnitCtr.dispose();
    noteCtr.dispose();
  }
}

class CollEffortCtrModel {
  CollEffortCtrModel({
    required this.typeCtr,
    required this.brandCtr,
    required this.countCtr,
    required this.sizeCtr,
    required this.noteCtr,
  });

  TextEditingController typeCtr;
  TextEditingController brandCtr;
  TextEditingController countCtr;
  TextEditingController sizeCtr;
  TextEditingController noteCtr;

  factory CollEffortCtrModel.empty() => CollEffortCtrModel(
      typeCtr: TextEditingController(),
      brandCtr: TextEditingController(),
      countCtr: TextEditingController(),
      sizeCtr: TextEditingController(),
      noteCtr: TextEditingController());

  factory CollEffortCtrModel.fromData(CollEffortData data) =>
      CollEffortCtrModel(
        typeCtr: TextEditingController(text: data.type ?? ''),
        brandCtr: TextEditingController(text: data.brand ?? ''),
        countCtr: TextEditingController(text: data.count.toString()),
        sizeCtr: TextEditingController(text: data.size.toString()),
        noteCtr: TextEditingController(text: data.notes ?? ''),
      );

  void dispose() {
    typeCtr.dispose();
    brandCtr.dispose();
    countCtr.dispose();
    sizeCtr.dispose();
    noteCtr.dispose();
  }
}

class CollPersonnelCtrModel {
  CollPersonnelCtrModel({
    required this.id,
    required this.nameIDCtr,
    required this.roleCtr,
    required this.nameCtr,
  });

  int? id;
  String? nameIDCtr;
  String? roleCtr;
  TextEditingController nameCtr;

  factory CollPersonnelCtrModel.empty() => CollPersonnelCtrModel(
        id: null,
        nameIDCtr: null,
        roleCtr: null,
        nameCtr: TextEditingController(),
      );

  factory CollPersonnelCtrModel.fromData(CollPersonnelData data) =>
      CollPersonnelCtrModel(
        id: data.id,
        nameIDCtr: data.personnelId,
        roleCtr: data.role,
        nameCtr: TextEditingController(text: data.name ?? ''),
      );

  void dispose() {
    nameCtr.dispose();
  }
}

class CollWeatherCtrModel {
  CollWeatherCtrModel({
    required this.lowestDayTempCtr,
    required this.highestDayTempCtr,
    required this.lowestNightTempCtr,
    required this.highestNightTempCtr,
    required this.averageHumidityCtr,
    required this.dewPointCtr,
    required this.sunriseTimeCtr,
    required this.sunsetTimeCtr,
    required this.moonPhaseCtr,
    required this.noteCtr,
  });

  TextEditingController lowestDayTempCtr;
  TextEditingController highestDayTempCtr;
  TextEditingController lowestNightTempCtr;
  TextEditingController highestNightTempCtr;
  TextEditingController averageHumidityCtr;
  TextEditingController dewPointCtr;
  TextEditingController sunriseTimeCtr;
  TextEditingController sunsetTimeCtr;
  TextEditingController noteCtr;
  String? moonPhaseCtr;

  factory CollWeatherCtrModel.fromData(WeatherData data) => CollWeatherCtrModel(
        lowestDayTempCtr:
            TextEditingController(text: data.lowestDayTempC?.toString() ?? ''),
        highestDayTempCtr:
            TextEditingController(text: data.highestDayTempC?.toString() ?? ''),
        lowestNightTempCtr: TextEditingController(
            text: data.lowestNightTempC?.toString() ?? ''),
        highestNightTempCtr: TextEditingController(
            text: data.highestNightTempC?.toString() ?? ''),
        averageHumidityCtr:
            TextEditingController(text: data.averageHumidity?.toString() ?? ''),
        dewPointCtr:
            TextEditingController(text: data.dewPointTemp?.toString() ?? ''),
        sunriseTimeCtr:
            TextEditingController(text: data.sunriseTime?.toString() ?? ''),
        sunsetTimeCtr:
            TextEditingController(text: data.sunsetTime?.toString() ?? ''),
        moonPhaseCtr: data.moonPhase,
        noteCtr: TextEditingController(text: data.notes ?? ''),
      );

  void dispose() {
    lowestDayTempCtr.dispose();
    highestDayTempCtr.dispose();
    lowestNightTempCtr.dispose();
    highestNightTempCtr.dispose();
    averageHumidityCtr.dispose();
    dewPointCtr.dispose();
    sunriseTimeCtr.dispose();
    sunsetTimeCtr.dispose();
    noteCtr.dispose();
  }
}
