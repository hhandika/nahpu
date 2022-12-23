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
  final String? dateCreated;
  final String? dateLastModified;
  ProjectData(
      {required this.projectUuid,
      required this.projectName,
      this.projectDescription,
      this.principalInvestigator,
      this.collector,
      this.collectorInitial,
      this.collectorEmail,
      this.catNumStart,
      this.dateCreated,
      this.dateLastModified});
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
      dateCreated: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dateCreated']),
      dateLastModified: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dateLastModified']),
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
    if (!nullToAbsent || dateCreated != null) {
      map['dateCreated'] = Variable<String?>(dateCreated);
    }
    if (!nullToAbsent || dateLastModified != null) {
      map['dateLastModified'] = Variable<String?>(dateLastModified);
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
      dateCreated: dateCreated == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreated),
      dateLastModified: dateLastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(dateLastModified),
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
      dateCreated: serializer.fromJson<String?>(json['dateCreated']),
      dateLastModified: serializer.fromJson<String?>(json['dateLastModified']),
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
      'dateCreated': serializer.toJson<String?>(dateCreated),
      'dateLastModified': serializer.toJson<String?>(dateLastModified),
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
          String? dateCreated,
          String? dateLastModified}) =>
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
        dateCreated: dateCreated ?? this.dateCreated,
        dateLastModified: dateLastModified ?? this.dateLastModified,
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
          ..write('dateCreated: $dateCreated, ')
          ..write('dateLastModified: $dateLastModified')
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
      dateCreated,
      dateLastModified);
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
          other.dateCreated == this.dateCreated &&
          other.dateLastModified == this.dateLastModified);
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
  final Value<String?> dateCreated;
  final Value<String?> dateLastModified;
  const ProjectCompanion({
    this.projectUuid = const Value.absent(),
    this.projectName = const Value.absent(),
    this.projectDescription = const Value.absent(),
    this.principalInvestigator = const Value.absent(),
    this.collector = const Value.absent(),
    this.collectorInitial = const Value.absent(),
    this.collectorEmail = const Value.absent(),
    this.catNumStart = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.dateLastModified = const Value.absent(),
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
    this.dateCreated = const Value.absent(),
    this.dateLastModified = const Value.absent(),
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
    Expression<String?>? dateCreated,
    Expression<String?>? dateLastModified,
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
      if (dateCreated != null) 'dateCreated': dateCreated,
      if (dateLastModified != null) 'dateLastModified': dateLastModified,
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
      Value<String?>? dateCreated,
      Value<String?>? dateLastModified}) {
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
      dateCreated: dateCreated ?? this.dateCreated,
      dateLastModified: dateLastModified ?? this.dateLastModified,
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
    if (dateCreated.present) {
      map['dateCreated'] = Variable<String?>(dateCreated.value);
    }
    if (dateLastModified.present) {
      map['dateLastModified'] = Variable<String?>(dateLastModified.value);
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
          ..write('dateCreated: $dateCreated, ')
          ..write('dateLastModified: $dateLastModified')
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
  final VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  late final GeneratedColumn<String?> dateCreated = GeneratedColumn<String?>(
      'dateCreated', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _dateLastModifiedMeta =
      const VerificationMeta('dateLastModified');
  late final GeneratedColumn<String?> dateLastModified =
      GeneratedColumn<String?>('dateLastModified', aliasedName, true,
          type: const StringType(),
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
        dateCreated,
        dateLastModified
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
    if (data.containsKey('dateCreated')) {
      context.handle(
          _dateCreatedMeta,
          dateCreated.isAcceptableOrUnknown(
              data['dateCreated']!, _dateCreatedMeta));
    }
    if (data.containsKey('dateLastModified')) {
      context.handle(
          _dateLastModifiedMeta,
          dateLastModified.isAcceptableOrUnknown(
              data['dateLastModified']!, _dateLastModifiedMeta));
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

class PersonnelData extends DataClass implements Insertable<PersonnelData> {
  final String? id;
  final String? name;
  final String? initial;
  final String? affiliation;
  final String? role;
  final int? lastCollectorNumber;
  final String? photoFileName;
  PersonnelData(
      {this.id,
      this.name,
      this.initial,
      this.affiliation,
      this.role,
      this.lastCollectorNumber,
      this.photoFileName});
  factory PersonnelData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PersonnelData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      initial: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}initial']),
      affiliation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}affiliation']),
      role: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}role']),
      lastCollectorNumber: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}lastCollectorNumber']),
      photoFileName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}photoFileName']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String?>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || initial != null) {
      map['initial'] = Variable<String?>(initial);
    }
    if (!nullToAbsent || affiliation != null) {
      map['affiliation'] = Variable<String?>(affiliation);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String?>(role);
    }
    if (!nullToAbsent || lastCollectorNumber != null) {
      map['lastCollectorNumber'] = Variable<int?>(lastCollectorNumber);
    }
    if (!nullToAbsent || photoFileName != null) {
      map['photoFileName'] = Variable<String?>(photoFileName);
    }
    return map;
  }

  PersonnelCompanion toCompanion(bool nullToAbsent) {
    return PersonnelCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      initial: initial == null && nullToAbsent
          ? const Value.absent()
          : Value(initial),
      affiliation: affiliation == null && nullToAbsent
          ? const Value.absent()
          : Value(affiliation),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      lastCollectorNumber: lastCollectorNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCollectorNumber),
      photoFileName: photoFileName == null && nullToAbsent
          ? const Value.absent()
          : Value(photoFileName),
    );
  }

  factory PersonnelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonnelData(
      id: serializer.fromJson<String?>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      initial: serializer.fromJson<String?>(json['initial']),
      affiliation: serializer.fromJson<String?>(json['affiliation']),
      role: serializer.fromJson<String?>(json['role']),
      lastCollectorNumber:
          serializer.fromJson<int?>(json['lastCollectorNumber']),
      photoFileName: serializer.fromJson<String?>(json['photoFileName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'name': serializer.toJson<String?>(name),
      'initial': serializer.toJson<String?>(initial),
      'affiliation': serializer.toJson<String?>(affiliation),
      'role': serializer.toJson<String?>(role),
      'lastCollectorNumber': serializer.toJson<int?>(lastCollectorNumber),
      'photoFileName': serializer.toJson<String?>(photoFileName),
    };
  }

  PersonnelData copyWith(
          {String? id,
          String? name,
          String? initial,
          String? affiliation,
          String? role,
          int? lastCollectorNumber,
          String? photoFileName}) =>
      PersonnelData(
        id: id ?? this.id,
        name: name ?? this.name,
        initial: initial ?? this.initial,
        affiliation: affiliation ?? this.affiliation,
        role: role ?? this.role,
        lastCollectorNumber: lastCollectorNumber ?? this.lastCollectorNumber,
        photoFileName: photoFileName ?? this.photoFileName,
      );
  @override
  String toString() {
    return (StringBuffer('PersonnelData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('initial: $initial, ')
          ..write('affiliation: $affiliation, ')
          ..write('role: $role, ')
          ..write('lastCollectorNumber: $lastCollectorNumber, ')
          ..write('photoFileName: $photoFileName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, initial, affiliation, role, lastCollectorNumber, photoFileName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonnelData &&
          other.id == this.id &&
          other.name == this.name &&
          other.initial == this.initial &&
          other.affiliation == this.affiliation &&
          other.role == this.role &&
          other.lastCollectorNumber == this.lastCollectorNumber &&
          other.photoFileName == this.photoFileName);
}

class PersonnelCompanion extends UpdateCompanion<PersonnelData> {
  final Value<String?> id;
  final Value<String?> name;
  final Value<String?> initial;
  final Value<String?> affiliation;
  final Value<String?> role;
  final Value<int?> lastCollectorNumber;
  final Value<String?> photoFileName;
  const PersonnelCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.initial = const Value.absent(),
    this.affiliation = const Value.absent(),
    this.role = const Value.absent(),
    this.lastCollectorNumber = const Value.absent(),
    this.photoFileName = const Value.absent(),
  });
  PersonnelCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.initial = const Value.absent(),
    this.affiliation = const Value.absent(),
    this.role = const Value.absent(),
    this.lastCollectorNumber = const Value.absent(),
    this.photoFileName = const Value.absent(),
  });
  static Insertable<PersonnelData> custom({
    Expression<String?>? id,
    Expression<String?>? name,
    Expression<String?>? initial,
    Expression<String?>? affiliation,
    Expression<String?>? role,
    Expression<int?>? lastCollectorNumber,
    Expression<String?>? photoFileName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (initial != null) 'initial': initial,
      if (affiliation != null) 'affiliation': affiliation,
      if (role != null) 'role': role,
      if (lastCollectorNumber != null)
        'lastCollectorNumber': lastCollectorNumber,
      if (photoFileName != null) 'photoFileName': photoFileName,
    });
  }

  PersonnelCompanion copyWith(
      {Value<String?>? id,
      Value<String?>? name,
      Value<String?>? initial,
      Value<String?>? affiliation,
      Value<String?>? role,
      Value<int?>? lastCollectorNumber,
      Value<String?>? photoFileName}) {
    return PersonnelCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      initial: initial ?? this.initial,
      affiliation: affiliation ?? this.affiliation,
      role: role ?? this.role,
      lastCollectorNumber: lastCollectorNumber ?? this.lastCollectorNumber,
      photoFileName: photoFileName ?? this.photoFileName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String?>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (initial.present) {
      map['initial'] = Variable<String?>(initial.value);
    }
    if (affiliation.present) {
      map['affiliation'] = Variable<String?>(affiliation.value);
    }
    if (role.present) {
      map['role'] = Variable<String?>(role.value);
    }
    if (lastCollectorNumber.present) {
      map['lastCollectorNumber'] = Variable<int?>(lastCollectorNumber.value);
    }
    if (photoFileName.present) {
      map['photoFileName'] = Variable<String?>(photoFileName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonnelCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('initial: $initial, ')
          ..write('affiliation: $affiliation, ')
          ..write('role: $role, ')
          ..write('lastCollectorNumber: $lastCollectorNumber, ')
          ..write('photoFileName: $photoFileName')
          ..write(')'))
        .toString();
  }
}

class Personnel extends Table with TableInfo<Personnel, PersonnelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Personnel(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE PRIMARY KEY');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _initialMeta = const VerificationMeta('initial');
  late final GeneratedColumn<String?> initial = GeneratedColumn<String?>(
      'initial', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _affiliationMeta =
      const VerificationMeta('affiliation');
  late final GeneratedColumn<String?> affiliation = GeneratedColumn<String?>(
      'affiliation', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _roleMeta = const VerificationMeta('role');
  late final GeneratedColumn<String?> role = GeneratedColumn<String?>(
      'role', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _lastCollectorNumberMeta =
      const VerificationMeta('lastCollectorNumber');
  late final GeneratedColumn<int?> lastCollectorNumber = GeneratedColumn<int?>(
      'lastCollectorNumber', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _photoFileNameMeta =
      const VerificationMeta('photoFileName');
  late final GeneratedColumn<String?> photoFileName = GeneratedColumn<String?>(
      'photoFileName', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        initial,
        affiliation,
        role,
        lastCollectorNumber,
        photoFileName
      ];
  @override
  String get aliasedName => _alias ?? 'personnel';
  @override
  String get actualTableName => 'personnel';
  @override
  VerificationContext validateIntegrity(Insertable<PersonnelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('initial')) {
      context.handle(_initialMeta,
          initial.isAcceptableOrUnknown(data['initial']!, _initialMeta));
    }
    if (data.containsKey('affiliation')) {
      context.handle(
          _affiliationMeta,
          affiliation.isAcceptableOrUnknown(
              data['affiliation']!, _affiliationMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('lastCollectorNumber')) {
      context.handle(
          _lastCollectorNumberMeta,
          lastCollectorNumber.isAcceptableOrUnknown(
              data['lastCollectorNumber']!, _lastCollectorNumberMeta));
    }
    if (data.containsKey('photoFileName')) {
      context.handle(
          _photoFileNameMeta,
          photoFileName.isAcceptableOrUnknown(
              data['photoFileName']!, _photoFileNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonnelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PersonnelData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Personnel createAlias(String alias) {
    return Personnel(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class PhotoData extends DataClass implements Insertable<PhotoData> {
  final int? id;
  final String? filename;
  final String? date;
  final String? camera;
  final String? lenses;
  final String? photographerID;
  PhotoData(
      {this.id,
      this.filename,
      this.date,
      this.camera,
      this.lenses,
      this.photographerID});
  factory PhotoData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PhotoData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      filename: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}filename']),
      date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
      camera: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}camera']),
      lenses: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lenses']),
      photographerID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}photographerID']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    if (!nullToAbsent || filename != null) {
      map['filename'] = Variable<String?>(filename);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String?>(date);
    }
    if (!nullToAbsent || camera != null) {
      map['camera'] = Variable<String?>(camera);
    }
    if (!nullToAbsent || lenses != null) {
      map['lenses'] = Variable<String?>(lenses);
    }
    if (!nullToAbsent || photographerID != null) {
      map['photographerID'] = Variable<String?>(photographerID);
    }
    return map;
  }

  PhotoCompanion toCompanion(bool nullToAbsent) {
    return PhotoCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      filename: filename == null && nullToAbsent
          ? const Value.absent()
          : Value(filename),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      camera:
          camera == null && nullToAbsent ? const Value.absent() : Value(camera),
      lenses:
          lenses == null && nullToAbsent ? const Value.absent() : Value(lenses),
      photographerID: photographerID == null && nullToAbsent
          ? const Value.absent()
          : Value(photographerID),
    );
  }

  factory PhotoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoData(
      id: serializer.fromJson<int?>(json['id']),
      filename: serializer.fromJson<String?>(json['filename']),
      date: serializer.fromJson<String?>(json['date']),
      camera: serializer.fromJson<String?>(json['camera']),
      lenses: serializer.fromJson<String?>(json['lenses']),
      photographerID: serializer.fromJson<String?>(json['photographerID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'filename': serializer.toJson<String?>(filename),
      'date': serializer.toJson<String?>(date),
      'camera': serializer.toJson<String?>(camera),
      'lenses': serializer.toJson<String?>(lenses),
      'photographerID': serializer.toJson<String?>(photographerID),
    };
  }

  PhotoData copyWith(
          {int? id,
          String? filename,
          String? date,
          String? camera,
          String? lenses,
          String? photographerID}) =>
      PhotoData(
        id: id ?? this.id,
        filename: filename ?? this.filename,
        date: date ?? this.date,
        camera: camera ?? this.camera,
        lenses: lenses ?? this.lenses,
        photographerID: photographerID ?? this.photographerID,
      );
  @override
  String toString() {
    return (StringBuffer('PhotoData(')
          ..write('id: $id, ')
          ..write('filename: $filename, ')
          ..write('date: $date, ')
          ..write('camera: $camera, ')
          ..write('lenses: $lenses, ')
          ..write('photographerID: $photographerID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, filename, date, camera, lenses, photographerID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoData &&
          other.id == this.id &&
          other.filename == this.filename &&
          other.date == this.date &&
          other.camera == this.camera &&
          other.lenses == this.lenses &&
          other.photographerID == this.photographerID);
}

class PhotoCompanion extends UpdateCompanion<PhotoData> {
  final Value<int?> id;
  final Value<String?> filename;
  final Value<String?> date;
  final Value<String?> camera;
  final Value<String?> lenses;
  final Value<String?> photographerID;
  const PhotoCompanion({
    this.id = const Value.absent(),
    this.filename = const Value.absent(),
    this.date = const Value.absent(),
    this.camera = const Value.absent(),
    this.lenses = const Value.absent(),
    this.photographerID = const Value.absent(),
  });
  PhotoCompanion.insert({
    this.id = const Value.absent(),
    this.filename = const Value.absent(),
    this.date = const Value.absent(),
    this.camera = const Value.absent(),
    this.lenses = const Value.absent(),
    this.photographerID = const Value.absent(),
  });
  static Insertable<PhotoData> custom({
    Expression<int?>? id,
    Expression<String?>? filename,
    Expression<String?>? date,
    Expression<String?>? camera,
    Expression<String?>? lenses,
    Expression<String?>? photographerID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (filename != null) 'filename': filename,
      if (date != null) 'date': date,
      if (camera != null) 'camera': camera,
      if (lenses != null) 'lenses': lenses,
      if (photographerID != null) 'photographerID': photographerID,
    });
  }

  PhotoCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? filename,
      Value<String?>? date,
      Value<String?>? camera,
      Value<String?>? lenses,
      Value<String?>? photographerID}) {
    return PhotoCompanion(
      id: id ?? this.id,
      filename: filename ?? this.filename,
      date: date ?? this.date,
      camera: camera ?? this.camera,
      lenses: lenses ?? this.lenses,
      photographerID: photographerID ?? this.photographerID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String?>(filename.value);
    }
    if (date.present) {
      map['date'] = Variable<String?>(date.value);
    }
    if (camera.present) {
      map['camera'] = Variable<String?>(camera.value);
    }
    if (lenses.present) {
      map['lenses'] = Variable<String?>(lenses.value);
    }
    if (photographerID.present) {
      map['photographerID'] = Variable<String?>(photographerID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoCompanion(')
          ..write('id: $id, ')
          ..write('filename: $filename, ')
          ..write('date: $date, ')
          ..write('camera: $camera, ')
          ..write('lenses: $lenses, ')
          ..write('photographerID: $photographerID')
          ..write(')'))
        .toString();
  }
}

class Photo extends Table with TableInfo<Photo, PhotoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Photo(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _filenameMeta = const VerificationMeta('filename');
  late final GeneratedColumn<String?> filename = GeneratedColumn<String?>(
      'filename', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<String?> date = GeneratedColumn<String?>(
      'date', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _cameraMeta = const VerificationMeta('camera');
  late final GeneratedColumn<String?> camera = GeneratedColumn<String?>(
      'camera', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _lensesMeta = const VerificationMeta('lenses');
  late final GeneratedColumn<String?> lenses = GeneratedColumn<String?>(
      'lenses', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _photographerIDMeta =
      const VerificationMeta('photographerID');
  late final GeneratedColumn<String?> photographerID = GeneratedColumn<String?>(
      'photographerID', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, filename, date, camera, lenses, photographerID];
  @override
  String get aliasedName => _alias ?? 'photo';
  @override
  String get actualTableName => 'photo';
  @override
  VerificationContext validateIntegrity(Insertable<PhotoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename']!, _filenameMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('camera')) {
      context.handle(_cameraMeta,
          camera.isAcceptableOrUnknown(data['camera']!, _cameraMeta));
    }
    if (data.containsKey('lenses')) {
      context.handle(_lensesMeta,
          lenses.isAcceptableOrUnknown(data['lenses']!, _lensesMeta));
    }
    if (data.containsKey('photographerID')) {
      context.handle(
          _photographerIDMeta,
          photographerID.isAcceptableOrUnknown(
              data['photographerID']!, _photographerIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhotoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PhotoData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Photo createAlias(String alias) {
    return Photo(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(photographerID) REFERENCES personnel(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class SiteData extends DataClass implements Insertable<SiteData> {
  final int id;
  final String? siteID;
  final String? projectUuid;
  final String? leadStuff;
  final String? siteType;
  final String? country;
  final String? stateProvince;
  final String? county;
  final String? municipality;
  final String? photoID;
  final String? locality;
  SiteData(
      {required this.id,
      this.siteID,
      this.projectUuid,
      this.leadStuff,
      this.siteType,
      this.country,
      this.stateProvince,
      this.county,
      this.municipality,
      this.photoID,
      this.locality});
  factory SiteData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SiteData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      siteID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}siteID']),
      projectUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectUuid']),
      leadStuff: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}leadStuff']),
      siteType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}siteType']),
      country: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}country']),
      stateProvince: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}stateProvince']),
      county: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}county']),
      municipality: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}municipality']),
      photoID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}photoID']),
      locality: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}locality']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || siteID != null) {
      map['siteID'] = Variable<String?>(siteID);
    }
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String?>(projectUuid);
    }
    if (!nullToAbsent || leadStuff != null) {
      map['leadStuff'] = Variable<String?>(leadStuff);
    }
    if (!nullToAbsent || siteType != null) {
      map['siteType'] = Variable<String?>(siteType);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String?>(country);
    }
    if (!nullToAbsent || stateProvince != null) {
      map['stateProvince'] = Variable<String?>(stateProvince);
    }
    if (!nullToAbsent || county != null) {
      map['county'] = Variable<String?>(county);
    }
    if (!nullToAbsent || municipality != null) {
      map['municipality'] = Variable<String?>(municipality);
    }
    if (!nullToAbsent || photoID != null) {
      map['photoID'] = Variable<String?>(photoID);
    }
    if (!nullToAbsent || locality != null) {
      map['locality'] = Variable<String?>(locality);
    }
    return map;
  }

  SiteCompanion toCompanion(bool nullToAbsent) {
    return SiteCompanion(
      id: Value(id),
      siteID:
          siteID == null && nullToAbsent ? const Value.absent() : Value(siteID),
      projectUuid: projectUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(projectUuid),
      leadStuff: leadStuff == null && nullToAbsent
          ? const Value.absent()
          : Value(leadStuff),
      siteType: siteType == null && nullToAbsent
          ? const Value.absent()
          : Value(siteType),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      stateProvince: stateProvince == null && nullToAbsent
          ? const Value.absent()
          : Value(stateProvince),
      county:
          county == null && nullToAbsent ? const Value.absent() : Value(county),
      municipality: municipality == null && nullToAbsent
          ? const Value.absent()
          : Value(municipality),
      photoID: photoID == null && nullToAbsent
          ? const Value.absent()
          : Value(photoID),
      locality: locality == null && nullToAbsent
          ? const Value.absent()
          : Value(locality),
    );
  }

  factory SiteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SiteData(
      id: serializer.fromJson<int>(json['id']),
      siteID: serializer.fromJson<String?>(json['siteID']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      leadStuff: serializer.fromJson<String?>(json['leadStuff']),
      siteType: serializer.fromJson<String?>(json['siteType']),
      country: serializer.fromJson<String?>(json['country']),
      stateProvince: serializer.fromJson<String?>(json['stateProvince']),
      county: serializer.fromJson<String?>(json['county']),
      municipality: serializer.fromJson<String?>(json['municipality']),
      photoID: serializer.fromJson<String?>(json['photoID']),
      locality: serializer.fromJson<String?>(json['locality']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'siteID': serializer.toJson<String?>(siteID),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'leadStuff': serializer.toJson<String?>(leadStuff),
      'siteType': serializer.toJson<String?>(siteType),
      'country': serializer.toJson<String?>(country),
      'stateProvince': serializer.toJson<String?>(stateProvince),
      'county': serializer.toJson<String?>(county),
      'municipality': serializer.toJson<String?>(municipality),
      'photoID': serializer.toJson<String?>(photoID),
      'locality': serializer.toJson<String?>(locality),
    };
  }

  SiteData copyWith(
          {int? id,
          String? siteID,
          String? projectUuid,
          String? leadStuff,
          String? siteType,
          String? country,
          String? stateProvince,
          String? county,
          String? municipality,
          String? photoID,
          String? locality}) =>
      SiteData(
        id: id ?? this.id,
        siteID: siteID ?? this.siteID,
        projectUuid: projectUuid ?? this.projectUuid,
        leadStuff: leadStuff ?? this.leadStuff,
        siteType: siteType ?? this.siteType,
        country: country ?? this.country,
        stateProvince: stateProvince ?? this.stateProvince,
        county: county ?? this.county,
        municipality: municipality ?? this.municipality,
        photoID: photoID ?? this.photoID,
        locality: locality ?? this.locality,
      );
  @override
  String toString() {
    return (StringBuffer('SiteData(')
          ..write('id: $id, ')
          ..write('siteID: $siteID, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('leadStuff: $leadStuff, ')
          ..write('siteType: $siteType, ')
          ..write('country: $country, ')
          ..write('stateProvince: $stateProvince, ')
          ..write('county: $county, ')
          ..write('municipality: $municipality, ')
          ..write('photoID: $photoID, ')
          ..write('locality: $locality')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, siteID, projectUuid, leadStuff, siteType,
      country, stateProvince, county, municipality, photoID, locality);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SiteData &&
          other.id == this.id &&
          other.siteID == this.siteID &&
          other.projectUuid == this.projectUuid &&
          other.leadStuff == this.leadStuff &&
          other.siteType == this.siteType &&
          other.country == this.country &&
          other.stateProvince == this.stateProvince &&
          other.county == this.county &&
          other.municipality == this.municipality &&
          other.photoID == this.photoID &&
          other.locality == this.locality);
}

class SiteCompanion extends UpdateCompanion<SiteData> {
  final Value<int> id;
  final Value<String?> siteID;
  final Value<String?> projectUuid;
  final Value<String?> leadStuff;
  final Value<String?> siteType;
  final Value<String?> country;
  final Value<String?> stateProvince;
  final Value<String?> county;
  final Value<String?> municipality;
  final Value<String?> photoID;
  final Value<String?> locality;
  const SiteCompanion({
    this.id = const Value.absent(),
    this.siteID = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.leadStuff = const Value.absent(),
    this.siteType = const Value.absent(),
    this.country = const Value.absent(),
    this.stateProvince = const Value.absent(),
    this.county = const Value.absent(),
    this.municipality = const Value.absent(),
    this.photoID = const Value.absent(),
    this.locality = const Value.absent(),
  });
  SiteCompanion.insert({
    this.id = const Value.absent(),
    this.siteID = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.leadStuff = const Value.absent(),
    this.siteType = const Value.absent(),
    this.country = const Value.absent(),
    this.stateProvince = const Value.absent(),
    this.county = const Value.absent(),
    this.municipality = const Value.absent(),
    this.photoID = const Value.absent(),
    this.locality = const Value.absent(),
  });
  static Insertable<SiteData> custom({
    Expression<int>? id,
    Expression<String?>? siteID,
    Expression<String?>? projectUuid,
    Expression<String?>? leadStuff,
    Expression<String?>? siteType,
    Expression<String?>? country,
    Expression<String?>? stateProvince,
    Expression<String?>? county,
    Expression<String?>? municipality,
    Expression<String?>? photoID,
    Expression<String?>? locality,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (siteID != null) 'siteID': siteID,
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (leadStuff != null) 'leadStuff': leadStuff,
      if (siteType != null) 'siteType': siteType,
      if (country != null) 'country': country,
      if (stateProvince != null) 'stateProvince': stateProvince,
      if (county != null) 'county': county,
      if (municipality != null) 'municipality': municipality,
      if (photoID != null) 'photoID': photoID,
      if (locality != null) 'locality': locality,
    });
  }

  SiteCompanion copyWith(
      {Value<int>? id,
      Value<String?>? siteID,
      Value<String?>? projectUuid,
      Value<String?>? leadStuff,
      Value<String?>? siteType,
      Value<String?>? country,
      Value<String?>? stateProvince,
      Value<String?>? county,
      Value<String?>? municipality,
      Value<String?>? photoID,
      Value<String?>? locality}) {
    return SiteCompanion(
      id: id ?? this.id,
      siteID: siteID ?? this.siteID,
      projectUuid: projectUuid ?? this.projectUuid,
      leadStuff: leadStuff ?? this.leadStuff,
      siteType: siteType ?? this.siteType,
      country: country ?? this.country,
      stateProvince: stateProvince ?? this.stateProvince,
      county: county ?? this.county,
      municipality: municipality ?? this.municipality,
      photoID: photoID ?? this.photoID,
      locality: locality ?? this.locality,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (siteID.present) {
      map['siteID'] = Variable<String?>(siteID.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String?>(projectUuid.value);
    }
    if (leadStuff.present) {
      map['leadStuff'] = Variable<String?>(leadStuff.value);
    }
    if (siteType.present) {
      map['siteType'] = Variable<String?>(siteType.value);
    }
    if (country.present) {
      map['country'] = Variable<String?>(country.value);
    }
    if (stateProvince.present) {
      map['stateProvince'] = Variable<String?>(stateProvince.value);
    }
    if (county.present) {
      map['county'] = Variable<String?>(county.value);
    }
    if (municipality.present) {
      map['municipality'] = Variable<String?>(municipality.value);
    }
    if (photoID.present) {
      map['photoID'] = Variable<String?>(photoID.value);
    }
    if (locality.present) {
      map['locality'] = Variable<String?>(locality.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SiteCompanion(')
          ..write('id: $id, ')
          ..write('siteID: $siteID, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('leadStuff: $leadStuff, ')
          ..write('siteType: $siteType, ')
          ..write('country: $country, ')
          ..write('stateProvince: $stateProvince, ')
          ..write('county: $county, ')
          ..write('municipality: $municipality, ')
          ..write('photoID: $photoID, ')
          ..write('locality: $locality')
          ..write(')'))
        .toString();
  }
}

class Site extends Table with TableInfo<Site, SiteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Site(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _siteIDMeta = const VerificationMeta('siteID');
  late final GeneratedColumn<String?> siteID = GeneratedColumn<String?>(
      'siteID', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
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
  final VerificationMeta _siteTypeMeta = const VerificationMeta('siteType');
  late final GeneratedColumn<String?> siteType = GeneratedColumn<String?>(
      'siteType', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _countryMeta = const VerificationMeta('country');
  late final GeneratedColumn<String?> country = GeneratedColumn<String?>(
      'country', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _stateProvinceMeta =
      const VerificationMeta('stateProvince');
  late final GeneratedColumn<String?> stateProvince = GeneratedColumn<String?>(
      'stateProvince', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _countyMeta = const VerificationMeta('county');
  late final GeneratedColumn<String?> county = GeneratedColumn<String?>(
      'county', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _municipalityMeta =
      const VerificationMeta('municipality');
  late final GeneratedColumn<String?> municipality = GeneratedColumn<String?>(
      'municipality', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _photoIDMeta = const VerificationMeta('photoID');
  late final GeneratedColumn<String?> photoID = GeneratedColumn<String?>(
      'photoID', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _localityMeta = const VerificationMeta('locality');
  late final GeneratedColumn<String?> locality = GeneratedColumn<String?>(
      'locality', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        siteID,
        projectUuid,
        leadStuff,
        siteType,
        country,
        stateProvince,
        county,
        municipality,
        photoID,
        locality
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('siteID')) {
      context.handle(_siteIDMeta,
          siteID.isAcceptableOrUnknown(data['siteID']!, _siteIDMeta));
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
    if (data.containsKey('siteType')) {
      context.handle(_siteTypeMeta,
          siteType.isAcceptableOrUnknown(data['siteType']!, _siteTypeMeta));
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    }
    if (data.containsKey('stateProvince')) {
      context.handle(
          _stateProvinceMeta,
          stateProvince.isAcceptableOrUnknown(
              data['stateProvince']!, _stateProvinceMeta));
    }
    if (data.containsKey('county')) {
      context.handle(_countyMeta,
          county.isAcceptableOrUnknown(data['county']!, _countyMeta));
    }
    if (data.containsKey('municipality')) {
      context.handle(
          _municipalityMeta,
          municipality.isAcceptableOrUnknown(
              data['municipality']!, _municipalityMeta));
    }
    if (data.containsKey('photoID')) {
      context.handle(_photoIDMeta,
          photoID.isAcceptableOrUnknown(data['photoID']!, _photoIDMeta));
    }
    if (data.containsKey('locality')) {
      context.handle(_localityMeta,
          locality.isAcceptableOrUnknown(data['locality']!, _localityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
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
  List<String> get customConstraints =>
      const ['FOREIGN KEY(photoID) REFERENCES photo(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class CoordinateData extends DataClass implements Insertable<CoordinateData> {
  final String? id;
  final double? decimalLatitude;
  final double? decimalLongitude;
  final int? elevationInMeter;
  final int? minimumElevationInMeters;
  final int? maximumElevationInMeters;
  final int? coordinateUncertaintyInMeters;
  final String? siteID;
  CoordinateData(
      {this.id,
      this.decimalLatitude,
      this.decimalLongitude,
      this.elevationInMeter,
      this.minimumElevationInMeters,
      this.maximumElevationInMeters,
      this.coordinateUncertaintyInMeters,
      this.siteID});
  factory CoordinateData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CoordinateData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id']),
      decimalLatitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}decimalLatitude']),
      decimalLongitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}decimalLongitude']),
      elevationInMeter: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}elevationInMeter']),
      minimumElevationInMeters: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}minimumElevationInMeters']),
      maximumElevationInMeters: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}maximumElevationInMeters']),
      coordinateUncertaintyInMeters: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}coordinateUncertaintyInMeters']),
      siteID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}siteID']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String?>(id);
    }
    if (!nullToAbsent || decimalLatitude != null) {
      map['decimalLatitude'] = Variable<double?>(decimalLatitude);
    }
    if (!nullToAbsent || decimalLongitude != null) {
      map['decimalLongitude'] = Variable<double?>(decimalLongitude);
    }
    if (!nullToAbsent || elevationInMeter != null) {
      map['elevationInMeter'] = Variable<int?>(elevationInMeter);
    }
    if (!nullToAbsent || minimumElevationInMeters != null) {
      map['minimumElevationInMeters'] =
          Variable<int?>(minimumElevationInMeters);
    }
    if (!nullToAbsent || maximumElevationInMeters != null) {
      map['maximumElevationInMeters'] =
          Variable<int?>(maximumElevationInMeters);
    }
    if (!nullToAbsent || coordinateUncertaintyInMeters != null) {
      map['coordinateUncertaintyInMeters'] =
          Variable<int?>(coordinateUncertaintyInMeters);
    }
    if (!nullToAbsent || siteID != null) {
      map['siteID'] = Variable<String?>(siteID);
    }
    return map;
  }

  CoordinateCompanion toCompanion(bool nullToAbsent) {
    return CoordinateCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      decimalLatitude: decimalLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(decimalLatitude),
      decimalLongitude: decimalLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(decimalLongitude),
      elevationInMeter: elevationInMeter == null && nullToAbsent
          ? const Value.absent()
          : Value(elevationInMeter),
      minimumElevationInMeters: minimumElevationInMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(minimumElevationInMeters),
      maximumElevationInMeters: maximumElevationInMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(maximumElevationInMeters),
      coordinateUncertaintyInMeters:
          coordinateUncertaintyInMeters == null && nullToAbsent
              ? const Value.absent()
              : Value(coordinateUncertaintyInMeters),
      siteID:
          siteID == null && nullToAbsent ? const Value.absent() : Value(siteID),
    );
  }

  factory CoordinateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoordinateData(
      id: serializer.fromJson<String?>(json['id']),
      decimalLatitude: serializer.fromJson<double?>(json['decimalLatitude']),
      decimalLongitude: serializer.fromJson<double?>(json['decimalLongitude']),
      elevationInMeter: serializer.fromJson<int?>(json['elevationInMeter']),
      minimumElevationInMeters:
          serializer.fromJson<int?>(json['minimumElevationInMeters']),
      maximumElevationInMeters:
          serializer.fromJson<int?>(json['maximumElevationInMeters']),
      coordinateUncertaintyInMeters:
          serializer.fromJson<int?>(json['coordinateUncertaintyInMeters']),
      siteID: serializer.fromJson<String?>(json['siteID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'decimalLatitude': serializer.toJson<double?>(decimalLatitude),
      'decimalLongitude': serializer.toJson<double?>(decimalLongitude),
      'elevationInMeter': serializer.toJson<int?>(elevationInMeter),
      'minimumElevationInMeters':
          serializer.toJson<int?>(minimumElevationInMeters),
      'maximumElevationInMeters':
          serializer.toJson<int?>(maximumElevationInMeters),
      'coordinateUncertaintyInMeters':
          serializer.toJson<int?>(coordinateUncertaintyInMeters),
      'siteID': serializer.toJson<String?>(siteID),
    };
  }

  CoordinateData copyWith(
          {String? id,
          double? decimalLatitude,
          double? decimalLongitude,
          int? elevationInMeter,
          int? minimumElevationInMeters,
          int? maximumElevationInMeters,
          int? coordinateUncertaintyInMeters,
          String? siteID}) =>
      CoordinateData(
        id: id ?? this.id,
        decimalLatitude: decimalLatitude ?? this.decimalLatitude,
        decimalLongitude: decimalLongitude ?? this.decimalLongitude,
        elevationInMeter: elevationInMeter ?? this.elevationInMeter,
        minimumElevationInMeters:
            minimumElevationInMeters ?? this.minimumElevationInMeters,
        maximumElevationInMeters:
            maximumElevationInMeters ?? this.maximumElevationInMeters,
        coordinateUncertaintyInMeters:
            coordinateUncertaintyInMeters ?? this.coordinateUncertaintyInMeters,
        siteID: siteID ?? this.siteID,
      );
  @override
  String toString() {
    return (StringBuffer('CoordinateData(')
          ..write('id: $id, ')
          ..write('decimalLatitude: $decimalLatitude, ')
          ..write('decimalLongitude: $decimalLongitude, ')
          ..write('elevationInMeter: $elevationInMeter, ')
          ..write('minimumElevationInMeters: $minimumElevationInMeters, ')
          ..write('maximumElevationInMeters: $maximumElevationInMeters, ')
          ..write(
              'coordinateUncertaintyInMeters: $coordinateUncertaintyInMeters, ')
          ..write('siteID: $siteID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      decimalLatitude,
      decimalLongitude,
      elevationInMeter,
      minimumElevationInMeters,
      maximumElevationInMeters,
      coordinateUncertaintyInMeters,
      siteID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoordinateData &&
          other.id == this.id &&
          other.decimalLatitude == this.decimalLatitude &&
          other.decimalLongitude == this.decimalLongitude &&
          other.elevationInMeter == this.elevationInMeter &&
          other.minimumElevationInMeters == this.minimumElevationInMeters &&
          other.maximumElevationInMeters == this.maximumElevationInMeters &&
          other.coordinateUncertaintyInMeters ==
              this.coordinateUncertaintyInMeters &&
          other.siteID == this.siteID);
}

class CoordinateCompanion extends UpdateCompanion<CoordinateData> {
  final Value<String?> id;
  final Value<double?> decimalLatitude;
  final Value<double?> decimalLongitude;
  final Value<int?> elevationInMeter;
  final Value<int?> minimumElevationInMeters;
  final Value<int?> maximumElevationInMeters;
  final Value<int?> coordinateUncertaintyInMeters;
  final Value<String?> siteID;
  const CoordinateCompanion({
    this.id = const Value.absent(),
    this.decimalLatitude = const Value.absent(),
    this.decimalLongitude = const Value.absent(),
    this.elevationInMeter = const Value.absent(),
    this.minimumElevationInMeters = const Value.absent(),
    this.maximumElevationInMeters = const Value.absent(),
    this.coordinateUncertaintyInMeters = const Value.absent(),
    this.siteID = const Value.absent(),
  });
  CoordinateCompanion.insert({
    this.id = const Value.absent(),
    this.decimalLatitude = const Value.absent(),
    this.decimalLongitude = const Value.absent(),
    this.elevationInMeter = const Value.absent(),
    this.minimumElevationInMeters = const Value.absent(),
    this.maximumElevationInMeters = const Value.absent(),
    this.coordinateUncertaintyInMeters = const Value.absent(),
    this.siteID = const Value.absent(),
  });
  static Insertable<CoordinateData> custom({
    Expression<String?>? id,
    Expression<double?>? decimalLatitude,
    Expression<double?>? decimalLongitude,
    Expression<int?>? elevationInMeter,
    Expression<int?>? minimumElevationInMeters,
    Expression<int?>? maximumElevationInMeters,
    Expression<int?>? coordinateUncertaintyInMeters,
    Expression<String?>? siteID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (decimalLatitude != null) 'decimalLatitude': decimalLatitude,
      if (decimalLongitude != null) 'decimalLongitude': decimalLongitude,
      if (elevationInMeter != null) 'elevationInMeter': elevationInMeter,
      if (minimumElevationInMeters != null)
        'minimumElevationInMeters': minimumElevationInMeters,
      if (maximumElevationInMeters != null)
        'maximumElevationInMeters': maximumElevationInMeters,
      if (coordinateUncertaintyInMeters != null)
        'coordinateUncertaintyInMeters': coordinateUncertaintyInMeters,
      if (siteID != null) 'siteID': siteID,
    });
  }

  CoordinateCompanion copyWith(
      {Value<String?>? id,
      Value<double?>? decimalLatitude,
      Value<double?>? decimalLongitude,
      Value<int?>? elevationInMeter,
      Value<int?>? minimumElevationInMeters,
      Value<int?>? maximumElevationInMeters,
      Value<int?>? coordinateUncertaintyInMeters,
      Value<String?>? siteID}) {
    return CoordinateCompanion(
      id: id ?? this.id,
      decimalLatitude: decimalLatitude ?? this.decimalLatitude,
      decimalLongitude: decimalLongitude ?? this.decimalLongitude,
      elevationInMeter: elevationInMeter ?? this.elevationInMeter,
      minimumElevationInMeters:
          minimumElevationInMeters ?? this.minimumElevationInMeters,
      maximumElevationInMeters:
          maximumElevationInMeters ?? this.maximumElevationInMeters,
      coordinateUncertaintyInMeters:
          coordinateUncertaintyInMeters ?? this.coordinateUncertaintyInMeters,
      siteID: siteID ?? this.siteID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String?>(id.value);
    }
    if (decimalLatitude.present) {
      map['decimalLatitude'] = Variable<double?>(decimalLatitude.value);
    }
    if (decimalLongitude.present) {
      map['decimalLongitude'] = Variable<double?>(decimalLongitude.value);
    }
    if (elevationInMeter.present) {
      map['elevationInMeter'] = Variable<int?>(elevationInMeter.value);
    }
    if (minimumElevationInMeters.present) {
      map['minimumElevationInMeters'] =
          Variable<int?>(minimumElevationInMeters.value);
    }
    if (maximumElevationInMeters.present) {
      map['maximumElevationInMeters'] =
          Variable<int?>(maximumElevationInMeters.value);
    }
    if (coordinateUncertaintyInMeters.present) {
      map['coordinateUncertaintyInMeters'] =
          Variable<int?>(coordinateUncertaintyInMeters.value);
    }
    if (siteID.present) {
      map['siteID'] = Variable<String?>(siteID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoordinateCompanion(')
          ..write('id: $id, ')
          ..write('decimalLatitude: $decimalLatitude, ')
          ..write('decimalLongitude: $decimalLongitude, ')
          ..write('elevationInMeter: $elevationInMeter, ')
          ..write('minimumElevationInMeters: $minimumElevationInMeters, ')
          ..write('maximumElevationInMeters: $maximumElevationInMeters, ')
          ..write(
              'coordinateUncertaintyInMeters: $coordinateUncertaintyInMeters, ')
          ..write('siteID: $siteID')
          ..write(')'))
        .toString();
  }
}

class Coordinate extends Table with TableInfo<Coordinate, CoordinateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Coordinate(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE PRIMARY KEY');
  final VerificationMeta _decimalLatitudeMeta =
      const VerificationMeta('decimalLatitude');
  late final GeneratedColumn<double?> decimalLatitude =
      GeneratedColumn<double?>('decimalLatitude', aliasedName, true,
          type: const RealType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _decimalLongitudeMeta =
      const VerificationMeta('decimalLongitude');
  late final GeneratedColumn<double?> decimalLongitude =
      GeneratedColumn<double?>('decimalLongitude', aliasedName, true,
          type: const RealType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _elevationInMeterMeta =
      const VerificationMeta('elevationInMeter');
  late final GeneratedColumn<int?> elevationInMeter = GeneratedColumn<int?>(
      'elevationInMeter', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _minimumElevationInMetersMeta =
      const VerificationMeta('minimumElevationInMeters');
  late final GeneratedColumn<int?> minimumElevationInMeters =
      GeneratedColumn<int?>('minimumElevationInMeters', aliasedName, true,
          type: const IntType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _maximumElevationInMetersMeta =
      const VerificationMeta('maximumElevationInMeters');
  late final GeneratedColumn<int?> maximumElevationInMeters =
      GeneratedColumn<int?>('maximumElevationInMeters', aliasedName, true,
          type: const IntType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _coordinateUncertaintyInMetersMeta =
      const VerificationMeta('coordinateUncertaintyInMeters');
  late final GeneratedColumn<int?> coordinateUncertaintyInMeters =
      GeneratedColumn<int?>('coordinateUncertaintyInMeters', aliasedName, true,
          type: const IntType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _siteIDMeta = const VerificationMeta('siteID');
  late final GeneratedColumn<String?> siteID = GeneratedColumn<String?>(
      'siteID', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES site(siteID)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        decimalLatitude,
        decimalLongitude,
        elevationInMeter,
        minimumElevationInMeters,
        maximumElevationInMeters,
        coordinateUncertaintyInMeters,
        siteID
      ];
  @override
  String get aliasedName => _alias ?? 'coordinate';
  @override
  String get actualTableName => 'coordinate';
  @override
  VerificationContext validateIntegrity(Insertable<CoordinateData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('decimalLatitude')) {
      context.handle(
          _decimalLatitudeMeta,
          decimalLatitude.isAcceptableOrUnknown(
              data['decimalLatitude']!, _decimalLatitudeMeta));
    }
    if (data.containsKey('decimalLongitude')) {
      context.handle(
          _decimalLongitudeMeta,
          decimalLongitude.isAcceptableOrUnknown(
              data['decimalLongitude']!, _decimalLongitudeMeta));
    }
    if (data.containsKey('elevationInMeter')) {
      context.handle(
          _elevationInMeterMeta,
          elevationInMeter.isAcceptableOrUnknown(
              data['elevationInMeter']!, _elevationInMeterMeta));
    }
    if (data.containsKey('minimumElevationInMeters')) {
      context.handle(
          _minimumElevationInMetersMeta,
          minimumElevationInMeters.isAcceptableOrUnknown(
              data['minimumElevationInMeters']!,
              _minimumElevationInMetersMeta));
    }
    if (data.containsKey('maximumElevationInMeters')) {
      context.handle(
          _maximumElevationInMetersMeta,
          maximumElevationInMeters.isAcceptableOrUnknown(
              data['maximumElevationInMeters']!,
              _maximumElevationInMetersMeta));
    }
    if (data.containsKey('coordinateUncertaintyInMeters')) {
      context.handle(
          _coordinateUncertaintyInMetersMeta,
          coordinateUncertaintyInMeters.isAcceptableOrUnknown(
              data['coordinateUncertaintyInMeters']!,
              _coordinateUncertaintyInMetersMeta));
    }
    if (data.containsKey('siteID')) {
      context.handle(_siteIDMeta,
          siteID.isAcceptableOrUnknown(data['siteID']!, _siteIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoordinateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CoordinateData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Coordinate createAlias(String alias) {
    return Coordinate(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CollEventData extends DataClass implements Insertable<CollEventData> {
  final int id;
  final String? projectUuid;
  final String? startDate;
  final String? startTime;
  final String? endDate;
  final String? endTime;
  final String? primaryCollMethod;
  final String? collMethodNotes;
  final String? siteID;
  CollEventData(
      {required this.id,
      this.projectUuid,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.primaryCollMethod,
      this.collMethodNotes,
      this.siteID});
  factory CollEventData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CollEventData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      projectUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectUuid']),
      startDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}startDate']),
      startTime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}startTime']),
      endDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}endDate']),
      endTime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}endTime']),
      primaryCollMethod: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}primaryCollMethod']),
      collMethodNotes: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}collMethodNotes']),
      siteID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}siteID']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String?>(projectUuid);
    }
    if (!nullToAbsent || startDate != null) {
      map['startDate'] = Variable<String?>(startDate);
    }
    if (!nullToAbsent || startTime != null) {
      map['startTime'] = Variable<String?>(startTime);
    }
    if (!nullToAbsent || endDate != null) {
      map['endDate'] = Variable<String?>(endDate);
    }
    if (!nullToAbsent || endTime != null) {
      map['endTime'] = Variable<String?>(endTime);
    }
    if (!nullToAbsent || primaryCollMethod != null) {
      map['primaryCollMethod'] = Variable<String?>(primaryCollMethod);
    }
    if (!nullToAbsent || collMethodNotes != null) {
      map['collMethodNotes'] = Variable<String?>(collMethodNotes);
    }
    if (!nullToAbsent || siteID != null) {
      map['siteID'] = Variable<String?>(siteID);
    }
    return map;
  }

  CollEventCompanion toCompanion(bool nullToAbsent) {
    return CollEventCompanion(
      id: Value(id),
      projectUuid: projectUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(projectUuid),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      primaryCollMethod: primaryCollMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryCollMethod),
      collMethodNotes: collMethodNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(collMethodNotes),
      siteID:
          siteID == null && nullToAbsent ? const Value.absent() : Value(siteID),
    );
  }

  factory CollEventData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollEventData(
      id: serializer.fromJson<int>(json['id']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      startDate: serializer.fromJson<String?>(json['startDate']),
      startTime: serializer.fromJson<String?>(json['startTime']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      endTime: serializer.fromJson<String?>(json['endTime']),
      primaryCollMethod:
          serializer.fromJson<String?>(json['primaryCollMethod']),
      collMethodNotes: serializer.fromJson<String?>(json['collMethodNotes']),
      siteID: serializer.fromJson<String?>(json['siteID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'startDate': serializer.toJson<String?>(startDate),
      'startTime': serializer.toJson<String?>(startTime),
      'endDate': serializer.toJson<String?>(endDate),
      'endTime': serializer.toJson<String?>(endTime),
      'primaryCollMethod': serializer.toJson<String?>(primaryCollMethod),
      'collMethodNotes': serializer.toJson<String?>(collMethodNotes),
      'siteID': serializer.toJson<String?>(siteID),
    };
  }

  CollEventData copyWith(
          {int? id,
          String? projectUuid,
          String? startDate,
          String? startTime,
          String? endDate,
          String? endTime,
          String? primaryCollMethod,
          String? collMethodNotes,
          String? siteID}) =>
      CollEventData(
        id: id ?? this.id,
        projectUuid: projectUuid ?? this.projectUuid,
        startDate: startDate ?? this.startDate,
        startTime: startTime ?? this.startTime,
        endDate: endDate ?? this.endDate,
        endTime: endTime ?? this.endTime,
        primaryCollMethod: primaryCollMethod ?? this.primaryCollMethod,
        collMethodNotes: collMethodNotes ?? this.collMethodNotes,
        siteID: siteID ?? this.siteID,
      );
  @override
  String toString() {
    return (StringBuffer('CollEventData(')
          ..write('id: $id, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('startDate: $startDate, ')
          ..write('startTime: $startTime, ')
          ..write('endDate: $endDate, ')
          ..write('endTime: $endTime, ')
          ..write('primaryCollMethod: $primaryCollMethod, ')
          ..write('collMethodNotes: $collMethodNotes, ')
          ..write('siteID: $siteID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, projectUuid, startDate, startTime,
      endDate, endTime, primaryCollMethod, collMethodNotes, siteID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollEventData &&
          other.id == this.id &&
          other.projectUuid == this.projectUuid &&
          other.startDate == this.startDate &&
          other.startTime == this.startTime &&
          other.endDate == this.endDate &&
          other.endTime == this.endTime &&
          other.primaryCollMethod == this.primaryCollMethod &&
          other.collMethodNotes == this.collMethodNotes &&
          other.siteID == this.siteID);
}

class CollEventCompanion extends UpdateCompanion<CollEventData> {
  final Value<int> id;
  final Value<String?> projectUuid;
  final Value<String?> startDate;
  final Value<String?> startTime;
  final Value<String?> endDate;
  final Value<String?> endTime;
  final Value<String?> primaryCollMethod;
  final Value<String?> collMethodNotes;
  final Value<String?> siteID;
  const CollEventCompanion({
    this.id = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.startDate = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endDate = const Value.absent(),
    this.endTime = const Value.absent(),
    this.primaryCollMethod = const Value.absent(),
    this.collMethodNotes = const Value.absent(),
    this.siteID = const Value.absent(),
  });
  CollEventCompanion.insert({
    this.id = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.startDate = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endDate = const Value.absent(),
    this.endTime = const Value.absent(),
    this.primaryCollMethod = const Value.absent(),
    this.collMethodNotes = const Value.absent(),
    this.siteID = const Value.absent(),
  });
  static Insertable<CollEventData> custom({
    Expression<int>? id,
    Expression<String?>? projectUuid,
    Expression<String?>? startDate,
    Expression<String?>? startTime,
    Expression<String?>? endDate,
    Expression<String?>? endTime,
    Expression<String?>? primaryCollMethod,
    Expression<String?>? collMethodNotes,
    Expression<String?>? siteID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (startDate != null) 'startDate': startDate,
      if (startTime != null) 'startTime': startTime,
      if (endDate != null) 'endDate': endDate,
      if (endTime != null) 'endTime': endTime,
      if (primaryCollMethod != null) 'primaryCollMethod': primaryCollMethod,
      if (collMethodNotes != null) 'collMethodNotes': collMethodNotes,
      if (siteID != null) 'siteID': siteID,
    });
  }

  CollEventCompanion copyWith(
      {Value<int>? id,
      Value<String?>? projectUuid,
      Value<String?>? startDate,
      Value<String?>? startTime,
      Value<String?>? endDate,
      Value<String?>? endTime,
      Value<String?>? primaryCollMethod,
      Value<String?>? collMethodNotes,
      Value<String?>? siteID}) {
    return CollEventCompanion(
      id: id ?? this.id,
      projectUuid: projectUuid ?? this.projectUuid,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
      primaryCollMethod: primaryCollMethod ?? this.primaryCollMethod,
      collMethodNotes: collMethodNotes ?? this.collMethodNotes,
      siteID: siteID ?? this.siteID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String?>(projectUuid.value);
    }
    if (startDate.present) {
      map['startDate'] = Variable<String?>(startDate.value);
    }
    if (startTime.present) {
      map['startTime'] = Variable<String?>(startTime.value);
    }
    if (endDate.present) {
      map['endDate'] = Variable<String?>(endDate.value);
    }
    if (endTime.present) {
      map['endTime'] = Variable<String?>(endTime.value);
    }
    if (primaryCollMethod.present) {
      map['primaryCollMethod'] = Variable<String?>(primaryCollMethod.value);
    }
    if (collMethodNotes.present) {
      map['collMethodNotes'] = Variable<String?>(collMethodNotes.value);
    }
    if (siteID.present) {
      map['siteID'] = Variable<String?>(siteID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollEventCompanion(')
          ..write('id: $id, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('startDate: $startDate, ')
          ..write('startTime: $startTime, ')
          ..write('endDate: $endDate, ')
          ..write('endTime: $endTime, ')
          ..write('primaryCollMethod: $primaryCollMethod, ')
          ..write('collMethodNotes: $collMethodNotes, ')
          ..write('siteID: $siteID')
          ..write(')'))
        .toString();
  }
}

class CollEvent extends Table with TableInfo<CollEvent, CollEventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CollEvent(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String?> projectUuid = GeneratedColumn<String?>(
      'projectUuid', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  late final GeneratedColumn<String?> startDate = GeneratedColumn<String?>(
      'startDate', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _startTimeMeta = const VerificationMeta('startTime');
  late final GeneratedColumn<String?> startTime = GeneratedColumn<String?>(
      'startTime', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _endDateMeta = const VerificationMeta('endDate');
  late final GeneratedColumn<String?> endDate = GeneratedColumn<String?>(
      'endDate', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _endTimeMeta = const VerificationMeta('endTime');
  late final GeneratedColumn<String?> endTime = GeneratedColumn<String?>(
      'endTime', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _primaryCollMethodMeta =
      const VerificationMeta('primaryCollMethod');
  late final GeneratedColumn<String?> primaryCollMethod =
      GeneratedColumn<String?>('primaryCollMethod', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _collMethodNotesMeta =
      const VerificationMeta('collMethodNotes');
  late final GeneratedColumn<String?> collMethodNotes =
      GeneratedColumn<String?>('collMethodNotes', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _siteIDMeta = const VerificationMeta('siteID');
  late final GeneratedColumn<String?> siteID = GeneratedColumn<String?>(
      'siteID', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES site(siteID)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        projectUuid,
        startDate,
        startTime,
        endDate,
        endTime,
        primaryCollMethod,
        collMethodNotes,
        siteID
      ];
  @override
  String get aliasedName => _alias ?? 'collEvent';
  @override
  String get actualTableName => 'collEvent';
  @override
  VerificationContext validateIntegrity(Insertable<CollEventData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('projectUuid')) {
      context.handle(
          _projectUuidMeta,
          projectUuid.isAcceptableOrUnknown(
              data['projectUuid']!, _projectUuidMeta));
    }
    if (data.containsKey('startDate')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['startDate']!, _startDateMeta));
    }
    if (data.containsKey('startTime')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['startTime']!, _startTimeMeta));
    }
    if (data.containsKey('endDate')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['endDate']!, _endDateMeta));
    }
    if (data.containsKey('endTime')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['endTime']!, _endTimeMeta));
    }
    if (data.containsKey('primaryCollMethod')) {
      context.handle(
          _primaryCollMethodMeta,
          primaryCollMethod.isAcceptableOrUnknown(
              data['primaryCollMethod']!, _primaryCollMethodMeta));
    }
    if (data.containsKey('collMethodNotes')) {
      context.handle(
          _collMethodNotesMeta,
          collMethodNotes.isAcceptableOrUnknown(
              data['collMethodNotes']!, _collMethodNotesMeta));
    }
    if (data.containsKey('siteID')) {
      context.handle(_siteIDMeta,
          siteID.isAcceptableOrUnknown(data['siteID']!, _siteIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollEventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CollEventData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  CollEvent createAlias(String alias) {
    return CollEvent(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(projectUuid) REFERENCES project(projectUuid)'];
  @override
  bool get dontWriteConstraints => true;
}

class NarrativeData extends DataClass implements Insertable<NarrativeData> {
  final int id;
  final String? projectUuid;
  final String? date;
  final String? siteID;
  final String? narrative;
  final int? photoID;
  NarrativeData(
      {required this.id,
      this.projectUuid,
      this.date,
      this.siteID,
      this.narrative,
      this.photoID});
  factory NarrativeData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NarrativeData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      projectUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectUuid']),
      date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
      siteID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}siteID']),
      narrative: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}narrative']),
      photoID: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}photoID']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String?>(projectUuid);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String?>(date);
    }
    if (!nullToAbsent || siteID != null) {
      map['siteID'] = Variable<String?>(siteID);
    }
    if (!nullToAbsent || narrative != null) {
      map['narrative'] = Variable<String?>(narrative);
    }
    if (!nullToAbsent || photoID != null) {
      map['photoID'] = Variable<int?>(photoID);
    }
    return map;
  }

  NarrativeCompanion toCompanion(bool nullToAbsent) {
    return NarrativeCompanion(
      id: Value(id),
      projectUuid: projectUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(projectUuid),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      siteID:
          siteID == null && nullToAbsent ? const Value.absent() : Value(siteID),
      narrative: narrative == null && nullToAbsent
          ? const Value.absent()
          : Value(narrative),
      photoID: photoID == null && nullToAbsent
          ? const Value.absent()
          : Value(photoID),
    );
  }

  factory NarrativeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NarrativeData(
      id: serializer.fromJson<int>(json['id']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      date: serializer.fromJson<String?>(json['date']),
      siteID: serializer.fromJson<String?>(json['siteID']),
      narrative: serializer.fromJson<String?>(json['narrative']),
      photoID: serializer.fromJson<int?>(json['photoID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'date': serializer.toJson<String?>(date),
      'siteID': serializer.toJson<String?>(siteID),
      'narrative': serializer.toJson<String?>(narrative),
      'photoID': serializer.toJson<int?>(photoID),
    };
  }

  NarrativeData copyWith(
          {int? id,
          String? projectUuid,
          String? date,
          String? siteID,
          String? narrative,
          int? photoID}) =>
      NarrativeData(
        id: id ?? this.id,
        projectUuid: projectUuid ?? this.projectUuid,
        date: date ?? this.date,
        siteID: siteID ?? this.siteID,
        narrative: narrative ?? this.narrative,
        photoID: photoID ?? this.photoID,
      );
  @override
  String toString() {
    return (StringBuffer('NarrativeData(')
          ..write('id: $id, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('date: $date, ')
          ..write('siteID: $siteID, ')
          ..write('narrative: $narrative, ')
          ..write('photoID: $photoID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, projectUuid, date, siteID, narrative, photoID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NarrativeData &&
          other.id == this.id &&
          other.projectUuid == this.projectUuid &&
          other.date == this.date &&
          other.siteID == this.siteID &&
          other.narrative == this.narrative &&
          other.photoID == this.photoID);
}

class NarrativeCompanion extends UpdateCompanion<NarrativeData> {
  final Value<int> id;
  final Value<String?> projectUuid;
  final Value<String?> date;
  final Value<String?> siteID;
  final Value<String?> narrative;
  final Value<int?> photoID;
  const NarrativeCompanion({
    this.id = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.date = const Value.absent(),
    this.siteID = const Value.absent(),
    this.narrative = const Value.absent(),
    this.photoID = const Value.absent(),
  });
  NarrativeCompanion.insert({
    this.id = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.date = const Value.absent(),
    this.siteID = const Value.absent(),
    this.narrative = const Value.absent(),
    this.photoID = const Value.absent(),
  });
  static Insertable<NarrativeData> custom({
    Expression<int>? id,
    Expression<String?>? projectUuid,
    Expression<String?>? date,
    Expression<String?>? siteID,
    Expression<String?>? narrative,
    Expression<int?>? photoID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (date != null) 'date': date,
      if (siteID != null) 'siteID': siteID,
      if (narrative != null) 'narrative': narrative,
      if (photoID != null) 'photoID': photoID,
    });
  }

  NarrativeCompanion copyWith(
      {Value<int>? id,
      Value<String?>? projectUuid,
      Value<String?>? date,
      Value<String?>? siteID,
      Value<String?>? narrative,
      Value<int?>? photoID}) {
    return NarrativeCompanion(
      id: id ?? this.id,
      projectUuid: projectUuid ?? this.projectUuid,
      date: date ?? this.date,
      siteID: siteID ?? this.siteID,
      narrative: narrative ?? this.narrative,
      photoID: photoID ?? this.photoID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String?>(projectUuid.value);
    }
    if (date.present) {
      map['date'] = Variable<String?>(date.value);
    }
    if (siteID.present) {
      map['siteID'] = Variable<String?>(siteID.value);
    }
    if (narrative.present) {
      map['narrative'] = Variable<String?>(narrative.value);
    }
    if (photoID.present) {
      map['photoID'] = Variable<int?>(photoID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NarrativeCompanion(')
          ..write('id: $id, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('date: $date, ')
          ..write('siteID: $siteID, ')
          ..write('narrative: $narrative, ')
          ..write('photoID: $photoID')
          ..write(')'))
        .toString();
  }
}

class Narrative extends Table with TableInfo<Narrative, NarrativeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Narrative(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String?> projectUuid = GeneratedColumn<String?>(
      'projectUuid', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<String?> date = GeneratedColumn<String?>(
      'date', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _siteIDMeta = const VerificationMeta('siteID');
  late final GeneratedColumn<String?> siteID = GeneratedColumn<String?>(
      'siteID', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _narrativeMeta = const VerificationMeta('narrative');
  late final GeneratedColumn<String?> narrative = GeneratedColumn<String?>(
      'narrative', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _photoIDMeta = const VerificationMeta('photoID');
  late final GeneratedColumn<int?> photoID = GeneratedColumn<int?>(
      'photoID', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES photo(id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectUuid, date, siteID, narrative, photoID];
  @override
  String get aliasedName => _alias ?? 'narrative';
  @override
  String get actualTableName => 'narrative';
  @override
  VerificationContext validateIntegrity(Insertable<NarrativeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('projectUuid')) {
      context.handle(
          _projectUuidMeta,
          projectUuid.isAcceptableOrUnknown(
              data['projectUuid']!, _projectUuidMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('siteID')) {
      context.handle(_siteIDMeta,
          siteID.isAcceptableOrUnknown(data['siteID']!, _siteIDMeta));
    }
    if (data.containsKey('narrative')) {
      context.handle(_narrativeMeta,
          narrative.isAcceptableOrUnknown(data['narrative']!, _narrativeMeta));
    }
    if (data.containsKey('photoID')) {
      context.handle(_photoIDMeta,
          photoID.isAcceptableOrUnknown(data['photoID']!, _photoIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NarrativeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NarrativeData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Narrative createAlias(String alias) {
    return Narrative(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(projectUuid) REFERENCES project(projectUuid)',
        'FOREIGN KEY(siteID) REFERENCES site(siteID)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class PersonnelListData extends DataClass
    implements Insertable<PersonnelListData> {
  final String? projectUuid;
  final String? personnelUuid;
  PersonnelListData({this.projectUuid, this.personnelUuid});
  factory PersonnelListData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PersonnelListData(
      projectUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectUuid']),
      personnelUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personnelUuid']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String?>(projectUuid);
    }
    if (!nullToAbsent || personnelUuid != null) {
      map['personnelUuid'] = Variable<String?>(personnelUuid);
    }
    return map;
  }

  PersonnelListCompanion toCompanion(bool nullToAbsent) {
    return PersonnelListCompanion(
      projectUuid: projectUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(projectUuid),
      personnelUuid: personnelUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(personnelUuid),
    );
  }

  factory PersonnelListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonnelListData(
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      personnelUuid: serializer.fromJson<String?>(json['personnelUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'personnelUuid': serializer.toJson<String?>(personnelUuid),
    };
  }

  PersonnelListData copyWith({String? projectUuid, String? personnelUuid}) =>
      PersonnelListData(
        projectUuid: projectUuid ?? this.projectUuid,
        personnelUuid: personnelUuid ?? this.personnelUuid,
      );
  @override
  String toString() {
    return (StringBuffer('PersonnelListData(')
          ..write('projectUuid: $projectUuid, ')
          ..write('personnelUuid: $personnelUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(projectUuid, personnelUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonnelListData &&
          other.projectUuid == this.projectUuid &&
          other.personnelUuid == this.personnelUuid);
}

class PersonnelListCompanion extends UpdateCompanion<PersonnelListData> {
  final Value<String?> projectUuid;
  final Value<String?> personnelUuid;
  const PersonnelListCompanion({
    this.projectUuid = const Value.absent(),
    this.personnelUuid = const Value.absent(),
  });
  PersonnelListCompanion.insert({
    this.projectUuid = const Value.absent(),
    this.personnelUuid = const Value.absent(),
  });
  static Insertable<PersonnelListData> custom({
    Expression<String?>? projectUuid,
    Expression<String?>? personnelUuid,
  }) {
    return RawValuesInsertable({
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (personnelUuid != null) 'personnelUuid': personnelUuid,
    });
  }

  PersonnelListCompanion copyWith(
      {Value<String?>? projectUuid, Value<String?>? personnelUuid}) {
    return PersonnelListCompanion(
      projectUuid: projectUuid ?? this.projectUuid,
      personnelUuid: personnelUuid ?? this.personnelUuid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String?>(projectUuid.value);
    }
    if (personnelUuid.present) {
      map['personnelUuid'] = Variable<String?>(personnelUuid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonnelListCompanion(')
          ..write('projectUuid: $projectUuid, ')
          ..write('personnelUuid: $personnelUuid')
          ..write(')'))
        .toString();
  }
}

class PersonnelList extends Table
    with TableInfo<PersonnelList, PersonnelListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PersonnelList(this.attachedDatabase, [this._alias]);
  final VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String?> projectUuid = GeneratedColumn<String?>(
      'projectUuid', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _personnelUuidMeta =
      const VerificationMeta('personnelUuid');
  late final GeneratedColumn<String?> personnelUuid = GeneratedColumn<String?>(
      'personnelUuid', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [projectUuid, personnelUuid];
  @override
  String get aliasedName => _alias ?? 'personnelList';
  @override
  String get actualTableName => 'personnelList';
  @override
  VerificationContext validateIntegrity(Insertable<PersonnelListData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('projectUuid')) {
      context.handle(
          _projectUuidMeta,
          projectUuid.isAcceptableOrUnknown(
              data['projectUuid']!, _projectUuidMeta));
    }
    if (data.containsKey('personnelUuid')) {
      context.handle(
          _personnelUuidMeta,
          personnelUuid.isAcceptableOrUnknown(
              data['personnelUuid']!, _personnelUuidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  PersonnelListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PersonnelListData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  PersonnelList createAlias(String alias) {
    return PersonnelList(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(projectUuid) REFERENCES project(projectUuid)',
        'FOREIGN KEY(personnelUuid) REFERENCES personnel(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class SpecimenData extends DataClass implements Insertable<SpecimenData> {
  final String specimenUuid;
  final String? projectUuid;
  final int? speciesID;
  final String? taxonGroup;
  final String? condition;
  final String? prepDate;
  final String? prepTime;
  final String? captureDate;
  final String? captureTime;
  final String? trapType;
  final String? collectorID;
  final int? collEventID;
  final String? preparatorID;
  SpecimenData(
      {required this.specimenUuid,
      this.projectUuid,
      this.speciesID,
      this.taxonGroup,
      this.condition,
      this.prepDate,
      this.prepTime,
      this.captureDate,
      this.captureTime,
      this.trapType,
      this.collectorID,
      this.collEventID,
      this.preparatorID});
  factory SpecimenData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SpecimenData(
      specimenUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}specimenUuid'])!,
      projectUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}projectUuid']),
      speciesID: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}speciesID']),
      taxonGroup: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}taxonGroup']),
      condition: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}condition']),
      prepDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}prepDate']),
      prepTime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}prepTime']),
      captureDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}captureDate']),
      captureTime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}captureTime']),
      trapType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}trapType']),
      collectorID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}collectorID']),
      collEventID: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}collEventID']),
      preparatorID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}preparatorID']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['specimenUuid'] = Variable<String>(specimenUuid);
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String?>(projectUuid);
    }
    if (!nullToAbsent || speciesID != null) {
      map['speciesID'] = Variable<int?>(speciesID);
    }
    if (!nullToAbsent || taxonGroup != null) {
      map['taxonGroup'] = Variable<String?>(taxonGroup);
    }
    if (!nullToAbsent || condition != null) {
      map['condition'] = Variable<String?>(condition);
    }
    if (!nullToAbsent || prepDate != null) {
      map['prepDate'] = Variable<String?>(prepDate);
    }
    if (!nullToAbsent || prepTime != null) {
      map['prepTime'] = Variable<String?>(prepTime);
    }
    if (!nullToAbsent || captureDate != null) {
      map['captureDate'] = Variable<String?>(captureDate);
    }
    if (!nullToAbsent || captureTime != null) {
      map['captureTime'] = Variable<String?>(captureTime);
    }
    if (!nullToAbsent || trapType != null) {
      map['trapType'] = Variable<String?>(trapType);
    }
    if (!nullToAbsent || collectorID != null) {
      map['collectorID'] = Variable<String?>(collectorID);
    }
    if (!nullToAbsent || collEventID != null) {
      map['collEventID'] = Variable<int?>(collEventID);
    }
    if (!nullToAbsent || preparatorID != null) {
      map['preparatorID'] = Variable<String?>(preparatorID);
    }
    return map;
  }

  SpecimenCompanion toCompanion(bool nullToAbsent) {
    return SpecimenCompanion(
      specimenUuid: Value(specimenUuid),
      projectUuid: projectUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(projectUuid),
      speciesID: speciesID == null && nullToAbsent
          ? const Value.absent()
          : Value(speciesID),
      taxonGroup: taxonGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(taxonGroup),
      condition: condition == null && nullToAbsent
          ? const Value.absent()
          : Value(condition),
      prepDate: prepDate == null && nullToAbsent
          ? const Value.absent()
          : Value(prepDate),
      prepTime: prepTime == null && nullToAbsent
          ? const Value.absent()
          : Value(prepTime),
      captureDate: captureDate == null && nullToAbsent
          ? const Value.absent()
          : Value(captureDate),
      captureTime: captureTime == null && nullToAbsent
          ? const Value.absent()
          : Value(captureTime),
      trapType: trapType == null && nullToAbsent
          ? const Value.absent()
          : Value(trapType),
      collectorID: collectorID == null && nullToAbsent
          ? const Value.absent()
          : Value(collectorID),
      collEventID: collEventID == null && nullToAbsent
          ? const Value.absent()
          : Value(collEventID),
      preparatorID: preparatorID == null && nullToAbsent
          ? const Value.absent()
          : Value(preparatorID),
    );
  }

  factory SpecimenData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpecimenData(
      specimenUuid: serializer.fromJson<String>(json['specimenUuid']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      speciesID: serializer.fromJson<int?>(json['speciesID']),
      taxonGroup: serializer.fromJson<String?>(json['taxonGroup']),
      condition: serializer.fromJson<String?>(json['condition']),
      prepDate: serializer.fromJson<String?>(json['prepDate']),
      prepTime: serializer.fromJson<String?>(json['prepTime']),
      captureDate: serializer.fromJson<String?>(json['captureDate']),
      captureTime: serializer.fromJson<String?>(json['captureTime']),
      trapType: serializer.fromJson<String?>(json['trapType']),
      collectorID: serializer.fromJson<String?>(json['collectorID']),
      collEventID: serializer.fromJson<int?>(json['collEventID']),
      preparatorID: serializer.fromJson<String?>(json['preparatorID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'specimenUuid': serializer.toJson<String>(specimenUuid),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'speciesID': serializer.toJson<int?>(speciesID),
      'taxonGroup': serializer.toJson<String?>(taxonGroup),
      'condition': serializer.toJson<String?>(condition),
      'prepDate': serializer.toJson<String?>(prepDate),
      'prepTime': serializer.toJson<String?>(prepTime),
      'captureDate': serializer.toJson<String?>(captureDate),
      'captureTime': serializer.toJson<String?>(captureTime),
      'trapType': serializer.toJson<String?>(trapType),
      'collectorID': serializer.toJson<String?>(collectorID),
      'collEventID': serializer.toJson<int?>(collEventID),
      'preparatorID': serializer.toJson<String?>(preparatorID),
    };
  }

  SpecimenData copyWith(
          {String? specimenUuid,
          String? projectUuid,
          int? speciesID,
          String? taxonGroup,
          String? condition,
          String? prepDate,
          String? prepTime,
          String? captureDate,
          String? captureTime,
          String? trapType,
          String? collectorID,
          int? collEventID,
          String? preparatorID}) =>
      SpecimenData(
        specimenUuid: specimenUuid ?? this.specimenUuid,
        projectUuid: projectUuid ?? this.projectUuid,
        speciesID: speciesID ?? this.speciesID,
        taxonGroup: taxonGroup ?? this.taxonGroup,
        condition: condition ?? this.condition,
        prepDate: prepDate ?? this.prepDate,
        prepTime: prepTime ?? this.prepTime,
        captureDate: captureDate ?? this.captureDate,
        captureTime: captureTime ?? this.captureTime,
        trapType: trapType ?? this.trapType,
        collectorID: collectorID ?? this.collectorID,
        collEventID: collEventID ?? this.collEventID,
        preparatorID: preparatorID ?? this.preparatorID,
      );
  @override
  String toString() {
    return (StringBuffer('SpecimenData(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('speciesID: $speciesID, ')
          ..write('taxonGroup: $taxonGroup, ')
          ..write('condition: $condition, ')
          ..write('prepDate: $prepDate, ')
          ..write('prepTime: $prepTime, ')
          ..write('captureDate: $captureDate, ')
          ..write('captureTime: $captureTime, ')
          ..write('trapType: $trapType, ')
          ..write('collectorID: $collectorID, ')
          ..write('collEventID: $collEventID, ')
          ..write('preparatorID: $preparatorID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      specimenUuid,
      projectUuid,
      speciesID,
      taxonGroup,
      condition,
      prepDate,
      prepTime,
      captureDate,
      captureTime,
      trapType,
      collectorID,
      collEventID,
      preparatorID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecimenData &&
          other.specimenUuid == this.specimenUuid &&
          other.projectUuid == this.projectUuid &&
          other.speciesID == this.speciesID &&
          other.taxonGroup == this.taxonGroup &&
          other.condition == this.condition &&
          other.prepDate == this.prepDate &&
          other.prepTime == this.prepTime &&
          other.captureDate == this.captureDate &&
          other.captureTime == this.captureTime &&
          other.trapType == this.trapType &&
          other.collectorID == this.collectorID &&
          other.collEventID == this.collEventID &&
          other.preparatorID == this.preparatorID);
}

class SpecimenCompanion extends UpdateCompanion<SpecimenData> {
  final Value<String> specimenUuid;
  final Value<String?> projectUuid;
  final Value<int?> speciesID;
  final Value<String?> taxonGroup;
  final Value<String?> condition;
  final Value<String?> prepDate;
  final Value<String?> prepTime;
  final Value<String?> captureDate;
  final Value<String?> captureTime;
  final Value<String?> trapType;
  final Value<String?> collectorID;
  final Value<int?> collEventID;
  final Value<String?> preparatorID;
  const SpecimenCompanion({
    this.specimenUuid = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.speciesID = const Value.absent(),
    this.taxonGroup = const Value.absent(),
    this.condition = const Value.absent(),
    this.prepDate = const Value.absent(),
    this.prepTime = const Value.absent(),
    this.captureDate = const Value.absent(),
    this.captureTime = const Value.absent(),
    this.trapType = const Value.absent(),
    this.collectorID = const Value.absent(),
    this.collEventID = const Value.absent(),
    this.preparatorID = const Value.absent(),
  });
  SpecimenCompanion.insert({
    required String specimenUuid,
    this.projectUuid = const Value.absent(),
    this.speciesID = const Value.absent(),
    this.taxonGroup = const Value.absent(),
    this.condition = const Value.absent(),
    this.prepDate = const Value.absent(),
    this.prepTime = const Value.absent(),
    this.captureDate = const Value.absent(),
    this.captureTime = const Value.absent(),
    this.trapType = const Value.absent(),
    this.collectorID = const Value.absent(),
    this.collEventID = const Value.absent(),
    this.preparatorID = const Value.absent(),
  }) : specimenUuid = Value(specimenUuid);
  static Insertable<SpecimenData> custom({
    Expression<String>? specimenUuid,
    Expression<String?>? projectUuid,
    Expression<int?>? speciesID,
    Expression<String?>? taxonGroup,
    Expression<String?>? condition,
    Expression<String?>? prepDate,
    Expression<String?>? prepTime,
    Expression<String?>? captureDate,
    Expression<String?>? captureTime,
    Expression<String?>? trapType,
    Expression<String?>? collectorID,
    Expression<int?>? collEventID,
    Expression<String?>? preparatorID,
  }) {
    return RawValuesInsertable({
      if (specimenUuid != null) 'specimenUuid': specimenUuid,
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (speciesID != null) 'speciesID': speciesID,
      if (taxonGroup != null) 'taxonGroup': taxonGroup,
      if (condition != null) 'condition': condition,
      if (prepDate != null) 'prepDate': prepDate,
      if (prepTime != null) 'prepTime': prepTime,
      if (captureDate != null) 'captureDate': captureDate,
      if (captureTime != null) 'captureTime': captureTime,
      if (trapType != null) 'trapType': trapType,
      if (collectorID != null) 'collectorID': collectorID,
      if (collEventID != null) 'collEventID': collEventID,
      if (preparatorID != null) 'preparatorID': preparatorID,
    });
  }

  SpecimenCompanion copyWith(
      {Value<String>? specimenUuid,
      Value<String?>? projectUuid,
      Value<int?>? speciesID,
      Value<String?>? taxonGroup,
      Value<String?>? condition,
      Value<String?>? prepDate,
      Value<String?>? prepTime,
      Value<String?>? captureDate,
      Value<String?>? captureTime,
      Value<String?>? trapType,
      Value<String?>? collectorID,
      Value<int?>? collEventID,
      Value<String?>? preparatorID}) {
    return SpecimenCompanion(
      specimenUuid: specimenUuid ?? this.specimenUuid,
      projectUuid: projectUuid ?? this.projectUuid,
      speciesID: speciesID ?? this.speciesID,
      taxonGroup: taxonGroup ?? this.taxonGroup,
      condition: condition ?? this.condition,
      prepDate: prepDate ?? this.prepDate,
      prepTime: prepTime ?? this.prepTime,
      captureDate: captureDate ?? this.captureDate,
      captureTime: captureTime ?? this.captureTime,
      trapType: trapType ?? this.trapType,
      collectorID: collectorID ?? this.collectorID,
      collEventID: collEventID ?? this.collEventID,
      preparatorID: preparatorID ?? this.preparatorID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (specimenUuid.present) {
      map['specimenUuid'] = Variable<String>(specimenUuid.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String?>(projectUuid.value);
    }
    if (speciesID.present) {
      map['speciesID'] = Variable<int?>(speciesID.value);
    }
    if (taxonGroup.present) {
      map['taxonGroup'] = Variable<String?>(taxonGroup.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String?>(condition.value);
    }
    if (prepDate.present) {
      map['prepDate'] = Variable<String?>(prepDate.value);
    }
    if (prepTime.present) {
      map['prepTime'] = Variable<String?>(prepTime.value);
    }
    if (captureDate.present) {
      map['captureDate'] = Variable<String?>(captureDate.value);
    }
    if (captureTime.present) {
      map['captureTime'] = Variable<String?>(captureTime.value);
    }
    if (trapType.present) {
      map['trapType'] = Variable<String?>(trapType.value);
    }
    if (collectorID.present) {
      map['collectorID'] = Variable<String?>(collectorID.value);
    }
    if (collEventID.present) {
      map['collEventID'] = Variable<int?>(collEventID.value);
    }
    if (preparatorID.present) {
      map['preparatorID'] = Variable<String?>(preparatorID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecimenCompanion(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('speciesID: $speciesID, ')
          ..write('taxonGroup: $taxonGroup, ')
          ..write('condition: $condition, ')
          ..write('prepDate: $prepDate, ')
          ..write('prepTime: $prepTime, ')
          ..write('captureDate: $captureDate, ')
          ..write('captureTime: $captureTime, ')
          ..write('trapType: $trapType, ')
          ..write('collectorID: $collectorID, ')
          ..write('collEventID: $collEventID, ')
          ..write('preparatorID: $preparatorID')
          ..write(')'))
        .toString();
  }
}

class Specimen extends Table with TableInfo<Specimen, SpecimenData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Specimen(this.attachedDatabase, [this._alias]);
  final VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String?> specimenUuid = GeneratedColumn<String?>(
      'specimenUuid', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL PRIMARY KEY');
  final VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String?> projectUuid = GeneratedColumn<String?>(
      'projectUuid', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _speciesIDMeta = const VerificationMeta('speciesID');
  late final GeneratedColumn<int?> speciesID = GeneratedColumn<int?>(
      'speciesID', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _taxonGroupMeta = const VerificationMeta('taxonGroup');
  late final GeneratedColumn<String?> taxonGroup = GeneratedColumn<String?>(
      'taxonGroup', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _conditionMeta = const VerificationMeta('condition');
  late final GeneratedColumn<String?> condition = GeneratedColumn<String?>(
      'condition', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _prepDateMeta = const VerificationMeta('prepDate');
  late final GeneratedColumn<String?> prepDate = GeneratedColumn<String?>(
      'prepDate', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _prepTimeMeta = const VerificationMeta('prepTime');
  late final GeneratedColumn<String?> prepTime = GeneratedColumn<String?>(
      'prepTime', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _captureDateMeta =
      const VerificationMeta('captureDate');
  late final GeneratedColumn<String?> captureDate = GeneratedColumn<String?>(
      'captureDate', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _captureTimeMeta =
      const VerificationMeta('captureTime');
  late final GeneratedColumn<String?> captureTime = GeneratedColumn<String?>(
      'captureTime', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _trapTypeMeta = const VerificationMeta('trapType');
  late final GeneratedColumn<String?> trapType = GeneratedColumn<String?>(
      'trapType', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _collectorIDMeta =
      const VerificationMeta('collectorID');
  late final GeneratedColumn<String?> collectorID = GeneratedColumn<String?>(
      'collectorID', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _collEventIDMeta =
      const VerificationMeta('collEventID');
  late final GeneratedColumn<int?> collEventID = GeneratedColumn<int?>(
      'collEventID', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _preparatorIDMeta =
      const VerificationMeta('preparatorID');
  late final GeneratedColumn<String?> preparatorID = GeneratedColumn<String?>(
      'preparatorID', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES personnel(id)');
  @override
  List<GeneratedColumn> get $columns => [
        specimenUuid,
        projectUuid,
        speciesID,
        taxonGroup,
        condition,
        prepDate,
        prepTime,
        captureDate,
        captureTime,
        trapType,
        collectorID,
        collEventID,
        preparatorID
      ];
  @override
  String get aliasedName => _alias ?? 'specimen';
  @override
  String get actualTableName => 'specimen';
  @override
  VerificationContext validateIntegrity(Insertable<SpecimenData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('specimenUuid')) {
      context.handle(
          _specimenUuidMeta,
          specimenUuid.isAcceptableOrUnknown(
              data['specimenUuid']!, _specimenUuidMeta));
    } else if (isInserting) {
      context.missing(_specimenUuidMeta);
    }
    if (data.containsKey('projectUuid')) {
      context.handle(
          _projectUuidMeta,
          projectUuid.isAcceptableOrUnknown(
              data['projectUuid']!, _projectUuidMeta));
    }
    if (data.containsKey('speciesID')) {
      context.handle(_speciesIDMeta,
          speciesID.isAcceptableOrUnknown(data['speciesID']!, _speciesIDMeta));
    }
    if (data.containsKey('taxonGroup')) {
      context.handle(
          _taxonGroupMeta,
          taxonGroup.isAcceptableOrUnknown(
              data['taxonGroup']!, _taxonGroupMeta));
    }
    if (data.containsKey('condition')) {
      context.handle(_conditionMeta,
          condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta));
    }
    if (data.containsKey('prepDate')) {
      context.handle(_prepDateMeta,
          prepDate.isAcceptableOrUnknown(data['prepDate']!, _prepDateMeta));
    }
    if (data.containsKey('prepTime')) {
      context.handle(_prepTimeMeta,
          prepTime.isAcceptableOrUnknown(data['prepTime']!, _prepTimeMeta));
    }
    if (data.containsKey('captureDate')) {
      context.handle(
          _captureDateMeta,
          captureDate.isAcceptableOrUnknown(
              data['captureDate']!, _captureDateMeta));
    }
    if (data.containsKey('captureTime')) {
      context.handle(
          _captureTimeMeta,
          captureTime.isAcceptableOrUnknown(
              data['captureTime']!, _captureTimeMeta));
    }
    if (data.containsKey('trapType')) {
      context.handle(_trapTypeMeta,
          trapType.isAcceptableOrUnknown(data['trapType']!, _trapTypeMeta));
    }
    if (data.containsKey('collectorID')) {
      context.handle(
          _collectorIDMeta,
          collectorID.isAcceptableOrUnknown(
              data['collectorID']!, _collectorIDMeta));
    }
    if (data.containsKey('collEventID')) {
      context.handle(
          _collEventIDMeta,
          collEventID.isAcceptableOrUnknown(
              data['collEventID']!, _collEventIDMeta));
    }
    if (data.containsKey('preparatorID')) {
      context.handle(
          _preparatorIDMeta,
          preparatorID.isAcceptableOrUnknown(
              data['preparatorID']!, _preparatorIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {specimenUuid};
  @override
  SpecimenData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SpecimenData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Specimen createAlias(String alias) {
    return Specimen(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(collectorID) REFERENCES personnel(id)',
        'FOREIGN KEY(collEventID) REFERENCES collEvent(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class MammalMeasurementData extends DataClass
    implements Insertable<MammalMeasurementData> {
  final int id;
  final String? specimenUuid;
  final int? totalLength;
  final int? tailLength;
  final int? hindFootLength;
  final int? earLength;
  final int? forearm;
  final int? weight;
  final String? inaccurate;
  final String? inaccurateReason;
  final String? sex;
  final String? lifeStage;
  final String? testesPosition;
  final int? testesLength;
  final int? testesWidth;
  final String? reproductiveStage;
  final String? placentalScars;
  final int? mammaeInguinalCount;
  final int? mammaeAxilaryCount;
  final int? mammaeAbdominalCount;
  final int? embryoLeftCount;
  final int? embryoRightCount;
  final int? embryoCRLeft;
  final int? embryoCRRight;
  MammalMeasurementData(
      {required this.id,
      this.specimenUuid,
      this.totalLength,
      this.tailLength,
      this.hindFootLength,
      this.earLength,
      this.forearm,
      this.weight,
      this.inaccurate,
      this.inaccurateReason,
      this.sex,
      this.lifeStage,
      this.testesPosition,
      this.testesLength,
      this.testesWidth,
      this.reproductiveStage,
      this.placentalScars,
      this.mammaeInguinalCount,
      this.mammaeAxilaryCount,
      this.mammaeAbdominalCount,
      this.embryoLeftCount,
      this.embryoRightCount,
      this.embryoCRLeft,
      this.embryoCRRight});
  factory MammalMeasurementData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MammalMeasurementData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      specimenUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}specimenUuid']),
      totalLength: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}totalLength']),
      tailLength: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tailLength']),
      hindFootLength: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hindFootLength']),
      earLength: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}earLength']),
      forearm: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}forearm']),
      weight: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}weight']),
      inaccurate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}inaccurate']),
      inaccurateReason: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}inaccurateReason']),
      sex: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sex']),
      lifeStage: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lifeStage']),
      testesPosition: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}testesPosition']),
      testesLength: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}testesLength']),
      testesWidth: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}testesWidth']),
      reproductiveStage: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}reproductiveStage']),
      placentalScars: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}placentalScars']),
      mammaeInguinalCount: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}mammaeInguinalCount']),
      mammaeAxilaryCount: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}mammaeAxilaryCount']),
      mammaeAbdominalCount: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}mammaeAbdominalCount']),
      embryoLeftCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}embryoLeftCount']),
      embryoRightCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}embryoRightCount']),
      embryoCRLeft: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}embryoCRLeft']),
      embryoCRRight: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}embryoCRRight']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || specimenUuid != null) {
      map['specimenUuid'] = Variable<String?>(specimenUuid);
    }
    if (!nullToAbsent || totalLength != null) {
      map['totalLength'] = Variable<int?>(totalLength);
    }
    if (!nullToAbsent || tailLength != null) {
      map['tailLength'] = Variable<int?>(tailLength);
    }
    if (!nullToAbsent || hindFootLength != null) {
      map['hindFootLength'] = Variable<int?>(hindFootLength);
    }
    if (!nullToAbsent || earLength != null) {
      map['earLength'] = Variable<int?>(earLength);
    }
    if (!nullToAbsent || forearm != null) {
      map['forearm'] = Variable<int?>(forearm);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int?>(weight);
    }
    if (!nullToAbsent || inaccurate != null) {
      map['inaccurate'] = Variable<String?>(inaccurate);
    }
    if (!nullToAbsent || inaccurateReason != null) {
      map['inaccurateReason'] = Variable<String?>(inaccurateReason);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<String?>(sex);
    }
    if (!nullToAbsent || lifeStage != null) {
      map['lifeStage'] = Variable<String?>(lifeStage);
    }
    if (!nullToAbsent || testesPosition != null) {
      map['testesPosition'] = Variable<String?>(testesPosition);
    }
    if (!nullToAbsent || testesLength != null) {
      map['testesLength'] = Variable<int?>(testesLength);
    }
    if (!nullToAbsent || testesWidth != null) {
      map['testesWidth'] = Variable<int?>(testesWidth);
    }
    if (!nullToAbsent || reproductiveStage != null) {
      map['reproductiveStage'] = Variable<String?>(reproductiveStage);
    }
    if (!nullToAbsent || placentalScars != null) {
      map['placentalScars'] = Variable<String?>(placentalScars);
    }
    if (!nullToAbsent || mammaeInguinalCount != null) {
      map['mammaeInguinalCount'] = Variable<int?>(mammaeInguinalCount);
    }
    if (!nullToAbsent || mammaeAxilaryCount != null) {
      map['mammaeAxilaryCount'] = Variable<int?>(mammaeAxilaryCount);
    }
    if (!nullToAbsent || mammaeAbdominalCount != null) {
      map['mammaeAbdominalCount'] = Variable<int?>(mammaeAbdominalCount);
    }
    if (!nullToAbsent || embryoLeftCount != null) {
      map['embryoLeftCount'] = Variable<int?>(embryoLeftCount);
    }
    if (!nullToAbsent || embryoRightCount != null) {
      map['embryoRightCount'] = Variable<int?>(embryoRightCount);
    }
    if (!nullToAbsent || embryoCRLeft != null) {
      map['embryoCRLeft'] = Variable<int?>(embryoCRLeft);
    }
    if (!nullToAbsent || embryoCRRight != null) {
      map['embryoCRRight'] = Variable<int?>(embryoCRRight);
    }
    return map;
  }

  MammalMeasurementCompanion toCompanion(bool nullToAbsent) {
    return MammalMeasurementCompanion(
      id: Value(id),
      specimenUuid: specimenUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(specimenUuid),
      totalLength: totalLength == null && nullToAbsent
          ? const Value.absent()
          : Value(totalLength),
      tailLength: tailLength == null && nullToAbsent
          ? const Value.absent()
          : Value(tailLength),
      hindFootLength: hindFootLength == null && nullToAbsent
          ? const Value.absent()
          : Value(hindFootLength),
      earLength: earLength == null && nullToAbsent
          ? const Value.absent()
          : Value(earLength),
      forearm: forearm == null && nullToAbsent
          ? const Value.absent()
          : Value(forearm),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      inaccurate: inaccurate == null && nullToAbsent
          ? const Value.absent()
          : Value(inaccurate),
      inaccurateReason: inaccurateReason == null && nullToAbsent
          ? const Value.absent()
          : Value(inaccurateReason),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      lifeStage: lifeStage == null && nullToAbsent
          ? const Value.absent()
          : Value(lifeStage),
      testesPosition: testesPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(testesPosition),
      testesLength: testesLength == null && nullToAbsent
          ? const Value.absent()
          : Value(testesLength),
      testesWidth: testesWidth == null && nullToAbsent
          ? const Value.absent()
          : Value(testesWidth),
      reproductiveStage: reproductiveStage == null && nullToAbsent
          ? const Value.absent()
          : Value(reproductiveStage),
      placentalScars: placentalScars == null && nullToAbsent
          ? const Value.absent()
          : Value(placentalScars),
      mammaeInguinalCount: mammaeInguinalCount == null && nullToAbsent
          ? const Value.absent()
          : Value(mammaeInguinalCount),
      mammaeAxilaryCount: mammaeAxilaryCount == null && nullToAbsent
          ? const Value.absent()
          : Value(mammaeAxilaryCount),
      mammaeAbdominalCount: mammaeAbdominalCount == null && nullToAbsent
          ? const Value.absent()
          : Value(mammaeAbdominalCount),
      embryoLeftCount: embryoLeftCount == null && nullToAbsent
          ? const Value.absent()
          : Value(embryoLeftCount),
      embryoRightCount: embryoRightCount == null && nullToAbsent
          ? const Value.absent()
          : Value(embryoRightCount),
      embryoCRLeft: embryoCRLeft == null && nullToAbsent
          ? const Value.absent()
          : Value(embryoCRLeft),
      embryoCRRight: embryoCRRight == null && nullToAbsent
          ? const Value.absent()
          : Value(embryoCRRight),
    );
  }

  factory MammalMeasurementData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MammalMeasurementData(
      id: serializer.fromJson<int>(json['id']),
      specimenUuid: serializer.fromJson<String?>(json['specimenUuid']),
      totalLength: serializer.fromJson<int?>(json['totalLength']),
      tailLength: serializer.fromJson<int?>(json['tailLength']),
      hindFootLength: serializer.fromJson<int?>(json['hindFootLength']),
      earLength: serializer.fromJson<int?>(json['earLength']),
      forearm: serializer.fromJson<int?>(json['forearm']),
      weight: serializer.fromJson<int?>(json['weight']),
      inaccurate: serializer.fromJson<String?>(json['inaccurate']),
      inaccurateReason: serializer.fromJson<String?>(json['inaccurateReason']),
      sex: serializer.fromJson<String?>(json['sex']),
      lifeStage: serializer.fromJson<String?>(json['lifeStage']),
      testesPosition: serializer.fromJson<String?>(json['testesPosition']),
      testesLength: serializer.fromJson<int?>(json['testesLength']),
      testesWidth: serializer.fromJson<int?>(json['testesWidth']),
      reproductiveStage:
          serializer.fromJson<String?>(json['reproductiveStage']),
      placentalScars: serializer.fromJson<String?>(json['placentalScars']),
      mammaeInguinalCount:
          serializer.fromJson<int?>(json['mammaeInguinalCount']),
      mammaeAxilaryCount: serializer.fromJson<int?>(json['mammaeAxilaryCount']),
      mammaeAbdominalCount:
          serializer.fromJson<int?>(json['mammaeAbdominalCount']),
      embryoLeftCount: serializer.fromJson<int?>(json['embryoLeftCount']),
      embryoRightCount: serializer.fromJson<int?>(json['embryoRightCount']),
      embryoCRLeft: serializer.fromJson<int?>(json['embryoCRLeft']),
      embryoCRRight: serializer.fromJson<int?>(json['embryoCRRight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'specimenUuid': serializer.toJson<String?>(specimenUuid),
      'totalLength': serializer.toJson<int?>(totalLength),
      'tailLength': serializer.toJson<int?>(tailLength),
      'hindFootLength': serializer.toJson<int?>(hindFootLength),
      'earLength': serializer.toJson<int?>(earLength),
      'forearm': serializer.toJson<int?>(forearm),
      'weight': serializer.toJson<int?>(weight),
      'inaccurate': serializer.toJson<String?>(inaccurate),
      'inaccurateReason': serializer.toJson<String?>(inaccurateReason),
      'sex': serializer.toJson<String?>(sex),
      'lifeStage': serializer.toJson<String?>(lifeStage),
      'testesPosition': serializer.toJson<String?>(testesPosition),
      'testesLength': serializer.toJson<int?>(testesLength),
      'testesWidth': serializer.toJson<int?>(testesWidth),
      'reproductiveStage': serializer.toJson<String?>(reproductiveStage),
      'placentalScars': serializer.toJson<String?>(placentalScars),
      'mammaeInguinalCount': serializer.toJson<int?>(mammaeInguinalCount),
      'mammaeAxilaryCount': serializer.toJson<int?>(mammaeAxilaryCount),
      'mammaeAbdominalCount': serializer.toJson<int?>(mammaeAbdominalCount),
      'embryoLeftCount': serializer.toJson<int?>(embryoLeftCount),
      'embryoRightCount': serializer.toJson<int?>(embryoRightCount),
      'embryoCRLeft': serializer.toJson<int?>(embryoCRLeft),
      'embryoCRRight': serializer.toJson<int?>(embryoCRRight),
    };
  }

  MammalMeasurementData copyWith(
          {int? id,
          String? specimenUuid,
          int? totalLength,
          int? tailLength,
          int? hindFootLength,
          int? earLength,
          int? forearm,
          int? weight,
          String? inaccurate,
          String? inaccurateReason,
          String? sex,
          String? lifeStage,
          String? testesPosition,
          int? testesLength,
          int? testesWidth,
          String? reproductiveStage,
          String? placentalScars,
          int? mammaeInguinalCount,
          int? mammaeAxilaryCount,
          int? mammaeAbdominalCount,
          int? embryoLeftCount,
          int? embryoRightCount,
          int? embryoCRLeft,
          int? embryoCRRight}) =>
      MammalMeasurementData(
        id: id ?? this.id,
        specimenUuid: specimenUuid ?? this.specimenUuid,
        totalLength: totalLength ?? this.totalLength,
        tailLength: tailLength ?? this.tailLength,
        hindFootLength: hindFootLength ?? this.hindFootLength,
        earLength: earLength ?? this.earLength,
        forearm: forearm ?? this.forearm,
        weight: weight ?? this.weight,
        inaccurate: inaccurate ?? this.inaccurate,
        inaccurateReason: inaccurateReason ?? this.inaccurateReason,
        sex: sex ?? this.sex,
        lifeStage: lifeStage ?? this.lifeStage,
        testesPosition: testesPosition ?? this.testesPosition,
        testesLength: testesLength ?? this.testesLength,
        testesWidth: testesWidth ?? this.testesWidth,
        reproductiveStage: reproductiveStage ?? this.reproductiveStage,
        placentalScars: placentalScars ?? this.placentalScars,
        mammaeInguinalCount: mammaeInguinalCount ?? this.mammaeInguinalCount,
        mammaeAxilaryCount: mammaeAxilaryCount ?? this.mammaeAxilaryCount,
        mammaeAbdominalCount: mammaeAbdominalCount ?? this.mammaeAbdominalCount,
        embryoLeftCount: embryoLeftCount ?? this.embryoLeftCount,
        embryoRightCount: embryoRightCount ?? this.embryoRightCount,
        embryoCRLeft: embryoCRLeft ?? this.embryoCRLeft,
        embryoCRRight: embryoCRRight ?? this.embryoCRRight,
      );
  @override
  String toString() {
    return (StringBuffer('MammalMeasurementData(')
          ..write('id: $id, ')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('totalLength: $totalLength, ')
          ..write('tailLength: $tailLength, ')
          ..write('hindFootLength: $hindFootLength, ')
          ..write('earLength: $earLength, ')
          ..write('forearm: $forearm, ')
          ..write('weight: $weight, ')
          ..write('inaccurate: $inaccurate, ')
          ..write('inaccurateReason: $inaccurateReason, ')
          ..write('sex: $sex, ')
          ..write('lifeStage: $lifeStage, ')
          ..write('testesPosition: $testesPosition, ')
          ..write('testesLength: $testesLength, ')
          ..write('testesWidth: $testesWidth, ')
          ..write('reproductiveStage: $reproductiveStage, ')
          ..write('placentalScars: $placentalScars, ')
          ..write('mammaeInguinalCount: $mammaeInguinalCount, ')
          ..write('mammaeAxilaryCount: $mammaeAxilaryCount, ')
          ..write('mammaeAbdominalCount: $mammaeAbdominalCount, ')
          ..write('embryoLeftCount: $embryoLeftCount, ')
          ..write('embryoRightCount: $embryoRightCount, ')
          ..write('embryoCRLeft: $embryoCRLeft, ')
          ..write('embryoCRRight: $embryoCRRight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        specimenUuid,
        totalLength,
        tailLength,
        hindFootLength,
        earLength,
        forearm,
        weight,
        inaccurate,
        inaccurateReason,
        sex,
        lifeStage,
        testesPosition,
        testesLength,
        testesWidth,
        reproductiveStage,
        placentalScars,
        mammaeInguinalCount,
        mammaeAxilaryCount,
        mammaeAbdominalCount,
        embryoLeftCount,
        embryoRightCount,
        embryoCRLeft,
        embryoCRRight
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MammalMeasurementData &&
          other.id == this.id &&
          other.specimenUuid == this.specimenUuid &&
          other.totalLength == this.totalLength &&
          other.tailLength == this.tailLength &&
          other.hindFootLength == this.hindFootLength &&
          other.earLength == this.earLength &&
          other.forearm == this.forearm &&
          other.weight == this.weight &&
          other.inaccurate == this.inaccurate &&
          other.inaccurateReason == this.inaccurateReason &&
          other.sex == this.sex &&
          other.lifeStage == this.lifeStage &&
          other.testesPosition == this.testesPosition &&
          other.testesLength == this.testesLength &&
          other.testesWidth == this.testesWidth &&
          other.reproductiveStage == this.reproductiveStage &&
          other.placentalScars == this.placentalScars &&
          other.mammaeInguinalCount == this.mammaeInguinalCount &&
          other.mammaeAxilaryCount == this.mammaeAxilaryCount &&
          other.mammaeAbdominalCount == this.mammaeAbdominalCount &&
          other.embryoLeftCount == this.embryoLeftCount &&
          other.embryoRightCount == this.embryoRightCount &&
          other.embryoCRLeft == this.embryoCRLeft &&
          other.embryoCRRight == this.embryoCRRight);
}

class MammalMeasurementCompanion
    extends UpdateCompanion<MammalMeasurementData> {
  final Value<int> id;
  final Value<String?> specimenUuid;
  final Value<int?> totalLength;
  final Value<int?> tailLength;
  final Value<int?> hindFootLength;
  final Value<int?> earLength;
  final Value<int?> forearm;
  final Value<int?> weight;
  final Value<String?> inaccurate;
  final Value<String?> inaccurateReason;
  final Value<String?> sex;
  final Value<String?> lifeStage;
  final Value<String?> testesPosition;
  final Value<int?> testesLength;
  final Value<int?> testesWidth;
  final Value<String?> reproductiveStage;
  final Value<String?> placentalScars;
  final Value<int?> mammaeInguinalCount;
  final Value<int?> mammaeAxilaryCount;
  final Value<int?> mammaeAbdominalCount;
  final Value<int?> embryoLeftCount;
  final Value<int?> embryoRightCount;
  final Value<int?> embryoCRLeft;
  final Value<int?> embryoCRRight;
  const MammalMeasurementCompanion({
    this.id = const Value.absent(),
    this.specimenUuid = const Value.absent(),
    this.totalLength = const Value.absent(),
    this.tailLength = const Value.absent(),
    this.hindFootLength = const Value.absent(),
    this.earLength = const Value.absent(),
    this.forearm = const Value.absent(),
    this.weight = const Value.absent(),
    this.inaccurate = const Value.absent(),
    this.inaccurateReason = const Value.absent(),
    this.sex = const Value.absent(),
    this.lifeStage = const Value.absent(),
    this.testesPosition = const Value.absent(),
    this.testesLength = const Value.absent(),
    this.testesWidth = const Value.absent(),
    this.reproductiveStage = const Value.absent(),
    this.placentalScars = const Value.absent(),
    this.mammaeInguinalCount = const Value.absent(),
    this.mammaeAxilaryCount = const Value.absent(),
    this.mammaeAbdominalCount = const Value.absent(),
    this.embryoLeftCount = const Value.absent(),
    this.embryoRightCount = const Value.absent(),
    this.embryoCRLeft = const Value.absent(),
    this.embryoCRRight = const Value.absent(),
  });
  MammalMeasurementCompanion.insert({
    this.id = const Value.absent(),
    this.specimenUuid = const Value.absent(),
    this.totalLength = const Value.absent(),
    this.tailLength = const Value.absent(),
    this.hindFootLength = const Value.absent(),
    this.earLength = const Value.absent(),
    this.forearm = const Value.absent(),
    this.weight = const Value.absent(),
    this.inaccurate = const Value.absent(),
    this.inaccurateReason = const Value.absent(),
    this.sex = const Value.absent(),
    this.lifeStage = const Value.absent(),
    this.testesPosition = const Value.absent(),
    this.testesLength = const Value.absent(),
    this.testesWidth = const Value.absent(),
    this.reproductiveStage = const Value.absent(),
    this.placentalScars = const Value.absent(),
    this.mammaeInguinalCount = const Value.absent(),
    this.mammaeAxilaryCount = const Value.absent(),
    this.mammaeAbdominalCount = const Value.absent(),
    this.embryoLeftCount = const Value.absent(),
    this.embryoRightCount = const Value.absent(),
    this.embryoCRLeft = const Value.absent(),
    this.embryoCRRight = const Value.absent(),
  });
  static Insertable<MammalMeasurementData> custom({
    Expression<int>? id,
    Expression<String?>? specimenUuid,
    Expression<int?>? totalLength,
    Expression<int?>? tailLength,
    Expression<int?>? hindFootLength,
    Expression<int?>? earLength,
    Expression<int?>? forearm,
    Expression<int?>? weight,
    Expression<String?>? inaccurate,
    Expression<String?>? inaccurateReason,
    Expression<String?>? sex,
    Expression<String?>? lifeStage,
    Expression<String?>? testesPosition,
    Expression<int?>? testesLength,
    Expression<int?>? testesWidth,
    Expression<String?>? reproductiveStage,
    Expression<String?>? placentalScars,
    Expression<int?>? mammaeInguinalCount,
    Expression<int?>? mammaeAxilaryCount,
    Expression<int?>? mammaeAbdominalCount,
    Expression<int?>? embryoLeftCount,
    Expression<int?>? embryoRightCount,
    Expression<int?>? embryoCRLeft,
    Expression<int?>? embryoCRRight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (specimenUuid != null) 'specimenUuid': specimenUuid,
      if (totalLength != null) 'totalLength': totalLength,
      if (tailLength != null) 'tailLength': tailLength,
      if (hindFootLength != null) 'hindFootLength': hindFootLength,
      if (earLength != null) 'earLength': earLength,
      if (forearm != null) 'forearm': forearm,
      if (weight != null) 'weight': weight,
      if (inaccurate != null) 'inaccurate': inaccurate,
      if (inaccurateReason != null) 'inaccurateReason': inaccurateReason,
      if (sex != null) 'sex': sex,
      if (lifeStage != null) 'lifeStage': lifeStage,
      if (testesPosition != null) 'testesPosition': testesPosition,
      if (testesLength != null) 'testesLength': testesLength,
      if (testesWidth != null) 'testesWidth': testesWidth,
      if (reproductiveStage != null) 'reproductiveStage': reproductiveStage,
      if (placentalScars != null) 'placentalScars': placentalScars,
      if (mammaeInguinalCount != null)
        'mammaeInguinalCount': mammaeInguinalCount,
      if (mammaeAxilaryCount != null) 'mammaeAxilaryCount': mammaeAxilaryCount,
      if (mammaeAbdominalCount != null)
        'mammaeAbdominalCount': mammaeAbdominalCount,
      if (embryoLeftCount != null) 'embryoLeftCount': embryoLeftCount,
      if (embryoRightCount != null) 'embryoRightCount': embryoRightCount,
      if (embryoCRLeft != null) 'embryoCRLeft': embryoCRLeft,
      if (embryoCRRight != null) 'embryoCRRight': embryoCRRight,
    });
  }

  MammalMeasurementCompanion copyWith(
      {Value<int>? id,
      Value<String?>? specimenUuid,
      Value<int?>? totalLength,
      Value<int?>? tailLength,
      Value<int?>? hindFootLength,
      Value<int?>? earLength,
      Value<int?>? forearm,
      Value<int?>? weight,
      Value<String?>? inaccurate,
      Value<String?>? inaccurateReason,
      Value<String?>? sex,
      Value<String?>? lifeStage,
      Value<String?>? testesPosition,
      Value<int?>? testesLength,
      Value<int?>? testesWidth,
      Value<String?>? reproductiveStage,
      Value<String?>? placentalScars,
      Value<int?>? mammaeInguinalCount,
      Value<int?>? mammaeAxilaryCount,
      Value<int?>? mammaeAbdominalCount,
      Value<int?>? embryoLeftCount,
      Value<int?>? embryoRightCount,
      Value<int?>? embryoCRLeft,
      Value<int?>? embryoCRRight}) {
    return MammalMeasurementCompanion(
      id: id ?? this.id,
      specimenUuid: specimenUuid ?? this.specimenUuid,
      totalLength: totalLength ?? this.totalLength,
      tailLength: tailLength ?? this.tailLength,
      hindFootLength: hindFootLength ?? this.hindFootLength,
      earLength: earLength ?? this.earLength,
      forearm: forearm ?? this.forearm,
      weight: weight ?? this.weight,
      inaccurate: inaccurate ?? this.inaccurate,
      inaccurateReason: inaccurateReason ?? this.inaccurateReason,
      sex: sex ?? this.sex,
      lifeStage: lifeStage ?? this.lifeStage,
      testesPosition: testesPosition ?? this.testesPosition,
      testesLength: testesLength ?? this.testesLength,
      testesWidth: testesWidth ?? this.testesWidth,
      reproductiveStage: reproductiveStage ?? this.reproductiveStage,
      placentalScars: placentalScars ?? this.placentalScars,
      mammaeInguinalCount: mammaeInguinalCount ?? this.mammaeInguinalCount,
      mammaeAxilaryCount: mammaeAxilaryCount ?? this.mammaeAxilaryCount,
      mammaeAbdominalCount: mammaeAbdominalCount ?? this.mammaeAbdominalCount,
      embryoLeftCount: embryoLeftCount ?? this.embryoLeftCount,
      embryoRightCount: embryoRightCount ?? this.embryoRightCount,
      embryoCRLeft: embryoCRLeft ?? this.embryoCRLeft,
      embryoCRRight: embryoCRRight ?? this.embryoCRRight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (specimenUuid.present) {
      map['specimenUuid'] = Variable<String?>(specimenUuid.value);
    }
    if (totalLength.present) {
      map['totalLength'] = Variable<int?>(totalLength.value);
    }
    if (tailLength.present) {
      map['tailLength'] = Variable<int?>(tailLength.value);
    }
    if (hindFootLength.present) {
      map['hindFootLength'] = Variable<int?>(hindFootLength.value);
    }
    if (earLength.present) {
      map['earLength'] = Variable<int?>(earLength.value);
    }
    if (forearm.present) {
      map['forearm'] = Variable<int?>(forearm.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int?>(weight.value);
    }
    if (inaccurate.present) {
      map['inaccurate'] = Variable<String?>(inaccurate.value);
    }
    if (inaccurateReason.present) {
      map['inaccurateReason'] = Variable<String?>(inaccurateReason.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String?>(sex.value);
    }
    if (lifeStage.present) {
      map['lifeStage'] = Variable<String?>(lifeStage.value);
    }
    if (testesPosition.present) {
      map['testesPosition'] = Variable<String?>(testesPosition.value);
    }
    if (testesLength.present) {
      map['testesLength'] = Variable<int?>(testesLength.value);
    }
    if (testesWidth.present) {
      map['testesWidth'] = Variable<int?>(testesWidth.value);
    }
    if (reproductiveStage.present) {
      map['reproductiveStage'] = Variable<String?>(reproductiveStage.value);
    }
    if (placentalScars.present) {
      map['placentalScars'] = Variable<String?>(placentalScars.value);
    }
    if (mammaeInguinalCount.present) {
      map['mammaeInguinalCount'] = Variable<int?>(mammaeInguinalCount.value);
    }
    if (mammaeAxilaryCount.present) {
      map['mammaeAxilaryCount'] = Variable<int?>(mammaeAxilaryCount.value);
    }
    if (mammaeAbdominalCount.present) {
      map['mammaeAbdominalCount'] = Variable<int?>(mammaeAbdominalCount.value);
    }
    if (embryoLeftCount.present) {
      map['embryoLeftCount'] = Variable<int?>(embryoLeftCount.value);
    }
    if (embryoRightCount.present) {
      map['embryoRightCount'] = Variable<int?>(embryoRightCount.value);
    }
    if (embryoCRLeft.present) {
      map['embryoCRLeft'] = Variable<int?>(embryoCRLeft.value);
    }
    if (embryoCRRight.present) {
      map['embryoCRRight'] = Variable<int?>(embryoCRRight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MammalMeasurementCompanion(')
          ..write('id: $id, ')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('totalLength: $totalLength, ')
          ..write('tailLength: $tailLength, ')
          ..write('hindFootLength: $hindFootLength, ')
          ..write('earLength: $earLength, ')
          ..write('forearm: $forearm, ')
          ..write('weight: $weight, ')
          ..write('inaccurate: $inaccurate, ')
          ..write('inaccurateReason: $inaccurateReason, ')
          ..write('sex: $sex, ')
          ..write('lifeStage: $lifeStage, ')
          ..write('testesPosition: $testesPosition, ')
          ..write('testesLength: $testesLength, ')
          ..write('testesWidth: $testesWidth, ')
          ..write('reproductiveStage: $reproductiveStage, ')
          ..write('placentalScars: $placentalScars, ')
          ..write('mammaeInguinalCount: $mammaeInguinalCount, ')
          ..write('mammaeAxilaryCount: $mammaeAxilaryCount, ')
          ..write('mammaeAbdominalCount: $mammaeAbdominalCount, ')
          ..write('embryoLeftCount: $embryoLeftCount, ')
          ..write('embryoRightCount: $embryoRightCount, ')
          ..write('embryoCRLeft: $embryoCRLeft, ')
          ..write('embryoCRRight: $embryoCRRight')
          ..write(')'))
        .toString();
  }
}

class MammalMeasurement extends Table
    with TableInfo<MammalMeasurement, MammalMeasurementData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  MammalMeasurement(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String?> specimenUuid = GeneratedColumn<String?>(
      'specimenUuid', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _totalLengthMeta =
      const VerificationMeta('totalLength');
  late final GeneratedColumn<int?> totalLength = GeneratedColumn<int?>(
      'totalLength', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _tailLengthMeta = const VerificationMeta('tailLength');
  late final GeneratedColumn<int?> tailLength = GeneratedColumn<int?>(
      'tailLength', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _hindFootLengthMeta =
      const VerificationMeta('hindFootLength');
  late final GeneratedColumn<int?> hindFootLength = GeneratedColumn<int?>(
      'hindFootLength', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _earLengthMeta = const VerificationMeta('earLength');
  late final GeneratedColumn<int?> earLength = GeneratedColumn<int?>(
      'earLength', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _forearmMeta = const VerificationMeta('forearm');
  late final GeneratedColumn<int?> forearm = GeneratedColumn<int?>(
      'forearm', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  late final GeneratedColumn<int?> weight = GeneratedColumn<int?>(
      'weight', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _inaccurateMeta = const VerificationMeta('inaccurate');
  late final GeneratedColumn<String?> inaccurate = GeneratedColumn<String?>(
      'inaccurate', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _inaccurateReasonMeta =
      const VerificationMeta('inaccurateReason');
  late final GeneratedColumn<String?> inaccurateReason =
      GeneratedColumn<String?>('inaccurateReason', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumn<String?> sex = GeneratedColumn<String?>(
      'sex', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _lifeStageMeta = const VerificationMeta('lifeStage');
  late final GeneratedColumn<String?> lifeStage = GeneratedColumn<String?>(
      'lifeStage', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _testesPositionMeta =
      const VerificationMeta('testesPosition');
  late final GeneratedColumn<String?> testesPosition = GeneratedColumn<String?>(
      'testesPosition', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _testesLengthMeta =
      const VerificationMeta('testesLength');
  late final GeneratedColumn<int?> testesLength = GeneratedColumn<int?>(
      'testesLength', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _testesWidthMeta =
      const VerificationMeta('testesWidth');
  late final GeneratedColumn<int?> testesWidth = GeneratedColumn<int?>(
      'testesWidth', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _reproductiveStageMeta =
      const VerificationMeta('reproductiveStage');
  late final GeneratedColumn<String?> reproductiveStage =
      GeneratedColumn<String?>('reproductiveStage', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _placentalScarsMeta =
      const VerificationMeta('placentalScars');
  late final GeneratedColumn<String?> placentalScars = GeneratedColumn<String?>(
      'placentalScars', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _mammaeInguinalCountMeta =
      const VerificationMeta('mammaeInguinalCount');
  late final GeneratedColumn<int?> mammaeInguinalCount = GeneratedColumn<int?>(
      'mammaeInguinalCount', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _mammaeAxilaryCountMeta =
      const VerificationMeta('mammaeAxilaryCount');
  late final GeneratedColumn<int?> mammaeAxilaryCount = GeneratedColumn<int?>(
      'mammaeAxilaryCount', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _mammaeAbdominalCountMeta =
      const VerificationMeta('mammaeAbdominalCount');
  late final GeneratedColumn<int?> mammaeAbdominalCount = GeneratedColumn<int?>(
      'mammaeAbdominalCount', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _embryoLeftCountMeta =
      const VerificationMeta('embryoLeftCount');
  late final GeneratedColumn<int?> embryoLeftCount = GeneratedColumn<int?>(
      'embryoLeftCount', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _embryoRightCountMeta =
      const VerificationMeta('embryoRightCount');
  late final GeneratedColumn<int?> embryoRightCount = GeneratedColumn<int?>(
      'embryoRightCount', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _embryoCRLeftMeta =
      const VerificationMeta('embryoCRLeft');
  late final GeneratedColumn<int?> embryoCRLeft = GeneratedColumn<int?>(
      'embryoCRLeft', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _embryoCRRightMeta =
      const VerificationMeta('embryoCRRight');
  late final GeneratedColumn<int?> embryoCRRight = GeneratedColumn<int?>(
      'embryoCRRight', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        specimenUuid,
        totalLength,
        tailLength,
        hindFootLength,
        earLength,
        forearm,
        weight,
        inaccurate,
        inaccurateReason,
        sex,
        lifeStage,
        testesPosition,
        testesLength,
        testesWidth,
        reproductiveStage,
        placentalScars,
        mammaeInguinalCount,
        mammaeAxilaryCount,
        mammaeAbdominalCount,
        embryoLeftCount,
        embryoRightCount,
        embryoCRLeft,
        embryoCRRight
      ];
  @override
  String get aliasedName => _alias ?? 'mammalMeasurement';
  @override
  String get actualTableName => 'mammalMeasurement';
  @override
  VerificationContext validateIntegrity(
      Insertable<MammalMeasurementData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('specimenUuid')) {
      context.handle(
          _specimenUuidMeta,
          specimenUuid.isAcceptableOrUnknown(
              data['specimenUuid']!, _specimenUuidMeta));
    }
    if (data.containsKey('totalLength')) {
      context.handle(
          _totalLengthMeta,
          totalLength.isAcceptableOrUnknown(
              data['totalLength']!, _totalLengthMeta));
    }
    if (data.containsKey('tailLength')) {
      context.handle(
          _tailLengthMeta,
          tailLength.isAcceptableOrUnknown(
              data['tailLength']!, _tailLengthMeta));
    }
    if (data.containsKey('hindFootLength')) {
      context.handle(
          _hindFootLengthMeta,
          hindFootLength.isAcceptableOrUnknown(
              data['hindFootLength']!, _hindFootLengthMeta));
    }
    if (data.containsKey('earLength')) {
      context.handle(_earLengthMeta,
          earLength.isAcceptableOrUnknown(data['earLength']!, _earLengthMeta));
    }
    if (data.containsKey('forearm')) {
      context.handle(_forearmMeta,
          forearm.isAcceptableOrUnknown(data['forearm']!, _forearmMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('inaccurate')) {
      context.handle(
          _inaccurateMeta,
          inaccurate.isAcceptableOrUnknown(
              data['inaccurate']!, _inaccurateMeta));
    }
    if (data.containsKey('inaccurateReason')) {
      context.handle(
          _inaccurateReasonMeta,
          inaccurateReason.isAcceptableOrUnknown(
              data['inaccurateReason']!, _inaccurateReasonMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
          _sexMeta, sex.isAcceptableOrUnknown(data['sex']!, _sexMeta));
    }
    if (data.containsKey('lifeStage')) {
      context.handle(_lifeStageMeta,
          lifeStage.isAcceptableOrUnknown(data['lifeStage']!, _lifeStageMeta));
    }
    if (data.containsKey('testesPosition')) {
      context.handle(
          _testesPositionMeta,
          testesPosition.isAcceptableOrUnknown(
              data['testesPosition']!, _testesPositionMeta));
    }
    if (data.containsKey('testesLength')) {
      context.handle(
          _testesLengthMeta,
          testesLength.isAcceptableOrUnknown(
              data['testesLength']!, _testesLengthMeta));
    }
    if (data.containsKey('testesWidth')) {
      context.handle(
          _testesWidthMeta,
          testesWidth.isAcceptableOrUnknown(
              data['testesWidth']!, _testesWidthMeta));
    }
    if (data.containsKey('reproductiveStage')) {
      context.handle(
          _reproductiveStageMeta,
          reproductiveStage.isAcceptableOrUnknown(
              data['reproductiveStage']!, _reproductiveStageMeta));
    }
    if (data.containsKey('placentalScars')) {
      context.handle(
          _placentalScarsMeta,
          placentalScars.isAcceptableOrUnknown(
              data['placentalScars']!, _placentalScarsMeta));
    }
    if (data.containsKey('mammaeInguinalCount')) {
      context.handle(
          _mammaeInguinalCountMeta,
          mammaeInguinalCount.isAcceptableOrUnknown(
              data['mammaeInguinalCount']!, _mammaeInguinalCountMeta));
    }
    if (data.containsKey('mammaeAxilaryCount')) {
      context.handle(
          _mammaeAxilaryCountMeta,
          mammaeAxilaryCount.isAcceptableOrUnknown(
              data['mammaeAxilaryCount']!, _mammaeAxilaryCountMeta));
    }
    if (data.containsKey('mammaeAbdominalCount')) {
      context.handle(
          _mammaeAbdominalCountMeta,
          mammaeAbdominalCount.isAcceptableOrUnknown(
              data['mammaeAbdominalCount']!, _mammaeAbdominalCountMeta));
    }
    if (data.containsKey('embryoLeftCount')) {
      context.handle(
          _embryoLeftCountMeta,
          embryoLeftCount.isAcceptableOrUnknown(
              data['embryoLeftCount']!, _embryoLeftCountMeta));
    }
    if (data.containsKey('embryoRightCount')) {
      context.handle(
          _embryoRightCountMeta,
          embryoRightCount.isAcceptableOrUnknown(
              data['embryoRightCount']!, _embryoRightCountMeta));
    }
    if (data.containsKey('embryoCRLeft')) {
      context.handle(
          _embryoCRLeftMeta,
          embryoCRLeft.isAcceptableOrUnknown(
              data['embryoCRLeft']!, _embryoCRLeftMeta));
    }
    if (data.containsKey('embryoCRRight')) {
      context.handle(
          _embryoCRRightMeta,
          embryoCRRight.isAcceptableOrUnknown(
              data['embryoCRRight']!, _embryoCRRightMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MammalMeasurementData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MammalMeasurementData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  MammalMeasurement createAlias(String alias) {
    return MammalMeasurement(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(specimenUuid) REFERENCES specimen(specimenUuid)'];
  @override
  bool get dontWriteConstraints => true;
}

class BirdMeasurementData extends DataClass
    implements Insertable<BirdMeasurementData> {
  final int id;
  final String? specimenUuid;
  final int? weight;
  final int? wingspan;
  final String? irisColor;
  final String? feetColor;
  final String? tarsusColor;
  final String? moltingWing;
  final String? moltingTail;
  final String? bodyFat;
  final int? bursaLength;
  final int? bursaWidth;
  final String? skullOssilation;
  final String? fat;
  final String? sex;
  final String? gonad;
  final String? stomach;
  BirdMeasurementData(
      {required this.id,
      this.specimenUuid,
      this.weight,
      this.wingspan,
      this.irisColor,
      this.feetColor,
      this.tarsusColor,
      this.moltingWing,
      this.moltingTail,
      this.bodyFat,
      this.bursaLength,
      this.bursaWidth,
      this.skullOssilation,
      this.fat,
      this.sex,
      this.gonad,
      this.stomach});
  factory BirdMeasurementData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return BirdMeasurementData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      specimenUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}specimenUuid']),
      weight: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}weight']),
      wingspan: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}wingspan']),
      irisColor: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}irisColor']),
      feetColor: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}feetColor']),
      tarsusColor: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tarsusColor']),
      moltingWing: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}moltingWing']),
      moltingTail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}moltingTail']),
      bodyFat: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bodyFat']),
      bursaLength: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bursaLength']),
      bursaWidth: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bursaWidth']),
      skullOssilation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}skullOssilation']),
      fat: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fat']),
      sex: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sex']),
      gonad: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gonad']),
      stomach: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}stomach']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || specimenUuid != null) {
      map['specimenUuid'] = Variable<String?>(specimenUuid);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int?>(weight);
    }
    if (!nullToAbsent || wingspan != null) {
      map['wingspan'] = Variable<int?>(wingspan);
    }
    if (!nullToAbsent || irisColor != null) {
      map['irisColor'] = Variable<String?>(irisColor);
    }
    if (!nullToAbsent || feetColor != null) {
      map['feetColor'] = Variable<String?>(feetColor);
    }
    if (!nullToAbsent || tarsusColor != null) {
      map['tarsusColor'] = Variable<String?>(tarsusColor);
    }
    if (!nullToAbsent || moltingWing != null) {
      map['moltingWing'] = Variable<String?>(moltingWing);
    }
    if (!nullToAbsent || moltingTail != null) {
      map['moltingTail'] = Variable<String?>(moltingTail);
    }
    if (!nullToAbsent || bodyFat != null) {
      map['bodyFat'] = Variable<String?>(bodyFat);
    }
    if (!nullToAbsent || bursaLength != null) {
      map['bursaLength'] = Variable<int?>(bursaLength);
    }
    if (!nullToAbsent || bursaWidth != null) {
      map['bursaWidth'] = Variable<int?>(bursaWidth);
    }
    if (!nullToAbsent || skullOssilation != null) {
      map['skullOssilation'] = Variable<String?>(skullOssilation);
    }
    if (!nullToAbsent || fat != null) {
      map['fat'] = Variable<String?>(fat);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<String?>(sex);
    }
    if (!nullToAbsent || gonad != null) {
      map['gonad'] = Variable<String?>(gonad);
    }
    if (!nullToAbsent || stomach != null) {
      map['stomach'] = Variable<String?>(stomach);
    }
    return map;
  }

  BirdMeasurementCompanion toCompanion(bool nullToAbsent) {
    return BirdMeasurementCompanion(
      id: Value(id),
      specimenUuid: specimenUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(specimenUuid),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      wingspan: wingspan == null && nullToAbsent
          ? const Value.absent()
          : Value(wingspan),
      irisColor: irisColor == null && nullToAbsent
          ? const Value.absent()
          : Value(irisColor),
      feetColor: feetColor == null && nullToAbsent
          ? const Value.absent()
          : Value(feetColor),
      tarsusColor: tarsusColor == null && nullToAbsent
          ? const Value.absent()
          : Value(tarsusColor),
      moltingWing: moltingWing == null && nullToAbsent
          ? const Value.absent()
          : Value(moltingWing),
      moltingTail: moltingTail == null && nullToAbsent
          ? const Value.absent()
          : Value(moltingTail),
      bodyFat: bodyFat == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFat),
      bursaLength: bursaLength == null && nullToAbsent
          ? const Value.absent()
          : Value(bursaLength),
      bursaWidth: bursaWidth == null && nullToAbsent
          ? const Value.absent()
          : Value(bursaWidth),
      skullOssilation: skullOssilation == null && nullToAbsent
          ? const Value.absent()
          : Value(skullOssilation),
      fat: fat == null && nullToAbsent ? const Value.absent() : Value(fat),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      gonad:
          gonad == null && nullToAbsent ? const Value.absent() : Value(gonad),
      stomach: stomach == null && nullToAbsent
          ? const Value.absent()
          : Value(stomach),
    );
  }

  factory BirdMeasurementData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BirdMeasurementData(
      id: serializer.fromJson<int>(json['id']),
      specimenUuid: serializer.fromJson<String?>(json['specimenUuid']),
      weight: serializer.fromJson<int?>(json['weight']),
      wingspan: serializer.fromJson<int?>(json['wingspan']),
      irisColor: serializer.fromJson<String?>(json['irisColor']),
      feetColor: serializer.fromJson<String?>(json['feetColor']),
      tarsusColor: serializer.fromJson<String?>(json['tarsusColor']),
      moltingWing: serializer.fromJson<String?>(json['moltingWing']),
      moltingTail: serializer.fromJson<String?>(json['moltingTail']),
      bodyFat: serializer.fromJson<String?>(json['bodyFat']),
      bursaLength: serializer.fromJson<int?>(json['bursaLength']),
      bursaWidth: serializer.fromJson<int?>(json['bursaWidth']),
      skullOssilation: serializer.fromJson<String?>(json['skullOssilation']),
      fat: serializer.fromJson<String?>(json['fat']),
      sex: serializer.fromJson<String?>(json['sex']),
      gonad: serializer.fromJson<String?>(json['gonad']),
      stomach: serializer.fromJson<String?>(json['stomach']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'specimenUuid': serializer.toJson<String?>(specimenUuid),
      'weight': serializer.toJson<int?>(weight),
      'wingspan': serializer.toJson<int?>(wingspan),
      'irisColor': serializer.toJson<String?>(irisColor),
      'feetColor': serializer.toJson<String?>(feetColor),
      'tarsusColor': serializer.toJson<String?>(tarsusColor),
      'moltingWing': serializer.toJson<String?>(moltingWing),
      'moltingTail': serializer.toJson<String?>(moltingTail),
      'bodyFat': serializer.toJson<String?>(bodyFat),
      'bursaLength': serializer.toJson<int?>(bursaLength),
      'bursaWidth': serializer.toJson<int?>(bursaWidth),
      'skullOssilation': serializer.toJson<String?>(skullOssilation),
      'fat': serializer.toJson<String?>(fat),
      'sex': serializer.toJson<String?>(sex),
      'gonad': serializer.toJson<String?>(gonad),
      'stomach': serializer.toJson<String?>(stomach),
    };
  }

  BirdMeasurementData copyWith(
          {int? id,
          String? specimenUuid,
          int? weight,
          int? wingspan,
          String? irisColor,
          String? feetColor,
          String? tarsusColor,
          String? moltingWing,
          String? moltingTail,
          String? bodyFat,
          int? bursaLength,
          int? bursaWidth,
          String? skullOssilation,
          String? fat,
          String? sex,
          String? gonad,
          String? stomach}) =>
      BirdMeasurementData(
        id: id ?? this.id,
        specimenUuid: specimenUuid ?? this.specimenUuid,
        weight: weight ?? this.weight,
        wingspan: wingspan ?? this.wingspan,
        irisColor: irisColor ?? this.irisColor,
        feetColor: feetColor ?? this.feetColor,
        tarsusColor: tarsusColor ?? this.tarsusColor,
        moltingWing: moltingWing ?? this.moltingWing,
        moltingTail: moltingTail ?? this.moltingTail,
        bodyFat: bodyFat ?? this.bodyFat,
        bursaLength: bursaLength ?? this.bursaLength,
        bursaWidth: bursaWidth ?? this.bursaWidth,
        skullOssilation: skullOssilation ?? this.skullOssilation,
        fat: fat ?? this.fat,
        sex: sex ?? this.sex,
        gonad: gonad ?? this.gonad,
        stomach: stomach ?? this.stomach,
      );
  @override
  String toString() {
    return (StringBuffer('BirdMeasurementData(')
          ..write('id: $id, ')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('weight: $weight, ')
          ..write('wingspan: $wingspan, ')
          ..write('irisColor: $irisColor, ')
          ..write('feetColor: $feetColor, ')
          ..write('tarsusColor: $tarsusColor, ')
          ..write('moltingWing: $moltingWing, ')
          ..write('moltingTail: $moltingTail, ')
          ..write('bodyFat: $bodyFat, ')
          ..write('bursaLength: $bursaLength, ')
          ..write('bursaWidth: $bursaWidth, ')
          ..write('skullOssilation: $skullOssilation, ')
          ..write('fat: $fat, ')
          ..write('sex: $sex, ')
          ..write('gonad: $gonad, ')
          ..write('stomach: $stomach')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      specimenUuid,
      weight,
      wingspan,
      irisColor,
      feetColor,
      tarsusColor,
      moltingWing,
      moltingTail,
      bodyFat,
      bursaLength,
      bursaWidth,
      skullOssilation,
      fat,
      sex,
      gonad,
      stomach);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BirdMeasurementData &&
          other.id == this.id &&
          other.specimenUuid == this.specimenUuid &&
          other.weight == this.weight &&
          other.wingspan == this.wingspan &&
          other.irisColor == this.irisColor &&
          other.feetColor == this.feetColor &&
          other.tarsusColor == this.tarsusColor &&
          other.moltingWing == this.moltingWing &&
          other.moltingTail == this.moltingTail &&
          other.bodyFat == this.bodyFat &&
          other.bursaLength == this.bursaLength &&
          other.bursaWidth == this.bursaWidth &&
          other.skullOssilation == this.skullOssilation &&
          other.fat == this.fat &&
          other.sex == this.sex &&
          other.gonad == this.gonad &&
          other.stomach == this.stomach);
}

class BirdMeasurementCompanion extends UpdateCompanion<BirdMeasurementData> {
  final Value<int> id;
  final Value<String?> specimenUuid;
  final Value<int?> weight;
  final Value<int?> wingspan;
  final Value<String?> irisColor;
  final Value<String?> feetColor;
  final Value<String?> tarsusColor;
  final Value<String?> moltingWing;
  final Value<String?> moltingTail;
  final Value<String?> bodyFat;
  final Value<int?> bursaLength;
  final Value<int?> bursaWidth;
  final Value<String?> skullOssilation;
  final Value<String?> fat;
  final Value<String?> sex;
  final Value<String?> gonad;
  final Value<String?> stomach;
  const BirdMeasurementCompanion({
    this.id = const Value.absent(),
    this.specimenUuid = const Value.absent(),
    this.weight = const Value.absent(),
    this.wingspan = const Value.absent(),
    this.irisColor = const Value.absent(),
    this.feetColor = const Value.absent(),
    this.tarsusColor = const Value.absent(),
    this.moltingWing = const Value.absent(),
    this.moltingTail = const Value.absent(),
    this.bodyFat = const Value.absent(),
    this.bursaLength = const Value.absent(),
    this.bursaWidth = const Value.absent(),
    this.skullOssilation = const Value.absent(),
    this.fat = const Value.absent(),
    this.sex = const Value.absent(),
    this.gonad = const Value.absent(),
    this.stomach = const Value.absent(),
  });
  BirdMeasurementCompanion.insert({
    this.id = const Value.absent(),
    this.specimenUuid = const Value.absent(),
    this.weight = const Value.absent(),
    this.wingspan = const Value.absent(),
    this.irisColor = const Value.absent(),
    this.feetColor = const Value.absent(),
    this.tarsusColor = const Value.absent(),
    this.moltingWing = const Value.absent(),
    this.moltingTail = const Value.absent(),
    this.bodyFat = const Value.absent(),
    this.bursaLength = const Value.absent(),
    this.bursaWidth = const Value.absent(),
    this.skullOssilation = const Value.absent(),
    this.fat = const Value.absent(),
    this.sex = const Value.absent(),
    this.gonad = const Value.absent(),
    this.stomach = const Value.absent(),
  });
  static Insertable<BirdMeasurementData> custom({
    Expression<int>? id,
    Expression<String?>? specimenUuid,
    Expression<int?>? weight,
    Expression<int?>? wingspan,
    Expression<String?>? irisColor,
    Expression<String?>? feetColor,
    Expression<String?>? tarsusColor,
    Expression<String?>? moltingWing,
    Expression<String?>? moltingTail,
    Expression<String?>? bodyFat,
    Expression<int?>? bursaLength,
    Expression<int?>? bursaWidth,
    Expression<String?>? skullOssilation,
    Expression<String?>? fat,
    Expression<String?>? sex,
    Expression<String?>? gonad,
    Expression<String?>? stomach,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (specimenUuid != null) 'specimenUuid': specimenUuid,
      if (weight != null) 'weight': weight,
      if (wingspan != null) 'wingspan': wingspan,
      if (irisColor != null) 'irisColor': irisColor,
      if (feetColor != null) 'feetColor': feetColor,
      if (tarsusColor != null) 'tarsusColor': tarsusColor,
      if (moltingWing != null) 'moltingWing': moltingWing,
      if (moltingTail != null) 'moltingTail': moltingTail,
      if (bodyFat != null) 'bodyFat': bodyFat,
      if (bursaLength != null) 'bursaLength': bursaLength,
      if (bursaWidth != null) 'bursaWidth': bursaWidth,
      if (skullOssilation != null) 'skullOssilation': skullOssilation,
      if (fat != null) 'fat': fat,
      if (sex != null) 'sex': sex,
      if (gonad != null) 'gonad': gonad,
      if (stomach != null) 'stomach': stomach,
    });
  }

  BirdMeasurementCompanion copyWith(
      {Value<int>? id,
      Value<String?>? specimenUuid,
      Value<int?>? weight,
      Value<int?>? wingspan,
      Value<String?>? irisColor,
      Value<String?>? feetColor,
      Value<String?>? tarsusColor,
      Value<String?>? moltingWing,
      Value<String?>? moltingTail,
      Value<String?>? bodyFat,
      Value<int?>? bursaLength,
      Value<int?>? bursaWidth,
      Value<String?>? skullOssilation,
      Value<String?>? fat,
      Value<String?>? sex,
      Value<String?>? gonad,
      Value<String?>? stomach}) {
    return BirdMeasurementCompanion(
      id: id ?? this.id,
      specimenUuid: specimenUuid ?? this.specimenUuid,
      weight: weight ?? this.weight,
      wingspan: wingspan ?? this.wingspan,
      irisColor: irisColor ?? this.irisColor,
      feetColor: feetColor ?? this.feetColor,
      tarsusColor: tarsusColor ?? this.tarsusColor,
      moltingWing: moltingWing ?? this.moltingWing,
      moltingTail: moltingTail ?? this.moltingTail,
      bodyFat: bodyFat ?? this.bodyFat,
      bursaLength: bursaLength ?? this.bursaLength,
      bursaWidth: bursaWidth ?? this.bursaWidth,
      skullOssilation: skullOssilation ?? this.skullOssilation,
      fat: fat ?? this.fat,
      sex: sex ?? this.sex,
      gonad: gonad ?? this.gonad,
      stomach: stomach ?? this.stomach,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (specimenUuid.present) {
      map['specimenUuid'] = Variable<String?>(specimenUuid.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int?>(weight.value);
    }
    if (wingspan.present) {
      map['wingspan'] = Variable<int?>(wingspan.value);
    }
    if (irisColor.present) {
      map['irisColor'] = Variable<String?>(irisColor.value);
    }
    if (feetColor.present) {
      map['feetColor'] = Variable<String?>(feetColor.value);
    }
    if (tarsusColor.present) {
      map['tarsusColor'] = Variable<String?>(tarsusColor.value);
    }
    if (moltingWing.present) {
      map['moltingWing'] = Variable<String?>(moltingWing.value);
    }
    if (moltingTail.present) {
      map['moltingTail'] = Variable<String?>(moltingTail.value);
    }
    if (bodyFat.present) {
      map['bodyFat'] = Variable<String?>(bodyFat.value);
    }
    if (bursaLength.present) {
      map['bursaLength'] = Variable<int?>(bursaLength.value);
    }
    if (bursaWidth.present) {
      map['bursaWidth'] = Variable<int?>(bursaWidth.value);
    }
    if (skullOssilation.present) {
      map['skullOssilation'] = Variable<String?>(skullOssilation.value);
    }
    if (fat.present) {
      map['fat'] = Variable<String?>(fat.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String?>(sex.value);
    }
    if (gonad.present) {
      map['gonad'] = Variable<String?>(gonad.value);
    }
    if (stomach.present) {
      map['stomach'] = Variable<String?>(stomach.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BirdMeasurementCompanion(')
          ..write('id: $id, ')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('weight: $weight, ')
          ..write('wingspan: $wingspan, ')
          ..write('irisColor: $irisColor, ')
          ..write('feetColor: $feetColor, ')
          ..write('tarsusColor: $tarsusColor, ')
          ..write('moltingWing: $moltingWing, ')
          ..write('moltingTail: $moltingTail, ')
          ..write('bodyFat: $bodyFat, ')
          ..write('bursaLength: $bursaLength, ')
          ..write('bursaWidth: $bursaWidth, ')
          ..write('skullOssilation: $skullOssilation, ')
          ..write('fat: $fat, ')
          ..write('sex: $sex, ')
          ..write('gonad: $gonad, ')
          ..write('stomach: $stomach')
          ..write(')'))
        .toString();
  }
}

class BirdMeasurement extends Table
    with TableInfo<BirdMeasurement, BirdMeasurementData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  BirdMeasurement(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String?> specimenUuid = GeneratedColumn<String?>(
      'specimenUuid', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  late final GeneratedColumn<int?> weight = GeneratedColumn<int?>(
      'weight', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _wingspanMeta = const VerificationMeta('wingspan');
  late final GeneratedColumn<int?> wingspan = GeneratedColumn<int?>(
      'wingspan', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _irisColorMeta = const VerificationMeta('irisColor');
  late final GeneratedColumn<String?> irisColor = GeneratedColumn<String?>(
      'irisColor', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _feetColorMeta = const VerificationMeta('feetColor');
  late final GeneratedColumn<String?> feetColor = GeneratedColumn<String?>(
      'feetColor', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _tarsusColorMeta =
      const VerificationMeta('tarsusColor');
  late final GeneratedColumn<String?> tarsusColor = GeneratedColumn<String?>(
      'tarsusColor', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _moltingWingMeta =
      const VerificationMeta('moltingWing');
  late final GeneratedColumn<String?> moltingWing = GeneratedColumn<String?>(
      'moltingWing', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _moltingTailMeta =
      const VerificationMeta('moltingTail');
  late final GeneratedColumn<String?> moltingTail = GeneratedColumn<String?>(
      'moltingTail', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _bodyFatMeta = const VerificationMeta('bodyFat');
  late final GeneratedColumn<String?> bodyFat = GeneratedColumn<String?>(
      'bodyFat', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _bursaLengthMeta =
      const VerificationMeta('bursaLength');
  late final GeneratedColumn<int?> bursaLength = GeneratedColumn<int?>(
      'bursaLength', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _bursaWidthMeta = const VerificationMeta('bursaWidth');
  late final GeneratedColumn<int?> bursaWidth = GeneratedColumn<int?>(
      'bursaWidth', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _skullOssilationMeta =
      const VerificationMeta('skullOssilation');
  late final GeneratedColumn<String?> skullOssilation =
      GeneratedColumn<String?>('skullOssilation', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _fatMeta = const VerificationMeta('fat');
  late final GeneratedColumn<String?> fat = GeneratedColumn<String?>(
      'fat', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumn<String?> sex = GeneratedColumn<String?>(
      'sex', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _gonadMeta = const VerificationMeta('gonad');
  late final GeneratedColumn<String?> gonad = GeneratedColumn<String?>(
      'gonad', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _stomachMeta = const VerificationMeta('stomach');
  late final GeneratedColumn<String?> stomach = GeneratedColumn<String?>(
      'stomach', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        specimenUuid,
        weight,
        wingspan,
        irisColor,
        feetColor,
        tarsusColor,
        moltingWing,
        moltingTail,
        bodyFat,
        bursaLength,
        bursaWidth,
        skullOssilation,
        fat,
        sex,
        gonad,
        stomach
      ];
  @override
  String get aliasedName => _alias ?? 'birdMeasurement';
  @override
  String get actualTableName => 'birdMeasurement';
  @override
  VerificationContext validateIntegrity(
      Insertable<BirdMeasurementData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('specimenUuid')) {
      context.handle(
          _specimenUuidMeta,
          specimenUuid.isAcceptableOrUnknown(
              data['specimenUuid']!, _specimenUuidMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('wingspan')) {
      context.handle(_wingspanMeta,
          wingspan.isAcceptableOrUnknown(data['wingspan']!, _wingspanMeta));
    }
    if (data.containsKey('irisColor')) {
      context.handle(_irisColorMeta,
          irisColor.isAcceptableOrUnknown(data['irisColor']!, _irisColorMeta));
    }
    if (data.containsKey('feetColor')) {
      context.handle(_feetColorMeta,
          feetColor.isAcceptableOrUnknown(data['feetColor']!, _feetColorMeta));
    }
    if (data.containsKey('tarsusColor')) {
      context.handle(
          _tarsusColorMeta,
          tarsusColor.isAcceptableOrUnknown(
              data['tarsusColor']!, _tarsusColorMeta));
    }
    if (data.containsKey('moltingWing')) {
      context.handle(
          _moltingWingMeta,
          moltingWing.isAcceptableOrUnknown(
              data['moltingWing']!, _moltingWingMeta));
    }
    if (data.containsKey('moltingTail')) {
      context.handle(
          _moltingTailMeta,
          moltingTail.isAcceptableOrUnknown(
              data['moltingTail']!, _moltingTailMeta));
    }
    if (data.containsKey('bodyFat')) {
      context.handle(_bodyFatMeta,
          bodyFat.isAcceptableOrUnknown(data['bodyFat']!, _bodyFatMeta));
    }
    if (data.containsKey('bursaLength')) {
      context.handle(
          _bursaLengthMeta,
          bursaLength.isAcceptableOrUnknown(
              data['bursaLength']!, _bursaLengthMeta));
    }
    if (data.containsKey('bursaWidth')) {
      context.handle(
          _bursaWidthMeta,
          bursaWidth.isAcceptableOrUnknown(
              data['bursaWidth']!, _bursaWidthMeta));
    }
    if (data.containsKey('skullOssilation')) {
      context.handle(
          _skullOssilationMeta,
          skullOssilation.isAcceptableOrUnknown(
              data['skullOssilation']!, _skullOssilationMeta));
    }
    if (data.containsKey('fat')) {
      context.handle(
          _fatMeta, fat.isAcceptableOrUnknown(data['fat']!, _fatMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
          _sexMeta, sex.isAcceptableOrUnknown(data['sex']!, _sexMeta));
    }
    if (data.containsKey('gonad')) {
      context.handle(
          _gonadMeta, gonad.isAcceptableOrUnknown(data['gonad']!, _gonadMeta));
    }
    if (data.containsKey('stomach')) {
      context.handle(_stomachMeta,
          stomach.isAcceptableOrUnknown(data['stomach']!, _stomachMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BirdMeasurementData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return BirdMeasurementData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  BirdMeasurement createAlias(String alias) {
    return BirdMeasurement(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(specimenUuid) REFERENCES specimen(specimenUuid)'];
  @override
  bool get dontWriteConstraints => true;
}

class PartData extends DataClass implements Insertable<PartData> {
  final String? specimenUuid;
  final String? secondaryNumber;
  final String? barcodeID;
  final String? type;
  final String? count;
  final String? treatment;
  final String? additionalTreatment;
  final String? museumPermanent;
  final String? museumLoan;
  PartData(
      {this.specimenUuid,
      this.secondaryNumber,
      this.barcodeID,
      this.type,
      this.count,
      this.treatment,
      this.additionalTreatment,
      this.museumPermanent,
      this.museumLoan});
  factory PartData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PartData(
      specimenUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}specimenUuid']),
      secondaryNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}secondaryNumber']),
      barcodeID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}barcodeID']),
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']),
      count: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}count']),
      treatment: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}treatment']),
      additionalTreatment: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}additionalTreatment']),
      museumPermanent: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}museumPermanent']),
      museumLoan: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}museumLoan']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || specimenUuid != null) {
      map['specimenUuid'] = Variable<String?>(specimenUuid);
    }
    if (!nullToAbsent || secondaryNumber != null) {
      map['secondaryNumber'] = Variable<String?>(secondaryNumber);
    }
    if (!nullToAbsent || barcodeID != null) {
      map['barcodeID'] = Variable<String?>(barcodeID);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String?>(type);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<String?>(count);
    }
    if (!nullToAbsent || treatment != null) {
      map['treatment'] = Variable<String?>(treatment);
    }
    if (!nullToAbsent || additionalTreatment != null) {
      map['additionalTreatment'] = Variable<String?>(additionalTreatment);
    }
    if (!nullToAbsent || museumPermanent != null) {
      map['museumPermanent'] = Variable<String?>(museumPermanent);
    }
    if (!nullToAbsent || museumLoan != null) {
      map['museumLoan'] = Variable<String?>(museumLoan);
    }
    return map;
  }

  PartCompanion toCompanion(bool nullToAbsent) {
    return PartCompanion(
      specimenUuid: specimenUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(specimenUuid),
      secondaryNumber: secondaryNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryNumber),
      barcodeID: barcodeID == null && nullToAbsent
          ? const Value.absent()
          : Value(barcodeID),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      treatment: treatment == null && nullToAbsent
          ? const Value.absent()
          : Value(treatment),
      additionalTreatment: additionalTreatment == null && nullToAbsent
          ? const Value.absent()
          : Value(additionalTreatment),
      museumPermanent: museumPermanent == null && nullToAbsent
          ? const Value.absent()
          : Value(museumPermanent),
      museumLoan: museumLoan == null && nullToAbsent
          ? const Value.absent()
          : Value(museumLoan),
    );
  }

  factory PartData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartData(
      specimenUuid: serializer.fromJson<String?>(json['specimenUuid']),
      secondaryNumber: serializer.fromJson<String?>(json['secondaryNumber']),
      barcodeID: serializer.fromJson<String?>(json['barcodeID']),
      type: serializer.fromJson<String?>(json['type']),
      count: serializer.fromJson<String?>(json['count']),
      treatment: serializer.fromJson<String?>(json['treatment']),
      additionalTreatment:
          serializer.fromJson<String?>(json['additionalTreatment']),
      museumPermanent: serializer.fromJson<String?>(json['museumPermanent']),
      museumLoan: serializer.fromJson<String?>(json['museumLoan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'specimenUuid': serializer.toJson<String?>(specimenUuid),
      'secondaryNumber': serializer.toJson<String?>(secondaryNumber),
      'barcodeID': serializer.toJson<String?>(barcodeID),
      'type': serializer.toJson<String?>(type),
      'count': serializer.toJson<String?>(count),
      'treatment': serializer.toJson<String?>(treatment),
      'additionalTreatment': serializer.toJson<String?>(additionalTreatment),
      'museumPermanent': serializer.toJson<String?>(museumPermanent),
      'museumLoan': serializer.toJson<String?>(museumLoan),
    };
  }

  PartData copyWith(
          {String? specimenUuid,
          String? secondaryNumber,
          String? barcodeID,
          String? type,
          String? count,
          String? treatment,
          String? additionalTreatment,
          String? museumPermanent,
          String? museumLoan}) =>
      PartData(
        specimenUuid: specimenUuid ?? this.specimenUuid,
        secondaryNumber: secondaryNumber ?? this.secondaryNumber,
        barcodeID: barcodeID ?? this.barcodeID,
        type: type ?? this.type,
        count: count ?? this.count,
        treatment: treatment ?? this.treatment,
        additionalTreatment: additionalTreatment ?? this.additionalTreatment,
        museumPermanent: museumPermanent ?? this.museumPermanent,
        museumLoan: museumLoan ?? this.museumLoan,
      );
  @override
  String toString() {
    return (StringBuffer('PartData(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('secondaryNumber: $secondaryNumber, ')
          ..write('barcodeID: $barcodeID, ')
          ..write('type: $type, ')
          ..write('count: $count, ')
          ..write('treatment: $treatment, ')
          ..write('additionalTreatment: $additionalTreatment, ')
          ..write('museumPermanent: $museumPermanent, ')
          ..write('museumLoan: $museumLoan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(specimenUuid, secondaryNumber, barcodeID,
      type, count, treatment, additionalTreatment, museumPermanent, museumLoan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartData &&
          other.specimenUuid == this.specimenUuid &&
          other.secondaryNumber == this.secondaryNumber &&
          other.barcodeID == this.barcodeID &&
          other.type == this.type &&
          other.count == this.count &&
          other.treatment == this.treatment &&
          other.additionalTreatment == this.additionalTreatment &&
          other.museumPermanent == this.museumPermanent &&
          other.museumLoan == this.museumLoan);
}

class PartCompanion extends UpdateCompanion<PartData> {
  final Value<String?> specimenUuid;
  final Value<String?> secondaryNumber;
  final Value<String?> barcodeID;
  final Value<String?> type;
  final Value<String?> count;
  final Value<String?> treatment;
  final Value<String?> additionalTreatment;
  final Value<String?> museumPermanent;
  final Value<String?> museumLoan;
  const PartCompanion({
    this.specimenUuid = const Value.absent(),
    this.secondaryNumber = const Value.absent(),
    this.barcodeID = const Value.absent(),
    this.type = const Value.absent(),
    this.count = const Value.absent(),
    this.treatment = const Value.absent(),
    this.additionalTreatment = const Value.absent(),
    this.museumPermanent = const Value.absent(),
    this.museumLoan = const Value.absent(),
  });
  PartCompanion.insert({
    this.specimenUuid = const Value.absent(),
    this.secondaryNumber = const Value.absent(),
    this.barcodeID = const Value.absent(),
    this.type = const Value.absent(),
    this.count = const Value.absent(),
    this.treatment = const Value.absent(),
    this.additionalTreatment = const Value.absent(),
    this.museumPermanent = const Value.absent(),
    this.museumLoan = const Value.absent(),
  });
  static Insertable<PartData> custom({
    Expression<String?>? specimenUuid,
    Expression<String?>? secondaryNumber,
    Expression<String?>? barcodeID,
    Expression<String?>? type,
    Expression<String?>? count,
    Expression<String?>? treatment,
    Expression<String?>? additionalTreatment,
    Expression<String?>? museumPermanent,
    Expression<String?>? museumLoan,
  }) {
    return RawValuesInsertable({
      if (specimenUuid != null) 'specimenUuid': specimenUuid,
      if (secondaryNumber != null) 'secondaryNumber': secondaryNumber,
      if (barcodeID != null) 'barcodeID': barcodeID,
      if (type != null) 'type': type,
      if (count != null) 'count': count,
      if (treatment != null) 'treatment': treatment,
      if (additionalTreatment != null)
        'additionalTreatment': additionalTreatment,
      if (museumPermanent != null) 'museumPermanent': museumPermanent,
      if (museumLoan != null) 'museumLoan': museumLoan,
    });
  }

  PartCompanion copyWith(
      {Value<String?>? specimenUuid,
      Value<String?>? secondaryNumber,
      Value<String?>? barcodeID,
      Value<String?>? type,
      Value<String?>? count,
      Value<String?>? treatment,
      Value<String?>? additionalTreatment,
      Value<String?>? museumPermanent,
      Value<String?>? museumLoan}) {
    return PartCompanion(
      specimenUuid: specimenUuid ?? this.specimenUuid,
      secondaryNumber: secondaryNumber ?? this.secondaryNumber,
      barcodeID: barcodeID ?? this.barcodeID,
      type: type ?? this.type,
      count: count ?? this.count,
      treatment: treatment ?? this.treatment,
      additionalTreatment: additionalTreatment ?? this.additionalTreatment,
      museumPermanent: museumPermanent ?? this.museumPermanent,
      museumLoan: museumLoan ?? this.museumLoan,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (specimenUuid.present) {
      map['specimenUuid'] = Variable<String?>(specimenUuid.value);
    }
    if (secondaryNumber.present) {
      map['secondaryNumber'] = Variable<String?>(secondaryNumber.value);
    }
    if (barcodeID.present) {
      map['barcodeID'] = Variable<String?>(barcodeID.value);
    }
    if (type.present) {
      map['type'] = Variable<String?>(type.value);
    }
    if (count.present) {
      map['count'] = Variable<String?>(count.value);
    }
    if (treatment.present) {
      map['treatment'] = Variable<String?>(treatment.value);
    }
    if (additionalTreatment.present) {
      map['additionalTreatment'] = Variable<String?>(additionalTreatment.value);
    }
    if (museumPermanent.present) {
      map['museumPermanent'] = Variable<String?>(museumPermanent.value);
    }
    if (museumLoan.present) {
      map['museumLoan'] = Variable<String?>(museumLoan.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartCompanion(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('secondaryNumber: $secondaryNumber, ')
          ..write('barcodeID: $barcodeID, ')
          ..write('type: $type, ')
          ..write('count: $count, ')
          ..write('treatment: $treatment, ')
          ..write('additionalTreatment: $additionalTreatment, ')
          ..write('museumPermanent: $museumPermanent, ')
          ..write('museumLoan: $museumLoan')
          ..write(')'))
        .toString();
  }
}

class Part extends Table with TableInfo<Part, PartData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Part(this.attachedDatabase, [this._alias]);
  final VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String?> specimenUuid = GeneratedColumn<String?>(
      'specimenUuid', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _secondaryNumberMeta =
      const VerificationMeta('secondaryNumber');
  late final GeneratedColumn<String?> secondaryNumber =
      GeneratedColumn<String?>('secondaryNumber', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _barcodeIDMeta = const VerificationMeta('barcodeID');
  late final GeneratedColumn<String?> barcodeID = GeneratedColumn<String?>(
      'barcodeID', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _countMeta = const VerificationMeta('count');
  late final GeneratedColumn<String?> count = GeneratedColumn<String?>(
      'count', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _treatmentMeta = const VerificationMeta('treatment');
  late final GeneratedColumn<String?> treatment = GeneratedColumn<String?>(
      'treatment', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _additionalTreatmentMeta =
      const VerificationMeta('additionalTreatment');
  late final GeneratedColumn<String?> additionalTreatment =
      GeneratedColumn<String?>('additionalTreatment', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _museumPermanentMeta =
      const VerificationMeta('museumPermanent');
  late final GeneratedColumn<String?> museumPermanent =
      GeneratedColumn<String?>('museumPermanent', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _museumLoanMeta = const VerificationMeta('museumLoan');
  late final GeneratedColumn<String?> museumLoan = GeneratedColumn<String?>(
      'museumLoan', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        specimenUuid,
        secondaryNumber,
        barcodeID,
        type,
        count,
        treatment,
        additionalTreatment,
        museumPermanent,
        museumLoan
      ];
  @override
  String get aliasedName => _alias ?? 'part';
  @override
  String get actualTableName => 'part';
  @override
  VerificationContext validateIntegrity(Insertable<PartData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('specimenUuid')) {
      context.handle(
          _specimenUuidMeta,
          specimenUuid.isAcceptableOrUnknown(
              data['specimenUuid']!, _specimenUuidMeta));
    }
    if (data.containsKey('secondaryNumber')) {
      context.handle(
          _secondaryNumberMeta,
          secondaryNumber.isAcceptableOrUnknown(
              data['secondaryNumber']!, _secondaryNumberMeta));
    }
    if (data.containsKey('barcodeID')) {
      context.handle(_barcodeIDMeta,
          barcodeID.isAcceptableOrUnknown(data['barcodeID']!, _barcodeIDMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    }
    if (data.containsKey('treatment')) {
      context.handle(_treatmentMeta,
          treatment.isAcceptableOrUnknown(data['treatment']!, _treatmentMeta));
    }
    if (data.containsKey('additionalTreatment')) {
      context.handle(
          _additionalTreatmentMeta,
          additionalTreatment.isAcceptableOrUnknown(
              data['additionalTreatment']!, _additionalTreatmentMeta));
    }
    if (data.containsKey('museumPermanent')) {
      context.handle(
          _museumPermanentMeta,
          museumPermanent.isAcceptableOrUnknown(
              data['museumPermanent']!, _museumPermanentMeta));
    }
    if (data.containsKey('museumLoan')) {
      context.handle(
          _museumLoanMeta,
          museumLoan.isAcceptableOrUnknown(
              data['museumLoan']!, _museumLoanMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  PartData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PartData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Part createAlias(String alias) {
    return Part(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TaxonomyData extends DataClass implements Insertable<TaxonomyData> {
  final int? id;
  final String? genus;
  final String? specificEpithet;
  final String? intraspecificEpithet;
  final String? taxonFamily;
  final String? taxonOrder;
  TaxonomyData(
      {this.id,
      this.genus,
      this.specificEpithet,
      this.intraspecificEpithet,
      this.taxonFamily,
      this.taxonOrder});
  factory TaxonomyData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TaxonomyData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      genus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}genus']),
      specificEpithet: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}specificEpithet']),
      intraspecificEpithet: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}intraspecificEpithet']),
      taxonFamily: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}taxonFamily']),
      taxonOrder: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}taxonOrder']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    if (!nullToAbsent || genus != null) {
      map['genus'] = Variable<String?>(genus);
    }
    if (!nullToAbsent || specificEpithet != null) {
      map['specificEpithet'] = Variable<String?>(specificEpithet);
    }
    if (!nullToAbsent || intraspecificEpithet != null) {
      map['intraspecificEpithet'] = Variable<String?>(intraspecificEpithet);
    }
    if (!nullToAbsent || taxonFamily != null) {
      map['taxonFamily'] = Variable<String?>(taxonFamily);
    }
    if (!nullToAbsent || taxonOrder != null) {
      map['taxonOrder'] = Variable<String?>(taxonOrder);
    }
    return map;
  }

  TaxonomyCompanion toCompanion(bool nullToAbsent) {
    return TaxonomyCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      genus:
          genus == null && nullToAbsent ? const Value.absent() : Value(genus),
      specificEpithet: specificEpithet == null && nullToAbsent
          ? const Value.absent()
          : Value(specificEpithet),
      intraspecificEpithet: intraspecificEpithet == null && nullToAbsent
          ? const Value.absent()
          : Value(intraspecificEpithet),
      taxonFamily: taxonFamily == null && nullToAbsent
          ? const Value.absent()
          : Value(taxonFamily),
      taxonOrder: taxonOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(taxonOrder),
    );
  }

  factory TaxonomyData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaxonomyData(
      id: serializer.fromJson<int?>(json['id']),
      genus: serializer.fromJson<String?>(json['genus']),
      specificEpithet: serializer.fromJson<String?>(json['specificEpithet']),
      intraspecificEpithet:
          serializer.fromJson<String?>(json['intraspecificEpithet']),
      taxonFamily: serializer.fromJson<String?>(json['taxonFamily']),
      taxonOrder: serializer.fromJson<String?>(json['taxonOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'genus': serializer.toJson<String?>(genus),
      'specificEpithet': serializer.toJson<String?>(specificEpithet),
      'intraspecificEpithet': serializer.toJson<String?>(intraspecificEpithet),
      'taxonFamily': serializer.toJson<String?>(taxonFamily),
      'taxonOrder': serializer.toJson<String?>(taxonOrder),
    };
  }

  TaxonomyData copyWith(
          {int? id,
          String? genus,
          String? specificEpithet,
          String? intraspecificEpithet,
          String? taxonFamily,
          String? taxonOrder}) =>
      TaxonomyData(
        id: id ?? this.id,
        genus: genus ?? this.genus,
        specificEpithet: specificEpithet ?? this.specificEpithet,
        intraspecificEpithet: intraspecificEpithet ?? this.intraspecificEpithet,
        taxonFamily: taxonFamily ?? this.taxonFamily,
        taxonOrder: taxonOrder ?? this.taxonOrder,
      );
  @override
  String toString() {
    return (StringBuffer('TaxonomyData(')
          ..write('id: $id, ')
          ..write('genus: $genus, ')
          ..write('specificEpithet: $specificEpithet, ')
          ..write('intraspecificEpithet: $intraspecificEpithet, ')
          ..write('taxonFamily: $taxonFamily, ')
          ..write('taxonOrder: $taxonOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, genus, specificEpithet,
      intraspecificEpithet, taxonFamily, taxonOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaxonomyData &&
          other.id == this.id &&
          other.genus == this.genus &&
          other.specificEpithet == this.specificEpithet &&
          other.intraspecificEpithet == this.intraspecificEpithet &&
          other.taxonFamily == this.taxonFamily &&
          other.taxonOrder == this.taxonOrder);
}

class TaxonomyCompanion extends UpdateCompanion<TaxonomyData> {
  final Value<int?> id;
  final Value<String?> genus;
  final Value<String?> specificEpithet;
  final Value<String?> intraspecificEpithet;
  final Value<String?> taxonFamily;
  final Value<String?> taxonOrder;
  const TaxonomyCompanion({
    this.id = const Value.absent(),
    this.genus = const Value.absent(),
    this.specificEpithet = const Value.absent(),
    this.intraspecificEpithet = const Value.absent(),
    this.taxonFamily = const Value.absent(),
    this.taxonOrder = const Value.absent(),
  });
  TaxonomyCompanion.insert({
    this.id = const Value.absent(),
    this.genus = const Value.absent(),
    this.specificEpithet = const Value.absent(),
    this.intraspecificEpithet = const Value.absent(),
    this.taxonFamily = const Value.absent(),
    this.taxonOrder = const Value.absent(),
  });
  static Insertable<TaxonomyData> custom({
    Expression<int?>? id,
    Expression<String?>? genus,
    Expression<String?>? specificEpithet,
    Expression<String?>? intraspecificEpithet,
    Expression<String?>? taxonFamily,
    Expression<String?>? taxonOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (genus != null) 'genus': genus,
      if (specificEpithet != null) 'specificEpithet': specificEpithet,
      if (intraspecificEpithet != null)
        'intraspecificEpithet': intraspecificEpithet,
      if (taxonFamily != null) 'taxonFamily': taxonFamily,
      if (taxonOrder != null) 'taxonOrder': taxonOrder,
    });
  }

  TaxonomyCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? genus,
      Value<String?>? specificEpithet,
      Value<String?>? intraspecificEpithet,
      Value<String?>? taxonFamily,
      Value<String?>? taxonOrder}) {
    return TaxonomyCompanion(
      id: id ?? this.id,
      genus: genus ?? this.genus,
      specificEpithet: specificEpithet ?? this.specificEpithet,
      intraspecificEpithet: intraspecificEpithet ?? this.intraspecificEpithet,
      taxonFamily: taxonFamily ?? this.taxonFamily,
      taxonOrder: taxonOrder ?? this.taxonOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (genus.present) {
      map['genus'] = Variable<String?>(genus.value);
    }
    if (specificEpithet.present) {
      map['specificEpithet'] = Variable<String?>(specificEpithet.value);
    }
    if (intraspecificEpithet.present) {
      map['intraspecificEpithet'] =
          Variable<String?>(intraspecificEpithet.value);
    }
    if (taxonFamily.present) {
      map['taxonFamily'] = Variable<String?>(taxonFamily.value);
    }
    if (taxonOrder.present) {
      map['taxonOrder'] = Variable<String?>(taxonOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaxonomyCompanion(')
          ..write('id: $id, ')
          ..write('genus: $genus, ')
          ..write('specificEpithet: $specificEpithet, ')
          ..write('intraspecificEpithet: $intraspecificEpithet, ')
          ..write('taxonFamily: $taxonFamily, ')
          ..write('taxonOrder: $taxonOrder')
          ..write(')'))
        .toString();
  }
}

class Taxonomy extends Table with TableInfo<Taxonomy, TaxonomyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Taxonomy(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _genusMeta = const VerificationMeta('genus');
  late final GeneratedColumn<String?> genus = GeneratedColumn<String?>(
      'genus', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _specificEpithetMeta =
      const VerificationMeta('specificEpithet');
  late final GeneratedColumn<String?> specificEpithet =
      GeneratedColumn<String?>('specificEpithet', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _intraspecificEpithetMeta =
      const VerificationMeta('intraspecificEpithet');
  late final GeneratedColumn<String?> intraspecificEpithet =
      GeneratedColumn<String?>('intraspecificEpithet', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _taxonFamilyMeta =
      const VerificationMeta('taxonFamily');
  late final GeneratedColumn<String?> taxonFamily = GeneratedColumn<String?>(
      'taxonFamily', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _taxonOrderMeta = const VerificationMeta('taxonOrder');
  late final GeneratedColumn<String?> taxonOrder = GeneratedColumn<String?>(
      'taxonOrder', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        genus,
        specificEpithet,
        intraspecificEpithet,
        taxonFamily,
        taxonOrder
      ];
  @override
  String get aliasedName => _alias ?? 'taxonomy';
  @override
  String get actualTableName => 'taxonomy';
  @override
  VerificationContext validateIntegrity(Insertable<TaxonomyData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('genus')) {
      context.handle(
          _genusMeta, genus.isAcceptableOrUnknown(data['genus']!, _genusMeta));
    }
    if (data.containsKey('specificEpithet')) {
      context.handle(
          _specificEpithetMeta,
          specificEpithet.isAcceptableOrUnknown(
              data['specificEpithet']!, _specificEpithetMeta));
    }
    if (data.containsKey('intraspecificEpithet')) {
      context.handle(
          _intraspecificEpithetMeta,
          intraspecificEpithet.isAcceptableOrUnknown(
              data['intraspecificEpithet']!, _intraspecificEpithetMeta));
    }
    if (data.containsKey('taxonFamily')) {
      context.handle(
          _taxonFamilyMeta,
          taxonFamily.isAcceptableOrUnknown(
              data['taxonFamily']!, _taxonFamilyMeta));
    }
    if (data.containsKey('taxonOrder')) {
      context.handle(
          _taxonOrderMeta,
          taxonOrder.isAcceptableOrUnknown(
              data['taxonOrder']!, _taxonOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaxonomyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TaxonomyData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Taxonomy createAlias(String alias) {
    return Taxonomy(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final Project project = Project(this);
  late final Personnel personnel = Personnel(this);
  late final Photo photo = Photo(this);
  late final Site site = Site(this);
  late final Coordinate coordinate = Coordinate(this);
  late final CollEvent collEvent = CollEvent(this);
  late final Narrative narrative = Narrative(this);
  late final PersonnelList personnelList = PersonnelList(this);
  late final Specimen specimen = Specimen(this);
  late final MammalMeasurement mammalMeasurement = MammalMeasurement(this);
  late final BirdMeasurement birdMeasurement = BirdMeasurement(this);
  late final Part part = Part(this);
  late final Taxonomy taxonomy = Taxonomy(this);
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
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        project,
        personnel,
        photo,
        site,
        coordinate,
        collEvent,
        narrative,
        personnelList,
        specimen,
        mammalMeasurement,
        birdMeasurement,
        part,
        taxonomy
      ];
}

class ListProjectResult {
  final String projectUuid;
  final String projectName;
  ListProjectResult({
    required this.projectUuid,
    required this.projectName,
  });
}
