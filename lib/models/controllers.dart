import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/services/database/database.dart';

class ProjectFormCtrModel {
  ProjectFormCtrModel({
    required this.projectNameCtr,
    required this.descriptionCtr,
    required this.pICtr,
    required this.locationCtr,
    required this.startDateCtr,
    required this.endDateCtr,
  });

  TextEditingController projectNameCtr;
  TextEditingController descriptionCtr;
  TextEditingController pICtr;
  TextEditingController locationCtr;
  TextEditingController startDateCtr;
  TextEditingController endDateCtr;

  factory ProjectFormCtrModel.empty() => ProjectFormCtrModel(
        projectNameCtr: TextEditingController(),
        descriptionCtr: TextEditingController(),
        pICtr: TextEditingController(),
        locationCtr: TextEditingController(),
        startDateCtr: TextEditingController(),
        endDateCtr: TextEditingController(),
      );

  factory ProjectFormCtrModel.fromData(ProjectData? data) =>
      ProjectFormCtrModel(
        projectNameCtr: TextEditingController(text: data?.name ?? ''),
        descriptionCtr: TextEditingController(text: data?.description ?? ''),
        pICtr: TextEditingController(text: data?.principalInvestigator ?? ''),
        locationCtr: TextEditingController(text: data?.location ?? ''),
        startDateCtr: TextEditingController(text: data?.startDate ?? ''),
        endDateCtr: TextEditingController(text: data?.endDate ?? ''),
      );

  void dispose() {
    projectNameCtr.dispose();
    descriptionCtr.dispose();
    pICtr.dispose();
    locationCtr.dispose();
    startDateCtr.dispose();
    endDateCtr.dispose();
  }
}

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
  String? siteTypeCtr;
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
        siteTypeCtr: null,
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
        siteTypeCtr: site.siteType,
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
    required this.speciesCtr,
    required this.catalogerCtr,
    required this.fieldNumberCtr,
    required this.collEventIDCtr,
    required this.multipleCollectorCtr,
    required this.collPersonnelCtr,
    required this.captureMethodCtr,
    required this.relativeTimeCtr,
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
  int? speciesCtr;
  int? collEventIDCtr;
  int? multipleCollectorCtr;
  int? collPersonnelCtr;
  int? captureMethodCtr;
  int? relativeTimeCtr;
  TextEditingController fieldNumberCtr;
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
        multipleCollectorCtr: null,
        collPersonnelCtr: null,
        relativeTimeCtr: null,
        captureMethodCtr: null,
        fieldNumberCtr: TextEditingController(),
        taxonDataCtr: TaxonData(),
        speciesCtr: null,
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
        multipleCollectorCtr: specimen.isMultipleCollector,
        collPersonnelCtr: specimen.collPersonnelID,
        captureMethodCtr: specimen.collMethodID,
        relativeTimeCtr: specimen.isRelativeTime,
        fieldNumberCtr:
            TextEditingController(text: specimen.fieldNumber?.toString() ?? ''),
        taxonDataCtr: taxonData,
        speciesCtr: specimen.speciesID,
        prepDateCtr: TextEditingController(text: specimen.prepDate),
        prepTimeCtr: TextEditingController(text: specimen.prepTime),
        captureDateCtr: TextEditingController(text: specimen.captureDate),
        captureTimeCtr: TextEditingController(text: specimen.captureTime),
        trapTypeCtr: TextEditingController(text: specimen.trapType),
      );

  void dispose() {
    fieldNumberCtr.dispose();
    prepDateCtr.dispose();
    prepTimeCtr.dispose();
    captureDateCtr.dispose();
    captureTimeCtr.dispose();
    trapTypeCtr.dispose();
  }
}

class MammalMeasurementCtrModel {
  MammalMeasurementCtrModel({
    required this.totalLengthCtr,
    required this.tailLengthCtr,
    required this.hindFootCtr,
    required this.earCtr,
    required this.forearmCtr,
    required this.weightCtr,
    required this.accuracyCtr,
    required this.sexCtr,
    required this.ageCtr,
    required this.testisPosCtr,
    required this.testisLengthCtr,
    required this.testisWidthCtr,
    required this.epididymisCtr,
    required this.reproductiveStageCtr,
    required this.leftPlacentaCtr,
    required this.rightPlacentaCtr,
    required this.mammaeConditionCtr,
    required this.mammaeIngCtr,
    required this.mammaeAxCtr,
    required this.mammaeAbdCtr,
    required this.vaginaOpeningCtr,
    required this.pubicSymphysisCtr,
    required this.embryoLeftCtr,
    required this.embryoRightCtr,
    required this.embryoCRCtr,
    required this.remarksCtr,
  });

  TextEditingController totalLengthCtr;
  TextEditingController tailLengthCtr;
  TextEditingController hindFootCtr;
  TextEditingController earCtr;
  TextEditingController forearmCtr;
  TextEditingController weightCtr;
  String? accuracyCtr;
  int? sexCtr;
  int? ageCtr;
  int? testisPosCtr;
  TextEditingController testisLengthCtr;
  TextEditingController testisWidthCtr;
  int? epididymisCtr;
  int? reproductiveStageCtr;
  TextEditingController leftPlacentaCtr;
  TextEditingController rightPlacentaCtr;
  int? mammaeConditionCtr;
  TextEditingController mammaeIngCtr;
  TextEditingController mammaeAxCtr;
  TextEditingController mammaeAbdCtr;
  int? vaginaOpeningCtr;
  int? pubicSymphysisCtr;
  TextEditingController embryoLeftCtr;
  TextEditingController embryoRightCtr;
  TextEditingController embryoCRCtr;
  TextEditingController remarksCtr;

  factory MammalMeasurementCtrModel.empty() => MammalMeasurementCtrModel(
      totalLengthCtr: TextEditingController(),
      tailLengthCtr: TextEditingController(),
      hindFootCtr: TextEditingController(),
      earCtr: TextEditingController(),
      forearmCtr: TextEditingController(),
      weightCtr: TextEditingController(),
      accuracyCtr: null,
      sexCtr: null,
      ageCtr: null,
      testisPosCtr: null,
      testisLengthCtr: TextEditingController(),
      testisWidthCtr: TextEditingController(),
      epididymisCtr: null,
      reproductiveStageCtr: null,
      leftPlacentaCtr: TextEditingController(),
      rightPlacentaCtr: TextEditingController(),
      mammaeConditionCtr: null,
      mammaeIngCtr: TextEditingController(),
      mammaeAxCtr: TextEditingController(),
      mammaeAbdCtr: TextEditingController(),
      vaginaOpeningCtr: null,
      pubicSymphysisCtr: null,
      embryoLeftCtr: TextEditingController(),
      embryoRightCtr: TextEditingController(),
      embryoCRCtr: TextEditingController(),
      remarksCtr: TextEditingController());

  factory MammalMeasurementCtrModel.fromData(MammalMeasurementData data) =>
      MammalMeasurementCtrModel(
        totalLengthCtr:
            TextEditingController(text: data.totalLength?.toString() ?? ''),
        tailLengthCtr:
            TextEditingController(text: data.tailLength?.toString() ?? ''),
        hindFootCtr:
            TextEditingController(text: data.hindFootLength?.toString() ?? ''),
        earCtr: TextEditingController(text: data.earLength?.toString() ?? ''),
        forearmCtr: TextEditingController(text: data.forearm?.toString() ?? ''),
        weightCtr: TextEditingController(text: data.weight?.toString() ?? ''),
        accuracyCtr: data.accuracy?.toString(),
        sexCtr: data.sex,
        ageCtr: data.age,
        testisPosCtr: data.testisPosition,
        testisLengthCtr:
            TextEditingController(text: data.testisLength?.toString() ?? ''),
        testisWidthCtr:
            TextEditingController(text: data.testisWidth?.toString() ?? ''),
        epididymisCtr: data.epididymisAppearance,
        reproductiveStageCtr: data.reproductiveStage,
        leftPlacentaCtr: TextEditingController(
            text: data.leftPlacentalScars?.toString() ?? ''),
        rightPlacentaCtr: TextEditingController(
            text: data.rightPlacentalScars?.toString() ?? ''),
        mammaeConditionCtr: data.mammaeCondition,
        mammaeIngCtr: TextEditingController(
            text: data.mammaeInguinalCount?.toString() ?? ''),
        mammaeAxCtr: TextEditingController(
            text: data.mammaeAxillaryCount?.toString() ?? ''),
        mammaeAbdCtr: TextEditingController(
            text: data.mammaeAbdominalCount?.toString() ?? ''),
        vaginaOpeningCtr: data.vaginaOpening,
        pubicSymphysisCtr: data.pubicSymphysis,
        embryoLeftCtr:
            TextEditingController(text: data.embryoLeftCount?.toString() ?? ''),
        embryoRightCtr: TextEditingController(
            text: data.embryoRightCount?.toString() ?? ''),
        embryoCRCtr:
            TextEditingController(text: data.embryoCR?.toString() ?? ''),
        remarksCtr: TextEditingController(text: data.remark?.toString() ?? ''),
      );

  void dispose() {
    totalLengthCtr.dispose();
    tailLengthCtr.dispose();
    hindFootCtr.dispose();
    earCtr.dispose();
    forearmCtr.dispose();
    weightCtr.dispose();
    testisLengthCtr.dispose();
    testisWidthCtr.dispose();
    leftPlacentaCtr.dispose();
    rightPlacentaCtr.dispose();
    mammaeIngCtr.dispose();
    mammaeAxCtr.dispose();
    mammaeAbdCtr.dispose();
    embryoLeftCtr.dispose();
    embryoRightCtr.dispose();
    embryoCRCtr.dispose();
    remarksCtr.dispose();
  }
}

class BirdMeasurementCtrModel {
  BirdMeasurementCtrModel({
    required this.weightCtr,
    required this.wingspanCtr,
    required this.irisCtr,
    required this.billCtr,
    required this.footCtr,
    required this.tarsusCtr,
    required this.sexCtr,
    required this.moltCtr,
    required this.broodPatchCtr,
    required this.skullOssCtr,
    required this.bursaCtr,
    required this.fatCtr,
    required this.stomachContentCtr,
    required this.testisLengthCtr,
    required this.testisWidthCtr,
    required this.testisRemarkCtr,
    required this.ovaryLengthCtr,
    required this.ovaryWidthCtr,
    required this.ovaryAppearanceCtr,
    required this.firstOvaSizeCtr,
    required this.secondOvaSizeCtr,
    required this.thirdOvaSizeCtr,
    required this.oviductWidthCtr,
    required this.oviductAppearanceCtr,
    required this.ovaryRemarkCtr,
    required this.wingLeftPrimaryMoltCtr,
    required this.wingRightPrimaryMoltCtr,
    required this.wingLeftSecondaryMoltCtr,
    required this.wingRightSecondaryMoltCtr,
    required this.tailLeftRectriceCtr,
    required this.tailRightRectriceCtr,
    required this.bodyMoltCtr,
    required this.moltRemarkCtr,
  });

  TextEditingController weightCtr;
  TextEditingController wingspanCtr;
  TextEditingController irisCtr;
  TextEditingController billCtr;
  TextEditingController footCtr;
  TextEditingController tarsusCtr;
  int? sexCtr;
  int? moltCtr;
  int? broodPatchCtr;
  int? skullOssCtr;
  TextEditingController bursaCtr;
  int? fatCtr;
  TextEditingController stomachContentCtr;
  TextEditingController testisLengthCtr;
  TextEditingController testisWidthCtr;
  TextEditingController testisRemarkCtr;
  TextEditingController ovaryLengthCtr;
  TextEditingController ovaryWidthCtr;
  int? ovaryAppearanceCtr;
  TextEditingController firstOvaSizeCtr;
  TextEditingController secondOvaSizeCtr;
  TextEditingController thirdOvaSizeCtr;
  TextEditingController oviductWidthCtr;
  int? oviductAppearanceCtr;
  TextEditingController ovaryRemarkCtr;
  TextEditingController wingRightPrimaryMoltCtr;
  TextEditingController wingLeftPrimaryMoltCtr;
  TextEditingController wingRightSecondaryMoltCtr;
  TextEditingController wingLeftSecondaryMoltCtr;
  TextEditingController tailRightRectriceCtr;
  TextEditingController tailLeftRectriceCtr;
  int? bodyMoltCtr;
  TextEditingController moltRemarkCtr;

  factory BirdMeasurementCtrModel.empty() => BirdMeasurementCtrModel(
        weightCtr: TextEditingController(),
        wingspanCtr: TextEditingController(),
        irisCtr: TextEditingController(),
        billCtr: TextEditingController(),
        footCtr: TextEditingController(),
        tarsusCtr: TextEditingController(),
        sexCtr: null,
        moltCtr: null,
        broodPatchCtr: null,
        skullOssCtr: null,
        bursaCtr: TextEditingController(),
        fatCtr: null,
        stomachContentCtr: TextEditingController(),
        testisLengthCtr: TextEditingController(),
        testisWidthCtr: TextEditingController(),
        testisRemarkCtr: TextEditingController(),
        ovaryLengthCtr: TextEditingController(),
        ovaryWidthCtr: TextEditingController(),
        oviductWidthCtr: TextEditingController(),
        ovaryAppearanceCtr: null,
        firstOvaSizeCtr: TextEditingController(),
        secondOvaSizeCtr: TextEditingController(),
        thirdOvaSizeCtr: TextEditingController(),
        oviductAppearanceCtr: null,
        ovaryRemarkCtr: TextEditingController(),
        wingRightPrimaryMoltCtr: TextEditingController(),
        wingLeftPrimaryMoltCtr: TextEditingController(),
        wingRightSecondaryMoltCtr: TextEditingController(),
        wingLeftSecondaryMoltCtr: TextEditingController(),
        tailRightRectriceCtr: TextEditingController(),
        tailLeftRectriceCtr: TextEditingController(),
        bodyMoltCtr: null,
        moltRemarkCtr: TextEditingController(),
      );

  factory BirdMeasurementCtrModel.fromData(BirdMeasurementData data) =>
      BirdMeasurementCtrModel(
        weightCtr: TextEditingController(text: data.weight?.toString() ?? ''),
        wingspanCtr:
            TextEditingController(text: data.wingspan?.toString() ?? ''),
        irisCtr: TextEditingController(text: data.irisColor ?? ''),
        billCtr: TextEditingController(text: data.billColor ?? ''),
        footCtr: TextEditingController(text: data.footColor ?? ''),
        tarsusCtr: TextEditingController(text: data.tarsusColor ?? ''),
        sexCtr: data.sex,
        moltCtr: data.molting,
        broodPatchCtr: data.broodPatch,
        skullOssCtr: data.skullOssification,
        bursaCtr:
            TextEditingController(text: data.bursaLength?.toString() ?? ''),
        fatCtr: data.fat,
        stomachContentCtr:
            TextEditingController(text: data.stomachContent ?? ''),
        testisLengthCtr:
            TextEditingController(text: data.testisLength?.toString() ?? ''),
        testisWidthCtr:
            TextEditingController(text: data.testisWidth?.toString() ?? ''),
        testisRemarkCtr: TextEditingController(text: data.testisRemark ?? ''),
        ovaryLengthCtr:
            TextEditingController(text: data.ovaryLength?.toString() ?? ''),
        ovaryWidthCtr:
            TextEditingController(text: data.ovaryWidth?.toString() ?? ''),
        ovaryAppearanceCtr: data.ovaryAppearance,
        firstOvaSizeCtr:
            TextEditingController(text: data.firstOvaSize?.toString() ?? ''),
        secondOvaSizeCtr:
            TextEditingController(text: data.secondOvaSize?.toString() ?? ''),
        thirdOvaSizeCtr:
            TextEditingController(text: data.thirdOvaSize?.toString() ?? ''),
        oviductWidthCtr:
            TextEditingController(text: data.oviductWidth?.toString() ?? ''),
        oviductAppearanceCtr: data.oviductAppearance,
        ovaryRemarkCtr: TextEditingController(text: data.ovaryRemark ?? ''),
        wingRightPrimaryMoltCtr: TextEditingController(
            text: data.wingRightPrimary?.toString() ?? ''),
        wingLeftPrimaryMoltCtr:
            TextEditingController(text: data.wingLeftPrimary?.toString() ?? ''),
        wingRightSecondaryMoltCtr: TextEditingController(
            text: data.wingRightSecondary?.toString() ?? ''),
        wingLeftSecondaryMoltCtr: TextEditingController(
            text: data.wingLeftSecondary?.toString() ?? ''),
        tailRightRectriceCtr: TextEditingController(
            text: data.tailRightRectrices?.toString() ?? ''),
        tailLeftRectriceCtr: TextEditingController(
            text: data.tailLeftRectrices?.toString() ?? ''),
        bodyMoltCtr: data.bodyMolt,
        moltRemarkCtr: TextEditingController(text: data.moltRemark ?? ''),
      );

  void dispose() {
    weightCtr.dispose();
    wingspanCtr.dispose();
    irisCtr.dispose();
    billCtr.dispose();
    footCtr.dispose();
    tarsusCtr.dispose();
    bursaCtr.dispose();
    stomachContentCtr.dispose();
    testisLengthCtr.dispose();
    testisWidthCtr.dispose();
    testisRemarkCtr.dispose();
    ovaryLengthCtr.dispose();
    ovaryWidthCtr.dispose();
    firstOvaSizeCtr.dispose();
    secondOvaSizeCtr.dispose();
    thirdOvaSizeCtr.dispose();
    ovaryRemarkCtr.dispose();
    oviductWidthCtr.dispose();
    wingRightPrimaryMoltCtr.dispose();
    wingLeftPrimaryMoltCtr.dispose();
    wingRightSecondaryMoltCtr.dispose();
    wingLeftSecondaryMoltCtr.dispose();
    tailRightRectriceCtr.dispose();
    tailLeftRectriceCtr.dispose();
    moltRemarkCtr.dispose();
  }
}

class PartFormCtrModel {
  PartFormCtrModel({
    required this.tissueIdCtr,
    required this.barcodeIdCtr,
    required this.typeCtr,
    required this.countCtr,
    required this.treatmentCtr,
    required this.additionalTreatmentCtr,
    required this.dateTakenCtr,
    required this.timeTakenCtr,
    required this.museumPermanentCtr,
    required this.museumLoanCtr,
    required this.remarkCtr,
  });

  TextEditingController tissueIdCtr;
  TextEditingController barcodeIdCtr;
  TextEditingController typeCtr;
  TextEditingController countCtr;
  TextEditingController treatmentCtr;
  TextEditingController additionalTreatmentCtr;
  TextEditingController dateTakenCtr;
  TextEditingController timeTakenCtr;
  TextEditingController museumPermanentCtr;
  TextEditingController museumLoanCtr;
  TextEditingController remarkCtr = TextEditingController();

  factory PartFormCtrModel.empty() => PartFormCtrModel(
        tissueIdCtr: TextEditingController(),
        barcodeIdCtr: TextEditingController(),
        typeCtr: TextEditingController(),
        countCtr: TextEditingController(),
        treatmentCtr: TextEditingController(),
        additionalTreatmentCtr: TextEditingController(),
        dateTakenCtr: TextEditingController(),
        timeTakenCtr: TextEditingController(),
        museumPermanentCtr: TextEditingController(),
        museumLoanCtr: TextEditingController(),
        remarkCtr: TextEditingController(),
      );

  factory PartFormCtrModel.fromData(SpecimenPartData data) => PartFormCtrModel(
        tissueIdCtr: TextEditingController(text: data.tissueID ?? ''),
        barcodeIdCtr: TextEditingController(text: data.barcodeID ?? ''),
        typeCtr: TextEditingController(text: data.type ?? ''),
        countCtr: TextEditingController(text: data.count?.toString() ?? ''),
        treatmentCtr: TextEditingController(text: data.treatment ?? ''),
        additionalTreatmentCtr:
            TextEditingController(text: data.additionalTreatment ?? ''),
        dateTakenCtr: TextEditingController(text: data.dateTaken ?? ''),
        timeTakenCtr: TextEditingController(text: data.timeTaken ?? ''),
        museumPermanentCtr:
            TextEditingController(text: data.museumPermanent ?? ''),
        museumLoanCtr: TextEditingController(text: data.museumLoan ?? ''),
        remarkCtr: TextEditingController(text: data.remark ?? ''),
      );

  void dispose() {
    tissueIdCtr.dispose();
    barcodeIdCtr.dispose();
    typeCtr.dispose();
    countCtr.dispose();
    treatmentCtr.dispose();
    additionalTreatmentCtr.dispose();
    dateTakenCtr.dispose();
    timeTakenCtr.dispose();
    museumPermanentCtr.dispose();
    museumLoanCtr.dispose();
    remarkCtr.dispose();
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
  int? photoIdCtr;
  TextEditingController noteCtr;

  factory PersonnelFormCtrModel.empty() => PersonnelFormCtrModel(
      nameCtr: TextEditingController(),
      initialCtr: TextEditingController(),
      emailCtr: TextEditingController(),
      phoneCtr: TextEditingController(),
      affiliationCtr: TextEditingController(),
      roleCtr: null,
      nextCollectorNumCtr: TextEditingController(),
      photoIdCtr: null,
      noteCtr: TextEditingController());

  factory PersonnelFormCtrModel.fromData(PersonnelData personnel) =>
      PersonnelFormCtrModel(
        nameCtr: TextEditingController(text: personnel.name),
        initialCtr: TextEditingController(text: personnel.initial),
        emailCtr: TextEditingController(text: personnel.email),
        phoneCtr: TextEditingController(text: personnel.phone),
        affiliationCtr: TextEditingController(text: personnel.affiliation),
        roleCtr: personnel.role,
        nextCollectorNumCtr: TextEditingController(
            text: personnel.currentFieldNumber?.toString() ?? ''),
        photoIdCtr: personnel.photoID,
        noteCtr: TextEditingController(text: personnel.notes),
      );
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

class ExportCtrModel {
  ExportCtrModel({
    required this.formatCtr,
    required this.pathCtr,
    required this.fileNameCtr,
  });

  TextEditingController formatCtr;
  TextEditingController pathCtr;
  TextEditingController fileNameCtr;

  factory ExportCtrModel.empty() => ExportCtrModel(
      formatCtr: TextEditingController(),
      pathCtr: TextEditingController(),
      fileNameCtr: TextEditingController());

  void dispose() {
    formatCtr.dispose();
    pathCtr.dispose();
    fileNameCtr.dispose();
  }
}
