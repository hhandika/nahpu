// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ProjectData extends DataClass implements Insertable<ProjectData> {
  final String projectUuid;
  final String projectName;
  final String? projectDescription;
  final String? principalInvestigator;
  final String? collector;
  final String? collectorInitial;
  final String? collectorEmail;
  final int? catNumStart;
  final int? catNumEnd;
  ProjectData(
      {required this.projectUuid,
      required this.projectName,
      this.projectDescription,
      this.principalInvestigator,
      this.collector,
      this.collectorInitial,
      this.collectorEmail,
      this.catNumStart,
      this.catNumEnd});
  factory ProjectData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProjectData(
      projectUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectUuid'])!,
      projectName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectName'])!,
      projectDescription: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}projectDescription']),
      principalInvestigator: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}principalInvestigator']),
      collector: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}collector']),
      collectorInitial: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}collectorInitial']),
      collectorEmail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}collectorEmail']),
      catNumStart: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}catNumStart']),
      catNumEnd: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}catNumEnd']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['projectUuid'] = Variable<String>(projectUuid);
    map['projectName'] = Variable<String>(projectName);
    if (!nullToAbsent || projectDescription != null) {
      map['projectDescription'] = Variable<String?>(projectDescription);
    }
    if (!nullToAbsent || principalInvestigator != null) {
      map['principalInvestigator'] = Variable<String?>(principalInvestigator);
    }
    if (!nullToAbsent || collector != null) {
      map['collector'] = Variable<String?>(collector);
    }
    if (!nullToAbsent || collectorInitial != null) {
      map['collectorInitial'] = Variable<String?>(collectorInitial);
    }
    if (!nullToAbsent || collectorEmail != null) {
      map['collectorEmail'] = Variable<String?>(collectorEmail);
    }
    if (!nullToAbsent || catNumStart != null) {
      map['catNumStart'] = Variable<int?>(catNumStart);
    }
    if (!nullToAbsent || catNumEnd != null) {
      map['catNumEnd'] = Variable<int?>(catNumEnd);
    }
    return map;
  }

  ProjectCompanion toCompanion(bool nullToAbsent) {
    return ProjectCompanion(
      projectUuid: Value(projectUuid),
      projectName: Value(projectName),
      projectDescription: projectDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(projectDescription),
      principalInvestigator: principalInvestigator == null && nullToAbsent
          ? const Value.absent()
          : Value(principalInvestigator),
      collector: collector == null && nullToAbsent
          ? const Value.absent()
          : Value(collector),
      collectorInitial: collectorInitial == null && nullToAbsent
          ? const Value.absent()
          : Value(collectorInitial),
      collectorEmail: collectorEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(collectorEmail),
      catNumStart: catNumStart == null && nullToAbsent
          ? const Value.absent()
          : Value(catNumStart),
      catNumEnd: catNumEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(catNumEnd),
    );
  }

  factory ProjectData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectData(
      projectUuid: serializer.fromJson<String>(json['projectUuid']),
      projectName: serializer.fromJson<String>(json['projectName']),
      projectDescription:
          serializer.fromJson<String?>(json['projectDescription']),
      principalInvestigator:
          serializer.fromJson<String?>(json['principalInvestigator']),
      collector: serializer.fromJson<String?>(json['collector']),
      collectorInitial: serializer.fromJson<String?>(json['collectorInitial']),
      collectorEmail: serializer.fromJson<String?>(json['collectorEmail']),
      catNumStart: serializer.fromJson<int?>(json['catNumStart']),
      catNumEnd: serializer.fromJson<int?>(json['catNumEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'projectUuid': serializer.toJson<String>(projectUuid),
      'projectName': serializer.toJson<String>(projectName),
      'projectDescription': serializer.toJson<String?>(projectDescription),
      'principalInvestigator':
          serializer.toJson<String?>(principalInvestigator),
      'collector': serializer.toJson<String?>(collector),
      'collectorInitial': serializer.toJson<String?>(collectorInitial),
      'collectorEmail': serializer.toJson<String?>(collectorEmail),
      'catNumStart': serializer.toJson<int?>(catNumStart),
      'catNumEnd': serializer.toJson<int?>(catNumEnd),
    };
  }

  ProjectData copyWith(
          {String? projectUuid,
          String? projectName,
          String? projectDescription,
          String? principalInvestigator,
          String? collector,
          String? collectorInitial,
          String? collectorEmail,
          int? catNumStart,
          int? catNumEnd}) =>
      ProjectData(
        projectUuid: projectUuid ?? this.projectUuid,
        projectName: projectName ?? this.projectName,
        projectDescription: projectDescription ?? this.projectDescription,
        principalInvestigator:
            principalInvestigator ?? this.principalInvestigator,
        collector: collector ?? this.collector,
        collectorInitial: collectorInitial ?? this.collectorInitial,
        collectorEmail: collectorEmail ?? this.collectorEmail,
        catNumStart: catNumStart ?? this.catNumStart,
        catNumEnd: catNumEnd ?? this.catNumEnd,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectData(')
          ..write('projectUuid: $projectUuid, ')
          ..write('projectName: $projectName, ')
          ..write('projectDescription: $projectDescription, ')
          ..write('principalInvestigator: $principalInvestigator, ')
          ..write('collector: $collector, ')
          ..write('collectorInitial: $collectorInitial, ')
          ..write('collectorEmail: $collectorEmail, ')
          ..write('catNumStart: $catNumStart, ')
          ..write('catNumEnd: $catNumEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      projectUuid,
      projectName,
      projectDescription,
      principalInvestigator,
      collector,
      collectorInitial,
      collectorEmail,
      catNumStart,
      catNumEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectData &&
          other.projectUuid == this.projectUuid &&
          other.projectName == this.projectName &&
          other.projectDescription == this.projectDescription &&
          other.principalInvestigator == this.principalInvestigator &&
          other.collector == this.collector &&
          other.collectorInitial == this.collectorInitial &&
          other.collectorEmail == this.collectorEmail &&
          other.catNumStart == this.catNumStart &&
          other.catNumEnd == this.catNumEnd);
}

class ProjectCompanion extends UpdateCompanion<ProjectData> {
  final Value<String> projectUuid;
  final Value<String> projectName;
  final Value<String?> projectDescription;
  final Value<String?> principalInvestigator;
  final Value<String?> collector;
  final Value<String?> collectorInitial;
  final Value<String?> collectorEmail;
  final Value<int?> catNumStart;
  final Value<int?> catNumEnd;
  const ProjectCompanion({
    this.projectUuid = const Value.absent(),
    this.projectName = const Value.absent(),
    this.projectDescription = const Value.absent(),
    this.principalInvestigator = const Value.absent(),
    this.collector = const Value.absent(),
    this.collectorInitial = const Value.absent(),
    this.collectorEmail = const Value.absent(),
    this.catNumStart = const Value.absent(),
    this.catNumEnd = const Value.absent(),
  });
  ProjectCompanion.insert({
    required String projectUuid,
    required String projectName,
    this.projectDescription = const Value.absent(),
    this.principalInvestigator = const Value.absent(),
    this.collector = const Value.absent(),
    this.collectorInitial = const Value.absent(),
    this.collectorEmail = const Value.absent(),
    this.catNumStart = const Value.absent(),
    this.catNumEnd = const Value.absent(),
  })  : projectUuid = Value(projectUuid),
        projectName = Value(projectName);
  static Insertable<ProjectData> custom({
    Expression<String>? projectUuid,
    Expression<String>? projectName,
    Expression<String?>? projectDescription,
    Expression<String?>? principalInvestigator,
    Expression<String?>? collector,
    Expression<String?>? collectorInitial,
    Expression<String?>? collectorEmail,
    Expression<int?>? catNumStart,
    Expression<int?>? catNumEnd,
  }) {
    return RawValuesInsertable({
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (projectName != null) 'projectName': projectName,
      if (projectDescription != null) 'projectDescription': projectDescription,
      if (principalInvestigator != null)
        'principalInvestigator': principalInvestigator,
      if (collector != null) 'collector': collector,
      if (collectorInitial != null) 'collectorInitial': collectorInitial,
      if (collectorEmail != null) 'collectorEmail': collectorEmail,
      if (catNumStart != null) 'catNumStart': catNumStart,
      if (catNumEnd != null) 'catNumEnd': catNumEnd,
    });
  }

  ProjectCompanion copyWith(
      {Value<String>? projectUuid,
      Value<String>? projectName,
      Value<String?>? projectDescription,
      Value<String?>? principalInvestigator,
      Value<String?>? collector,
      Value<String?>? collectorInitial,
      Value<String?>? collectorEmail,
      Value<int?>? catNumStart,
      Value<int?>? catNumEnd}) {
    return ProjectCompanion(
      projectUuid: projectUuid ?? this.projectUuid,
      projectName: projectName ?? this.projectName,
      projectDescription: projectDescription ?? this.projectDescription,
      principalInvestigator:
          principalInvestigator ?? this.principalInvestigator,
      collector: collector ?? this.collector,
      collectorInitial: collectorInitial ?? this.collectorInitial,
      collectorEmail: collectorEmail ?? this.collectorEmail,
      catNumStart: catNumStart ?? this.catNumStart,
      catNumEnd: catNumEnd ?? this.catNumEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String>(projectUuid.value);
    }
    if (projectName.present) {
      map['projectName'] = Variable<String>(projectName.value);
    }
    if (projectDescription.present) {
      map['projectDescription'] = Variable<String?>(projectDescription.value);
    }
    if (principalInvestigator.present) {
      map['principalInvestigator'] =
          Variable<String?>(principalInvestigator.value);
    }
    if (collector.present) {
      map['collector'] = Variable<String?>(collector.value);
    }
    if (collectorInitial.present) {
      map['collectorInitial'] = Variable<String?>(collectorInitial.value);
    }
    if (collectorEmail.present) {
      map['collectorEmail'] = Variable<String?>(collectorEmail.value);
    }
    if (catNumStart.present) {
      map['catNumStart'] = Variable<int?>(catNumStart.value);
    }
    if (catNumEnd.present) {
      map['catNumEnd'] = Variable<int?>(catNumEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectCompanion(')
          ..write('projectUuid: $projectUuid, ')
          ..write('projectName: $projectName, ')
          ..write('projectDescription: $projectDescription, ')
          ..write('principalInvestigator: $principalInvestigator, ')
          ..write('collector: $collector, ')
          ..write('collectorInitial: $collectorInitial, ')
          ..write('collectorEmail: $collectorEmail, ')
          ..write('catNumStart: $catNumStart, ')
          ..write('catNumEnd: $catNumEnd')
          ..write(')'))
        .toString();
  }
}

class Project extends Table with TableInfo<Project, ProjectData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Project(this.attachedDatabase, [this._alias]);
  final VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String?> projectUuid = GeneratedColumn<String?>(
      'projectUuid', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  final VerificationMeta _projectNameMeta =
      const VerificationMeta('projectName');
  late final GeneratedColumn<String?> projectName = GeneratedColumn<String?>(
      'projectName', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  final VerificationMeta _projectDescriptionMeta =
      const VerificationMeta('projectDescription');
  late final GeneratedColumn<String?> projectDescription =
      GeneratedColumn<String?>('projectDescription', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _principalInvestigatorMeta =
      const VerificationMeta('principalInvestigator');
  late final GeneratedColumn<String?> principalInvestigator =
      GeneratedColumn<String?>('principalInvestigator', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _collectorMeta = const VerificationMeta('collector');
  late final GeneratedColumn<String?> collector = GeneratedColumn<String?>(
      'collector', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _collectorInitialMeta =
      const VerificationMeta('collectorInitial');
  late final GeneratedColumn<String?> collectorInitial =
      GeneratedColumn<String?>('collectorInitial', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _collectorEmailMeta =
      const VerificationMeta('collectorEmail');
  late final GeneratedColumn<String?> collectorEmail = GeneratedColumn<String?>(
      'collectorEmail', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _catNumStartMeta =
      const VerificationMeta('catNumStart');
  late final GeneratedColumn<int?> catNumStart = GeneratedColumn<int?>(
      'catNumStart', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _catNumEndMeta = const VerificationMeta('catNumEnd');
  late final GeneratedColumn<int?> catNumEnd = GeneratedColumn<int?>(
      'catNumEnd', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        projectUuid,
        projectName,
        projectDescription,
        principalInvestigator,
        collector,
        collectorInitial,
        collectorEmail,
        catNumStart,
        catNumEnd
      ];
  @override
  String get aliasedName => _alias ?? 'project';
  @override
  String get actualTableName => 'project';
  @override
  VerificationContext validateIntegrity(Insertable<ProjectData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('projectUuid')) {
      context.handle(
          _projectUuidMeta,
          projectUuid.isAcceptableOrUnknown(
              data['projectUuid']!, _projectUuidMeta));
    } else if (isInserting) {
      context.missing(_projectUuidMeta);
    }
    if (data.containsKey('projectName')) {
      context.handle(
          _projectNameMeta,
          projectName.isAcceptableOrUnknown(
              data['projectName']!, _projectNameMeta));
    } else if (isInserting) {
      context.missing(_projectNameMeta);
    }
    if (data.containsKey('projectDescription')) {
      context.handle(
          _projectDescriptionMeta,
          projectDescription.isAcceptableOrUnknown(
              data['projectDescription']!, _projectDescriptionMeta));
    }
    if (data.containsKey('principalInvestigator')) {
      context.handle(
          _principalInvestigatorMeta,
          principalInvestigator.isAcceptableOrUnknown(
              data['principalInvestigator']!, _principalInvestigatorMeta));
    }
    if (data.containsKey('collector')) {
      context.handle(_collectorMeta,
          collector.isAcceptableOrUnknown(data['collector']!, _collectorMeta));
    }
    if (data.containsKey('collectorInitial')) {
      context.handle(
          _collectorInitialMeta,
          collectorInitial.isAcceptableOrUnknown(
              data['collectorInitial']!, _collectorInitialMeta));
    }
    if (data.containsKey('collectorEmail')) {
      context.handle(
          _collectorEmailMeta,
          collectorEmail.isAcceptableOrUnknown(
              data['collectorEmail']!, _collectorEmailMeta));
    }
    if (data.containsKey('catNumStart')) {
      context.handle(
          _catNumStartMeta,
          catNumStart.isAcceptableOrUnknown(
              data['catNumStart']!, _catNumStartMeta));
    }
    if (data.containsKey('catNumEnd')) {
      context.handle(_catNumEndMeta,
          catNumEnd.isAcceptableOrUnknown(data['catNumEnd']!, _catNumEndMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {projectUuid};
  @override
  ProjectData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProjectData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Project createAlias(String alias) {
    return Project(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class SiteData extends DataClass implements Insertable<SiteData> {
  final String siteID;
  final String? projectUuid;
  final String? leadStuff;
  final String? type;
  final String? country;
  final String? state;
  final String? preciseLocality;
  final double? latitude;
  final double? longitude;
  final int? elevation;
  SiteData(
      {required this.siteID,
      this.projectUuid,
      this.leadStuff,
      this.type,
      this.country,
      this.state,
      this.preciseLocality,
      this.latitude,
      this.longitude,
      this.elevation});
  factory SiteData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SiteData(
      siteID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}siteID'])!,
      projectUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectUuid']),
      leadStuff: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}leadStuff']),
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']),
      country: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}country']),
      state: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}state']),
      preciseLocality: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}preciseLocality']),
      latitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude']),
      longitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude']),
      elevation: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}elevation']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['siteID'] = Variable<String>(siteID);
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String?>(projectUuid);
    }
    if (!nullToAbsent || leadStuff != null) {
      map['leadStuff'] = Variable<String?>(leadStuff);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String?>(type);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String?>(country);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String?>(state);
    }
    if (!nullToAbsent || preciseLocality != null) {
      map['preciseLocality'] = Variable<String?>(preciseLocality);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double?>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double?>(longitude);
    }
    if (!nullToAbsent || elevation != null) {
      map['elevation'] = Variable<int?>(elevation);
    }
    return map;
  }

  SiteCompanion toCompanion(bool nullToAbsent) {
    return SiteCompanion(
      siteID: Value(siteID),
      projectUuid: projectUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(projectUuid),
      leadStuff: leadStuff == null && nullToAbsent
          ? const Value.absent()
          : Value(leadStuff),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      state:
          state == null && nullToAbsent ? const Value.absent() : Value(state),
      preciseLocality: preciseLocality == null && nullToAbsent
          ? const Value.absent()
          : Value(preciseLocality),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      elevation: elevation == null && nullToAbsent
          ? const Value.absent()
          : Value(elevation),
    );
  }

  factory SiteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SiteData(
      siteID: serializer.fromJson<String>(json['siteID']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      leadStuff: serializer.fromJson<String?>(json['leadStuff']),
      type: serializer.fromJson<String?>(json['type']),
      country: serializer.fromJson<String?>(json['country']),
      state: serializer.fromJson<String?>(json['state']),
      preciseLocality: serializer.fromJson<String?>(json['preciseLocality']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      elevation: serializer.fromJson<int?>(json['elevation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'siteID': serializer.toJson<String>(siteID),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'leadStuff': serializer.toJson<String?>(leadStuff),
      'type': serializer.toJson<String?>(type),
      'country': serializer.toJson<String?>(country),
      'state': serializer.toJson<String?>(state),
      'preciseLocality': serializer.toJson<String?>(preciseLocality),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'elevation': serializer.toJson<int?>(elevation),
    };
  }

  SiteData copyWith(
          {String? siteID,
          String? projectUuid,
          String? leadStuff,
          String? type,
          String? country,
          String? state,
          String? preciseLocality,
          double? latitude,
          double? longitude,
          int? elevation}) =>
      SiteData(
        siteID: siteID ?? this.siteID,
        projectUuid: projectUuid ?? this.projectUuid,
        leadStuff: leadStuff ?? this.leadStuff,
        type: type ?? this.type,
        country: country ?? this.country,
        state: state ?? this.state,
        preciseLocality: preciseLocality ?? this.preciseLocality,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        elevation: elevation ?? this.elevation,
      );
  @override
  String toString() {
    return (StringBuffer('SiteData(')
          ..write('siteID: $siteID, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('leadStuff: $leadStuff, ')
          ..write('type: $type, ')
          ..write('country: $country, ')
          ..write('state: $state, ')
          ..write('preciseLocality: $preciseLocality, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('elevation: $elevation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(siteID, projectUuid, leadStuff, type, country,
      state, preciseLocality, latitude, longitude, elevation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SiteData &&
          other.siteID == this.siteID &&
          other.projectUuid == this.projectUuid &&
          other.leadStuff == this.leadStuff &&
          other.type == this.type &&
          other.country == this.country &&
          other.state == this.state &&
          other.preciseLocality == this.preciseLocality &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.elevation == this.elevation);
}

class SiteCompanion extends UpdateCompanion<SiteData> {
  final Value<String> siteID;
  final Value<String?> projectUuid;
  final Value<String?> leadStuff;
  final Value<String?> type;
  final Value<String?> country;
  final Value<String?> state;
  final Value<String?> preciseLocality;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<int?> elevation;
  const SiteCompanion({
    this.siteID = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.leadStuff = const Value.absent(),
    this.type = const Value.absent(),
    this.country = const Value.absent(),
    this.state = const Value.absent(),
    this.preciseLocality = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.elevation = const Value.absent(),
  });
  SiteCompanion.insert({
    required String siteID,
    this.projectUuid = const Value.absent(),
    this.leadStuff = const Value.absent(),
    this.type = const Value.absent(),
    this.country = const Value.absent(),
    this.state = const Value.absent(),
    this.preciseLocality = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.elevation = const Value.absent(),
  }) : siteID = Value(siteID);
  static Insertable<SiteData> custom({
    Expression<String>? siteID,
    Expression<String?>? projectUuid,
    Expression<String?>? leadStuff,
    Expression<String?>? type,
    Expression<String?>? country,
    Expression<String?>? state,
    Expression<String?>? preciseLocality,
    Expression<double?>? latitude,
    Expression<double?>? longitude,
    Expression<int?>? elevation,
  }) {
    return RawValuesInsertable({
      if (siteID != null) 'siteID': siteID,
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (leadStuff != null) 'leadStuff': leadStuff,
      if (type != null) 'type': type,
      if (country != null) 'country': country,
      if (state != null) 'state': state,
      if (preciseLocality != null) 'preciseLocality': preciseLocality,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (elevation != null) 'elevation': elevation,
    });
  }

  SiteCompanion copyWith(
      {Value<String>? siteID,
      Value<String?>? projectUuid,
      Value<String?>? leadStuff,
      Value<String?>? type,
      Value<String?>? country,
      Value<String?>? state,
      Value<String?>? preciseLocality,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<int?>? elevation}) {
    return SiteCompanion(
      siteID: siteID ?? this.siteID,
      projectUuid: projectUuid ?? this.projectUuid,
      leadStuff: leadStuff ?? this.leadStuff,
      type: type ?? this.type,
      country: country ?? this.country,
      state: state ?? this.state,
      preciseLocality: preciseLocality ?? this.preciseLocality,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      elevation: elevation ?? this.elevation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (siteID.present) {
      map['siteID'] = Variable<String>(siteID.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String?>(projectUuid.value);
    }
    if (leadStuff.present) {
      map['leadStuff'] = Variable<String?>(leadStuff.value);
    }
    if (type.present) {
      map['type'] = Variable<String?>(type.value);
    }
    if (country.present) {
      map['country'] = Variable<String?>(country.value);
    }
    if (state.present) {
      map['state'] = Variable<String?>(state.value);
    }
    if (preciseLocality.present) {
      map['preciseLocality'] = Variable<String?>(preciseLocality.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double?>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double?>(longitude.value);
    }
    if (elevation.present) {
      map['elevation'] = Variable<int?>(elevation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SiteCompanion(')
          ..write('siteID: $siteID, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('leadStuff: $leadStuff, ')
          ..write('type: $type, ')
          ..write('country: $country, ')
          ..write('state: $state, ')
          ..write('preciseLocality: $preciseLocality, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('elevation: $elevation')
          ..write(')'))
        .toString();
  }
}

class Site extends Table with TableInfo<Site, SiteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Site(this.attachedDatabase, [this._alias]);
  final VerificationMeta _siteIDMeta = const VerificationMeta('siteID');
  late final GeneratedColumn<String?> siteID = GeneratedColumn<String?>(
      'siteID', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  final VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String?> projectUuid = GeneratedColumn<String?>(
      'projectUuid', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _leadStuffMeta = const VerificationMeta('leadStuff');
  late final GeneratedColumn<String?> leadStuff = GeneratedColumn<String?>(
      'leadStuff', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _countryMeta = const VerificationMeta('country');
  late final GeneratedColumn<String?> country = GeneratedColumn<String?>(
      'country', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _stateMeta = const VerificationMeta('state');
  late final GeneratedColumn<String?> state = GeneratedColumn<String?>(
      'state', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _preciseLocalityMeta =
      const VerificationMeta('preciseLocality');
  late final GeneratedColumn<String?> preciseLocality =
      GeneratedColumn<String?>('preciseLocality', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  late final GeneratedColumn<double?> latitude = GeneratedColumn<double?>(
      'latitude', aliasedName, true,
      type: const RealType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  late final GeneratedColumn<double?> longitude = GeneratedColumn<double?>(
      'longitude', aliasedName, true,
      type: const RealType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _elevationMeta = const VerificationMeta('elevation');
  late final GeneratedColumn<int?> elevation = GeneratedColumn<int?>(
      'elevation', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        siteID,
        projectUuid,
        leadStuff,
        type,
        country,
        state,
        preciseLocality,
        latitude,
        longitude,
        elevation
      ];
  @override
  String get aliasedName => _alias ?? 'site';
  @override
  String get actualTableName => 'site';
  @override
  VerificationContext validateIntegrity(Insertable<SiteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('siteID')) {
      context.handle(_siteIDMeta,
          siteID.isAcceptableOrUnknown(data['siteID']!, _siteIDMeta));
    } else if (isInserting) {
      context.missing(_siteIDMeta);
    }
    if (data.containsKey('projectUuid')) {
      context.handle(
          _projectUuidMeta,
          projectUuid.isAcceptableOrUnknown(
              data['projectUuid']!, _projectUuidMeta));
    }
    if (data.containsKey('leadStuff')) {
      context.handle(_leadStuffMeta,
          leadStuff.isAcceptableOrUnknown(data['leadStuff']!, _leadStuffMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    }
    if (data.containsKey('preciseLocality')) {
      context.handle(
          _preciseLocalityMeta,
          preciseLocality.isAcceptableOrUnknown(
              data['preciseLocality']!, _preciseLocalityMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('elevation')) {
      context.handle(_elevationMeta,
          elevation.isAcceptableOrUnknown(data['elevation']!, _elevationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {siteID};
  @override
  SiteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SiteData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Site createAlias(String alias) {
    return Site(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final Project project = Project(this);
  late final Site site = Site(this);
  Selectable<ListProjectResult> listProject() {
    return customSelect('SELECT projectUuid,projectName FROM project',
        variables: [],
        readsFrom: {
          project,
        }).map((QueryRow row) {
      return ListProjectResult(
        projectUuid: row.read<String>('projectUuid'),
        projectName: row.read<String>('projectName'),
      );
    });
  }

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [project, site];
}

class ListProjectResult {
  final String projectUuid;
  final String projectName;
  ListProjectResult({
    required this.projectUuid,
    required this.projectName,
  });
}
