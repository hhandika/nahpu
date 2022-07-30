// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ProjectData extends DataClass implements Insertable<ProjectData> {
  final String projectId;
  final String? projectName;
  final String? projectDescription;
  final String? collector;
  final String? collectorEmail;
  final int? catNumStart;
  final int? catNumEnd;
  final String? teamLeader;
  ProjectData(
      {required this.projectId,
      this.projectName,
      this.projectDescription,
      this.collector,
      this.collectorEmail,
      this.catNumStart,
      this.catNumEnd,
      this.teamLeader});
  factory ProjectData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProjectData(
      projectId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectId'])!,
      projectName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectName']),
      projectDescription: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}projectDescription']),
      collector: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}collector']),
      collectorEmail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}collectorEmail']),
      catNumStart: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}catNumStart']),
      catNumEnd: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}catNumEnd']),
      teamLeader: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}teamLeader']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['projectId'] = Variable<String>(projectId);
    if (!nullToAbsent || projectName != null) {
      map['projectName'] = Variable<String?>(projectName);
    }
    if (!nullToAbsent || projectDescription != null) {
      map['projectDescription'] = Variable<String?>(projectDescription);
    }
    if (!nullToAbsent || collector != null) {
      map['collector'] = Variable<String?>(collector);
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
    if (!nullToAbsent || teamLeader != null) {
      map['teamLeader'] = Variable<String?>(teamLeader);
    }
    return map;
  }

  ProjectCompanion toCompanion(bool nullToAbsent) {
    return ProjectCompanion(
      projectId: Value(projectId),
      projectName: projectName == null && nullToAbsent
          ? const Value.absent()
          : Value(projectName),
      projectDescription: projectDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(projectDescription),
      collector: collector == null && nullToAbsent
          ? const Value.absent()
          : Value(collector),
      collectorEmail: collectorEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(collectorEmail),
      catNumStart: catNumStart == null && nullToAbsent
          ? const Value.absent()
          : Value(catNumStart),
      catNumEnd: catNumEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(catNumEnd),
      teamLeader: teamLeader == null && nullToAbsent
          ? const Value.absent()
          : Value(teamLeader),
    );
  }

  factory ProjectData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectData(
      projectId: serializer.fromJson<String>(json['projectId']),
      projectName: serializer.fromJson<String?>(json['projectName']),
      projectDescription:
          serializer.fromJson<String?>(json['projectDescription']),
      collector: serializer.fromJson<String?>(json['collector']),
      collectorEmail: serializer.fromJson<String?>(json['collectorEmail']),
      catNumStart: serializer.fromJson<int?>(json['catNumStart']),
      catNumEnd: serializer.fromJson<int?>(json['catNumEnd']),
      teamLeader: serializer.fromJson<String?>(json['teamLeader']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'projectId': serializer.toJson<String>(projectId),
      'projectName': serializer.toJson<String?>(projectName),
      'projectDescription': serializer.toJson<String?>(projectDescription),
      'collector': serializer.toJson<String?>(collector),
      'collectorEmail': serializer.toJson<String?>(collectorEmail),
      'catNumStart': serializer.toJson<int?>(catNumStart),
      'catNumEnd': serializer.toJson<int?>(catNumEnd),
      'teamLeader': serializer.toJson<String?>(teamLeader),
    };
  }

  ProjectData copyWith(
          {String? projectId,
          String? projectName,
          String? projectDescription,
          String? collector,
          String? collectorEmail,
          int? catNumStart,
          int? catNumEnd,
          String? teamLeader}) =>
      ProjectData(
        projectId: projectId ?? this.projectId,
        projectName: projectName ?? this.projectName,
        projectDescription: projectDescription ?? this.projectDescription,
        collector: collector ?? this.collector,
        collectorEmail: collectorEmail ?? this.collectorEmail,
        catNumStart: catNumStart ?? this.catNumStart,
        catNumEnd: catNumEnd ?? this.catNumEnd,
        teamLeader: teamLeader ?? this.teamLeader,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectData(')
          ..write('projectId: $projectId, ')
          ..write('projectName: $projectName, ')
          ..write('projectDescription: $projectDescription, ')
          ..write('collector: $collector, ')
          ..write('collectorEmail: $collectorEmail, ')
          ..write('catNumStart: $catNumStart, ')
          ..write('catNumEnd: $catNumEnd, ')
          ..write('teamLeader: $teamLeader')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(projectId, projectName, projectDescription,
      collector, collectorEmail, catNumStart, catNumEnd, teamLeader);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectData &&
          other.projectId == this.projectId &&
          other.projectName == this.projectName &&
          other.projectDescription == this.projectDescription &&
          other.collector == this.collector &&
          other.collectorEmail == this.collectorEmail &&
          other.catNumStart == this.catNumStart &&
          other.catNumEnd == this.catNumEnd &&
          other.teamLeader == this.teamLeader);
}

class ProjectCompanion extends UpdateCompanion<ProjectData> {
  final Value<String> projectId;
  final Value<String?> projectName;
  final Value<String?> projectDescription;
  final Value<String?> collector;
  final Value<String?> collectorEmail;
  final Value<int?> catNumStart;
  final Value<int?> catNumEnd;
  final Value<String?> teamLeader;
  const ProjectCompanion({
    this.projectId = const Value.absent(),
    this.projectName = const Value.absent(),
    this.projectDescription = const Value.absent(),
    this.collector = const Value.absent(),
    this.collectorEmail = const Value.absent(),
    this.catNumStart = const Value.absent(),
    this.catNumEnd = const Value.absent(),
    this.teamLeader = const Value.absent(),
  });
  ProjectCompanion.insert({
    required String projectId,
    this.projectName = const Value.absent(),
    this.projectDescription = const Value.absent(),
    this.collector = const Value.absent(),
    this.collectorEmail = const Value.absent(),
    this.catNumStart = const Value.absent(),
    this.catNumEnd = const Value.absent(),
    this.teamLeader = const Value.absent(),
  }) : projectId = Value(projectId);
  static Insertable<ProjectData> custom({
    Expression<String>? projectId,
    Expression<String?>? projectName,
    Expression<String?>? projectDescription,
    Expression<String?>? collector,
    Expression<String?>? collectorEmail,
    Expression<int?>? catNumStart,
    Expression<int?>? catNumEnd,
    Expression<String?>? teamLeader,
  }) {
    return RawValuesInsertable({
      if (projectId != null) 'projectId': projectId,
      if (projectName != null) 'projectName': projectName,
      if (projectDescription != null) 'projectDescription': projectDescription,
      if (collector != null) 'collector': collector,
      if (collectorEmail != null) 'collectorEmail': collectorEmail,
      if (catNumStart != null) 'catNumStart': catNumStart,
      if (catNumEnd != null) 'catNumEnd': catNumEnd,
      if (teamLeader != null) 'teamLeader': teamLeader,
    });
  }

  ProjectCompanion copyWith(
      {Value<String>? projectId,
      Value<String?>? projectName,
      Value<String?>? projectDescription,
      Value<String?>? collector,
      Value<String?>? collectorEmail,
      Value<int?>? catNumStart,
      Value<int?>? catNumEnd,
      Value<String?>? teamLeader}) {
    return ProjectCompanion(
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      projectDescription: projectDescription ?? this.projectDescription,
      collector: collector ?? this.collector,
      collectorEmail: collectorEmail ?? this.collectorEmail,
      catNumStart: catNumStart ?? this.catNumStart,
      catNumEnd: catNumEnd ?? this.catNumEnd,
      teamLeader: teamLeader ?? this.teamLeader,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (projectId.present) {
      map['projectId'] = Variable<String>(projectId.value);
    }
    if (projectName.present) {
      map['projectName'] = Variable<String?>(projectName.value);
    }
    if (projectDescription.present) {
      map['projectDescription'] = Variable<String?>(projectDescription.value);
    }
    if (collector.present) {
      map['collector'] = Variable<String?>(collector.value);
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
    if (teamLeader.present) {
      map['teamLeader'] = Variable<String?>(teamLeader.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectCompanion(')
          ..write('projectId: $projectId, ')
          ..write('projectName: $projectName, ')
          ..write('projectDescription: $projectDescription, ')
          ..write('collector: $collector, ')
          ..write('collectorEmail: $collectorEmail, ')
          ..write('catNumStart: $catNumStart, ')
          ..write('catNumEnd: $catNumEnd, ')
          ..write('teamLeader: $teamLeader')
          ..write(')'))
        .toString();
  }
}

class Project extends Table with TableInfo<Project, ProjectData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Project(this.attachedDatabase, [this._alias]);
  final VerificationMeta _projectIdMeta = const VerificationMeta('projectId');
  late final GeneratedColumn<String?> projectId = GeneratedColumn<String?>(
      'projectId', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  final VerificationMeta _projectNameMeta =
      const VerificationMeta('projectName');
  late final GeneratedColumn<String?> projectName = GeneratedColumn<String?>(
      'projectName', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _projectDescriptionMeta =
      const VerificationMeta('projectDescription');
  late final GeneratedColumn<String?> projectDescription =
      GeneratedColumn<String?>('projectDescription', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _collectorMeta = const VerificationMeta('collector');
  late final GeneratedColumn<String?> collector = GeneratedColumn<String?>(
      'collector', aliasedName, true,
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
  final VerificationMeta _teamLeaderMeta = const VerificationMeta('teamLeader');
  late final GeneratedColumn<String?> teamLeader = GeneratedColumn<String?>(
      'teamLeader', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        projectId,
        projectName,
        projectDescription,
        collector,
        collectorEmail,
        catNumStart,
        catNumEnd,
        teamLeader
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
    if (data.containsKey('projectId')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['projectId']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('projectName')) {
      context.handle(
          _projectNameMeta,
          projectName.isAcceptableOrUnknown(
              data['projectName']!, _projectNameMeta));
    }
    if (data.containsKey('projectDescription')) {
      context.handle(
          _projectDescriptionMeta,
          projectDescription.isAcceptableOrUnknown(
              data['projectDescription']!, _projectDescriptionMeta));
    }
    if (data.containsKey('collector')) {
      context.handle(_collectorMeta,
          collector.isAcceptableOrUnknown(data['collector']!, _collectorMeta));
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
    if (data.containsKey('teamLeader')) {
      context.handle(
          _teamLeaderMeta,
          teamLeader.isAcceptableOrUnknown(
              data['teamLeader']!, _teamLeaderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {projectId};
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
  final String? projectID;
  final String? leadStuff;
  final String? type;
  final String? country;
  final String? state;
  final String? preciseLocality;
  SiteData(
      {required this.siteID,
      this.projectID,
      this.leadStuff,
      this.type,
      this.country,
      this.state,
      this.preciseLocality});
  factory SiteData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SiteData(
      siteID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}siteID'])!,
      projectID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectID']),
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
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['siteID'] = Variable<String>(siteID);
    if (!nullToAbsent || projectID != null) {
      map['projectID'] = Variable<String?>(projectID);
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
    return map;
  }

  SiteCompanion toCompanion(bool nullToAbsent) {
    return SiteCompanion(
      siteID: Value(siteID),
      projectID: projectID == null && nullToAbsent
          ? const Value.absent()
          : Value(projectID),
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
    );
  }

  factory SiteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SiteData(
      siteID: serializer.fromJson<String>(json['siteID']),
      projectID: serializer.fromJson<String?>(json['projectID']),
      leadStuff: serializer.fromJson<String?>(json['leadStuff']),
      type: serializer.fromJson<String?>(json['type']),
      country: serializer.fromJson<String?>(json['country']),
      state: serializer.fromJson<String?>(json['state']),
      preciseLocality: serializer.fromJson<String?>(json['preciseLocality']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'siteID': serializer.toJson<String>(siteID),
      'projectID': serializer.toJson<String?>(projectID),
      'leadStuff': serializer.toJson<String?>(leadStuff),
      'type': serializer.toJson<String?>(type),
      'country': serializer.toJson<String?>(country),
      'state': serializer.toJson<String?>(state),
      'preciseLocality': serializer.toJson<String?>(preciseLocality),
    };
  }

  SiteData copyWith(
          {String? siteID,
          String? projectID,
          String? leadStuff,
          String? type,
          String? country,
          String? state,
          String? preciseLocality}) =>
      SiteData(
        siteID: siteID ?? this.siteID,
        projectID: projectID ?? this.projectID,
        leadStuff: leadStuff ?? this.leadStuff,
        type: type ?? this.type,
        country: country ?? this.country,
        state: state ?? this.state,
        preciseLocality: preciseLocality ?? this.preciseLocality,
      );
  @override
  String toString() {
    return (StringBuffer('SiteData(')
          ..write('siteID: $siteID, ')
          ..write('projectID: $projectID, ')
          ..write('leadStuff: $leadStuff, ')
          ..write('type: $type, ')
          ..write('country: $country, ')
          ..write('state: $state, ')
          ..write('preciseLocality: $preciseLocality')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      siteID, projectID, leadStuff, type, country, state, preciseLocality);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SiteData &&
          other.siteID == this.siteID &&
          other.projectID == this.projectID &&
          other.leadStuff == this.leadStuff &&
          other.type == this.type &&
          other.country == this.country &&
          other.state == this.state &&
          other.preciseLocality == this.preciseLocality);
}

class SiteCompanion extends UpdateCompanion<SiteData> {
  final Value<String> siteID;
  final Value<String?> projectID;
  final Value<String?> leadStuff;
  final Value<String?> type;
  final Value<String?> country;
  final Value<String?> state;
  final Value<String?> preciseLocality;
  const SiteCompanion({
    this.siteID = const Value.absent(),
    this.projectID = const Value.absent(),
    this.leadStuff = const Value.absent(),
    this.type = const Value.absent(),
    this.country = const Value.absent(),
    this.state = const Value.absent(),
    this.preciseLocality = const Value.absent(),
  });
  SiteCompanion.insert({
    required String siteID,
    this.projectID = const Value.absent(),
    this.leadStuff = const Value.absent(),
    this.type = const Value.absent(),
    this.country = const Value.absent(),
    this.state = const Value.absent(),
    this.preciseLocality = const Value.absent(),
  }) : siteID = Value(siteID);
  static Insertable<SiteData> custom({
    Expression<String>? siteID,
    Expression<String?>? projectID,
    Expression<String?>? leadStuff,
    Expression<String?>? type,
    Expression<String?>? country,
    Expression<String?>? state,
    Expression<String?>? preciseLocality,
  }) {
    return RawValuesInsertable({
      if (siteID != null) 'siteID': siteID,
      if (projectID != null) 'projectID': projectID,
      if (leadStuff != null) 'leadStuff': leadStuff,
      if (type != null) 'type': type,
      if (country != null) 'country': country,
      if (state != null) 'state': state,
      if (preciseLocality != null) 'preciseLocality': preciseLocality,
    });
  }

  SiteCompanion copyWith(
      {Value<String>? siteID,
      Value<String?>? projectID,
      Value<String?>? leadStuff,
      Value<String?>? type,
      Value<String?>? country,
      Value<String?>? state,
      Value<String?>? preciseLocality}) {
    return SiteCompanion(
      siteID: siteID ?? this.siteID,
      projectID: projectID ?? this.projectID,
      leadStuff: leadStuff ?? this.leadStuff,
      type: type ?? this.type,
      country: country ?? this.country,
      state: state ?? this.state,
      preciseLocality: preciseLocality ?? this.preciseLocality,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (siteID.present) {
      map['siteID'] = Variable<String>(siteID.value);
    }
    if (projectID.present) {
      map['projectID'] = Variable<String?>(projectID.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SiteCompanion(')
          ..write('siteID: $siteID, ')
          ..write('projectID: $projectID, ')
          ..write('leadStuff: $leadStuff, ')
          ..write('type: $type, ')
          ..write('country: $country, ')
          ..write('state: $state, ')
          ..write('preciseLocality: $preciseLocality')
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
  final VerificationMeta _projectIDMeta = const VerificationMeta('projectID');
  late final GeneratedColumn<String?> projectID = GeneratedColumn<String?>(
      'projectID', aliasedName, true,
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
  @override
  List<GeneratedColumn> get $columns =>
      [siteID, projectID, leadStuff, type, country, state, preciseLocality];
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
    if (data.containsKey('projectID')) {
      context.handle(_projectIDMeta,
          projectID.isAcceptableOrUnknown(data['projectID']!, _projectIDMeta));
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
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [project, site];
}
