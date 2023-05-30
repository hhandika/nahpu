// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Project extends Table with TableInfo<Project, ProjectData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Project(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _principalInvestigatorMeta =
      const VerificationMeta('principalInvestigator');
  late final GeneratedColumn<String> principalInvestigator =
      GeneratedColumn<String>('principalInvestigator', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'startDate', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'endDate', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  late final GeneratedColumn<String> created = GeneratedColumn<String>(
      'created', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _lastAccessedMeta =
      const VerificationMeta('lastAccessed');
  late final GeneratedColumn<String> lastAccessed = GeneratedColumn<String>(
      'lastAccessed', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        uuid,
        name,
        description,
        principalInvestigator,
        location,
        startDate,
        endDate,
        created,
        lastAccessed
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
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('principalInvestigator')) {
      context.handle(
          _principalInvestigatorMeta,
          principalInvestigator.isAcceptableOrUnknown(
              data['principalInvestigator']!, _principalInvestigatorMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('startDate')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['startDate']!, _startDateMeta));
    }
    if (data.containsKey('endDate')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['endDate']!, _endDateMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('lastAccessed')) {
      context.handle(
          _lastAccessedMeta,
          lastAccessed.isAcceptableOrUnknown(
              data['lastAccessed']!, _lastAccessedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  ProjectData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      principalInvestigator: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}principalInvestigator']),
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}startDate']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endDate']),
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created']),
      lastAccessed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lastAccessed']),
    );
  }

  @override
  Project createAlias(String alias) {
    return Project(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ProjectData extends DataClass implements Insertable<ProjectData> {
  final String uuid;
  final String name;
  final String? description;
  final String? principalInvestigator;
  final String? location;
  final String? startDate;
  final String? endDate;
  final String? created;
  final String? lastAccessed;
  const ProjectData(
      {required this.uuid,
      required this.name,
      this.description,
      this.principalInvestigator,
      this.location,
      this.startDate,
      this.endDate,
      this.created,
      this.lastAccessed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || principalInvestigator != null) {
      map['principalInvestigator'] = Variable<String>(principalInvestigator);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || startDate != null) {
      map['startDate'] = Variable<String>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['endDate'] = Variable<String>(endDate);
    }
    if (!nullToAbsent || created != null) {
      map['created'] = Variable<String>(created);
    }
    if (!nullToAbsent || lastAccessed != null) {
      map['lastAccessed'] = Variable<String>(lastAccessed);
    }
    return map;
  }

  ProjectCompanion toCompanion(bool nullToAbsent) {
    return ProjectCompanion(
      uuid: Value(uuid),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      principalInvestigator: principalInvestigator == null && nullToAbsent
          ? const Value.absent()
          : Value(principalInvestigator),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      created: created == null && nullToAbsent
          ? const Value.absent()
          : Value(created),
      lastAccessed: lastAccessed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAccessed),
    );
  }

  factory ProjectData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectData(
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      principalInvestigator:
          serializer.fromJson<String?>(json['principalInvestigator']),
      location: serializer.fromJson<String?>(json['location']),
      startDate: serializer.fromJson<String?>(json['startDate']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      created: serializer.fromJson<String?>(json['created']),
      lastAccessed: serializer.fromJson<String?>(json['lastAccessed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'principalInvestigator':
          serializer.toJson<String?>(principalInvestigator),
      'location': serializer.toJson<String?>(location),
      'startDate': serializer.toJson<String?>(startDate),
      'endDate': serializer.toJson<String?>(endDate),
      'created': serializer.toJson<String?>(created),
      'lastAccessed': serializer.toJson<String?>(lastAccessed),
    };
  }

  ProjectData copyWith(
          {String? uuid,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> principalInvestigator = const Value.absent(),
          Value<String?> location = const Value.absent(),
          Value<String?> startDate = const Value.absent(),
          Value<String?> endDate = const Value.absent(),
          Value<String?> created = const Value.absent(),
          Value<String?> lastAccessed = const Value.absent()}) =>
      ProjectData(
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        principalInvestigator: principalInvestigator.present
            ? principalInvestigator.value
            : this.principalInvestigator,
        location: location.present ? location.value : this.location,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        created: created.present ? created.value : this.created,
        lastAccessed:
            lastAccessed.present ? lastAccessed.value : this.lastAccessed,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectData(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('principalInvestigator: $principalInvestigator, ')
          ..write('location: $location, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('created: $created, ')
          ..write('lastAccessed: $lastAccessed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uuid,
      name,
      description,
      principalInvestigator,
      location,
      startDate,
      endDate,
      created,
      lastAccessed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectData &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.description == this.description &&
          other.principalInvestigator == this.principalInvestigator &&
          other.location == this.location &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.created == this.created &&
          other.lastAccessed == this.lastAccessed);
}

class ProjectCompanion extends UpdateCompanion<ProjectData> {
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> principalInvestigator;
  final Value<String?> location;
  final Value<String?> startDate;
  final Value<String?> endDate;
  final Value<String?> created;
  final Value<String?> lastAccessed;
  final Value<int> rowid;
  const ProjectCompanion({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.principalInvestigator = const Value.absent(),
    this.location = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.created = const Value.absent(),
    this.lastAccessed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectCompanion.insert({
    required String uuid,
    required String name,
    this.description = const Value.absent(),
    this.principalInvestigator = const Value.absent(),
    this.location = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.created = const Value.absent(),
    this.lastAccessed = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uuid = Value(uuid),
        name = Value(name);
  static Insertable<ProjectData> custom({
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? principalInvestigator,
    Expression<String>? location,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? created,
    Expression<String>? lastAccessed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (principalInvestigator != null)
        'principalInvestigator': principalInvestigator,
      if (location != null) 'location': location,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (created != null) 'created': created,
      if (lastAccessed != null) 'lastAccessed': lastAccessed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? principalInvestigator,
      Value<String?>? location,
      Value<String?>? startDate,
      Value<String?>? endDate,
      Value<String?>? created,
      Value<String?>? lastAccessed,
      Value<int>? rowid}) {
    return ProjectCompanion(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      principalInvestigator:
          principalInvestigator ?? this.principalInvestigator,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      created: created ?? this.created,
      lastAccessed: lastAccessed ?? this.lastAccessed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (principalInvestigator.present) {
      map['principalInvestigator'] =
          Variable<String>(principalInvestigator.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (startDate.present) {
      map['startDate'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['endDate'] = Variable<String>(endDate.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (lastAccessed.present) {
      map['lastAccessed'] = Variable<String>(lastAccessed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectCompanion(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('principalInvestigator: $principalInvestigator, ')
          ..write('location: $location, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('created: $created, ')
          ..write('lastAccessed: $lastAccessed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Personnel extends Table with TableInfo<Personnel, PersonnelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Personnel(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL PRIMARY KEY');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _initialMeta =
      const VerificationMeta('initial');
  late final GeneratedColumn<String> initial = GeneratedColumn<String>(
      'initial', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _affiliationMeta =
      const VerificationMeta('affiliation');
  late final GeneratedColumn<String> affiliation = GeneratedColumn<String>(
      'affiliation', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _currentFieldNumberMeta =
      const VerificationMeta('currentFieldNumber');
  late final GeneratedColumn<int> currentFieldNumber = GeneratedColumn<int>(
      'currentFieldNumber', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photoPath', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        uuid,
        name,
        initial,
        email,
        phone,
        affiliation,
        role,
        currentFieldNumber,
        notes,
        photoPath
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
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('initial')) {
      context.handle(_initialMeta,
          initial.isAcceptableOrUnknown(data['initial']!, _initialMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
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
    if (data.containsKey('currentFieldNumber')) {
      context.handle(
          _currentFieldNumberMeta,
          currentFieldNumber.isAcceptableOrUnknown(
              data['currentFieldNumber']!, _currentFieldNumberMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('photoPath')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photoPath']!, _photoPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  PersonnelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonnelData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      initial: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}initial']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      affiliation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}affiliation']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role']),
      currentFieldNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}currentFieldNumber']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photoPath']),
    );
  }

  @override
  Personnel createAlias(String alias) {
    return Personnel(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class PersonnelData extends DataClass implements Insertable<PersonnelData> {
  final String uuid;
  final String? name;
  final String? initial;
  final String? email;
  final String? phone;
  final String? affiliation;
  final String? role;
  final int? currentFieldNumber;

  /// the next input for field number
  final String? notes;
  final String? photoPath;
  const PersonnelData(
      {required this.uuid,
      this.name,
      this.initial,
      this.email,
      this.phone,
      this.affiliation,
      this.role,
      this.currentFieldNumber,
      this.notes,
      this.photoPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || initial != null) {
      map['initial'] = Variable<String>(initial);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || affiliation != null) {
      map['affiliation'] = Variable<String>(affiliation);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    if (!nullToAbsent || currentFieldNumber != null) {
      map['currentFieldNumber'] = Variable<int>(currentFieldNumber);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photoPath'] = Variable<String>(photoPath);
    }
    return map;
  }

  PersonnelCompanion toCompanion(bool nullToAbsent) {
    return PersonnelCompanion(
      uuid: Value(uuid),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      initial: initial == null && nullToAbsent
          ? const Value.absent()
          : Value(initial),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      affiliation: affiliation == null && nullToAbsent
          ? const Value.absent()
          : Value(affiliation),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      currentFieldNumber: currentFieldNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(currentFieldNumber),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
    );
  }

  factory PersonnelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonnelData(
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String?>(json['name']),
      initial: serializer.fromJson<String?>(json['initial']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      affiliation: serializer.fromJson<String?>(json['affiliation']),
      role: serializer.fromJson<String?>(json['role']),
      currentFieldNumber: serializer.fromJson<int?>(json['currentFieldNumber']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String?>(name),
      'initial': serializer.toJson<String?>(initial),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'affiliation': serializer.toJson<String?>(affiliation),
      'role': serializer.toJson<String?>(role),
      'currentFieldNumber': serializer.toJson<int?>(currentFieldNumber),
      'notes': serializer.toJson<String?>(notes),
      'photoPath': serializer.toJson<String?>(photoPath),
    };
  }

  PersonnelData copyWith(
          {String? uuid,
          Value<String?> name = const Value.absent(),
          Value<String?> initial = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> affiliation = const Value.absent(),
          Value<String?> role = const Value.absent(),
          Value<int?> currentFieldNumber = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<String?> photoPath = const Value.absent()}) =>
      PersonnelData(
        uuid: uuid ?? this.uuid,
        name: name.present ? name.value : this.name,
        initial: initial.present ? initial.value : this.initial,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        affiliation: affiliation.present ? affiliation.value : this.affiliation,
        role: role.present ? role.value : this.role,
        currentFieldNumber: currentFieldNumber.present
            ? currentFieldNumber.value
            : this.currentFieldNumber,
        notes: notes.present ? notes.value : this.notes,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
      );
  @override
  String toString() {
    return (StringBuffer('PersonnelData(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('initial: $initial, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('affiliation: $affiliation, ')
          ..write('role: $role, ')
          ..write('currentFieldNumber: $currentFieldNumber, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, name, initial, email, phone,
      affiliation, role, currentFieldNumber, notes, photoPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonnelData &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.initial == this.initial &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.affiliation == this.affiliation &&
          other.role == this.role &&
          other.currentFieldNumber == this.currentFieldNumber &&
          other.notes == this.notes &&
          other.photoPath == this.photoPath);
}

class PersonnelCompanion extends UpdateCompanion<PersonnelData> {
  final Value<String> uuid;
  final Value<String?> name;
  final Value<String?> initial;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> affiliation;
  final Value<String?> role;
  final Value<int?> currentFieldNumber;
  final Value<String?> notes;
  final Value<String?> photoPath;
  final Value<int> rowid;
  const PersonnelCompanion({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.initial = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.affiliation = const Value.absent(),
    this.role = const Value.absent(),
    this.currentFieldNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonnelCompanion.insert({
    required String uuid,
    this.name = const Value.absent(),
    this.initial = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.affiliation = const Value.absent(),
    this.role = const Value.absent(),
    this.currentFieldNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid);
  static Insertable<PersonnelData> custom({
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? initial,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? affiliation,
    Expression<String>? role,
    Expression<int>? currentFieldNumber,
    Expression<String>? notes,
    Expression<String>? photoPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (initial != null) 'initial': initial,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (affiliation != null) 'affiliation': affiliation,
      if (role != null) 'role': role,
      if (currentFieldNumber != null) 'currentFieldNumber': currentFieldNumber,
      if (notes != null) 'notes': notes,
      if (photoPath != null) 'photoPath': photoPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonnelCompanion copyWith(
      {Value<String>? uuid,
      Value<String?>? name,
      Value<String?>? initial,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? affiliation,
      Value<String?>? role,
      Value<int?>? currentFieldNumber,
      Value<String?>? notes,
      Value<String?>? photoPath,
      Value<int>? rowid}) {
    return PersonnelCompanion(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      initial: initial ?? this.initial,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      affiliation: affiliation ?? this.affiliation,
      role: role ?? this.role,
      currentFieldNumber: currentFieldNumber ?? this.currentFieldNumber,
      notes: notes ?? this.notes,
      photoPath: photoPath ?? this.photoPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (initial.present) {
      map['initial'] = Variable<String>(initial.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (affiliation.present) {
      map['affiliation'] = Variable<String>(affiliation.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (currentFieldNumber.present) {
      map['currentFieldNumber'] = Variable<int>(currentFieldNumber.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoPath.present) {
      map['photoPath'] = Variable<String>(photoPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonnelCompanion(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('initial: $initial, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('affiliation: $affiliation, ')
          ..write('role: $role, ')
          ..write('currentFieldNumber: $currentFieldNumber, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Media extends Table with TableInfo<Media, MediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Media(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _primaryIdMeta =
      const VerificationMeta('primaryId');
  late final GeneratedColumn<int> primaryId = GeneratedColumn<int>(
      'primaryId', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String> projectUuid = GeneratedColumn<String>(
      'projectUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _secondaryIdMeta =
      const VerificationMeta('secondaryId');
  late final GeneratedColumn<String> secondaryId = GeneratedColumn<String>(
      'secondaryId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _subcategoryMeta =
      const VerificationMeta('subcategory');
  late final GeneratedColumn<String> subcategory = GeneratedColumn<String>(
      'subcategory', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _takenMeta = const VerificationMeta('taken');
  late final GeneratedColumn<String> taken = GeneratedColumn<String>(
      'taken', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _cameraMeta = const VerificationMeta('camera');
  late final GeneratedColumn<String> camera = GeneratedColumn<String>(
      'camera', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _lensesMeta = const VerificationMeta('lenses');
  late final GeneratedColumn<String> lenses = GeneratedColumn<String>(
      'lenses', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _additionalExifMeta =
      const VerificationMeta('additionalExif');
  late final GeneratedColumn<String> additionalExif = GeneratedColumn<String>(
      'additionalExif', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _personnelIdMeta =
      const VerificationMeta('personnelId');
  late final GeneratedColumn<String> personnelId = GeneratedColumn<String>(
      'personnelId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'filePath', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _captionMeta =
      const VerificationMeta('caption');
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
      'caption', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        primaryId,
        projectUuid,
        secondaryId,
        category,
        subcategory,
        taken,
        camera,
        lenses,
        additionalExif,
        personnelId,
        filePath,
        caption
      ];
  @override
  String get aliasedName => _alias ?? 'media';
  @override
  String get actualTableName => 'media';
  @override
  VerificationContext validateIntegrity(Insertable<MediaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('primaryId')) {
      context.handle(_primaryIdMeta,
          primaryId.isAcceptableOrUnknown(data['primaryId']!, _primaryIdMeta));
    }
    if (data.containsKey('projectUuid')) {
      context.handle(
          _projectUuidMeta,
          projectUuid.isAcceptableOrUnknown(
              data['projectUuid']!, _projectUuidMeta));
    }
    if (data.containsKey('secondaryId')) {
      context.handle(
          _secondaryIdMeta,
          secondaryId.isAcceptableOrUnknown(
              data['secondaryId']!, _secondaryIdMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('subcategory')) {
      context.handle(
          _subcategoryMeta,
          subcategory.isAcceptableOrUnknown(
              data['subcategory']!, _subcategoryMeta));
    }
    if (data.containsKey('taken')) {
      context.handle(
          _takenMeta, taken.isAcceptableOrUnknown(data['taken']!, _takenMeta));
    }
    if (data.containsKey('camera')) {
      context.handle(_cameraMeta,
          camera.isAcceptableOrUnknown(data['camera']!, _cameraMeta));
    }
    if (data.containsKey('lenses')) {
      context.handle(_lensesMeta,
          lenses.isAcceptableOrUnknown(data['lenses']!, _lensesMeta));
    }
    if (data.containsKey('additionalExif')) {
      context.handle(
          _additionalExifMeta,
          additionalExif.isAcceptableOrUnknown(
              data['additionalExif']!, _additionalExifMeta));
    }
    if (data.containsKey('personnelId')) {
      context.handle(
          _personnelIdMeta,
          personnelId.isAcceptableOrUnknown(
              data['personnelId']!, _personnelIdMeta));
    }
    if (data.containsKey('filePath')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['filePath']!, _filePathMeta));
    }
    if (data.containsKey('caption')) {
      context.handle(_captionMeta,
          caption.isAcceptableOrUnknown(data['caption']!, _captionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {primaryId};
  @override
  MediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaData(
      primaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}primaryId']),
      projectUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}projectUuid']),
      secondaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}secondaryId']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      subcategory: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subcategory']),
      taken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}taken']),
      camera: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}camera']),
      lenses: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lenses']),
      additionalExif: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}additionalExif']),
      personnelId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}personnelId']),
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filePath']),
      caption: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caption']),
    );
  }

  @override
  Media createAlias(String alias) {
    return Media(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(personnelId)REFERENCES personnel(uuid)',
        'FOREIGN KEY(projectUuid)REFERENCES project(uuid)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class MediaData extends DataClass implements Insertable<MediaData> {
  final int? primaryId;
  final String? projectUuid;
  final String? secondaryId;
  final String? category;
  final String? subcategory;
  final String? taken;
  final String? camera;
  final String? lenses;
  final String? additionalExif;
  final String? personnelId;
  final String? filePath;
  final String? caption;
  const MediaData(
      {this.primaryId,
      this.projectUuid,
      this.secondaryId,
      this.category,
      this.subcategory,
      this.taken,
      this.camera,
      this.lenses,
      this.additionalExif,
      this.personnelId,
      this.filePath,
      this.caption});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || primaryId != null) {
      map['primaryId'] = Variable<int>(primaryId);
    }
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String>(projectUuid);
    }
    if (!nullToAbsent || secondaryId != null) {
      map['secondaryId'] = Variable<String>(secondaryId);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || subcategory != null) {
      map['subcategory'] = Variable<String>(subcategory);
    }
    if (!nullToAbsent || taken != null) {
      map['taken'] = Variable<String>(taken);
    }
    if (!nullToAbsent || camera != null) {
      map['camera'] = Variable<String>(camera);
    }
    if (!nullToAbsent || lenses != null) {
      map['lenses'] = Variable<String>(lenses);
    }
    if (!nullToAbsent || additionalExif != null) {
      map['additionalExif'] = Variable<String>(additionalExif);
    }
    if (!nullToAbsent || personnelId != null) {
      map['personnelId'] = Variable<String>(personnelId);
    }
    if (!nullToAbsent || filePath != null) {
      map['filePath'] = Variable<String>(filePath);
    }
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    return map;
  }

  MediaCompanion toCompanion(bool nullToAbsent) {
    return MediaCompanion(
      primaryId: primaryId == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryId),
      projectUuid: projectUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(projectUuid),
      secondaryId: secondaryId == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryId),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      subcategory: subcategory == null && nullToAbsent
          ? const Value.absent()
          : Value(subcategory),
      taken:
          taken == null && nullToAbsent ? const Value.absent() : Value(taken),
      camera:
          camera == null && nullToAbsent ? const Value.absent() : Value(camera),
      lenses:
          lenses == null && nullToAbsent ? const Value.absent() : Value(lenses),
      additionalExif: additionalExif == null && nullToAbsent
          ? const Value.absent()
          : Value(additionalExif),
      personnelId: personnelId == null && nullToAbsent
          ? const Value.absent()
          : Value(personnelId),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
    );
  }

  factory MediaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaData(
      primaryId: serializer.fromJson<int?>(json['primaryId']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      secondaryId: serializer.fromJson<String?>(json['secondaryId']),
      category: serializer.fromJson<String?>(json['category']),
      subcategory: serializer.fromJson<String?>(json['subcategory']),
      taken: serializer.fromJson<String?>(json['taken']),
      camera: serializer.fromJson<String?>(json['camera']),
      lenses: serializer.fromJson<String?>(json['lenses']),
      additionalExif: serializer.fromJson<String?>(json['additionalExif']),
      personnelId: serializer.fromJson<String?>(json['personnelId']),
      filePath: serializer.fromJson<String?>(json['filePath']),
      caption: serializer.fromJson<String?>(json['caption']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'primaryId': serializer.toJson<int?>(primaryId),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'secondaryId': serializer.toJson<String?>(secondaryId),
      'category': serializer.toJson<String?>(category),
      'subcategory': serializer.toJson<String?>(subcategory),
      'taken': serializer.toJson<String?>(taken),
      'camera': serializer.toJson<String?>(camera),
      'lenses': serializer.toJson<String?>(lenses),
      'additionalExif': serializer.toJson<String?>(additionalExif),
      'personnelId': serializer.toJson<String?>(personnelId),
      'filePath': serializer.toJson<String?>(filePath),
      'caption': serializer.toJson<String?>(caption),
    };
  }

  MediaData copyWith(
          {Value<int?> primaryId = const Value.absent(),
          Value<String?> projectUuid = const Value.absent(),
          Value<String?> secondaryId = const Value.absent(),
          Value<String?> category = const Value.absent(),
          Value<String?> subcategory = const Value.absent(),
          Value<String?> taken = const Value.absent(),
          Value<String?> camera = const Value.absent(),
          Value<String?> lenses = const Value.absent(),
          Value<String?> additionalExif = const Value.absent(),
          Value<String?> personnelId = const Value.absent(),
          Value<String?> filePath = const Value.absent(),
          Value<String?> caption = const Value.absent()}) =>
      MediaData(
        primaryId: primaryId.present ? primaryId.value : this.primaryId,
        projectUuid: projectUuid.present ? projectUuid.value : this.projectUuid,
        secondaryId: secondaryId.present ? secondaryId.value : this.secondaryId,
        category: category.present ? category.value : this.category,
        subcategory: subcategory.present ? subcategory.value : this.subcategory,
        taken: taken.present ? taken.value : this.taken,
        camera: camera.present ? camera.value : this.camera,
        lenses: lenses.present ? lenses.value : this.lenses,
        additionalExif:
            additionalExif.present ? additionalExif.value : this.additionalExif,
        personnelId: personnelId.present ? personnelId.value : this.personnelId,
        filePath: filePath.present ? filePath.value : this.filePath,
        caption: caption.present ? caption.value : this.caption,
      );
  @override
  String toString() {
    return (StringBuffer('MediaData(')
          ..write('primaryId: $primaryId, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('secondaryId: $secondaryId, ')
          ..write('category: $category, ')
          ..write('subcategory: $subcategory, ')
          ..write('taken: $taken, ')
          ..write('camera: $camera, ')
          ..write('lenses: $lenses, ')
          ..write('additionalExif: $additionalExif, ')
          ..write('personnelId: $personnelId, ')
          ..write('filePath: $filePath, ')
          ..write('caption: $caption')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      primaryId,
      projectUuid,
      secondaryId,
      category,
      subcategory,
      taken,
      camera,
      lenses,
      additionalExif,
      personnelId,
      filePath,
      caption);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaData &&
          other.primaryId == this.primaryId &&
          other.projectUuid == this.projectUuid &&
          other.secondaryId == this.secondaryId &&
          other.category == this.category &&
          other.subcategory == this.subcategory &&
          other.taken == this.taken &&
          other.camera == this.camera &&
          other.lenses == this.lenses &&
          other.additionalExif == this.additionalExif &&
          other.personnelId == this.personnelId &&
          other.filePath == this.filePath &&
          other.caption == this.caption);
}

class MediaCompanion extends UpdateCompanion<MediaData> {
  final Value<int?> primaryId;
  final Value<String?> projectUuid;
  final Value<String?> secondaryId;
  final Value<String?> category;
  final Value<String?> subcategory;
  final Value<String?> taken;
  final Value<String?> camera;
  final Value<String?> lenses;
  final Value<String?> additionalExif;
  final Value<String?> personnelId;
  final Value<String?> filePath;
  final Value<String?> caption;
  const MediaCompanion({
    this.primaryId = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.secondaryId = const Value.absent(),
    this.category = const Value.absent(),
    this.subcategory = const Value.absent(),
    this.taken = const Value.absent(),
    this.camera = const Value.absent(),
    this.lenses = const Value.absent(),
    this.additionalExif = const Value.absent(),
    this.personnelId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.caption = const Value.absent(),
  });
  MediaCompanion.insert({
    this.primaryId = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.secondaryId = const Value.absent(),
    this.category = const Value.absent(),
    this.subcategory = const Value.absent(),
    this.taken = const Value.absent(),
    this.camera = const Value.absent(),
    this.lenses = const Value.absent(),
    this.additionalExif = const Value.absent(),
    this.personnelId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.caption = const Value.absent(),
  });
  static Insertable<MediaData> custom({
    Expression<int>? primaryId,
    Expression<String>? projectUuid,
    Expression<String>? secondaryId,
    Expression<String>? category,
    Expression<String>? subcategory,
    Expression<String>? taken,
    Expression<String>? camera,
    Expression<String>? lenses,
    Expression<String>? additionalExif,
    Expression<String>? personnelId,
    Expression<String>? filePath,
    Expression<String>? caption,
  }) {
    return RawValuesInsertable({
      if (primaryId != null) 'primaryId': primaryId,
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (secondaryId != null) 'secondaryId': secondaryId,
      if (category != null) 'category': category,
      if (subcategory != null) 'subcategory': subcategory,
      if (taken != null) 'taken': taken,
      if (camera != null) 'camera': camera,
      if (lenses != null) 'lenses': lenses,
      if (additionalExif != null) 'additionalExif': additionalExif,
      if (personnelId != null) 'personnelId': personnelId,
      if (filePath != null) 'filePath': filePath,
      if (caption != null) 'caption': caption,
    });
  }

  MediaCompanion copyWith(
      {Value<int?>? primaryId,
      Value<String?>? projectUuid,
      Value<String?>? secondaryId,
      Value<String?>? category,
      Value<String?>? subcategory,
      Value<String?>? taken,
      Value<String?>? camera,
      Value<String?>? lenses,
      Value<String?>? additionalExif,
      Value<String?>? personnelId,
      Value<String?>? filePath,
      Value<String?>? caption}) {
    return MediaCompanion(
      primaryId: primaryId ?? this.primaryId,
      projectUuid: projectUuid ?? this.projectUuid,
      secondaryId: secondaryId ?? this.secondaryId,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      taken: taken ?? this.taken,
      camera: camera ?? this.camera,
      lenses: lenses ?? this.lenses,
      additionalExif: additionalExif ?? this.additionalExif,
      personnelId: personnelId ?? this.personnelId,
      filePath: filePath ?? this.filePath,
      caption: caption ?? this.caption,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (primaryId.present) {
      map['primaryId'] = Variable<int>(primaryId.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String>(projectUuid.value);
    }
    if (secondaryId.present) {
      map['secondaryId'] = Variable<String>(secondaryId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (subcategory.present) {
      map['subcategory'] = Variable<String>(subcategory.value);
    }
    if (taken.present) {
      map['taken'] = Variable<String>(taken.value);
    }
    if (camera.present) {
      map['camera'] = Variable<String>(camera.value);
    }
    if (lenses.present) {
      map['lenses'] = Variable<String>(lenses.value);
    }
    if (additionalExif.present) {
      map['additionalExif'] = Variable<String>(additionalExif.value);
    }
    if (personnelId.present) {
      map['personnelId'] = Variable<String>(personnelId.value);
    }
    if (filePath.present) {
      map['filePath'] = Variable<String>(filePath.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaCompanion(')
          ..write('primaryId: $primaryId, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('secondaryId: $secondaryId, ')
          ..write('category: $category, ')
          ..write('subcategory: $subcategory, ')
          ..write('taken: $taken, ')
          ..write('camera: $camera, ')
          ..write('lenses: $lenses, ')
          ..write('additionalExif: $additionalExif, ')
          ..write('personnelId: $personnelId, ')
          ..write('filePath: $filePath, ')
          ..write('caption: $caption')
          ..write(')'))
        .toString();
  }
}

class Site extends Table with TableInfo<Site, SiteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Site(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _siteIDMeta = const VerificationMeta('siteID');
  late final GeneratedColumn<String> siteID = GeneratedColumn<String>(
      'siteID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String> projectUuid = GeneratedColumn<String>(
      'projectUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _leadStaffIdMeta =
      const VerificationMeta('leadStaffId');
  late final GeneratedColumn<String> leadStaffId = GeneratedColumn<String>(
      'leadStaffId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _siteTypeMeta =
      const VerificationMeta('siteType');
  late final GeneratedColumn<String> siteType = GeneratedColumn<String>(
      'siteType', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _stateProvinceMeta =
      const VerificationMeta('stateProvince');
  late final GeneratedColumn<String> stateProvince = GeneratedColumn<String>(
      'stateProvince', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _countyMeta = const VerificationMeta('county');
  late final GeneratedColumn<String> county = GeneratedColumn<String>(
      'county', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _municipalityMeta =
      const VerificationMeta('municipality');
  late final GeneratedColumn<String> municipality = GeneratedColumn<String>(
      'municipality', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _mediaIDMeta =
      const VerificationMeta('mediaID');
  late final GeneratedColumn<String> mediaID = GeneratedColumn<String>(
      'mediaID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _localityMeta =
      const VerificationMeta('locality');
  late final GeneratedColumn<String> locality = GeneratedColumn<String>(
      'locality', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _habitatTypeMeta =
      const VerificationMeta('habitatType');
  late final GeneratedColumn<String> habitatType = GeneratedColumn<String>(
      'habitatType', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _habitatConditionMeta =
      const VerificationMeta('habitatCondition');
  late final GeneratedColumn<String> habitatCondition = GeneratedColumn<String>(
      'habitatCondition', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _habitatDescriptionMeta =
      const VerificationMeta('habitatDescription');
  late final GeneratedColumn<String> habitatDescription =
      GeneratedColumn<String>('habitatDescription', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        siteID,
        projectUuid,
        leadStaffId,
        siteType,
        country,
        stateProvince,
        county,
        municipality,
        mediaID,
        locality,
        remark,
        habitatType,
        habitatCondition,
        habitatDescription
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
    if (data.containsKey('leadStaffId')) {
      context.handle(
          _leadStaffIdMeta,
          leadStaffId.isAcceptableOrUnknown(
              data['leadStaffId']!, _leadStaffIdMeta));
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
    if (data.containsKey('mediaID')) {
      context.handle(_mediaIDMeta,
          mediaID.isAcceptableOrUnknown(data['mediaID']!, _mediaIDMeta));
    }
    if (data.containsKey('locality')) {
      context.handle(_localityMeta,
          locality.isAcceptableOrUnknown(data['locality']!, _localityMeta));
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    }
    if (data.containsKey('habitatType')) {
      context.handle(
          _habitatTypeMeta,
          habitatType.isAcceptableOrUnknown(
              data['habitatType']!, _habitatTypeMeta));
    }
    if (data.containsKey('habitatCondition')) {
      context.handle(
          _habitatConditionMeta,
          habitatCondition.isAcceptableOrUnknown(
              data['habitatCondition']!, _habitatConditionMeta));
    }
    if (data.containsKey('habitatDescription')) {
      context.handle(
          _habitatDescriptionMeta,
          habitatDescription.isAcceptableOrUnknown(
              data['habitatDescription']!, _habitatDescriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SiteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SiteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      siteID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}siteID']),
      projectUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}projectUuid']),
      leadStaffId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}leadStaffId']),
      siteType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}siteType']),
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country']),
      stateProvince: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stateProvince']),
      county: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}county']),
      municipality: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}municipality']),
      mediaID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mediaID']),
      locality: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locality']),
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
      habitatType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habitatType']),
      habitatCondition: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}habitatCondition']),
      habitatDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}habitatDescription']),
    );
  }

  @override
  Site createAlias(String alias) {
    return Site(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(mediaID)REFERENCES media(primaryId)',
        'FOREIGN KEY(leadStaffId)REFERENCES personnel(uuid)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class SiteData extends DataClass implements Insertable<SiteData> {
  final int id;
  final String? siteID;
  final String? projectUuid;
  final String? leadStaffId;
  final String? siteType;
  final String? country;
  final String? stateProvince;
  final String? county;
  final String? municipality;
  final String? mediaID;
  final String? locality;

  /// verbatim locality in DWC
  final String? remark;
  final String? habitatType;
  final String? habitatCondition;
  final String? habitatDescription;
  const SiteData(
      {required this.id,
      this.siteID,
      this.projectUuid,
      this.leadStaffId,
      this.siteType,
      this.country,
      this.stateProvince,
      this.county,
      this.municipality,
      this.mediaID,
      this.locality,
      this.remark,
      this.habitatType,
      this.habitatCondition,
      this.habitatDescription});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || siteID != null) {
      map['siteID'] = Variable<String>(siteID);
    }
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String>(projectUuid);
    }
    if (!nullToAbsent || leadStaffId != null) {
      map['leadStaffId'] = Variable<String>(leadStaffId);
    }
    if (!nullToAbsent || siteType != null) {
      map['siteType'] = Variable<String>(siteType);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || stateProvince != null) {
      map['stateProvince'] = Variable<String>(stateProvince);
    }
    if (!nullToAbsent || county != null) {
      map['county'] = Variable<String>(county);
    }
    if (!nullToAbsent || municipality != null) {
      map['municipality'] = Variable<String>(municipality);
    }
    if (!nullToAbsent || mediaID != null) {
      map['mediaID'] = Variable<String>(mediaID);
    }
    if (!nullToAbsent || locality != null) {
      map['locality'] = Variable<String>(locality);
    }
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    if (!nullToAbsent || habitatType != null) {
      map['habitatType'] = Variable<String>(habitatType);
    }
    if (!nullToAbsent || habitatCondition != null) {
      map['habitatCondition'] = Variable<String>(habitatCondition);
    }
    if (!nullToAbsent || habitatDescription != null) {
      map['habitatDescription'] = Variable<String>(habitatDescription);
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
      leadStaffId: leadStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(leadStaffId),
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
      mediaID: mediaID == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaID),
      locality: locality == null && nullToAbsent
          ? const Value.absent()
          : Value(locality),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
      habitatType: habitatType == null && nullToAbsent
          ? const Value.absent()
          : Value(habitatType),
      habitatCondition: habitatCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(habitatCondition),
      habitatDescription: habitatDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(habitatDescription),
    );
  }

  factory SiteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SiteData(
      id: serializer.fromJson<int>(json['id']),
      siteID: serializer.fromJson<String?>(json['siteID']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      leadStaffId: serializer.fromJson<String?>(json['leadStaffId']),
      siteType: serializer.fromJson<String?>(json['siteType']),
      country: serializer.fromJson<String?>(json['country']),
      stateProvince: serializer.fromJson<String?>(json['stateProvince']),
      county: serializer.fromJson<String?>(json['county']),
      municipality: serializer.fromJson<String?>(json['municipality']),
      mediaID: serializer.fromJson<String?>(json['mediaID']),
      locality: serializer.fromJson<String?>(json['locality']),
      remark: serializer.fromJson<String?>(json['remark']),
      habitatType: serializer.fromJson<String?>(json['habitatType']),
      habitatCondition: serializer.fromJson<String?>(json['habitatCondition']),
      habitatDescription:
          serializer.fromJson<String?>(json['habitatDescription']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'siteID': serializer.toJson<String?>(siteID),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'leadStaffId': serializer.toJson<String?>(leadStaffId),
      'siteType': serializer.toJson<String?>(siteType),
      'country': serializer.toJson<String?>(country),
      'stateProvince': serializer.toJson<String?>(stateProvince),
      'county': serializer.toJson<String?>(county),
      'municipality': serializer.toJson<String?>(municipality),
      'mediaID': serializer.toJson<String?>(mediaID),
      'locality': serializer.toJson<String?>(locality),
      'remark': serializer.toJson<String?>(remark),
      'habitatType': serializer.toJson<String?>(habitatType),
      'habitatCondition': serializer.toJson<String?>(habitatCondition),
      'habitatDescription': serializer.toJson<String?>(habitatDescription),
    };
  }

  SiteData copyWith(
          {int? id,
          Value<String?> siteID = const Value.absent(),
          Value<String?> projectUuid = const Value.absent(),
          Value<String?> leadStaffId = const Value.absent(),
          Value<String?> siteType = const Value.absent(),
          Value<String?> country = const Value.absent(),
          Value<String?> stateProvince = const Value.absent(),
          Value<String?> county = const Value.absent(),
          Value<String?> municipality = const Value.absent(),
          Value<String?> mediaID = const Value.absent(),
          Value<String?> locality = const Value.absent(),
          Value<String?> remark = const Value.absent(),
          Value<String?> habitatType = const Value.absent(),
          Value<String?> habitatCondition = const Value.absent(),
          Value<String?> habitatDescription = const Value.absent()}) =>
      SiteData(
        id: id ?? this.id,
        siteID: siteID.present ? siteID.value : this.siteID,
        projectUuid: projectUuid.present ? projectUuid.value : this.projectUuid,
        leadStaffId: leadStaffId.present ? leadStaffId.value : this.leadStaffId,
        siteType: siteType.present ? siteType.value : this.siteType,
        country: country.present ? country.value : this.country,
        stateProvince:
            stateProvince.present ? stateProvince.value : this.stateProvince,
        county: county.present ? county.value : this.county,
        municipality:
            municipality.present ? municipality.value : this.municipality,
        mediaID: mediaID.present ? mediaID.value : this.mediaID,
        locality: locality.present ? locality.value : this.locality,
        remark: remark.present ? remark.value : this.remark,
        habitatType: habitatType.present ? habitatType.value : this.habitatType,
        habitatCondition: habitatCondition.present
            ? habitatCondition.value
            : this.habitatCondition,
        habitatDescription: habitatDescription.present
            ? habitatDescription.value
            : this.habitatDescription,
      );
  @override
  String toString() {
    return (StringBuffer('SiteData(')
          ..write('id: $id, ')
          ..write('siteID: $siteID, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('leadStaffId: $leadStaffId, ')
          ..write('siteType: $siteType, ')
          ..write('country: $country, ')
          ..write('stateProvince: $stateProvince, ')
          ..write('county: $county, ')
          ..write('municipality: $municipality, ')
          ..write('mediaID: $mediaID, ')
          ..write('locality: $locality, ')
          ..write('remark: $remark, ')
          ..write('habitatType: $habitatType, ')
          ..write('habitatCondition: $habitatCondition, ')
          ..write('habitatDescription: $habitatDescription')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      siteID,
      projectUuid,
      leadStaffId,
      siteType,
      country,
      stateProvince,
      county,
      municipality,
      mediaID,
      locality,
      remark,
      habitatType,
      habitatCondition,
      habitatDescription);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SiteData &&
          other.id == this.id &&
          other.siteID == this.siteID &&
          other.projectUuid == this.projectUuid &&
          other.leadStaffId == this.leadStaffId &&
          other.siteType == this.siteType &&
          other.country == this.country &&
          other.stateProvince == this.stateProvince &&
          other.county == this.county &&
          other.municipality == this.municipality &&
          other.mediaID == this.mediaID &&
          other.locality == this.locality &&
          other.remark == this.remark &&
          other.habitatType == this.habitatType &&
          other.habitatCondition == this.habitatCondition &&
          other.habitatDescription == this.habitatDescription);
}

class SiteCompanion extends UpdateCompanion<SiteData> {
  final Value<int> id;
  final Value<String?> siteID;
  final Value<String?> projectUuid;
  final Value<String?> leadStaffId;
  final Value<String?> siteType;
  final Value<String?> country;
  final Value<String?> stateProvince;
  final Value<String?> county;
  final Value<String?> municipality;
  final Value<String?> mediaID;
  final Value<String?> locality;
  final Value<String?> remark;
  final Value<String?> habitatType;
  final Value<String?> habitatCondition;
  final Value<String?> habitatDescription;
  const SiteCompanion({
    this.id = const Value.absent(),
    this.siteID = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.leadStaffId = const Value.absent(),
    this.siteType = const Value.absent(),
    this.country = const Value.absent(),
    this.stateProvince = const Value.absent(),
    this.county = const Value.absent(),
    this.municipality = const Value.absent(),
    this.mediaID = const Value.absent(),
    this.locality = const Value.absent(),
    this.remark = const Value.absent(),
    this.habitatType = const Value.absent(),
    this.habitatCondition = const Value.absent(),
    this.habitatDescription = const Value.absent(),
  });
  SiteCompanion.insert({
    this.id = const Value.absent(),
    this.siteID = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.leadStaffId = const Value.absent(),
    this.siteType = const Value.absent(),
    this.country = const Value.absent(),
    this.stateProvince = const Value.absent(),
    this.county = const Value.absent(),
    this.municipality = const Value.absent(),
    this.mediaID = const Value.absent(),
    this.locality = const Value.absent(),
    this.remark = const Value.absent(),
    this.habitatType = const Value.absent(),
    this.habitatCondition = const Value.absent(),
    this.habitatDescription = const Value.absent(),
  });
  static Insertable<SiteData> custom({
    Expression<int>? id,
    Expression<String>? siteID,
    Expression<String>? projectUuid,
    Expression<String>? leadStaffId,
    Expression<String>? siteType,
    Expression<String>? country,
    Expression<String>? stateProvince,
    Expression<String>? county,
    Expression<String>? municipality,
    Expression<String>? mediaID,
    Expression<String>? locality,
    Expression<String>? remark,
    Expression<String>? habitatType,
    Expression<String>? habitatCondition,
    Expression<String>? habitatDescription,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (siteID != null) 'siteID': siteID,
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (leadStaffId != null) 'leadStaffId': leadStaffId,
      if (siteType != null) 'siteType': siteType,
      if (country != null) 'country': country,
      if (stateProvince != null) 'stateProvince': stateProvince,
      if (county != null) 'county': county,
      if (municipality != null) 'municipality': municipality,
      if (mediaID != null) 'mediaID': mediaID,
      if (locality != null) 'locality': locality,
      if (remark != null) 'remark': remark,
      if (habitatType != null) 'habitatType': habitatType,
      if (habitatCondition != null) 'habitatCondition': habitatCondition,
      if (habitatDescription != null) 'habitatDescription': habitatDescription,
    });
  }

  SiteCompanion copyWith(
      {Value<int>? id,
      Value<String?>? siteID,
      Value<String?>? projectUuid,
      Value<String?>? leadStaffId,
      Value<String?>? siteType,
      Value<String?>? country,
      Value<String?>? stateProvince,
      Value<String?>? county,
      Value<String?>? municipality,
      Value<String?>? mediaID,
      Value<String?>? locality,
      Value<String?>? remark,
      Value<String?>? habitatType,
      Value<String?>? habitatCondition,
      Value<String?>? habitatDescription}) {
    return SiteCompanion(
      id: id ?? this.id,
      siteID: siteID ?? this.siteID,
      projectUuid: projectUuid ?? this.projectUuid,
      leadStaffId: leadStaffId ?? this.leadStaffId,
      siteType: siteType ?? this.siteType,
      country: country ?? this.country,
      stateProvince: stateProvince ?? this.stateProvince,
      county: county ?? this.county,
      municipality: municipality ?? this.municipality,
      mediaID: mediaID ?? this.mediaID,
      locality: locality ?? this.locality,
      remark: remark ?? this.remark,
      habitatType: habitatType ?? this.habitatType,
      habitatCondition: habitatCondition ?? this.habitatCondition,
      habitatDescription: habitatDescription ?? this.habitatDescription,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (siteID.present) {
      map['siteID'] = Variable<String>(siteID.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String>(projectUuid.value);
    }
    if (leadStaffId.present) {
      map['leadStaffId'] = Variable<String>(leadStaffId.value);
    }
    if (siteType.present) {
      map['siteType'] = Variable<String>(siteType.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (stateProvince.present) {
      map['stateProvince'] = Variable<String>(stateProvince.value);
    }
    if (county.present) {
      map['county'] = Variable<String>(county.value);
    }
    if (municipality.present) {
      map['municipality'] = Variable<String>(municipality.value);
    }
    if (mediaID.present) {
      map['mediaID'] = Variable<String>(mediaID.value);
    }
    if (locality.present) {
      map['locality'] = Variable<String>(locality.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (habitatType.present) {
      map['habitatType'] = Variable<String>(habitatType.value);
    }
    if (habitatCondition.present) {
      map['habitatCondition'] = Variable<String>(habitatCondition.value);
    }
    if (habitatDescription.present) {
      map['habitatDescription'] = Variable<String>(habitatDescription.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SiteCompanion(')
          ..write('id: $id, ')
          ..write('siteID: $siteID, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('leadStaffId: $leadStaffId, ')
          ..write('siteType: $siteType, ')
          ..write('country: $country, ')
          ..write('stateProvince: $stateProvince, ')
          ..write('county: $county, ')
          ..write('municipality: $municipality, ')
          ..write('mediaID: $mediaID, ')
          ..write('locality: $locality, ')
          ..write('remark: $remark, ')
          ..write('habitatType: $habitatType, ')
          ..write('habitatCondition: $habitatCondition, ')
          ..write('habitatDescription: $habitatDescription')
          ..write(')'))
        .toString();
  }
}

class Coordinate extends Table with TableInfo<Coordinate, CoordinateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Coordinate(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _nameIdMeta = const VerificationMeta('nameId');
  late final GeneratedColumn<String> nameId = GeneratedColumn<String>(
      'nameId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _decimalLatitudeMeta =
      const VerificationMeta('decimalLatitude');
  late final GeneratedColumn<double> decimalLatitude = GeneratedColumn<double>(
      'decimalLatitude', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _decimalLongitudeMeta =
      const VerificationMeta('decimalLongitude');
  late final GeneratedColumn<double> decimalLongitude = GeneratedColumn<double>(
      'decimalLongitude', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _elevationInMeterMeta =
      const VerificationMeta('elevationInMeter');
  late final GeneratedColumn<int> elevationInMeter = GeneratedColumn<int>(
      'elevationInMeter', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _minimumElevationInMetersMeta =
      const VerificationMeta('minimumElevationInMeters');
  late final GeneratedColumn<int> minimumElevationInMeters =
      GeneratedColumn<int>('minimumElevationInMeters', aliasedName, true,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _maximumElevationInMetersMeta =
      const VerificationMeta('maximumElevationInMeters');
  late final GeneratedColumn<int> maximumElevationInMeters =
      GeneratedColumn<int>('maximumElevationInMeters', aliasedName, true,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _datumMeta = const VerificationMeta('datum');
  late final GeneratedColumn<String> datum = GeneratedColumn<String>(
      'datum', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _uncertaintyInMetersMeta =
      const VerificationMeta('uncertaintyInMeters');
  late final GeneratedColumn<int> uncertaintyInMeters = GeneratedColumn<int>(
      'uncertaintyInMeters', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _gpsUnitMeta =
      const VerificationMeta('gpsUnit');
  late final GeneratedColumn<String> gpsUnit = GeneratedColumn<String>(
      'gpsUnit', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _siteIDMeta = const VerificationMeta('siteID');
  late final GeneratedColumn<int> siteID = GeneratedColumn<int>(
      'siteID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nameId,
        decimalLatitude,
        decimalLongitude,
        elevationInMeter,
        minimumElevationInMeters,
        maximumElevationInMeters,
        datum,
        uncertaintyInMeters,
        gpsUnit,
        notes,
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
    if (data.containsKey('nameId')) {
      context.handle(_nameIdMeta,
          nameId.isAcceptableOrUnknown(data['nameId']!, _nameIdMeta));
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
    if (data.containsKey('datum')) {
      context.handle(
          _datumMeta, datum.isAcceptableOrUnknown(data['datum']!, _datumMeta));
    }
    if (data.containsKey('uncertaintyInMeters')) {
      context.handle(
          _uncertaintyInMetersMeta,
          uncertaintyInMeters.isAcceptableOrUnknown(
              data['uncertaintyInMeters']!, _uncertaintyInMetersMeta));
    }
    if (data.containsKey('gpsUnit')) {
      context.handle(_gpsUnitMeta,
          gpsUnit.isAcceptableOrUnknown(data['gpsUnit']!, _gpsUnitMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoordinateData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      nameId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nameId']),
      decimalLatitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}decimalLatitude']),
      decimalLongitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}decimalLongitude']),
      elevationInMeter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}elevationInMeter']),
      minimumElevationInMeters: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}minimumElevationInMeters']),
      maximumElevationInMeters: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}maximumElevationInMeters']),
      datum: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}datum']),
      uncertaintyInMeters: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}uncertaintyInMeters']),
      gpsUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gpsUnit']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      siteID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}siteID']),
    );
  }

  @override
  Coordinate createAlias(String alias) {
    return Coordinate(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(siteID)REFERENCES site(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class CoordinateData extends DataClass implements Insertable<CoordinateData> {
  final int? id;

  /// internal id for easy access
  final String? nameId;

  /// users assigned id.
  final double? decimalLatitude;
  final double? decimalLongitude;
  final int? elevationInMeter;
  final int? minimumElevationInMeters;
  final int? maximumElevationInMeters;
  final String? datum;
  final int? uncertaintyInMeters;
  final String? gpsUnit;
  final String? notes;
  final int? siteID;
  const CoordinateData(
      {this.id,
      this.nameId,
      this.decimalLatitude,
      this.decimalLongitude,
      this.elevationInMeter,
      this.minimumElevationInMeters,
      this.maximumElevationInMeters,
      this.datum,
      this.uncertaintyInMeters,
      this.gpsUnit,
      this.notes,
      this.siteID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || nameId != null) {
      map['nameId'] = Variable<String>(nameId);
    }
    if (!nullToAbsent || decimalLatitude != null) {
      map['decimalLatitude'] = Variable<double>(decimalLatitude);
    }
    if (!nullToAbsent || decimalLongitude != null) {
      map['decimalLongitude'] = Variable<double>(decimalLongitude);
    }
    if (!nullToAbsent || elevationInMeter != null) {
      map['elevationInMeter'] = Variable<int>(elevationInMeter);
    }
    if (!nullToAbsent || minimumElevationInMeters != null) {
      map['minimumElevationInMeters'] = Variable<int>(minimumElevationInMeters);
    }
    if (!nullToAbsent || maximumElevationInMeters != null) {
      map['maximumElevationInMeters'] = Variable<int>(maximumElevationInMeters);
    }
    if (!nullToAbsent || datum != null) {
      map['datum'] = Variable<String>(datum);
    }
    if (!nullToAbsent || uncertaintyInMeters != null) {
      map['uncertaintyInMeters'] = Variable<int>(uncertaintyInMeters);
    }
    if (!nullToAbsent || gpsUnit != null) {
      map['gpsUnit'] = Variable<String>(gpsUnit);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || siteID != null) {
      map['siteID'] = Variable<int>(siteID);
    }
    return map;
  }

  CoordinateCompanion toCompanion(bool nullToAbsent) {
    return CoordinateCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nameId:
          nameId == null && nullToAbsent ? const Value.absent() : Value(nameId),
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
      datum:
          datum == null && nullToAbsent ? const Value.absent() : Value(datum),
      uncertaintyInMeters: uncertaintyInMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(uncertaintyInMeters),
      gpsUnit: gpsUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsUnit),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      siteID:
          siteID == null && nullToAbsent ? const Value.absent() : Value(siteID),
    );
  }

  factory CoordinateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoordinateData(
      id: serializer.fromJson<int?>(json['id']),
      nameId: serializer.fromJson<String?>(json['nameId']),
      decimalLatitude: serializer.fromJson<double?>(json['decimalLatitude']),
      decimalLongitude: serializer.fromJson<double?>(json['decimalLongitude']),
      elevationInMeter: serializer.fromJson<int?>(json['elevationInMeter']),
      minimumElevationInMeters:
          serializer.fromJson<int?>(json['minimumElevationInMeters']),
      maximumElevationInMeters:
          serializer.fromJson<int?>(json['maximumElevationInMeters']),
      datum: serializer.fromJson<String?>(json['datum']),
      uncertaintyInMeters:
          serializer.fromJson<int?>(json['uncertaintyInMeters']),
      gpsUnit: serializer.fromJson<String?>(json['gpsUnit']),
      notes: serializer.fromJson<String?>(json['notes']),
      siteID: serializer.fromJson<int?>(json['siteID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'nameId': serializer.toJson<String?>(nameId),
      'decimalLatitude': serializer.toJson<double?>(decimalLatitude),
      'decimalLongitude': serializer.toJson<double?>(decimalLongitude),
      'elevationInMeter': serializer.toJson<int?>(elevationInMeter),
      'minimumElevationInMeters':
          serializer.toJson<int?>(minimumElevationInMeters),
      'maximumElevationInMeters':
          serializer.toJson<int?>(maximumElevationInMeters),
      'datum': serializer.toJson<String?>(datum),
      'uncertaintyInMeters': serializer.toJson<int?>(uncertaintyInMeters),
      'gpsUnit': serializer.toJson<String?>(gpsUnit),
      'notes': serializer.toJson<String?>(notes),
      'siteID': serializer.toJson<int?>(siteID),
    };
  }

  CoordinateData copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> nameId = const Value.absent(),
          Value<double?> decimalLatitude = const Value.absent(),
          Value<double?> decimalLongitude = const Value.absent(),
          Value<int?> elevationInMeter = const Value.absent(),
          Value<int?> minimumElevationInMeters = const Value.absent(),
          Value<int?> maximumElevationInMeters = const Value.absent(),
          Value<String?> datum = const Value.absent(),
          Value<int?> uncertaintyInMeters = const Value.absent(),
          Value<String?> gpsUnit = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<int?> siteID = const Value.absent()}) =>
      CoordinateData(
        id: id.present ? id.value : this.id,
        nameId: nameId.present ? nameId.value : this.nameId,
        decimalLatitude: decimalLatitude.present
            ? decimalLatitude.value
            : this.decimalLatitude,
        decimalLongitude: decimalLongitude.present
            ? decimalLongitude.value
            : this.decimalLongitude,
        elevationInMeter: elevationInMeter.present
            ? elevationInMeter.value
            : this.elevationInMeter,
        minimumElevationInMeters: minimumElevationInMeters.present
            ? minimumElevationInMeters.value
            : this.minimumElevationInMeters,
        maximumElevationInMeters: maximumElevationInMeters.present
            ? maximumElevationInMeters.value
            : this.maximumElevationInMeters,
        datum: datum.present ? datum.value : this.datum,
        uncertaintyInMeters: uncertaintyInMeters.present
            ? uncertaintyInMeters.value
            : this.uncertaintyInMeters,
        gpsUnit: gpsUnit.present ? gpsUnit.value : this.gpsUnit,
        notes: notes.present ? notes.value : this.notes,
        siteID: siteID.present ? siteID.value : this.siteID,
      );
  @override
  String toString() {
    return (StringBuffer('CoordinateData(')
          ..write('id: $id, ')
          ..write('nameId: $nameId, ')
          ..write('decimalLatitude: $decimalLatitude, ')
          ..write('decimalLongitude: $decimalLongitude, ')
          ..write('elevationInMeter: $elevationInMeter, ')
          ..write('minimumElevationInMeters: $minimumElevationInMeters, ')
          ..write('maximumElevationInMeters: $maximumElevationInMeters, ')
          ..write('datum: $datum, ')
          ..write('uncertaintyInMeters: $uncertaintyInMeters, ')
          ..write('gpsUnit: $gpsUnit, ')
          ..write('notes: $notes, ')
          ..write('siteID: $siteID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nameId,
      decimalLatitude,
      decimalLongitude,
      elevationInMeter,
      minimumElevationInMeters,
      maximumElevationInMeters,
      datum,
      uncertaintyInMeters,
      gpsUnit,
      notes,
      siteID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoordinateData &&
          other.id == this.id &&
          other.nameId == this.nameId &&
          other.decimalLatitude == this.decimalLatitude &&
          other.decimalLongitude == this.decimalLongitude &&
          other.elevationInMeter == this.elevationInMeter &&
          other.minimumElevationInMeters == this.minimumElevationInMeters &&
          other.maximumElevationInMeters == this.maximumElevationInMeters &&
          other.datum == this.datum &&
          other.uncertaintyInMeters == this.uncertaintyInMeters &&
          other.gpsUnit == this.gpsUnit &&
          other.notes == this.notes &&
          other.siteID == this.siteID);
}

class CoordinateCompanion extends UpdateCompanion<CoordinateData> {
  final Value<int?> id;
  final Value<String?> nameId;
  final Value<double?> decimalLatitude;
  final Value<double?> decimalLongitude;
  final Value<int?> elevationInMeter;
  final Value<int?> minimumElevationInMeters;
  final Value<int?> maximumElevationInMeters;
  final Value<String?> datum;
  final Value<int?> uncertaintyInMeters;
  final Value<String?> gpsUnit;
  final Value<String?> notes;
  final Value<int?> siteID;
  const CoordinateCompanion({
    this.id = const Value.absent(),
    this.nameId = const Value.absent(),
    this.decimalLatitude = const Value.absent(),
    this.decimalLongitude = const Value.absent(),
    this.elevationInMeter = const Value.absent(),
    this.minimumElevationInMeters = const Value.absent(),
    this.maximumElevationInMeters = const Value.absent(),
    this.datum = const Value.absent(),
    this.uncertaintyInMeters = const Value.absent(),
    this.gpsUnit = const Value.absent(),
    this.notes = const Value.absent(),
    this.siteID = const Value.absent(),
  });
  CoordinateCompanion.insert({
    this.id = const Value.absent(),
    this.nameId = const Value.absent(),
    this.decimalLatitude = const Value.absent(),
    this.decimalLongitude = const Value.absent(),
    this.elevationInMeter = const Value.absent(),
    this.minimumElevationInMeters = const Value.absent(),
    this.maximumElevationInMeters = const Value.absent(),
    this.datum = const Value.absent(),
    this.uncertaintyInMeters = const Value.absent(),
    this.gpsUnit = const Value.absent(),
    this.notes = const Value.absent(),
    this.siteID = const Value.absent(),
  });
  static Insertable<CoordinateData> custom({
    Expression<int>? id,
    Expression<String>? nameId,
    Expression<double>? decimalLatitude,
    Expression<double>? decimalLongitude,
    Expression<int>? elevationInMeter,
    Expression<int>? minimumElevationInMeters,
    Expression<int>? maximumElevationInMeters,
    Expression<String>? datum,
    Expression<int>? uncertaintyInMeters,
    Expression<String>? gpsUnit,
    Expression<String>? notes,
    Expression<int>? siteID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameId != null) 'nameId': nameId,
      if (decimalLatitude != null) 'decimalLatitude': decimalLatitude,
      if (decimalLongitude != null) 'decimalLongitude': decimalLongitude,
      if (elevationInMeter != null) 'elevationInMeter': elevationInMeter,
      if (minimumElevationInMeters != null)
        'minimumElevationInMeters': minimumElevationInMeters,
      if (maximumElevationInMeters != null)
        'maximumElevationInMeters': maximumElevationInMeters,
      if (datum != null) 'datum': datum,
      if (uncertaintyInMeters != null)
        'uncertaintyInMeters': uncertaintyInMeters,
      if (gpsUnit != null) 'gpsUnit': gpsUnit,
      if (notes != null) 'notes': notes,
      if (siteID != null) 'siteID': siteID,
    });
  }

  CoordinateCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? nameId,
      Value<double?>? decimalLatitude,
      Value<double?>? decimalLongitude,
      Value<int?>? elevationInMeter,
      Value<int?>? minimumElevationInMeters,
      Value<int?>? maximumElevationInMeters,
      Value<String?>? datum,
      Value<int?>? uncertaintyInMeters,
      Value<String?>? gpsUnit,
      Value<String?>? notes,
      Value<int?>? siteID}) {
    return CoordinateCompanion(
      id: id ?? this.id,
      nameId: nameId ?? this.nameId,
      decimalLatitude: decimalLatitude ?? this.decimalLatitude,
      decimalLongitude: decimalLongitude ?? this.decimalLongitude,
      elevationInMeter: elevationInMeter ?? this.elevationInMeter,
      minimumElevationInMeters:
          minimumElevationInMeters ?? this.minimumElevationInMeters,
      maximumElevationInMeters:
          maximumElevationInMeters ?? this.maximumElevationInMeters,
      datum: datum ?? this.datum,
      uncertaintyInMeters: uncertaintyInMeters ?? this.uncertaintyInMeters,
      gpsUnit: gpsUnit ?? this.gpsUnit,
      notes: notes ?? this.notes,
      siteID: siteID ?? this.siteID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameId.present) {
      map['nameId'] = Variable<String>(nameId.value);
    }
    if (decimalLatitude.present) {
      map['decimalLatitude'] = Variable<double>(decimalLatitude.value);
    }
    if (decimalLongitude.present) {
      map['decimalLongitude'] = Variable<double>(decimalLongitude.value);
    }
    if (elevationInMeter.present) {
      map['elevationInMeter'] = Variable<int>(elevationInMeter.value);
    }
    if (minimumElevationInMeters.present) {
      map['minimumElevationInMeters'] =
          Variable<int>(minimumElevationInMeters.value);
    }
    if (maximumElevationInMeters.present) {
      map['maximumElevationInMeters'] =
          Variable<int>(maximumElevationInMeters.value);
    }
    if (datum.present) {
      map['datum'] = Variable<String>(datum.value);
    }
    if (uncertaintyInMeters.present) {
      map['uncertaintyInMeters'] = Variable<int>(uncertaintyInMeters.value);
    }
    if (gpsUnit.present) {
      map['gpsUnit'] = Variable<String>(gpsUnit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (siteID.present) {
      map['siteID'] = Variable<int>(siteID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoordinateCompanion(')
          ..write('id: $id, ')
          ..write('nameId: $nameId, ')
          ..write('decimalLatitude: $decimalLatitude, ')
          ..write('decimalLongitude: $decimalLongitude, ')
          ..write('elevationInMeter: $elevationInMeter, ')
          ..write('minimumElevationInMeters: $minimumElevationInMeters, ')
          ..write('maximumElevationInMeters: $maximumElevationInMeters, ')
          ..write('datum: $datum, ')
          ..write('uncertaintyInMeters: $uncertaintyInMeters, ')
          ..write('gpsUnit: $gpsUnit, ')
          ..write('notes: $notes, ')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _idSuffixMeta =
      const VerificationMeta('idSuffix');
  late final GeneratedColumn<String> idSuffix = GeneratedColumn<String>(
      'idSuffix', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String> projectUuid = GeneratedColumn<String>(
      'projectUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'startDate', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
      'startTime', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'endDate', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
      'endTime', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _primaryCollMethodMeta =
      const VerificationMeta('primaryCollMethod');
  late final GeneratedColumn<String> primaryCollMethod =
      GeneratedColumn<String>('primaryCollMethod', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _collMethodNotesMeta =
      const VerificationMeta('collMethodNotes');
  late final GeneratedColumn<String> collMethodNotes = GeneratedColumn<String>(
      'collMethodNotes', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _siteIDMeta = const VerificationMeta('siteID');
  late final GeneratedColumn<int> siteID = GeneratedColumn<int>(
      'siteID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES site(id)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idSuffix,
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
    if (data.containsKey('idSuffix')) {
      context.handle(_idSuffixMeta,
          idSuffix.isAcceptableOrUnknown(data['idSuffix']!, _idSuffixMeta));
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollEventData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idSuffix: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}idSuffix']),
      projectUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}projectUuid']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}startDate']),
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}startTime']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endDate']),
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endTime']),
      primaryCollMethod: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}primaryCollMethod']),
      collMethodNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collMethodNotes']),
      siteID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}siteID']),
    );
  }

  @override
  CollEvent createAlias(String alias) {
    return CollEvent(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(projectUuid)REFERENCES project(uuid)'];
  @override
  bool get dontWriteConstraints => true;
}

class CollEventData extends DataClass implements Insertable<CollEventData> {
  final int id;
  final String? idSuffix;

  /// v4 new name
  final String? projectUuid;
  final String? startDate;
  final String? startTime;
  final String? endDate;
  final String? endTime;
  final String? primaryCollMethod;
  final String? collMethodNotes;
  final int? siteID;
  const CollEventData(
      {required this.id,
      this.idSuffix,
      this.projectUuid,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.primaryCollMethod,
      this.collMethodNotes,
      this.siteID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || idSuffix != null) {
      map['idSuffix'] = Variable<String>(idSuffix);
    }
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String>(projectUuid);
    }
    if (!nullToAbsent || startDate != null) {
      map['startDate'] = Variable<String>(startDate);
    }
    if (!nullToAbsent || startTime != null) {
      map['startTime'] = Variable<String>(startTime);
    }
    if (!nullToAbsent || endDate != null) {
      map['endDate'] = Variable<String>(endDate);
    }
    if (!nullToAbsent || endTime != null) {
      map['endTime'] = Variable<String>(endTime);
    }
    if (!nullToAbsent || primaryCollMethod != null) {
      map['primaryCollMethod'] = Variable<String>(primaryCollMethod);
    }
    if (!nullToAbsent || collMethodNotes != null) {
      map['collMethodNotes'] = Variable<String>(collMethodNotes);
    }
    if (!nullToAbsent || siteID != null) {
      map['siteID'] = Variable<int>(siteID);
    }
    return map;
  }

  CollEventCompanion toCompanion(bool nullToAbsent) {
    return CollEventCompanion(
      id: Value(id),
      idSuffix: idSuffix == null && nullToAbsent
          ? const Value.absent()
          : Value(idSuffix),
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
      idSuffix: serializer.fromJson<String?>(json['idSuffix']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      startDate: serializer.fromJson<String?>(json['startDate']),
      startTime: serializer.fromJson<String?>(json['startTime']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      endTime: serializer.fromJson<String?>(json['endTime']),
      primaryCollMethod:
          serializer.fromJson<String?>(json['primaryCollMethod']),
      collMethodNotes: serializer.fromJson<String?>(json['collMethodNotes']),
      siteID: serializer.fromJson<int?>(json['siteID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idSuffix': serializer.toJson<String?>(idSuffix),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'startDate': serializer.toJson<String?>(startDate),
      'startTime': serializer.toJson<String?>(startTime),
      'endDate': serializer.toJson<String?>(endDate),
      'endTime': serializer.toJson<String?>(endTime),
      'primaryCollMethod': serializer.toJson<String?>(primaryCollMethod),
      'collMethodNotes': serializer.toJson<String?>(collMethodNotes),
      'siteID': serializer.toJson<int?>(siteID),
    };
  }

  CollEventData copyWith(
          {int? id,
          Value<String?> idSuffix = const Value.absent(),
          Value<String?> projectUuid = const Value.absent(),
          Value<String?> startDate = const Value.absent(),
          Value<String?> startTime = const Value.absent(),
          Value<String?> endDate = const Value.absent(),
          Value<String?> endTime = const Value.absent(),
          Value<String?> primaryCollMethod = const Value.absent(),
          Value<String?> collMethodNotes = const Value.absent(),
          Value<int?> siteID = const Value.absent()}) =>
      CollEventData(
        id: id ?? this.id,
        idSuffix: idSuffix.present ? idSuffix.value : this.idSuffix,
        projectUuid: projectUuid.present ? projectUuid.value : this.projectUuid,
        startDate: startDate.present ? startDate.value : this.startDate,
        startTime: startTime.present ? startTime.value : this.startTime,
        endDate: endDate.present ? endDate.value : this.endDate,
        endTime: endTime.present ? endTime.value : this.endTime,
        primaryCollMethod: primaryCollMethod.present
            ? primaryCollMethod.value
            : this.primaryCollMethod,
        collMethodNotes: collMethodNotes.present
            ? collMethodNotes.value
            : this.collMethodNotes,
        siteID: siteID.present ? siteID.value : this.siteID,
      );
  @override
  String toString() {
    return (StringBuffer('CollEventData(')
          ..write('id: $id, ')
          ..write('idSuffix: $idSuffix, ')
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
  int get hashCode => Object.hash(id, idSuffix, projectUuid, startDate,
      startTime, endDate, endTime, primaryCollMethod, collMethodNotes, siteID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollEventData &&
          other.id == this.id &&
          other.idSuffix == this.idSuffix &&
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
  final Value<String?> idSuffix;
  final Value<String?> projectUuid;
  final Value<String?> startDate;
  final Value<String?> startTime;
  final Value<String?> endDate;
  final Value<String?> endTime;
  final Value<String?> primaryCollMethod;
  final Value<String?> collMethodNotes;
  final Value<int?> siteID;
  const CollEventCompanion({
    this.id = const Value.absent(),
    this.idSuffix = const Value.absent(),
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
    this.idSuffix = const Value.absent(),
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
    Expression<String>? idSuffix,
    Expression<String>? projectUuid,
    Expression<String>? startDate,
    Expression<String>? startTime,
    Expression<String>? endDate,
    Expression<String>? endTime,
    Expression<String>? primaryCollMethod,
    Expression<String>? collMethodNotes,
    Expression<int>? siteID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idSuffix != null) 'idSuffix': idSuffix,
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
      Value<String?>? idSuffix,
      Value<String?>? projectUuid,
      Value<String?>? startDate,
      Value<String?>? startTime,
      Value<String?>? endDate,
      Value<String?>? endTime,
      Value<String?>? primaryCollMethod,
      Value<String?>? collMethodNotes,
      Value<int?>? siteID}) {
    return CollEventCompanion(
      id: id ?? this.id,
      idSuffix: idSuffix ?? this.idSuffix,
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
    if (idSuffix.present) {
      map['idSuffix'] = Variable<String>(idSuffix.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String>(projectUuid.value);
    }
    if (startDate.present) {
      map['startDate'] = Variable<String>(startDate.value);
    }
    if (startTime.present) {
      map['startTime'] = Variable<String>(startTime.value);
    }
    if (endDate.present) {
      map['endDate'] = Variable<String>(endDate.value);
    }
    if (endTime.present) {
      map['endTime'] = Variable<String>(endTime.value);
    }
    if (primaryCollMethod.present) {
      map['primaryCollMethod'] = Variable<String>(primaryCollMethod.value);
    }
    if (collMethodNotes.present) {
      map['collMethodNotes'] = Variable<String>(collMethodNotes.value);
    }
    if (siteID.present) {
      map['siteID'] = Variable<int>(siteID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollEventCompanion(')
          ..write('id: $id, ')
          ..write('idSuffix: $idSuffix, ')
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

class Weather extends Table with TableInfo<Weather, WeatherData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Weather(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIDMeta =
      const VerificationMeta('eventID');
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
      'eventID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _lowestDayTempCMeta =
      const VerificationMeta('lowestDayTempC');
  late final GeneratedColumn<double> lowestDayTempC = GeneratedColumn<double>(
      'lowestDayTempC', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _highestDayTempCMeta =
      const VerificationMeta('highestDayTempC');
  late final GeneratedColumn<double> highestDayTempC = GeneratedColumn<double>(
      'highestDayTempC', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _lowestNightTempCMeta =
      const VerificationMeta('lowestNightTempC');
  late final GeneratedColumn<double> lowestNightTempC = GeneratedColumn<double>(
      'lowestNightTempC', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _highestNightTempCMeta =
      const VerificationMeta('highestNightTempC');
  late final GeneratedColumn<double> highestNightTempC =
      GeneratedColumn<double>('highestNightTempC', aliasedName, true,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _averageHumidityMeta =
      const VerificationMeta('averageHumidity');
  late final GeneratedColumn<double> averageHumidity = GeneratedColumn<double>(
      'averageHumidity', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _dewPointTempMeta =
      const VerificationMeta('dewPointTemp');
  late final GeneratedColumn<double> dewPointTemp = GeneratedColumn<double>(
      'dewPointTemp', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sunriseTimeMeta =
      const VerificationMeta('sunriseTime');
  late final GeneratedColumn<String> sunriseTime = GeneratedColumn<String>(
      'sunriseTime', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sunsetTimeMeta =
      const VerificationMeta('sunsetTime');
  late final GeneratedColumn<String> sunsetTime = GeneratedColumn<String>(
      'sunsetTime', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _moonPhaseMeta =
      const VerificationMeta('moonPhase');
  late final GeneratedColumn<String> moonPhase = GeneratedColumn<String>(
      'moonPhase', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        eventID,
        lowestDayTempC,
        highestDayTempC,
        lowestNightTempC,
        highestNightTempC,
        averageHumidity,
        dewPointTemp,
        sunriseTime,
        sunsetTime,
        moonPhase,
        notes
      ];
  @override
  String get aliasedName => _alias ?? 'weather';
  @override
  String get actualTableName => 'weather';
  @override
  VerificationContext validateIntegrity(Insertable<WeatherData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('eventID')) {
      context.handle(_eventIDMeta,
          eventID.isAcceptableOrUnknown(data['eventID']!, _eventIDMeta));
    }
    if (data.containsKey('lowestDayTempC')) {
      context.handle(
          _lowestDayTempCMeta,
          lowestDayTempC.isAcceptableOrUnknown(
              data['lowestDayTempC']!, _lowestDayTempCMeta));
    }
    if (data.containsKey('highestDayTempC')) {
      context.handle(
          _highestDayTempCMeta,
          highestDayTempC.isAcceptableOrUnknown(
              data['highestDayTempC']!, _highestDayTempCMeta));
    }
    if (data.containsKey('lowestNightTempC')) {
      context.handle(
          _lowestNightTempCMeta,
          lowestNightTempC.isAcceptableOrUnknown(
              data['lowestNightTempC']!, _lowestNightTempCMeta));
    }
    if (data.containsKey('highestNightTempC')) {
      context.handle(
          _highestNightTempCMeta,
          highestNightTempC.isAcceptableOrUnknown(
              data['highestNightTempC']!, _highestNightTempCMeta));
    }
    if (data.containsKey('averageHumidity')) {
      context.handle(
          _averageHumidityMeta,
          averageHumidity.isAcceptableOrUnknown(
              data['averageHumidity']!, _averageHumidityMeta));
    }
    if (data.containsKey('dewPointTemp')) {
      context.handle(
          _dewPointTempMeta,
          dewPointTemp.isAcceptableOrUnknown(
              data['dewPointTemp']!, _dewPointTempMeta));
    }
    if (data.containsKey('sunriseTime')) {
      context.handle(
          _sunriseTimeMeta,
          sunriseTime.isAcceptableOrUnknown(
              data['sunriseTime']!, _sunriseTimeMeta));
    }
    if (data.containsKey('sunsetTime')) {
      context.handle(
          _sunsetTimeMeta,
          sunsetTime.isAcceptableOrUnknown(
              data['sunsetTime']!, _sunsetTimeMeta));
    }
    if (data.containsKey('moonPhase')) {
      context.handle(_moonPhaseMeta,
          moonPhase.isAcceptableOrUnknown(data['moonPhase']!, _moonPhaseMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  WeatherData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherData(
      eventID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}eventID']),
      lowestDayTempC: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lowestDayTempC']),
      highestDayTempC: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}highestDayTempC']),
      lowestNightTempC: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}lowestNightTempC']),
      highestNightTempC: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}highestNightTempC']),
      averageHumidity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}averageHumidity']),
      dewPointTemp: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dewPointTemp']),
      sunriseTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sunriseTime']),
      sunsetTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sunsetTime']),
      moonPhase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}moonPhase']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  Weather createAlias(String alias) {
    return Weather(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(eventID)REFERENCES collEvent(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class WeatherData extends DataClass implements Insertable<WeatherData> {
  final int? eventID;
  final double? lowestDayTempC;
  final double? highestDayTempC;
  final double? lowestNightTempC;
  final double? highestNightTempC;
  final double? averageHumidity;
  final double? dewPointTemp;
  final String? sunriseTime;
  final String? sunsetTime;
  final String? moonPhase;
  final String? notes;
  const WeatherData(
      {this.eventID,
      this.lowestDayTempC,
      this.highestDayTempC,
      this.lowestNightTempC,
      this.highestNightTempC,
      this.averageHumidity,
      this.dewPointTemp,
      this.sunriseTime,
      this.sunsetTime,
      this.moonPhase,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || eventID != null) {
      map['eventID'] = Variable<int>(eventID);
    }
    if (!nullToAbsent || lowestDayTempC != null) {
      map['lowestDayTempC'] = Variable<double>(lowestDayTempC);
    }
    if (!nullToAbsent || highestDayTempC != null) {
      map['highestDayTempC'] = Variable<double>(highestDayTempC);
    }
    if (!nullToAbsent || lowestNightTempC != null) {
      map['lowestNightTempC'] = Variable<double>(lowestNightTempC);
    }
    if (!nullToAbsent || highestNightTempC != null) {
      map['highestNightTempC'] = Variable<double>(highestNightTempC);
    }
    if (!nullToAbsent || averageHumidity != null) {
      map['averageHumidity'] = Variable<double>(averageHumidity);
    }
    if (!nullToAbsent || dewPointTemp != null) {
      map['dewPointTemp'] = Variable<double>(dewPointTemp);
    }
    if (!nullToAbsent || sunriseTime != null) {
      map['sunriseTime'] = Variable<String>(sunriseTime);
    }
    if (!nullToAbsent || sunsetTime != null) {
      map['sunsetTime'] = Variable<String>(sunsetTime);
    }
    if (!nullToAbsent || moonPhase != null) {
      map['moonPhase'] = Variable<String>(moonPhase);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WeatherCompanion toCompanion(bool nullToAbsent) {
    return WeatherCompanion(
      eventID: eventID == null && nullToAbsent
          ? const Value.absent()
          : Value(eventID),
      lowestDayTempC: lowestDayTempC == null && nullToAbsent
          ? const Value.absent()
          : Value(lowestDayTempC),
      highestDayTempC: highestDayTempC == null && nullToAbsent
          ? const Value.absent()
          : Value(highestDayTempC),
      lowestNightTempC: lowestNightTempC == null && nullToAbsent
          ? const Value.absent()
          : Value(lowestNightTempC),
      highestNightTempC: highestNightTempC == null && nullToAbsent
          ? const Value.absent()
          : Value(highestNightTempC),
      averageHumidity: averageHumidity == null && nullToAbsent
          ? const Value.absent()
          : Value(averageHumidity),
      dewPointTemp: dewPointTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(dewPointTemp),
      sunriseTime: sunriseTime == null && nullToAbsent
          ? const Value.absent()
          : Value(sunriseTime),
      sunsetTime: sunsetTime == null && nullToAbsent
          ? const Value.absent()
          : Value(sunsetTime),
      moonPhase: moonPhase == null && nullToAbsent
          ? const Value.absent()
          : Value(moonPhase),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory WeatherData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherData(
      eventID: serializer.fromJson<int?>(json['eventID']),
      lowestDayTempC: serializer.fromJson<double?>(json['lowestDayTempC']),
      highestDayTempC: serializer.fromJson<double?>(json['highestDayTempC']),
      lowestNightTempC: serializer.fromJson<double?>(json['lowestNightTempC']),
      highestNightTempC:
          serializer.fromJson<double?>(json['highestNightTempC']),
      averageHumidity: serializer.fromJson<double?>(json['averageHumidity']),
      dewPointTemp: serializer.fromJson<double?>(json['dewPointTemp']),
      sunriseTime: serializer.fromJson<String?>(json['sunriseTime']),
      sunsetTime: serializer.fromJson<String?>(json['sunsetTime']),
      moonPhase: serializer.fromJson<String?>(json['moonPhase']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventID': serializer.toJson<int?>(eventID),
      'lowestDayTempC': serializer.toJson<double?>(lowestDayTempC),
      'highestDayTempC': serializer.toJson<double?>(highestDayTempC),
      'lowestNightTempC': serializer.toJson<double?>(lowestNightTempC),
      'highestNightTempC': serializer.toJson<double?>(highestNightTempC),
      'averageHumidity': serializer.toJson<double?>(averageHumidity),
      'dewPointTemp': serializer.toJson<double?>(dewPointTemp),
      'sunriseTime': serializer.toJson<String?>(sunriseTime),
      'sunsetTime': serializer.toJson<String?>(sunsetTime),
      'moonPhase': serializer.toJson<String?>(moonPhase),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WeatherData copyWith(
          {Value<int?> eventID = const Value.absent(),
          Value<double?> lowestDayTempC = const Value.absent(),
          Value<double?> highestDayTempC = const Value.absent(),
          Value<double?> lowestNightTempC = const Value.absent(),
          Value<double?> highestNightTempC = const Value.absent(),
          Value<double?> averageHumidity = const Value.absent(),
          Value<double?> dewPointTemp = const Value.absent(),
          Value<String?> sunriseTime = const Value.absent(),
          Value<String?> sunsetTime = const Value.absent(),
          Value<String?> moonPhase = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      WeatherData(
        eventID: eventID.present ? eventID.value : this.eventID,
        lowestDayTempC:
            lowestDayTempC.present ? lowestDayTempC.value : this.lowestDayTempC,
        highestDayTempC: highestDayTempC.present
            ? highestDayTempC.value
            : this.highestDayTempC,
        lowestNightTempC: lowestNightTempC.present
            ? lowestNightTempC.value
            : this.lowestNightTempC,
        highestNightTempC: highestNightTempC.present
            ? highestNightTempC.value
            : this.highestNightTempC,
        averageHumidity: averageHumidity.present
            ? averageHumidity.value
            : this.averageHumidity,
        dewPointTemp:
            dewPointTemp.present ? dewPointTemp.value : this.dewPointTemp,
        sunriseTime: sunriseTime.present ? sunriseTime.value : this.sunriseTime,
        sunsetTime: sunsetTime.present ? sunsetTime.value : this.sunsetTime,
        moonPhase: moonPhase.present ? moonPhase.value : this.moonPhase,
        notes: notes.present ? notes.value : this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('WeatherData(')
          ..write('eventID: $eventID, ')
          ..write('lowestDayTempC: $lowestDayTempC, ')
          ..write('highestDayTempC: $highestDayTempC, ')
          ..write('lowestNightTempC: $lowestNightTempC, ')
          ..write('highestNightTempC: $highestNightTempC, ')
          ..write('averageHumidity: $averageHumidity, ')
          ..write('dewPointTemp: $dewPointTemp, ')
          ..write('sunriseTime: $sunriseTime, ')
          ..write('sunsetTime: $sunsetTime, ')
          ..write('moonPhase: $moonPhase, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      eventID,
      lowestDayTempC,
      highestDayTempC,
      lowestNightTempC,
      highestNightTempC,
      averageHumidity,
      dewPointTemp,
      sunriseTime,
      sunsetTime,
      moonPhase,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherData &&
          other.eventID == this.eventID &&
          other.lowestDayTempC == this.lowestDayTempC &&
          other.highestDayTempC == this.highestDayTempC &&
          other.lowestNightTempC == this.lowestNightTempC &&
          other.highestNightTempC == this.highestNightTempC &&
          other.averageHumidity == this.averageHumidity &&
          other.dewPointTemp == this.dewPointTemp &&
          other.sunriseTime == this.sunriseTime &&
          other.sunsetTime == this.sunsetTime &&
          other.moonPhase == this.moonPhase &&
          other.notes == this.notes);
}

class WeatherCompanion extends UpdateCompanion<WeatherData> {
  final Value<int?> eventID;
  final Value<double?> lowestDayTempC;
  final Value<double?> highestDayTempC;
  final Value<double?> lowestNightTempC;
  final Value<double?> highestNightTempC;
  final Value<double?> averageHumidity;
  final Value<double?> dewPointTemp;
  final Value<String?> sunriseTime;
  final Value<String?> sunsetTime;
  final Value<String?> moonPhase;
  final Value<String?> notes;
  final Value<int> rowid;
  const WeatherCompanion({
    this.eventID = const Value.absent(),
    this.lowestDayTempC = const Value.absent(),
    this.highestDayTempC = const Value.absent(),
    this.lowestNightTempC = const Value.absent(),
    this.highestNightTempC = const Value.absent(),
    this.averageHumidity = const Value.absent(),
    this.dewPointTemp = const Value.absent(),
    this.sunriseTime = const Value.absent(),
    this.sunsetTime = const Value.absent(),
    this.moonPhase = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeatherCompanion.insert({
    this.eventID = const Value.absent(),
    this.lowestDayTempC = const Value.absent(),
    this.highestDayTempC = const Value.absent(),
    this.lowestNightTempC = const Value.absent(),
    this.highestNightTempC = const Value.absent(),
    this.averageHumidity = const Value.absent(),
    this.dewPointTemp = const Value.absent(),
    this.sunriseTime = const Value.absent(),
    this.sunsetTime = const Value.absent(),
    this.moonPhase = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<WeatherData> custom({
    Expression<int>? eventID,
    Expression<double>? lowestDayTempC,
    Expression<double>? highestDayTempC,
    Expression<double>? lowestNightTempC,
    Expression<double>? highestNightTempC,
    Expression<double>? averageHumidity,
    Expression<double>? dewPointTemp,
    Expression<String>? sunriseTime,
    Expression<String>? sunsetTime,
    Expression<String>? moonPhase,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventID != null) 'eventID': eventID,
      if (lowestDayTempC != null) 'lowestDayTempC': lowestDayTempC,
      if (highestDayTempC != null) 'highestDayTempC': highestDayTempC,
      if (lowestNightTempC != null) 'lowestNightTempC': lowestNightTempC,
      if (highestNightTempC != null) 'highestNightTempC': highestNightTempC,
      if (averageHumidity != null) 'averageHumidity': averageHumidity,
      if (dewPointTemp != null) 'dewPointTemp': dewPointTemp,
      if (sunriseTime != null) 'sunriseTime': sunriseTime,
      if (sunsetTime != null) 'sunsetTime': sunsetTime,
      if (moonPhase != null) 'moonPhase': moonPhase,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeatherCompanion copyWith(
      {Value<int?>? eventID,
      Value<double?>? lowestDayTempC,
      Value<double?>? highestDayTempC,
      Value<double?>? lowestNightTempC,
      Value<double?>? highestNightTempC,
      Value<double?>? averageHumidity,
      Value<double?>? dewPointTemp,
      Value<String?>? sunriseTime,
      Value<String?>? sunsetTime,
      Value<String?>? moonPhase,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return WeatherCompanion(
      eventID: eventID ?? this.eventID,
      lowestDayTempC: lowestDayTempC ?? this.lowestDayTempC,
      highestDayTempC: highestDayTempC ?? this.highestDayTempC,
      lowestNightTempC: lowestNightTempC ?? this.lowestNightTempC,
      highestNightTempC: highestNightTempC ?? this.highestNightTempC,
      averageHumidity: averageHumidity ?? this.averageHumidity,
      dewPointTemp: dewPointTemp ?? this.dewPointTemp,
      sunriseTime: sunriseTime ?? this.sunriseTime,
      sunsetTime: sunsetTime ?? this.sunsetTime,
      moonPhase: moonPhase ?? this.moonPhase,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventID.present) {
      map['eventID'] = Variable<int>(eventID.value);
    }
    if (lowestDayTempC.present) {
      map['lowestDayTempC'] = Variable<double>(lowestDayTempC.value);
    }
    if (highestDayTempC.present) {
      map['highestDayTempC'] = Variable<double>(highestDayTempC.value);
    }
    if (lowestNightTempC.present) {
      map['lowestNightTempC'] = Variable<double>(lowestNightTempC.value);
    }
    if (highestNightTempC.present) {
      map['highestNightTempC'] = Variable<double>(highestNightTempC.value);
    }
    if (averageHumidity.present) {
      map['averageHumidity'] = Variable<double>(averageHumidity.value);
    }
    if (dewPointTemp.present) {
      map['dewPointTemp'] = Variable<double>(dewPointTemp.value);
    }
    if (sunriseTime.present) {
      map['sunriseTime'] = Variable<String>(sunriseTime.value);
    }
    if (sunsetTime.present) {
      map['sunsetTime'] = Variable<String>(sunsetTime.value);
    }
    if (moonPhase.present) {
      map['moonPhase'] = Variable<String>(moonPhase.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherCompanion(')
          ..write('eventID: $eventID, ')
          ..write('lowestDayTempC: $lowestDayTempC, ')
          ..write('highestDayTempC: $highestDayTempC, ')
          ..write('lowestNightTempC: $lowestNightTempC, ')
          ..write('highestNightTempC: $highestNightTempC, ')
          ..write('averageHumidity: $averageHumidity, ')
          ..write('dewPointTemp: $dewPointTemp, ')
          ..write('sunriseTime: $sunriseTime, ')
          ..write('sunsetTime: $sunsetTime, ')
          ..write('moonPhase: $moonPhase, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class CollPersonnel extends Table
    with TableInfo<CollPersonnel, CollPersonnelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CollPersonnel(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _eventIDMeta =
      const VerificationMeta('eventID');
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
      'eventID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _personnelIdMeta =
      const VerificationMeta('personnelId');
  late final GeneratedColumn<String> personnelId = GeneratedColumn<String>(
      'personnelId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, eventID, personnelId, name, role];
  @override
  String get aliasedName => _alias ?? 'collPersonnel';
  @override
  String get actualTableName => 'collPersonnel';
  @override
  VerificationContext validateIntegrity(Insertable<CollPersonnelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('eventID')) {
      context.handle(_eventIDMeta,
          eventID.isAcceptableOrUnknown(data['eventID']!, _eventIDMeta));
    }
    if (data.containsKey('personnelId')) {
      context.handle(
          _personnelIdMeta,
          personnelId.isAcceptableOrUnknown(
              data['personnelId']!, _personnelIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollPersonnelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollPersonnelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      eventID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}eventID']),
      personnelId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}personnelId']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role']),
    );
  }

  @override
  CollPersonnel createAlias(String alias) {
    return CollPersonnel(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(eventID)REFERENCES collEvent(id)',
        'FOREIGN KEY(personnelId)REFERENCES personnel(uuid)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class CollPersonnelData extends DataClass
    implements Insertable<CollPersonnelData> {
  final int id;
  final int? eventID;
  final String? personnelId;
  final String? name;

  /// we add it here to save time pulling it from personnel data
  final String? role;
  const CollPersonnelData(
      {required this.id, this.eventID, this.personnelId, this.name, this.role});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || eventID != null) {
      map['eventID'] = Variable<int>(eventID);
    }
    if (!nullToAbsent || personnelId != null) {
      map['personnelId'] = Variable<String>(personnelId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    return map;
  }

  CollPersonnelCompanion toCompanion(bool nullToAbsent) {
    return CollPersonnelCompanion(
      id: Value(id),
      eventID: eventID == null && nullToAbsent
          ? const Value.absent()
          : Value(eventID),
      personnelId: personnelId == null && nullToAbsent
          ? const Value.absent()
          : Value(personnelId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
    );
  }

  factory CollPersonnelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollPersonnelData(
      id: serializer.fromJson<int>(json['id']),
      eventID: serializer.fromJson<int?>(json['eventID']),
      personnelId: serializer.fromJson<String?>(json['personnelId']),
      name: serializer.fromJson<String?>(json['name']),
      role: serializer.fromJson<String?>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventID': serializer.toJson<int?>(eventID),
      'personnelId': serializer.toJson<String?>(personnelId),
      'name': serializer.toJson<String?>(name),
      'role': serializer.toJson<String?>(role),
    };
  }

  CollPersonnelData copyWith(
          {int? id,
          Value<int?> eventID = const Value.absent(),
          Value<String?> personnelId = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<String?> role = const Value.absent()}) =>
      CollPersonnelData(
        id: id ?? this.id,
        eventID: eventID.present ? eventID.value : this.eventID,
        personnelId: personnelId.present ? personnelId.value : this.personnelId,
        name: name.present ? name.value : this.name,
        role: role.present ? role.value : this.role,
      );
  @override
  String toString() {
    return (StringBuffer('CollPersonnelData(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('personnelId: $personnelId, ')
          ..write('name: $name, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventID, personnelId, name, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollPersonnelData &&
          other.id == this.id &&
          other.eventID == this.eventID &&
          other.personnelId == this.personnelId &&
          other.name == this.name &&
          other.role == this.role);
}

class CollPersonnelCompanion extends UpdateCompanion<CollPersonnelData> {
  final Value<int> id;
  final Value<int?> eventID;
  final Value<String?> personnelId;
  final Value<String?> name;
  final Value<String?> role;
  const CollPersonnelCompanion({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.personnelId = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
  });
  CollPersonnelCompanion.insert({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.personnelId = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
  });
  static Insertable<CollPersonnelData> custom({
    Expression<int>? id,
    Expression<int>? eventID,
    Expression<String>? personnelId,
    Expression<String>? name,
    Expression<String>? role,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventID != null) 'eventID': eventID,
      if (personnelId != null) 'personnelId': personnelId,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
    });
  }

  CollPersonnelCompanion copyWith(
      {Value<int>? id,
      Value<int?>? eventID,
      Value<String?>? personnelId,
      Value<String?>? name,
      Value<String?>? role}) {
    return CollPersonnelCompanion(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      personnelId: personnelId ?? this.personnelId,
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventID.present) {
      map['eventID'] = Variable<int>(eventID.value);
    }
    if (personnelId.present) {
      map['personnelId'] = Variable<String>(personnelId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollPersonnelCompanion(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('personnelId: $personnelId, ')
          ..write('name: $name, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }
}

class CollEffort extends Table with TableInfo<CollEffort, CollEffortData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CollEffort(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _eventIDMeta =
      const VerificationMeta('eventID');
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
      'eventID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
      'size', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, eventID, method, brand, count, size, notes];
  @override
  String get aliasedName => _alias ?? 'collEffort';
  @override
  String get actualTableName => 'collEffort';
  @override
  VerificationContext validateIntegrity(Insertable<CollEffortData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('eventID')) {
      context.handle(_eventIDMeta,
          eventID.isAcceptableOrUnknown(data['eventID']!, _eventIDMeta));
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollEffortData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollEffortData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      eventID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}eventID']),
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method']),
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand']),
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count']),
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}size']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  CollEffort createAlias(String alias) {
    return CollEffort(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(eventID)REFERENCES collEvent(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class CollEffortData extends DataClass implements Insertable<CollEffortData> {
  final int id;
  final int? eventID;
  final String? method;

  /// v4 rename
  final String? brand;
  final int? count;
  final String? size;
  final String? notes;
  const CollEffortData(
      {required this.id,
      this.eventID,
      this.method,
      this.brand,
      this.count,
      this.size,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || eventID != null) {
      map['eventID'] = Variable<int>(eventID);
    }
    if (!nullToAbsent || method != null) {
      map['method'] = Variable<String>(method);
    }
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  CollEffortCompanion toCompanion(bool nullToAbsent) {
    return CollEffortCompanion(
      id: Value(id),
      eventID: eventID == null && nullToAbsent
          ? const Value.absent()
          : Value(eventID),
      method:
          method == null && nullToAbsent ? const Value.absent() : Value(method),
      brand:
          brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory CollEffortData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollEffortData(
      id: serializer.fromJson<int>(json['id']),
      eventID: serializer.fromJson<int?>(json['eventID']),
      method: serializer.fromJson<String?>(json['method']),
      brand: serializer.fromJson<String?>(json['brand']),
      count: serializer.fromJson<int?>(json['count']),
      size: serializer.fromJson<String?>(json['size']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventID': serializer.toJson<int?>(eventID),
      'method': serializer.toJson<String?>(method),
      'brand': serializer.toJson<String?>(brand),
      'count': serializer.toJson<int?>(count),
      'size': serializer.toJson<String?>(size),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  CollEffortData copyWith(
          {int? id,
          Value<int?> eventID = const Value.absent(),
          Value<String?> method = const Value.absent(),
          Value<String?> brand = const Value.absent(),
          Value<int?> count = const Value.absent(),
          Value<String?> size = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      CollEffortData(
        id: id ?? this.id,
        eventID: eventID.present ? eventID.value : this.eventID,
        method: method.present ? method.value : this.method,
        brand: brand.present ? brand.value : this.brand,
        count: count.present ? count.value : this.count,
        size: size.present ? size.value : this.size,
        notes: notes.present ? notes.value : this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('CollEffortData(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('method: $method, ')
          ..write('brand: $brand, ')
          ..write('count: $count, ')
          ..write('size: $size, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, eventID, method, brand, count, size, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollEffortData &&
          other.id == this.id &&
          other.eventID == this.eventID &&
          other.method == this.method &&
          other.brand == this.brand &&
          other.count == this.count &&
          other.size == this.size &&
          other.notes == this.notes);
}

class CollEffortCompanion extends UpdateCompanion<CollEffortData> {
  final Value<int> id;
  final Value<int?> eventID;
  final Value<String?> method;
  final Value<String?> brand;
  final Value<int?> count;
  final Value<String?> size;
  final Value<String?> notes;
  const CollEffortCompanion({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.method = const Value.absent(),
    this.brand = const Value.absent(),
    this.count = const Value.absent(),
    this.size = const Value.absent(),
    this.notes = const Value.absent(),
  });
  CollEffortCompanion.insert({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.method = const Value.absent(),
    this.brand = const Value.absent(),
    this.count = const Value.absent(),
    this.size = const Value.absent(),
    this.notes = const Value.absent(),
  });
  static Insertable<CollEffortData> custom({
    Expression<int>? id,
    Expression<int>? eventID,
    Expression<String>? method,
    Expression<String>? brand,
    Expression<int>? count,
    Expression<String>? size,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventID != null) 'eventID': eventID,
      if (method != null) 'method': method,
      if (brand != null) 'brand': brand,
      if (count != null) 'count': count,
      if (size != null) 'size': size,
      if (notes != null) 'notes': notes,
    });
  }

  CollEffortCompanion copyWith(
      {Value<int>? id,
      Value<int?>? eventID,
      Value<String?>? method,
      Value<String?>? brand,
      Value<int?>? count,
      Value<String?>? size,
      Value<String?>? notes}) {
    return CollEffortCompanion(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      method: method ?? this.method,
      brand: brand ?? this.brand,
      count: count ?? this.count,
      size: size ?? this.size,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventID.present) {
      map['eventID'] = Variable<int>(eventID.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollEffortCompanion(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('method: $method, ')
          ..write('brand: $brand, ')
          ..write('count: $count, ')
          ..write('size: $size, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class Narrative extends Table with TableInfo<Narrative, NarrativeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Narrative(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String> projectUuid = GeneratedColumn<String>(
      'projectUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _siteIDMeta = const VerificationMeta('siteID');
  late final GeneratedColumn<int> siteID = GeneratedColumn<int>(
      'siteID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _narrativeMeta =
      const VerificationMeta('narrative');
  late final GeneratedColumn<String> narrative = GeneratedColumn<String>(
      'narrative', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _mediaIDMeta =
      const VerificationMeta('mediaID');
  late final GeneratedColumn<int> mediaID = GeneratedColumn<int>(
      'mediaID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES media(primaryId)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectUuid, date, siteID, narrative, mediaID];
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
    if (data.containsKey('mediaID')) {
      context.handle(_mediaIDMeta,
          mediaID.isAcceptableOrUnknown(data['mediaID']!, _mediaIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NarrativeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NarrativeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      projectUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}projectUuid']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date']),
      siteID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}siteID']),
      narrative: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}narrative']),
      mediaID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mediaID']),
    );
  }

  @override
  Narrative createAlias(String alias) {
    return Narrative(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(projectUuid)REFERENCES project(uuid)',
        'FOREIGN KEY(siteID)REFERENCES site(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class NarrativeData extends DataClass implements Insertable<NarrativeData> {
  final int id;
  final String? projectUuid;
  final String? date;
  final int? siteID;
  final String? narrative;
  final int? mediaID;
  const NarrativeData(
      {required this.id,
      this.projectUuid,
      this.date,
      this.siteID,
      this.narrative,
      this.mediaID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String>(projectUuid);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || siteID != null) {
      map['siteID'] = Variable<int>(siteID);
    }
    if (!nullToAbsent || narrative != null) {
      map['narrative'] = Variable<String>(narrative);
    }
    if (!nullToAbsent || mediaID != null) {
      map['mediaID'] = Variable<int>(mediaID);
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
      mediaID: mediaID == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaID),
    );
  }

  factory NarrativeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NarrativeData(
      id: serializer.fromJson<int>(json['id']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      date: serializer.fromJson<String?>(json['date']),
      siteID: serializer.fromJson<int?>(json['siteID']),
      narrative: serializer.fromJson<String?>(json['narrative']),
      mediaID: serializer.fromJson<int?>(json['mediaID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'date': serializer.toJson<String?>(date),
      'siteID': serializer.toJson<int?>(siteID),
      'narrative': serializer.toJson<String?>(narrative),
      'mediaID': serializer.toJson<int?>(mediaID),
    };
  }

  NarrativeData copyWith(
          {int? id,
          Value<String?> projectUuid = const Value.absent(),
          Value<String?> date = const Value.absent(),
          Value<int?> siteID = const Value.absent(),
          Value<String?> narrative = const Value.absent(),
          Value<int?> mediaID = const Value.absent()}) =>
      NarrativeData(
        id: id ?? this.id,
        projectUuid: projectUuid.present ? projectUuid.value : this.projectUuid,
        date: date.present ? date.value : this.date,
        siteID: siteID.present ? siteID.value : this.siteID,
        narrative: narrative.present ? narrative.value : this.narrative,
        mediaID: mediaID.present ? mediaID.value : this.mediaID,
      );
  @override
  String toString() {
    return (StringBuffer('NarrativeData(')
          ..write('id: $id, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('date: $date, ')
          ..write('siteID: $siteID, ')
          ..write('narrative: $narrative, ')
          ..write('mediaID: $mediaID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, projectUuid, date, siteID, narrative, mediaID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NarrativeData &&
          other.id == this.id &&
          other.projectUuid == this.projectUuid &&
          other.date == this.date &&
          other.siteID == this.siteID &&
          other.narrative == this.narrative &&
          other.mediaID == this.mediaID);
}

class NarrativeCompanion extends UpdateCompanion<NarrativeData> {
  final Value<int> id;
  final Value<String?> projectUuid;
  final Value<String?> date;
  final Value<int?> siteID;
  final Value<String?> narrative;
  final Value<int?> mediaID;
  const NarrativeCompanion({
    this.id = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.date = const Value.absent(),
    this.siteID = const Value.absent(),
    this.narrative = const Value.absent(),
    this.mediaID = const Value.absent(),
  });
  NarrativeCompanion.insert({
    this.id = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.date = const Value.absent(),
    this.siteID = const Value.absent(),
    this.narrative = const Value.absent(),
    this.mediaID = const Value.absent(),
  });
  static Insertable<NarrativeData> custom({
    Expression<int>? id,
    Expression<String>? projectUuid,
    Expression<String>? date,
    Expression<int>? siteID,
    Expression<String>? narrative,
    Expression<int>? mediaID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (date != null) 'date': date,
      if (siteID != null) 'siteID': siteID,
      if (narrative != null) 'narrative': narrative,
      if (mediaID != null) 'mediaID': mediaID,
    });
  }

  NarrativeCompanion copyWith(
      {Value<int>? id,
      Value<String?>? projectUuid,
      Value<String?>? date,
      Value<int?>? siteID,
      Value<String?>? narrative,
      Value<int?>? mediaID}) {
    return NarrativeCompanion(
      id: id ?? this.id,
      projectUuid: projectUuid ?? this.projectUuid,
      date: date ?? this.date,
      siteID: siteID ?? this.siteID,
      narrative: narrative ?? this.narrative,
      mediaID: mediaID ?? this.mediaID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String>(projectUuid.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (siteID.present) {
      map['siteID'] = Variable<int>(siteID.value);
    }
    if (narrative.present) {
      map['narrative'] = Variable<String>(narrative.value);
    }
    if (mediaID.present) {
      map['mediaID'] = Variable<int>(mediaID.value);
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
          ..write('mediaID: $mediaID')
          ..write(')'))
        .toString();
  }
}

class NarrativeMedia extends Table
    with TableInfo<NarrativeMedia, NarrativeMediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  NarrativeMedia(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _narrativeIdMeta =
      const VerificationMeta('narrativeId');
  late final GeneratedColumn<int> narrativeId = GeneratedColumn<int>(
      'narrativeId', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _mediaIdMeta =
      const VerificationMeta('mediaId');
  late final GeneratedColumn<int> mediaId = GeneratedColumn<int>(
      'mediaId', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [narrativeId, mediaId];
  @override
  String get aliasedName => _alias ?? 'narrativeMedia';
  @override
  String get actualTableName => 'narrativeMedia';
  @override
  VerificationContext validateIntegrity(Insertable<NarrativeMediaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('narrativeId')) {
      context.handle(
          _narrativeIdMeta,
          narrativeId.isAcceptableOrUnknown(
              data['narrativeId']!, _narrativeIdMeta));
    } else if (isInserting) {
      context.missing(_narrativeIdMeta);
    }
    if (data.containsKey('mediaId')) {
      context.handle(_mediaIdMeta,
          mediaId.isAcceptableOrUnknown(data['mediaId']!, _mediaIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  NarrativeMediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NarrativeMediaData(
      narrativeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}narrativeId'])!,
      mediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mediaId']),
    );
  }

  @override
  NarrativeMedia createAlias(String alias) {
    return NarrativeMedia(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(narrativeId)REFERENCES narrative(id)',
        'FOREIGN KEY(mediaId)REFERENCES media(primaryId)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class NarrativeMediaData extends DataClass
    implements Insertable<NarrativeMediaData> {
  final int narrativeId;
  final int? mediaId;
  const NarrativeMediaData({required this.narrativeId, this.mediaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['narrativeId'] = Variable<int>(narrativeId);
    if (!nullToAbsent || mediaId != null) {
      map['mediaId'] = Variable<int>(mediaId);
    }
    return map;
  }

  NarrativeMediaCompanion toCompanion(bool nullToAbsent) {
    return NarrativeMediaCompanion(
      narrativeId: Value(narrativeId),
      mediaId: mediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaId),
    );
  }

  factory NarrativeMediaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NarrativeMediaData(
      narrativeId: serializer.fromJson<int>(json['narrativeId']),
      mediaId: serializer.fromJson<int?>(json['mediaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'narrativeId': serializer.toJson<int>(narrativeId),
      'mediaId': serializer.toJson<int?>(mediaId),
    };
  }

  NarrativeMediaData copyWith(
          {int? narrativeId, Value<int?> mediaId = const Value.absent()}) =>
      NarrativeMediaData(
        narrativeId: narrativeId ?? this.narrativeId,
        mediaId: mediaId.present ? mediaId.value : this.mediaId,
      );
  @override
  String toString() {
    return (StringBuffer('NarrativeMediaData(')
          ..write('narrativeId: $narrativeId, ')
          ..write('mediaId: $mediaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(narrativeId, mediaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NarrativeMediaData &&
          other.narrativeId == this.narrativeId &&
          other.mediaId == this.mediaId);
}

class NarrativeMediaCompanion extends UpdateCompanion<NarrativeMediaData> {
  final Value<int> narrativeId;
  final Value<int?> mediaId;
  final Value<int> rowid;
  const NarrativeMediaCompanion({
    this.narrativeId = const Value.absent(),
    this.mediaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NarrativeMediaCompanion.insert({
    required int narrativeId,
    this.mediaId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : narrativeId = Value(narrativeId);
  static Insertable<NarrativeMediaData> custom({
    Expression<int>? narrativeId,
    Expression<int>? mediaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (narrativeId != null) 'narrativeId': narrativeId,
      if (mediaId != null) 'mediaId': mediaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NarrativeMediaCompanion copyWith(
      {Value<int>? narrativeId, Value<int?>? mediaId, Value<int>? rowid}) {
    return NarrativeMediaCompanion(
      narrativeId: narrativeId ?? this.narrativeId,
      mediaId: mediaId ?? this.mediaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (narrativeId.present) {
      map['narrativeId'] = Variable<int>(narrativeId.value);
    }
    if (mediaId.present) {
      map['mediaId'] = Variable<int>(mediaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NarrativeMediaCompanion(')
          ..write('narrativeId: $narrativeId, ')
          ..write('mediaId: $mediaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class SiteMedia extends Table with TableInfo<SiteMedia, SiteMediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SiteMedia(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _siteIdMeta = const VerificationMeta('siteId');
  late final GeneratedColumn<int> siteId = GeneratedColumn<int>(
      'siteId', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _mediaIdMeta =
      const VerificationMeta('mediaId');
  late final GeneratedColumn<int> mediaId = GeneratedColumn<int>(
      'mediaId', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [siteId, mediaId];
  @override
  String get aliasedName => _alias ?? 'siteMedia';
  @override
  String get actualTableName => 'siteMedia';
  @override
  VerificationContext validateIntegrity(Insertable<SiteMediaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('siteId')) {
      context.handle(_siteIdMeta,
          siteId.isAcceptableOrUnknown(data['siteId']!, _siteIdMeta));
    } else if (isInserting) {
      context.missing(_siteIdMeta);
    }
    if (data.containsKey('mediaId')) {
      context.handle(_mediaIdMeta,
          mediaId.isAcceptableOrUnknown(data['mediaId']!, _mediaIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SiteMediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SiteMediaData(
      siteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}siteId'])!,
      mediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mediaId']),
    );
  }

  @override
  SiteMedia createAlias(String alias) {
    return SiteMedia(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(siteId)REFERENCES site(id)',
        'FOREIGN KEY(mediaId)REFERENCES media(primaryId)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class SiteMediaData extends DataClass implements Insertable<SiteMediaData> {
  final int siteId;
  final int? mediaId;
  const SiteMediaData({required this.siteId, this.mediaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['siteId'] = Variable<int>(siteId);
    if (!nullToAbsent || mediaId != null) {
      map['mediaId'] = Variable<int>(mediaId);
    }
    return map;
  }

  SiteMediaCompanion toCompanion(bool nullToAbsent) {
    return SiteMediaCompanion(
      siteId: Value(siteId),
      mediaId: mediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaId),
    );
  }

  factory SiteMediaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SiteMediaData(
      siteId: serializer.fromJson<int>(json['siteId']),
      mediaId: serializer.fromJson<int?>(json['mediaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'siteId': serializer.toJson<int>(siteId),
      'mediaId': serializer.toJson<int?>(mediaId),
    };
  }

  SiteMediaData copyWith(
          {int? siteId, Value<int?> mediaId = const Value.absent()}) =>
      SiteMediaData(
        siteId: siteId ?? this.siteId,
        mediaId: mediaId.present ? mediaId.value : this.mediaId,
      );
  @override
  String toString() {
    return (StringBuffer('SiteMediaData(')
          ..write('siteId: $siteId, ')
          ..write('mediaId: $mediaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(siteId, mediaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SiteMediaData &&
          other.siteId == this.siteId &&
          other.mediaId == this.mediaId);
}

class SiteMediaCompanion extends UpdateCompanion<SiteMediaData> {
  final Value<int> siteId;
  final Value<int?> mediaId;
  final Value<int> rowid;
  const SiteMediaCompanion({
    this.siteId = const Value.absent(),
    this.mediaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SiteMediaCompanion.insert({
    required int siteId,
    this.mediaId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : siteId = Value(siteId);
  static Insertable<SiteMediaData> custom({
    Expression<int>? siteId,
    Expression<int>? mediaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (siteId != null) 'siteId': siteId,
      if (mediaId != null) 'mediaId': mediaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SiteMediaCompanion copyWith(
      {Value<int>? siteId, Value<int?>? mediaId, Value<int>? rowid}) {
    return SiteMediaCompanion(
      siteId: siteId ?? this.siteId,
      mediaId: mediaId ?? this.mediaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (siteId.present) {
      map['siteId'] = Variable<int>(siteId.value);
    }
    if (mediaId.present) {
      map['mediaId'] = Variable<int>(mediaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SiteMediaCompanion(')
          ..write('siteId: $siteId, ')
          ..write('mediaId: $mediaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Taxonomy extends Table with TableInfo<Taxonomy, TaxonomyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Taxonomy(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _taxonClassMeta =
      const VerificationMeta('taxonClass');
  late final GeneratedColumn<String> taxonClass = GeneratedColumn<String>(
      'taxonClass', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _taxonOrderMeta =
      const VerificationMeta('taxonOrder');
  late final GeneratedColumn<String> taxonOrder = GeneratedColumn<String>(
      'taxonOrder', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _taxonFamilyMeta =
      const VerificationMeta('taxonFamily');
  late final GeneratedColumn<String> taxonFamily = GeneratedColumn<String>(
      'taxonFamily', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _genusMeta = const VerificationMeta('genus');
  late final GeneratedColumn<String> genus = GeneratedColumn<String>(
      'genus', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _specificEpithetMeta =
      const VerificationMeta('specificEpithet');
  late final GeneratedColumn<String> specificEpithet = GeneratedColumn<String>(
      'specificEpithet', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _commonNameMeta =
      const VerificationMeta('commonName');
  late final GeneratedColumn<String> commonName = GeneratedColumn<String>(
      'commonName', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _mediaIdMeta =
      const VerificationMeta('mediaId');
  late final GeneratedColumn<int> mediaId = GeneratedColumn<int>(
      'mediaId', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        taxonClass,
        taxonOrder,
        taxonFamily,
        genus,
        specificEpithet,
        commonName,
        notes,
        mediaId
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
    if (data.containsKey('taxonClass')) {
      context.handle(
          _taxonClassMeta,
          taxonClass.isAcceptableOrUnknown(
              data['taxonClass']!, _taxonClassMeta));
    }
    if (data.containsKey('taxonOrder')) {
      context.handle(
          _taxonOrderMeta,
          taxonOrder.isAcceptableOrUnknown(
              data['taxonOrder']!, _taxonOrderMeta));
    }
    if (data.containsKey('taxonFamily')) {
      context.handle(
          _taxonFamilyMeta,
          taxonFamily.isAcceptableOrUnknown(
              data['taxonFamily']!, _taxonFamilyMeta));
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
    if (data.containsKey('commonName')) {
      context.handle(
          _commonNameMeta,
          commonName.isAcceptableOrUnknown(
              data['commonName']!, _commonNameMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('mediaId')) {
      context.handle(_mediaIdMeta,
          mediaId.isAcceptableOrUnknown(data['mediaId']!, _mediaIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaxonomyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaxonomyData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      taxonClass: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}taxonClass']),
      taxonOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}taxonOrder']),
      taxonFamily: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}taxonFamily']),
      genus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genus']),
      specificEpithet: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specificEpithet']),
      commonName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}commonName']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      mediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mediaId']),
    );
  }

  @override
  Taxonomy createAlias(String alias) {
    return Taxonomy(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(mediaId)REFERENCES media(primaryId)'];
  @override
  bool get dontWriteConstraints => true;
}

class TaxonomyData extends DataClass implements Insertable<TaxonomyData> {
  final int id;
  final String? taxonClass;
  final String? taxonOrder;
  final String? taxonFamily;
  final String? genus;
  final String? specificEpithet;
  final String? commonName;
  final String? notes;
  final int? mediaId;
  const TaxonomyData(
      {required this.id,
      this.taxonClass,
      this.taxonOrder,
      this.taxonFamily,
      this.genus,
      this.specificEpithet,
      this.commonName,
      this.notes,
      this.mediaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || taxonClass != null) {
      map['taxonClass'] = Variable<String>(taxonClass);
    }
    if (!nullToAbsent || taxonOrder != null) {
      map['taxonOrder'] = Variable<String>(taxonOrder);
    }
    if (!nullToAbsent || taxonFamily != null) {
      map['taxonFamily'] = Variable<String>(taxonFamily);
    }
    if (!nullToAbsent || genus != null) {
      map['genus'] = Variable<String>(genus);
    }
    if (!nullToAbsent || specificEpithet != null) {
      map['specificEpithet'] = Variable<String>(specificEpithet);
    }
    if (!nullToAbsent || commonName != null) {
      map['commonName'] = Variable<String>(commonName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || mediaId != null) {
      map['mediaId'] = Variable<int>(mediaId);
    }
    return map;
  }

  TaxonomyCompanion toCompanion(bool nullToAbsent) {
    return TaxonomyCompanion(
      id: Value(id),
      taxonClass: taxonClass == null && nullToAbsent
          ? const Value.absent()
          : Value(taxonClass),
      taxonOrder: taxonOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(taxonOrder),
      taxonFamily: taxonFamily == null && nullToAbsent
          ? const Value.absent()
          : Value(taxonFamily),
      genus:
          genus == null && nullToAbsent ? const Value.absent() : Value(genus),
      specificEpithet: specificEpithet == null && nullToAbsent
          ? const Value.absent()
          : Value(specificEpithet),
      commonName: commonName == null && nullToAbsent
          ? const Value.absent()
          : Value(commonName),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      mediaId: mediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaId),
    );
  }

  factory TaxonomyData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaxonomyData(
      id: serializer.fromJson<int>(json['id']),
      taxonClass: serializer.fromJson<String?>(json['taxonClass']),
      taxonOrder: serializer.fromJson<String?>(json['taxonOrder']),
      taxonFamily: serializer.fromJson<String?>(json['taxonFamily']),
      genus: serializer.fromJson<String?>(json['genus']),
      specificEpithet: serializer.fromJson<String?>(json['specificEpithet']),
      commonName: serializer.fromJson<String?>(json['commonName']),
      notes: serializer.fromJson<String?>(json['notes']),
      mediaId: serializer.fromJson<int?>(json['mediaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taxonClass': serializer.toJson<String?>(taxonClass),
      'taxonOrder': serializer.toJson<String?>(taxonOrder),
      'taxonFamily': serializer.toJson<String?>(taxonFamily),
      'genus': serializer.toJson<String?>(genus),
      'specificEpithet': serializer.toJson<String?>(specificEpithet),
      'commonName': serializer.toJson<String?>(commonName),
      'notes': serializer.toJson<String?>(notes),
      'mediaId': serializer.toJson<int?>(mediaId),
    };
  }

  TaxonomyData copyWith(
          {int? id,
          Value<String?> taxonClass = const Value.absent(),
          Value<String?> taxonOrder = const Value.absent(),
          Value<String?> taxonFamily = const Value.absent(),
          Value<String?> genus = const Value.absent(),
          Value<String?> specificEpithet = const Value.absent(),
          Value<String?> commonName = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<int?> mediaId = const Value.absent()}) =>
      TaxonomyData(
        id: id ?? this.id,
        taxonClass: taxonClass.present ? taxonClass.value : this.taxonClass,
        taxonOrder: taxonOrder.present ? taxonOrder.value : this.taxonOrder,
        taxonFamily: taxonFamily.present ? taxonFamily.value : this.taxonFamily,
        genus: genus.present ? genus.value : this.genus,
        specificEpithet: specificEpithet.present
            ? specificEpithet.value
            : this.specificEpithet,
        commonName: commonName.present ? commonName.value : this.commonName,
        notes: notes.present ? notes.value : this.notes,
        mediaId: mediaId.present ? mediaId.value : this.mediaId,
      );
  @override
  String toString() {
    return (StringBuffer('TaxonomyData(')
          ..write('id: $id, ')
          ..write('taxonClass: $taxonClass, ')
          ..write('taxonOrder: $taxonOrder, ')
          ..write('taxonFamily: $taxonFamily, ')
          ..write('genus: $genus, ')
          ..write('specificEpithet: $specificEpithet, ')
          ..write('commonName: $commonName, ')
          ..write('notes: $notes, ')
          ..write('mediaId: $mediaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taxonClass, taxonOrder, taxonFamily,
      genus, specificEpithet, commonName, notes, mediaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaxonomyData &&
          other.id == this.id &&
          other.taxonClass == this.taxonClass &&
          other.taxonOrder == this.taxonOrder &&
          other.taxonFamily == this.taxonFamily &&
          other.genus == this.genus &&
          other.specificEpithet == this.specificEpithet &&
          other.commonName == this.commonName &&
          other.notes == this.notes &&
          other.mediaId == this.mediaId);
}

class TaxonomyCompanion extends UpdateCompanion<TaxonomyData> {
  final Value<int> id;
  final Value<String?> taxonClass;
  final Value<String?> taxonOrder;
  final Value<String?> taxonFamily;
  final Value<String?> genus;
  final Value<String?> specificEpithet;
  final Value<String?> commonName;
  final Value<String?> notes;
  final Value<int?> mediaId;
  const TaxonomyCompanion({
    this.id = const Value.absent(),
    this.taxonClass = const Value.absent(),
    this.taxonOrder = const Value.absent(),
    this.taxonFamily = const Value.absent(),
    this.genus = const Value.absent(),
    this.specificEpithet = const Value.absent(),
    this.commonName = const Value.absent(),
    this.notes = const Value.absent(),
    this.mediaId = const Value.absent(),
  });
  TaxonomyCompanion.insert({
    this.id = const Value.absent(),
    this.taxonClass = const Value.absent(),
    this.taxonOrder = const Value.absent(),
    this.taxonFamily = const Value.absent(),
    this.genus = const Value.absent(),
    this.specificEpithet = const Value.absent(),
    this.commonName = const Value.absent(),
    this.notes = const Value.absent(),
    this.mediaId = const Value.absent(),
  });
  static Insertable<TaxonomyData> custom({
    Expression<int>? id,
    Expression<String>? taxonClass,
    Expression<String>? taxonOrder,
    Expression<String>? taxonFamily,
    Expression<String>? genus,
    Expression<String>? specificEpithet,
    Expression<String>? commonName,
    Expression<String>? notes,
    Expression<int>? mediaId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taxonClass != null) 'taxonClass': taxonClass,
      if (taxonOrder != null) 'taxonOrder': taxonOrder,
      if (taxonFamily != null) 'taxonFamily': taxonFamily,
      if (genus != null) 'genus': genus,
      if (specificEpithet != null) 'specificEpithet': specificEpithet,
      if (commonName != null) 'commonName': commonName,
      if (notes != null) 'notes': notes,
      if (mediaId != null) 'mediaId': mediaId,
    });
  }

  TaxonomyCompanion copyWith(
      {Value<int>? id,
      Value<String?>? taxonClass,
      Value<String?>? taxonOrder,
      Value<String?>? taxonFamily,
      Value<String?>? genus,
      Value<String?>? specificEpithet,
      Value<String?>? commonName,
      Value<String?>? notes,
      Value<int?>? mediaId}) {
    return TaxonomyCompanion(
      id: id ?? this.id,
      taxonClass: taxonClass ?? this.taxonClass,
      taxonOrder: taxonOrder ?? this.taxonOrder,
      taxonFamily: taxonFamily ?? this.taxonFamily,
      genus: genus ?? this.genus,
      specificEpithet: specificEpithet ?? this.specificEpithet,
      commonName: commonName ?? this.commonName,
      notes: notes ?? this.notes,
      mediaId: mediaId ?? this.mediaId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taxonClass.present) {
      map['taxonClass'] = Variable<String>(taxonClass.value);
    }
    if (taxonOrder.present) {
      map['taxonOrder'] = Variable<String>(taxonOrder.value);
    }
    if (taxonFamily.present) {
      map['taxonFamily'] = Variable<String>(taxonFamily.value);
    }
    if (genus.present) {
      map['genus'] = Variable<String>(genus.value);
    }
    if (specificEpithet.present) {
      map['specificEpithet'] = Variable<String>(specificEpithet.value);
    }
    if (commonName.present) {
      map['commonName'] = Variable<String>(commonName.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (mediaId.present) {
      map['mediaId'] = Variable<int>(mediaId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaxonomyCompanion(')
          ..write('id: $id, ')
          ..write('taxonClass: $taxonClass, ')
          ..write('taxonOrder: $taxonOrder, ')
          ..write('taxonFamily: $taxonFamily, ')
          ..write('genus: $genus, ')
          ..write('specificEpithet: $specificEpithet, ')
          ..write('commonName: $commonName, ')
          ..write('notes: $notes, ')
          ..write('mediaId: $mediaId')
          ..write(')'))
        .toString();
  }
}

class Specimen extends Table with TableInfo<Specimen, SpecimenData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Specimen(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL PRIMARY KEY');
  static const VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String> projectUuid = GeneratedColumn<String>(
      'projectUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _speciesIDMeta =
      const VerificationMeta('speciesID');
  late final GeneratedColumn<int> speciesID = GeneratedColumn<int>(
      'speciesID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _taxonGroupMeta =
      const VerificationMeta('taxonGroup');
  late final GeneratedColumn<String> taxonGroup = GeneratedColumn<String>(
      'taxonGroup', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _conditionMeta =
      const VerificationMeta('condition');
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
      'condition', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _prepDateMeta =
      const VerificationMeta('prepDate');
  late final GeneratedColumn<String> prepDate = GeneratedColumn<String>(
      'prepDate', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _prepTimeMeta =
      const VerificationMeta('prepTime');
  late final GeneratedColumn<String> prepTime = GeneratedColumn<String>(
      'prepTime', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _collectionTimeMeta =
      const VerificationMeta('collectionTime');
  late final GeneratedColumn<String> collectionTime = GeneratedColumn<String>(
      'collectionTime', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _captureDateMeta =
      const VerificationMeta('captureDate');
  late final GeneratedColumn<String> captureDate = GeneratedColumn<String>(
      'captureDate', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _isRelativeTimeMeta =
      const VerificationMeta('isRelativeTime');
  late final GeneratedColumn<int> isRelativeTime = GeneratedColumn<int>(
      'isRelativeTime', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _captureTimeMeta =
      const VerificationMeta('captureTime');
  late final GeneratedColumn<String> captureTime = GeneratedColumn<String>(
      'captureTime', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _trapTypeMeta =
      const VerificationMeta('trapType');
  late final GeneratedColumn<String> trapType = GeneratedColumn<String>(
      'trapType', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _methodIDMeta =
      const VerificationMeta('methodID');
  late final GeneratedColumn<String> methodID = GeneratedColumn<String>(
      'methodID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _coordinateIDMeta =
      const VerificationMeta('coordinateID');
  late final GeneratedColumn<int> coordinateID = GeneratedColumn<int>(
      'coordinateID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _catalogerIDMeta =
      const VerificationMeta('catalogerID');
  late final GeneratedColumn<String> catalogerID = GeneratedColumn<String>(
      'catalogerID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _fieldNumberMeta =
      const VerificationMeta('fieldNumber');
  late final GeneratedColumn<int> fieldNumber = GeneratedColumn<int>(
      'fieldNumber', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _collEventIDMeta =
      const VerificationMeta('collEventID');
  late final GeneratedColumn<int> collEventID = GeneratedColumn<int>(
      'collEventID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _isMultipleCollectorMeta =
      const VerificationMeta('isMultipleCollector');
  late final GeneratedColumn<int> isMultipleCollector = GeneratedColumn<int>(
      'isMultipleCollector', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _collPersonnelIDMeta =
      const VerificationMeta('collPersonnelID');
  late final GeneratedColumn<int> collPersonnelID = GeneratedColumn<int>(
      'collPersonnelID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _collMethodIDMeta =
      const VerificationMeta('collMethodID');
  late final GeneratedColumn<int> collMethodID = GeneratedColumn<int>(
      'collMethodID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _museumIDMeta =
      const VerificationMeta('museumID');
  late final GeneratedColumn<String> museumID = GeneratedColumn<String>(
      'museumID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _preparatorIDMeta =
      const VerificationMeta('preparatorID');
  late final GeneratedColumn<String> preparatorID = GeneratedColumn<String>(
      'preparatorID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES personnel(uuid)');
  @override
  List<GeneratedColumn> get $columns => [
        uuid,
        projectUuid,
        speciesID,
        taxonGroup,
        condition,
        prepDate,
        prepTime,
        collectionTime,
        captureDate,
        isRelativeTime,
        captureTime,
        trapType,
        methodID,
        coordinateID,
        catalogerID,
        fieldNumber,
        collEventID,
        isMultipleCollector,
        collPersonnelID,
        collMethodID,
        museumID,
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
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
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
    if (data.containsKey('collectionTime')) {
      context.handle(
          _collectionTimeMeta,
          collectionTime.isAcceptableOrUnknown(
              data['collectionTime']!, _collectionTimeMeta));
    }
    if (data.containsKey('captureDate')) {
      context.handle(
          _captureDateMeta,
          captureDate.isAcceptableOrUnknown(
              data['captureDate']!, _captureDateMeta));
    }
    if (data.containsKey('isRelativeTime')) {
      context.handle(
          _isRelativeTimeMeta,
          isRelativeTime.isAcceptableOrUnknown(
              data['isRelativeTime']!, _isRelativeTimeMeta));
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
    if (data.containsKey('methodID')) {
      context.handle(_methodIDMeta,
          methodID.isAcceptableOrUnknown(data['methodID']!, _methodIDMeta));
    }
    if (data.containsKey('coordinateID')) {
      context.handle(
          _coordinateIDMeta,
          coordinateID.isAcceptableOrUnknown(
              data['coordinateID']!, _coordinateIDMeta));
    }
    if (data.containsKey('catalogerID')) {
      context.handle(
          _catalogerIDMeta,
          catalogerID.isAcceptableOrUnknown(
              data['catalogerID']!, _catalogerIDMeta));
    }
    if (data.containsKey('fieldNumber')) {
      context.handle(
          _fieldNumberMeta,
          fieldNumber.isAcceptableOrUnknown(
              data['fieldNumber']!, _fieldNumberMeta));
    }
    if (data.containsKey('collEventID')) {
      context.handle(
          _collEventIDMeta,
          collEventID.isAcceptableOrUnknown(
              data['collEventID']!, _collEventIDMeta));
    }
    if (data.containsKey('isMultipleCollector')) {
      context.handle(
          _isMultipleCollectorMeta,
          isMultipleCollector.isAcceptableOrUnknown(
              data['isMultipleCollector']!, _isMultipleCollectorMeta));
    }
    if (data.containsKey('collPersonnelID')) {
      context.handle(
          _collPersonnelIDMeta,
          collPersonnelID.isAcceptableOrUnknown(
              data['collPersonnelID']!, _collPersonnelIDMeta));
    }
    if (data.containsKey('collMethodID')) {
      context.handle(
          _collMethodIDMeta,
          collMethodID.isAcceptableOrUnknown(
              data['collMethodID']!, _collMethodIDMeta));
    }
    if (data.containsKey('museumID')) {
      context.handle(_museumIDMeta,
          museumID.isAcceptableOrUnknown(data['museumID']!, _museumIDMeta));
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
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  SpecimenData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpecimenData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      projectUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}projectUuid']),
      speciesID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}speciesID']),
      taxonGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}taxonGroup']),
      condition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}condition']),
      prepDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prepDate']),
      prepTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prepTime']),
      collectionTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collectionTime']),
      captureDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}captureDate']),
      isRelativeTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}isRelativeTime']),
      captureTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}captureTime']),
      trapType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}trapType']),
      methodID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}methodID']),
      coordinateID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coordinateID']),
      catalogerID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}catalogerID']),
      fieldNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fieldNumber']),
      collEventID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}collEventID']),
      isMultipleCollector: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}isMultipleCollector']),
      collPersonnelID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}collPersonnelID']),
      collMethodID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}collMethodID']),
      museumID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}museumID']),
      preparatorID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}preparatorID']),
    );
  }

  @override
  Specimen createAlias(String alias) {
    return Specimen(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(projectUuid)REFERENCES project(uuid)',
        'FOREIGN KEY(catalogerID)REFERENCES personnel(uuid)',
        'FOREIGN KEY(collPersonnelID)REFERENCES collPersonnel(id)',
        'FOREIGN KEY(collMethodID)REFERENCES collEffort(id)',
        'FOREIGN KEY(speciesID)REFERENCES taxonomy(id)',
        'FOREIGN KEY(collEventID)REFERENCES collEvent(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class SpecimenData extends DataClass implements Insertable<SpecimenData> {
  final String uuid;
  final String? projectUuid;
  final int? speciesID;
  final String? taxonGroup;

  /// use for catalog formats
  final String? condition;
  final String? prepDate;
  final String? prepTime;
  final String? collectionTime;

  /// v4 update
  final String? captureDate;
  final int? isRelativeTime;
  final String? captureTime;
  final String? trapType;
  final String? methodID;

  /// v4 rename
  final int? coordinateID;
  final String? catalogerID;
  final int? fieldNumber;
  final int? collEventID;
  final int? isMultipleCollector;
  final int? collPersonnelID;
  final int? collMethodID;
  final String? museumID;
  final String? preparatorID;
  const SpecimenData(
      {required this.uuid,
      this.projectUuid,
      this.speciesID,
      this.taxonGroup,
      this.condition,
      this.prepDate,
      this.prepTime,
      this.collectionTime,
      this.captureDate,
      this.isRelativeTime,
      this.captureTime,
      this.trapType,
      this.methodID,
      this.coordinateID,
      this.catalogerID,
      this.fieldNumber,
      this.collEventID,
      this.isMultipleCollector,
      this.collPersonnelID,
      this.collMethodID,
      this.museumID,
      this.preparatorID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String>(projectUuid);
    }
    if (!nullToAbsent || speciesID != null) {
      map['speciesID'] = Variable<int>(speciesID);
    }
    if (!nullToAbsent || taxonGroup != null) {
      map['taxonGroup'] = Variable<String>(taxonGroup);
    }
    if (!nullToAbsent || condition != null) {
      map['condition'] = Variable<String>(condition);
    }
    if (!nullToAbsent || prepDate != null) {
      map['prepDate'] = Variable<String>(prepDate);
    }
    if (!nullToAbsent || prepTime != null) {
      map['prepTime'] = Variable<String>(prepTime);
    }
    if (!nullToAbsent || collectionTime != null) {
      map['collectionTime'] = Variable<String>(collectionTime);
    }
    if (!nullToAbsent || captureDate != null) {
      map['captureDate'] = Variable<String>(captureDate);
    }
    if (!nullToAbsent || isRelativeTime != null) {
      map['isRelativeTime'] = Variable<int>(isRelativeTime);
    }
    if (!nullToAbsent || captureTime != null) {
      map['captureTime'] = Variable<String>(captureTime);
    }
    if (!nullToAbsent || trapType != null) {
      map['trapType'] = Variable<String>(trapType);
    }
    if (!nullToAbsent || methodID != null) {
      map['methodID'] = Variable<String>(methodID);
    }
    if (!nullToAbsent || coordinateID != null) {
      map['coordinateID'] = Variable<int>(coordinateID);
    }
    if (!nullToAbsent || catalogerID != null) {
      map['catalogerID'] = Variable<String>(catalogerID);
    }
    if (!nullToAbsent || fieldNumber != null) {
      map['fieldNumber'] = Variable<int>(fieldNumber);
    }
    if (!nullToAbsent || collEventID != null) {
      map['collEventID'] = Variable<int>(collEventID);
    }
    if (!nullToAbsent || isMultipleCollector != null) {
      map['isMultipleCollector'] = Variable<int>(isMultipleCollector);
    }
    if (!nullToAbsent || collPersonnelID != null) {
      map['collPersonnelID'] = Variable<int>(collPersonnelID);
    }
    if (!nullToAbsent || collMethodID != null) {
      map['collMethodID'] = Variable<int>(collMethodID);
    }
    if (!nullToAbsent || museumID != null) {
      map['museumID'] = Variable<String>(museumID);
    }
    if (!nullToAbsent || preparatorID != null) {
      map['preparatorID'] = Variable<String>(preparatorID);
    }
    return map;
  }

  SpecimenCompanion toCompanion(bool nullToAbsent) {
    return SpecimenCompanion(
      uuid: Value(uuid),
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
      collectionTime: collectionTime == null && nullToAbsent
          ? const Value.absent()
          : Value(collectionTime),
      captureDate: captureDate == null && nullToAbsent
          ? const Value.absent()
          : Value(captureDate),
      isRelativeTime: isRelativeTime == null && nullToAbsent
          ? const Value.absent()
          : Value(isRelativeTime),
      captureTime: captureTime == null && nullToAbsent
          ? const Value.absent()
          : Value(captureTime),
      trapType: trapType == null && nullToAbsent
          ? const Value.absent()
          : Value(trapType),
      methodID: methodID == null && nullToAbsent
          ? const Value.absent()
          : Value(methodID),
      coordinateID: coordinateID == null && nullToAbsent
          ? const Value.absent()
          : Value(coordinateID),
      catalogerID: catalogerID == null && nullToAbsent
          ? const Value.absent()
          : Value(catalogerID),
      fieldNumber: fieldNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldNumber),
      collEventID: collEventID == null && nullToAbsent
          ? const Value.absent()
          : Value(collEventID),
      isMultipleCollector: isMultipleCollector == null && nullToAbsent
          ? const Value.absent()
          : Value(isMultipleCollector),
      collPersonnelID: collPersonnelID == null && nullToAbsent
          ? const Value.absent()
          : Value(collPersonnelID),
      collMethodID: collMethodID == null && nullToAbsent
          ? const Value.absent()
          : Value(collMethodID),
      museumID: museumID == null && nullToAbsent
          ? const Value.absent()
          : Value(museumID),
      preparatorID: preparatorID == null && nullToAbsent
          ? const Value.absent()
          : Value(preparatorID),
    );
  }

  factory SpecimenData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpecimenData(
      uuid: serializer.fromJson<String>(json['uuid']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      speciesID: serializer.fromJson<int?>(json['speciesID']),
      taxonGroup: serializer.fromJson<String?>(json['taxonGroup']),
      condition: serializer.fromJson<String?>(json['condition']),
      prepDate: serializer.fromJson<String?>(json['prepDate']),
      prepTime: serializer.fromJson<String?>(json['prepTime']),
      collectionTime: serializer.fromJson<String?>(json['collectionTime']),
      captureDate: serializer.fromJson<String?>(json['captureDate']),
      isRelativeTime: serializer.fromJson<int?>(json['isRelativeTime']),
      captureTime: serializer.fromJson<String?>(json['captureTime']),
      trapType: serializer.fromJson<String?>(json['trapType']),
      methodID: serializer.fromJson<String?>(json['methodID']),
      coordinateID: serializer.fromJson<int?>(json['coordinateID']),
      catalogerID: serializer.fromJson<String?>(json['catalogerID']),
      fieldNumber: serializer.fromJson<int?>(json['fieldNumber']),
      collEventID: serializer.fromJson<int?>(json['collEventID']),
      isMultipleCollector:
          serializer.fromJson<int?>(json['isMultipleCollector']),
      collPersonnelID: serializer.fromJson<int?>(json['collPersonnelID']),
      collMethodID: serializer.fromJson<int?>(json['collMethodID']),
      museumID: serializer.fromJson<String?>(json['museumID']),
      preparatorID: serializer.fromJson<String?>(json['preparatorID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'speciesID': serializer.toJson<int?>(speciesID),
      'taxonGroup': serializer.toJson<String?>(taxonGroup),
      'condition': serializer.toJson<String?>(condition),
      'prepDate': serializer.toJson<String?>(prepDate),
      'prepTime': serializer.toJson<String?>(prepTime),
      'collectionTime': serializer.toJson<String?>(collectionTime),
      'captureDate': serializer.toJson<String?>(captureDate),
      'isRelativeTime': serializer.toJson<int?>(isRelativeTime),
      'captureTime': serializer.toJson<String?>(captureTime),
      'trapType': serializer.toJson<String?>(trapType),
      'methodID': serializer.toJson<String?>(methodID),
      'coordinateID': serializer.toJson<int?>(coordinateID),
      'catalogerID': serializer.toJson<String?>(catalogerID),
      'fieldNumber': serializer.toJson<int?>(fieldNumber),
      'collEventID': serializer.toJson<int?>(collEventID),
      'isMultipleCollector': serializer.toJson<int?>(isMultipleCollector),
      'collPersonnelID': serializer.toJson<int?>(collPersonnelID),
      'collMethodID': serializer.toJson<int?>(collMethodID),
      'museumID': serializer.toJson<String?>(museumID),
      'preparatorID': serializer.toJson<String?>(preparatorID),
    };
  }

  SpecimenData copyWith(
          {String? uuid,
          Value<String?> projectUuid = const Value.absent(),
          Value<int?> speciesID = const Value.absent(),
          Value<String?> taxonGroup = const Value.absent(),
          Value<String?> condition = const Value.absent(),
          Value<String?> prepDate = const Value.absent(),
          Value<String?> prepTime = const Value.absent(),
          Value<String?> collectionTime = const Value.absent(),
          Value<String?> captureDate = const Value.absent(),
          Value<int?> isRelativeTime = const Value.absent(),
          Value<String?> captureTime = const Value.absent(),
          Value<String?> trapType = const Value.absent(),
          Value<String?> methodID = const Value.absent(),
          Value<int?> coordinateID = const Value.absent(),
          Value<String?> catalogerID = const Value.absent(),
          Value<int?> fieldNumber = const Value.absent(),
          Value<int?> collEventID = const Value.absent(),
          Value<int?> isMultipleCollector = const Value.absent(),
          Value<int?> collPersonnelID = const Value.absent(),
          Value<int?> collMethodID = const Value.absent(),
          Value<String?> museumID = const Value.absent(),
          Value<String?> preparatorID = const Value.absent()}) =>
      SpecimenData(
        uuid: uuid ?? this.uuid,
        projectUuid: projectUuid.present ? projectUuid.value : this.projectUuid,
        speciesID: speciesID.present ? speciesID.value : this.speciesID,
        taxonGroup: taxonGroup.present ? taxonGroup.value : this.taxonGroup,
        condition: condition.present ? condition.value : this.condition,
        prepDate: prepDate.present ? prepDate.value : this.prepDate,
        prepTime: prepTime.present ? prepTime.value : this.prepTime,
        collectionTime:
            collectionTime.present ? collectionTime.value : this.collectionTime,
        captureDate: captureDate.present ? captureDate.value : this.captureDate,
        isRelativeTime:
            isRelativeTime.present ? isRelativeTime.value : this.isRelativeTime,
        captureTime: captureTime.present ? captureTime.value : this.captureTime,
        trapType: trapType.present ? trapType.value : this.trapType,
        methodID: methodID.present ? methodID.value : this.methodID,
        coordinateID:
            coordinateID.present ? coordinateID.value : this.coordinateID,
        catalogerID: catalogerID.present ? catalogerID.value : this.catalogerID,
        fieldNumber: fieldNumber.present ? fieldNumber.value : this.fieldNumber,
        collEventID: collEventID.present ? collEventID.value : this.collEventID,
        isMultipleCollector: isMultipleCollector.present
            ? isMultipleCollector.value
            : this.isMultipleCollector,
        collPersonnelID: collPersonnelID.present
            ? collPersonnelID.value
            : this.collPersonnelID,
        collMethodID:
            collMethodID.present ? collMethodID.value : this.collMethodID,
        museumID: museumID.present ? museumID.value : this.museumID,
        preparatorID:
            preparatorID.present ? preparatorID.value : this.preparatorID,
      );
  @override
  String toString() {
    return (StringBuffer('SpecimenData(')
          ..write('uuid: $uuid, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('speciesID: $speciesID, ')
          ..write('taxonGroup: $taxonGroup, ')
          ..write('condition: $condition, ')
          ..write('prepDate: $prepDate, ')
          ..write('prepTime: $prepTime, ')
          ..write('collectionTime: $collectionTime, ')
          ..write('captureDate: $captureDate, ')
          ..write('isRelativeTime: $isRelativeTime, ')
          ..write('captureTime: $captureTime, ')
          ..write('trapType: $trapType, ')
          ..write('methodID: $methodID, ')
          ..write('coordinateID: $coordinateID, ')
          ..write('catalogerID: $catalogerID, ')
          ..write('fieldNumber: $fieldNumber, ')
          ..write('collEventID: $collEventID, ')
          ..write('isMultipleCollector: $isMultipleCollector, ')
          ..write('collPersonnelID: $collPersonnelID, ')
          ..write('collMethodID: $collMethodID, ')
          ..write('museumID: $museumID, ')
          ..write('preparatorID: $preparatorID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        uuid,
        projectUuid,
        speciesID,
        taxonGroup,
        condition,
        prepDate,
        prepTime,
        collectionTime,
        captureDate,
        isRelativeTime,
        captureTime,
        trapType,
        methodID,
        coordinateID,
        catalogerID,
        fieldNumber,
        collEventID,
        isMultipleCollector,
        collPersonnelID,
        collMethodID,
        museumID,
        preparatorID
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecimenData &&
          other.uuid == this.uuid &&
          other.projectUuid == this.projectUuid &&
          other.speciesID == this.speciesID &&
          other.taxonGroup == this.taxonGroup &&
          other.condition == this.condition &&
          other.prepDate == this.prepDate &&
          other.prepTime == this.prepTime &&
          other.collectionTime == this.collectionTime &&
          other.captureDate == this.captureDate &&
          other.isRelativeTime == this.isRelativeTime &&
          other.captureTime == this.captureTime &&
          other.trapType == this.trapType &&
          other.methodID == this.methodID &&
          other.coordinateID == this.coordinateID &&
          other.catalogerID == this.catalogerID &&
          other.fieldNumber == this.fieldNumber &&
          other.collEventID == this.collEventID &&
          other.isMultipleCollector == this.isMultipleCollector &&
          other.collPersonnelID == this.collPersonnelID &&
          other.collMethodID == this.collMethodID &&
          other.museumID == this.museumID &&
          other.preparatorID == this.preparatorID);
}

class SpecimenCompanion extends UpdateCompanion<SpecimenData> {
  final Value<String> uuid;
  final Value<String?> projectUuid;
  final Value<int?> speciesID;
  final Value<String?> taxonGroup;
  final Value<String?> condition;
  final Value<String?> prepDate;
  final Value<String?> prepTime;
  final Value<String?> collectionTime;
  final Value<String?> captureDate;
  final Value<int?> isRelativeTime;
  final Value<String?> captureTime;
  final Value<String?> trapType;
  final Value<String?> methodID;
  final Value<int?> coordinateID;
  final Value<String?> catalogerID;
  final Value<int?> fieldNumber;
  final Value<int?> collEventID;
  final Value<int?> isMultipleCollector;
  final Value<int?> collPersonnelID;
  final Value<int?> collMethodID;
  final Value<String?> museumID;
  final Value<String?> preparatorID;
  final Value<int> rowid;
  const SpecimenCompanion({
    this.uuid = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.speciesID = const Value.absent(),
    this.taxonGroup = const Value.absent(),
    this.condition = const Value.absent(),
    this.prepDate = const Value.absent(),
    this.prepTime = const Value.absent(),
    this.collectionTime = const Value.absent(),
    this.captureDate = const Value.absent(),
    this.isRelativeTime = const Value.absent(),
    this.captureTime = const Value.absent(),
    this.trapType = const Value.absent(),
    this.methodID = const Value.absent(),
    this.coordinateID = const Value.absent(),
    this.catalogerID = const Value.absent(),
    this.fieldNumber = const Value.absent(),
    this.collEventID = const Value.absent(),
    this.isMultipleCollector = const Value.absent(),
    this.collPersonnelID = const Value.absent(),
    this.collMethodID = const Value.absent(),
    this.museumID = const Value.absent(),
    this.preparatorID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpecimenCompanion.insert({
    required String uuid,
    this.projectUuid = const Value.absent(),
    this.speciesID = const Value.absent(),
    this.taxonGroup = const Value.absent(),
    this.condition = const Value.absent(),
    this.prepDate = const Value.absent(),
    this.prepTime = const Value.absent(),
    this.collectionTime = const Value.absent(),
    this.captureDate = const Value.absent(),
    this.isRelativeTime = const Value.absent(),
    this.captureTime = const Value.absent(),
    this.trapType = const Value.absent(),
    this.methodID = const Value.absent(),
    this.coordinateID = const Value.absent(),
    this.catalogerID = const Value.absent(),
    this.fieldNumber = const Value.absent(),
    this.collEventID = const Value.absent(),
    this.isMultipleCollector = const Value.absent(),
    this.collPersonnelID = const Value.absent(),
    this.collMethodID = const Value.absent(),
    this.museumID = const Value.absent(),
    this.preparatorID = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid);
  static Insertable<SpecimenData> custom({
    Expression<String>? uuid,
    Expression<String>? projectUuid,
    Expression<int>? speciesID,
    Expression<String>? taxonGroup,
    Expression<String>? condition,
    Expression<String>? prepDate,
    Expression<String>? prepTime,
    Expression<String>? collectionTime,
    Expression<String>? captureDate,
    Expression<int>? isRelativeTime,
    Expression<String>? captureTime,
    Expression<String>? trapType,
    Expression<String>? methodID,
    Expression<int>? coordinateID,
    Expression<String>? catalogerID,
    Expression<int>? fieldNumber,
    Expression<int>? collEventID,
    Expression<int>? isMultipleCollector,
    Expression<int>? collPersonnelID,
    Expression<int>? collMethodID,
    Expression<String>? museumID,
    Expression<String>? preparatorID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (speciesID != null) 'speciesID': speciesID,
      if (taxonGroup != null) 'taxonGroup': taxonGroup,
      if (condition != null) 'condition': condition,
      if (prepDate != null) 'prepDate': prepDate,
      if (prepTime != null) 'prepTime': prepTime,
      if (collectionTime != null) 'collectionTime': collectionTime,
      if (captureDate != null) 'captureDate': captureDate,
      if (isRelativeTime != null) 'isRelativeTime': isRelativeTime,
      if (captureTime != null) 'captureTime': captureTime,
      if (trapType != null) 'trapType': trapType,
      if (methodID != null) 'methodID': methodID,
      if (coordinateID != null) 'coordinateID': coordinateID,
      if (catalogerID != null) 'catalogerID': catalogerID,
      if (fieldNumber != null) 'fieldNumber': fieldNumber,
      if (collEventID != null) 'collEventID': collEventID,
      if (isMultipleCollector != null)
        'isMultipleCollector': isMultipleCollector,
      if (collPersonnelID != null) 'collPersonnelID': collPersonnelID,
      if (collMethodID != null) 'collMethodID': collMethodID,
      if (museumID != null) 'museumID': museumID,
      if (preparatorID != null) 'preparatorID': preparatorID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpecimenCompanion copyWith(
      {Value<String>? uuid,
      Value<String?>? projectUuid,
      Value<int?>? speciesID,
      Value<String?>? taxonGroup,
      Value<String?>? condition,
      Value<String?>? prepDate,
      Value<String?>? prepTime,
      Value<String?>? collectionTime,
      Value<String?>? captureDate,
      Value<int?>? isRelativeTime,
      Value<String?>? captureTime,
      Value<String?>? trapType,
      Value<String?>? methodID,
      Value<int?>? coordinateID,
      Value<String?>? catalogerID,
      Value<int?>? fieldNumber,
      Value<int?>? collEventID,
      Value<int?>? isMultipleCollector,
      Value<int?>? collPersonnelID,
      Value<int?>? collMethodID,
      Value<String?>? museumID,
      Value<String?>? preparatorID,
      Value<int>? rowid}) {
    return SpecimenCompanion(
      uuid: uuid ?? this.uuid,
      projectUuid: projectUuid ?? this.projectUuid,
      speciesID: speciesID ?? this.speciesID,
      taxonGroup: taxonGroup ?? this.taxonGroup,
      condition: condition ?? this.condition,
      prepDate: prepDate ?? this.prepDate,
      prepTime: prepTime ?? this.prepTime,
      collectionTime: collectionTime ?? this.collectionTime,
      captureDate: captureDate ?? this.captureDate,
      isRelativeTime: isRelativeTime ?? this.isRelativeTime,
      captureTime: captureTime ?? this.captureTime,
      trapType: trapType ?? this.trapType,
      methodID: methodID ?? this.methodID,
      coordinateID: coordinateID ?? this.coordinateID,
      catalogerID: catalogerID ?? this.catalogerID,
      fieldNumber: fieldNumber ?? this.fieldNumber,
      collEventID: collEventID ?? this.collEventID,
      isMultipleCollector: isMultipleCollector ?? this.isMultipleCollector,
      collPersonnelID: collPersonnelID ?? this.collPersonnelID,
      collMethodID: collMethodID ?? this.collMethodID,
      museumID: museumID ?? this.museumID,
      preparatorID: preparatorID ?? this.preparatorID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String>(projectUuid.value);
    }
    if (speciesID.present) {
      map['speciesID'] = Variable<int>(speciesID.value);
    }
    if (taxonGroup.present) {
      map['taxonGroup'] = Variable<String>(taxonGroup.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (prepDate.present) {
      map['prepDate'] = Variable<String>(prepDate.value);
    }
    if (prepTime.present) {
      map['prepTime'] = Variable<String>(prepTime.value);
    }
    if (collectionTime.present) {
      map['collectionTime'] = Variable<String>(collectionTime.value);
    }
    if (captureDate.present) {
      map['captureDate'] = Variable<String>(captureDate.value);
    }
    if (isRelativeTime.present) {
      map['isRelativeTime'] = Variable<int>(isRelativeTime.value);
    }
    if (captureTime.present) {
      map['captureTime'] = Variable<String>(captureTime.value);
    }
    if (trapType.present) {
      map['trapType'] = Variable<String>(trapType.value);
    }
    if (methodID.present) {
      map['methodID'] = Variable<String>(methodID.value);
    }
    if (coordinateID.present) {
      map['coordinateID'] = Variable<int>(coordinateID.value);
    }
    if (catalogerID.present) {
      map['catalogerID'] = Variable<String>(catalogerID.value);
    }
    if (fieldNumber.present) {
      map['fieldNumber'] = Variable<int>(fieldNumber.value);
    }
    if (collEventID.present) {
      map['collEventID'] = Variable<int>(collEventID.value);
    }
    if (isMultipleCollector.present) {
      map['isMultipleCollector'] = Variable<int>(isMultipleCollector.value);
    }
    if (collPersonnelID.present) {
      map['collPersonnelID'] = Variable<int>(collPersonnelID.value);
    }
    if (collMethodID.present) {
      map['collMethodID'] = Variable<int>(collMethodID.value);
    }
    if (museumID.present) {
      map['museumID'] = Variable<String>(museumID.value);
    }
    if (preparatorID.present) {
      map['preparatorID'] = Variable<String>(preparatorID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecimenCompanion(')
          ..write('uuid: $uuid, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('speciesID: $speciesID, ')
          ..write('taxonGroup: $taxonGroup, ')
          ..write('condition: $condition, ')
          ..write('prepDate: $prepDate, ')
          ..write('prepTime: $prepTime, ')
          ..write('collectionTime: $collectionTime, ')
          ..write('captureDate: $captureDate, ')
          ..write('isRelativeTime: $isRelativeTime, ')
          ..write('captureTime: $captureTime, ')
          ..write('trapType: $trapType, ')
          ..write('methodID: $methodID, ')
          ..write('coordinateID: $coordinateID, ')
          ..write('catalogerID: $catalogerID, ')
          ..write('fieldNumber: $fieldNumber, ')
          ..write('collEventID: $collEventID, ')
          ..write('isMultipleCollector: $isMultipleCollector, ')
          ..write('collPersonnelID: $collPersonnelID, ')
          ..write('collMethodID: $collMethodID, ')
          ..write('museumID: $museumID, ')
          ..write('preparatorID: $preparatorID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class SpecimenMedia extends Table
    with TableInfo<SpecimenMedia, SpecimenMediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SpecimenMedia(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String> specimenUuid = GeneratedColumn<String>(
      'specimenUuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _mediaIdMeta =
      const VerificationMeta('mediaId');
  late final GeneratedColumn<int> mediaId = GeneratedColumn<int>(
      'mediaId', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [specimenUuid, mediaId];
  @override
  String get aliasedName => _alias ?? 'specimenMedia';
  @override
  String get actualTableName => 'specimenMedia';
  @override
  VerificationContext validateIntegrity(Insertable<SpecimenMediaData> instance,
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
    if (data.containsKey('mediaId')) {
      context.handle(_mediaIdMeta,
          mediaId.isAcceptableOrUnknown(data['mediaId']!, _mediaIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SpecimenMediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpecimenMediaData(
      specimenUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specimenUuid'])!,
      mediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mediaId']),
    );
  }

  @override
  SpecimenMedia createAlias(String alias) {
    return SpecimenMedia(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(specimenUuid)REFERENCES specimen(uuid)',
        'FOREIGN KEY(mediaId)REFERENCES media(primaryId)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class SpecimenMediaData extends DataClass
    implements Insertable<SpecimenMediaData> {
  final String specimenUuid;
  final int? mediaId;
  const SpecimenMediaData({required this.specimenUuid, this.mediaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['specimenUuid'] = Variable<String>(specimenUuid);
    if (!nullToAbsent || mediaId != null) {
      map['mediaId'] = Variable<int>(mediaId);
    }
    return map;
  }

  SpecimenMediaCompanion toCompanion(bool nullToAbsent) {
    return SpecimenMediaCompanion(
      specimenUuid: Value(specimenUuid),
      mediaId: mediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaId),
    );
  }

  factory SpecimenMediaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpecimenMediaData(
      specimenUuid: serializer.fromJson<String>(json['specimenUuid']),
      mediaId: serializer.fromJson<int?>(json['mediaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'specimenUuid': serializer.toJson<String>(specimenUuid),
      'mediaId': serializer.toJson<int?>(mediaId),
    };
  }

  SpecimenMediaData copyWith(
          {String? specimenUuid, Value<int?> mediaId = const Value.absent()}) =>
      SpecimenMediaData(
        specimenUuid: specimenUuid ?? this.specimenUuid,
        mediaId: mediaId.present ? mediaId.value : this.mediaId,
      );
  @override
  String toString() {
    return (StringBuffer('SpecimenMediaData(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('mediaId: $mediaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(specimenUuid, mediaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecimenMediaData &&
          other.specimenUuid == this.specimenUuid &&
          other.mediaId == this.mediaId);
}

class SpecimenMediaCompanion extends UpdateCompanion<SpecimenMediaData> {
  final Value<String> specimenUuid;
  final Value<int?> mediaId;
  final Value<int> rowid;
  const SpecimenMediaCompanion({
    this.specimenUuid = const Value.absent(),
    this.mediaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpecimenMediaCompanion.insert({
    required String specimenUuid,
    this.mediaId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : specimenUuid = Value(specimenUuid);
  static Insertable<SpecimenMediaData> custom({
    Expression<String>? specimenUuid,
    Expression<int>? mediaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (specimenUuid != null) 'specimenUuid': specimenUuid,
      if (mediaId != null) 'mediaId': mediaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpecimenMediaCompanion copyWith(
      {Value<String>? specimenUuid, Value<int?>? mediaId, Value<int>? rowid}) {
    return SpecimenMediaCompanion(
      specimenUuid: specimenUuid ?? this.specimenUuid,
      mediaId: mediaId ?? this.mediaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (specimenUuid.present) {
      map['specimenUuid'] = Variable<String>(specimenUuid.value);
    }
    if (mediaId.present) {
      map['mediaId'] = Variable<int>(mediaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecimenMediaCompanion(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('mediaId: $mediaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class AssociatedData extends Table
    with TableInfo<AssociatedData, AssociatedDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AssociatedData(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _primaryIdMeta =
      const VerificationMeta('primaryId');
  late final GeneratedColumn<int> primaryId = GeneratedColumn<int>(
      'primaryId', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _secondaryIdMeta =
      const VerificationMeta('secondaryId');
  late final GeneratedColumn<String> secondaryId = GeneratedColumn<String>(
      'secondaryId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _secondaryIdRefMeta =
      const VerificationMeta('secondaryIdRef');
  late final GeneratedColumn<String> secondaryIdRef = GeneratedColumn<String>(
      'secondaryIdRef', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  late final GeneratedColumn<String> fileId = GeneratedColumn<String>(
      'fileId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [primaryId, secondaryId, secondaryIdRef, type, description, fileId];
  @override
  String get aliasedName => _alias ?? 'associatedData';
  @override
  String get actualTableName => 'associatedData';
  @override
  VerificationContext validateIntegrity(Insertable<AssociatedDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('primaryId')) {
      context.handle(_primaryIdMeta,
          primaryId.isAcceptableOrUnknown(data['primaryId']!, _primaryIdMeta));
    }
    if (data.containsKey('secondaryId')) {
      context.handle(
          _secondaryIdMeta,
          secondaryId.isAcceptableOrUnknown(
              data['secondaryId']!, _secondaryIdMeta));
    }
    if (data.containsKey('secondaryIdRef')) {
      context.handle(
          _secondaryIdRefMeta,
          secondaryIdRef.isAcceptableOrUnknown(
              data['secondaryIdRef']!, _secondaryIdRefMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('fileId')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['fileId']!, _fileIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {primaryId};
  @override
  AssociatedDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssociatedDataData(
      primaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}primaryId']),
      secondaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}secondaryId']),
      secondaryIdRef: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}secondaryIdRef']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fileId']),
    );
  }

  @override
  AssociatedData createAlias(String alias) {
    return AssociatedData(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class AssociatedDataData extends DataClass
    implements Insertable<AssociatedDataData> {
  final int? primaryId;
  final String? secondaryId;
  final String? secondaryIdRef;
  final String? type;
  final String? description;
  final String? fileId;
  const AssociatedDataData(
      {this.primaryId,
      this.secondaryId,
      this.secondaryIdRef,
      this.type,
      this.description,
      this.fileId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || primaryId != null) {
      map['primaryId'] = Variable<int>(primaryId);
    }
    if (!nullToAbsent || secondaryId != null) {
      map['secondaryId'] = Variable<String>(secondaryId);
    }
    if (!nullToAbsent || secondaryIdRef != null) {
      map['secondaryIdRef'] = Variable<String>(secondaryIdRef);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || fileId != null) {
      map['fileId'] = Variable<String>(fileId);
    }
    return map;
  }

  AssociatedDataCompanion toCompanion(bool nullToAbsent) {
    return AssociatedDataCompanion(
      primaryId: primaryId == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryId),
      secondaryId: secondaryId == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryId),
      secondaryIdRef: secondaryIdRef == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryIdRef),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      fileId:
          fileId == null && nullToAbsent ? const Value.absent() : Value(fileId),
    );
  }

  factory AssociatedDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssociatedDataData(
      primaryId: serializer.fromJson<int?>(json['primaryId']),
      secondaryId: serializer.fromJson<String?>(json['secondaryId']),
      secondaryIdRef: serializer.fromJson<String?>(json['secondaryIdRef']),
      type: serializer.fromJson<String?>(json['type']),
      description: serializer.fromJson<String?>(json['description']),
      fileId: serializer.fromJson<String?>(json['fileId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'primaryId': serializer.toJson<int?>(primaryId),
      'secondaryId': serializer.toJson<String?>(secondaryId),
      'secondaryIdRef': serializer.toJson<String?>(secondaryIdRef),
      'type': serializer.toJson<String?>(type),
      'description': serializer.toJson<String?>(description),
      'fileId': serializer.toJson<String?>(fileId),
    };
  }

  AssociatedDataData copyWith(
          {Value<int?> primaryId = const Value.absent(),
          Value<String?> secondaryId = const Value.absent(),
          Value<String?> secondaryIdRef = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> fileId = const Value.absent()}) =>
      AssociatedDataData(
        primaryId: primaryId.present ? primaryId.value : this.primaryId,
        secondaryId: secondaryId.present ? secondaryId.value : this.secondaryId,
        secondaryIdRef:
            secondaryIdRef.present ? secondaryIdRef.value : this.secondaryIdRef,
        type: type.present ? type.value : this.type,
        description: description.present ? description.value : this.description,
        fileId: fileId.present ? fileId.value : this.fileId,
      );
  @override
  String toString() {
    return (StringBuffer('AssociatedDataData(')
          ..write('primaryId: $primaryId, ')
          ..write('secondaryId: $secondaryId, ')
          ..write('secondaryIdRef: $secondaryIdRef, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('fileId: $fileId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      primaryId, secondaryId, secondaryIdRef, type, description, fileId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssociatedDataData &&
          other.primaryId == this.primaryId &&
          other.secondaryId == this.secondaryId &&
          other.secondaryIdRef == this.secondaryIdRef &&
          other.type == this.type &&
          other.description == this.description &&
          other.fileId == this.fileId);
}

class AssociatedDataCompanion extends UpdateCompanion<AssociatedDataData> {
  final Value<int?> primaryId;
  final Value<String?> secondaryId;
  final Value<String?> secondaryIdRef;
  final Value<String?> type;
  final Value<String?> description;
  final Value<String?> fileId;
  const AssociatedDataCompanion({
    this.primaryId = const Value.absent(),
    this.secondaryId = const Value.absent(),
    this.secondaryIdRef = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.fileId = const Value.absent(),
  });
  AssociatedDataCompanion.insert({
    this.primaryId = const Value.absent(),
    this.secondaryId = const Value.absent(),
    this.secondaryIdRef = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.fileId = const Value.absent(),
  });
  static Insertable<AssociatedDataData> custom({
    Expression<int>? primaryId,
    Expression<String>? secondaryId,
    Expression<String>? secondaryIdRef,
    Expression<String>? type,
    Expression<String>? description,
    Expression<String>? fileId,
  }) {
    return RawValuesInsertable({
      if (primaryId != null) 'primaryId': primaryId,
      if (secondaryId != null) 'secondaryId': secondaryId,
      if (secondaryIdRef != null) 'secondaryIdRef': secondaryIdRef,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (fileId != null) 'fileId': fileId,
    });
  }

  AssociatedDataCompanion copyWith(
      {Value<int?>? primaryId,
      Value<String?>? secondaryId,
      Value<String?>? secondaryIdRef,
      Value<String?>? type,
      Value<String?>? description,
      Value<String?>? fileId}) {
    return AssociatedDataCompanion(
      primaryId: primaryId ?? this.primaryId,
      secondaryId: secondaryId ?? this.secondaryId,
      secondaryIdRef: secondaryIdRef ?? this.secondaryIdRef,
      type: type ?? this.type,
      description: description ?? this.description,
      fileId: fileId ?? this.fileId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (primaryId.present) {
      map['primaryId'] = Variable<int>(primaryId.value);
    }
    if (secondaryId.present) {
      map['secondaryId'] = Variable<String>(secondaryId.value);
    }
    if (secondaryIdRef.present) {
      map['secondaryIdRef'] = Variable<String>(secondaryIdRef.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (fileId.present) {
      map['fileId'] = Variable<String>(fileId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssociatedDataCompanion(')
          ..write('primaryId: $primaryId, ')
          ..write('secondaryId: $secondaryId, ')
          ..write('secondaryIdRef: $secondaryIdRef, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('fileId: $fileId')
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
  static const VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String> projectUuid = GeneratedColumn<String>(
      'projectUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _personnelUuidMeta =
      const VerificationMeta('personnelUuid');
  late final GeneratedColumn<String> personnelUuid = GeneratedColumn<String>(
      'personnelUuid', aliasedName, true,
      type: DriftSqlType.string,
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PersonnelListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonnelListData(
      projectUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}projectUuid']),
      personnelUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}personnelUuid']),
    );
  }

  @override
  PersonnelList createAlias(String alias) {
    return PersonnelList(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(projectUuid)REFERENCES project(uuid)',
        'FOREIGN KEY(personnelUuid)REFERENCES personnel(uuid)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class PersonnelListData extends DataClass
    implements Insertable<PersonnelListData> {
  final String? projectUuid;
  final String? personnelUuid;
  const PersonnelListData({this.projectUuid, this.personnelUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String>(projectUuid);
    }
    if (!nullToAbsent || personnelUuid != null) {
      map['personnelUuid'] = Variable<String>(personnelUuid);
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

  PersonnelListData copyWith(
          {Value<String?> projectUuid = const Value.absent(),
          Value<String?> personnelUuid = const Value.absent()}) =>
      PersonnelListData(
        projectUuid: projectUuid.present ? projectUuid.value : this.projectUuid,
        personnelUuid:
            personnelUuid.present ? personnelUuid.value : this.personnelUuid,
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
  final Value<int> rowid;
  const PersonnelListCompanion({
    this.projectUuid = const Value.absent(),
    this.personnelUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonnelListCompanion.insert({
    this.projectUuid = const Value.absent(),
    this.personnelUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<PersonnelListData> custom({
    Expression<String>? projectUuid,
    Expression<String>? personnelUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (personnelUuid != null) 'personnelUuid': personnelUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonnelListCompanion copyWith(
      {Value<String?>? projectUuid,
      Value<String?>? personnelUuid,
      Value<int>? rowid}) {
    return PersonnelListCompanion(
      projectUuid: projectUuid ?? this.projectUuid,
      personnelUuid: personnelUuid ?? this.personnelUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String>(projectUuid.value);
    }
    if (personnelUuid.present) {
      map['personnelUuid'] = Variable<String>(personnelUuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonnelListCompanion(')
          ..write('projectUuid: $projectUuid, ')
          ..write('personnelUuid: $personnelUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ProjectPersonnel extends Table
    with TableInfo<ProjectPersonnel, ProjectPersonnelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ProjectPersonnel(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String> projectUuid = GeneratedColumn<String>(
      'projectUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _personnelIdMeta =
      const VerificationMeta('personnelId');
  late final GeneratedColumn<String> personnelId = GeneratedColumn<String>(
      'personnelId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [projectUuid, personnelId];
  @override
  String get aliasedName => _alias ?? 'projectPersonnel';
  @override
  String get actualTableName => 'projectPersonnel';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProjectPersonnelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('projectUuid')) {
      context.handle(
          _projectUuidMeta,
          projectUuid.isAcceptableOrUnknown(
              data['projectUuid']!, _projectUuidMeta));
    }
    if (data.containsKey('personnelId')) {
      context.handle(
          _personnelIdMeta,
          personnelId.isAcceptableOrUnknown(
              data['personnelId']!, _personnelIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ProjectPersonnelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectPersonnelData(
      projectUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}projectUuid']),
      personnelId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}personnelId']),
    );
  }

  @override
  ProjectPersonnel createAlias(String alias) {
    return ProjectPersonnel(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(projectUuid)REFERENCES project(uuid)',
        'FOREIGN KEY(personnelId)REFERENCES personnel(uuid)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class ProjectPersonnelData extends DataClass
    implements Insertable<ProjectPersonnelData> {
  final String? projectUuid;
  final String? personnelId;
  const ProjectPersonnelData({this.projectUuid, this.personnelId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String>(projectUuid);
    }
    if (!nullToAbsent || personnelId != null) {
      map['personnelId'] = Variable<String>(personnelId);
    }
    return map;
  }

  ProjectPersonnelCompanion toCompanion(bool nullToAbsent) {
    return ProjectPersonnelCompanion(
      projectUuid: projectUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(projectUuid),
      personnelId: personnelId == null && nullToAbsent
          ? const Value.absent()
          : Value(personnelId),
    );
  }

  factory ProjectPersonnelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectPersonnelData(
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      personnelId: serializer.fromJson<String?>(json['personnelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'personnelId': serializer.toJson<String?>(personnelId),
    };
  }

  ProjectPersonnelData copyWith(
          {Value<String?> projectUuid = const Value.absent(),
          Value<String?> personnelId = const Value.absent()}) =>
      ProjectPersonnelData(
        projectUuid: projectUuid.present ? projectUuid.value : this.projectUuid,
        personnelId: personnelId.present ? personnelId.value : this.personnelId,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectPersonnelData(')
          ..write('projectUuid: $projectUuid, ')
          ..write('personnelId: $personnelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(projectUuid, personnelId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectPersonnelData &&
          other.projectUuid == this.projectUuid &&
          other.personnelId == this.personnelId);
}

class ProjectPersonnelCompanion extends UpdateCompanion<ProjectPersonnelData> {
  final Value<String?> projectUuid;
  final Value<String?> personnelId;
  final Value<int> rowid;
  const ProjectPersonnelCompanion({
    this.projectUuid = const Value.absent(),
    this.personnelId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectPersonnelCompanion.insert({
    this.projectUuid = const Value.absent(),
    this.personnelId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<ProjectPersonnelData> custom({
    Expression<String>? projectUuid,
    Expression<String>? personnelId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (personnelId != null) 'personnelId': personnelId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectPersonnelCompanion copyWith(
      {Value<String?>? projectUuid,
      Value<String?>? personnelId,
      Value<int>? rowid}) {
    return ProjectPersonnelCompanion(
      projectUuid: projectUuid ?? this.projectUuid,
      personnelId: personnelId ?? this.personnelId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String>(projectUuid.value);
    }
    if (personnelId.present) {
      map['personnelId'] = Variable<String>(personnelId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectPersonnelCompanion(')
          ..write('projectUuid: $projectUuid, ')
          ..write('personnelId: $personnelId, ')
          ..write('rowid: $rowid')
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
  static const VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String> specimenUuid = GeneratedColumn<String>(
      'specimenUuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _totalLengthMeta =
      const VerificationMeta('totalLength');
  late final GeneratedColumn<double> totalLength = GeneratedColumn<double>(
      'totalLength', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tailLengthMeta =
      const VerificationMeta('tailLength');
  late final GeneratedColumn<double> tailLength = GeneratedColumn<double>(
      'tailLength', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _hindFootLengthMeta =
      const VerificationMeta('hindFootLength');
  late final GeneratedColumn<double> hindFootLength = GeneratedColumn<double>(
      'hindFootLength', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _earLengthMeta =
      const VerificationMeta('earLength');
  late final GeneratedColumn<double> earLength = GeneratedColumn<double>(
      'earLength', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _forearmMeta =
      const VerificationMeta('forearm');
  late final GeneratedColumn<double> forearm = GeneratedColumn<double>(
      'forearm', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _accuracyMeta =
      const VerificationMeta('accuracy');
  late final GeneratedColumn<String> accuracy = GeneratedColumn<String>(
      'accuracy', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _accuracySpecifyMeta =
      const VerificationMeta('accuracySpecify');
  late final GeneratedColumn<String> accuracySpecify = GeneratedColumn<String>(
      'accuracySpecify', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumn<int> sex = GeneratedColumn<int>(
      'sex', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _testisPositionMeta =
      const VerificationMeta('testisPosition');
  late final GeneratedColumn<int> testisPosition = GeneratedColumn<int>(
      'testisPosition', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _testisLengthMeta =
      const VerificationMeta('testisLength');
  late final GeneratedColumn<double> testisLength = GeneratedColumn<double>(
      'testisLength', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _testisWidthMeta =
      const VerificationMeta('testisWidth');
  late final GeneratedColumn<double> testisWidth = GeneratedColumn<double>(
      'testisWidth', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _epididymisAppearanceMeta =
      const VerificationMeta('epididymisAppearance');
  late final GeneratedColumn<int> epididymisAppearance = GeneratedColumn<int>(
      'epididymisAppearance', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _reproductiveStageMeta =
      const VerificationMeta('reproductiveStage');
  late final GeneratedColumn<int> reproductiveStage = GeneratedColumn<int>(
      'reproductiveStage', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _leftPlacentalScarsMeta =
      const VerificationMeta('leftPlacentalScars');
  late final GeneratedColumn<int> leftPlacentalScars = GeneratedColumn<int>(
      'leftPlacentalScars', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _rightPlacentalScarsMeta =
      const VerificationMeta('rightPlacentalScars');
  late final GeneratedColumn<int> rightPlacentalScars = GeneratedColumn<int>(
      'rightPlacentalScars', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _mammaeConditionMeta =
      const VerificationMeta('mammaeCondition');
  late final GeneratedColumn<int> mammaeCondition = GeneratedColumn<int>(
      'mammaeCondition', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _mammaeInguinalCountMeta =
      const VerificationMeta('mammaeInguinalCount');
  late final GeneratedColumn<int> mammaeInguinalCount = GeneratedColumn<int>(
      'mammaeInguinalCount', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _mammaeAxillaryCountMeta =
      const VerificationMeta('mammaeAxillaryCount');
  late final GeneratedColumn<int> mammaeAxillaryCount = GeneratedColumn<int>(
      'mammaeAxillaryCount', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _mammaeAbdominalCountMeta =
      const VerificationMeta('mammaeAbdominalCount');
  late final GeneratedColumn<int> mammaeAbdominalCount = GeneratedColumn<int>(
      'mammaeAbdominalCount', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _vaginaOpeningMeta =
      const VerificationMeta('vaginaOpening');
  late final GeneratedColumn<int> vaginaOpening = GeneratedColumn<int>(
      'vaginaOpening', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _pubicSymphysisMeta =
      const VerificationMeta('pubicSymphysis');
  late final GeneratedColumn<int> pubicSymphysis = GeneratedColumn<int>(
      'pubicSymphysis', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _embryoLeftCountMeta =
      const VerificationMeta('embryoLeftCount');
  late final GeneratedColumn<int> embryoLeftCount = GeneratedColumn<int>(
      'embryoLeftCount', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _embryoRightCountMeta =
      const VerificationMeta('embryoRightCount');
  late final GeneratedColumn<int> embryoRightCount = GeneratedColumn<int>(
      'embryoRightCount', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _embryoCRMeta =
      const VerificationMeta('embryoCR');
  late final GeneratedColumn<int> embryoCR = GeneratedColumn<int>(
      'embryoCR', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        specimenUuid,
        totalLength,
        tailLength,
        hindFootLength,
        earLength,
        forearm,
        weight,
        accuracy,
        accuracySpecify,
        sex,
        age,
        testisPosition,
        testisLength,
        testisWidth,
        epididymisAppearance,
        reproductiveStage,
        leftPlacentalScars,
        rightPlacentalScars,
        mammaeCondition,
        mammaeInguinalCount,
        mammaeAxillaryCount,
        mammaeAbdominalCount,
        vaginaOpening,
        pubicSymphysis,
        embryoLeftCount,
        embryoRightCount,
        embryoCR,
        remark
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
    if (data.containsKey('specimenUuid')) {
      context.handle(
          _specimenUuidMeta,
          specimenUuid.isAcceptableOrUnknown(
              data['specimenUuid']!, _specimenUuidMeta));
    } else if (isInserting) {
      context.missing(_specimenUuidMeta);
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
    if (data.containsKey('accuracy')) {
      context.handle(_accuracyMeta,
          accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta));
    }
    if (data.containsKey('accuracySpecify')) {
      context.handle(
          _accuracySpecifyMeta,
          accuracySpecify.isAcceptableOrUnknown(
              data['accuracySpecify']!, _accuracySpecifyMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
          _sexMeta, sex.isAcceptableOrUnknown(data['sex']!, _sexMeta));
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('testisPosition')) {
      context.handle(
          _testisPositionMeta,
          testisPosition.isAcceptableOrUnknown(
              data['testisPosition']!, _testisPositionMeta));
    }
    if (data.containsKey('testisLength')) {
      context.handle(
          _testisLengthMeta,
          testisLength.isAcceptableOrUnknown(
              data['testisLength']!, _testisLengthMeta));
    }
    if (data.containsKey('testisWidth')) {
      context.handle(
          _testisWidthMeta,
          testisWidth.isAcceptableOrUnknown(
              data['testisWidth']!, _testisWidthMeta));
    }
    if (data.containsKey('epididymisAppearance')) {
      context.handle(
          _epididymisAppearanceMeta,
          epididymisAppearance.isAcceptableOrUnknown(
              data['epididymisAppearance']!, _epididymisAppearanceMeta));
    }
    if (data.containsKey('reproductiveStage')) {
      context.handle(
          _reproductiveStageMeta,
          reproductiveStage.isAcceptableOrUnknown(
              data['reproductiveStage']!, _reproductiveStageMeta));
    }
    if (data.containsKey('leftPlacentalScars')) {
      context.handle(
          _leftPlacentalScarsMeta,
          leftPlacentalScars.isAcceptableOrUnknown(
              data['leftPlacentalScars']!, _leftPlacentalScarsMeta));
    }
    if (data.containsKey('rightPlacentalScars')) {
      context.handle(
          _rightPlacentalScarsMeta,
          rightPlacentalScars.isAcceptableOrUnknown(
              data['rightPlacentalScars']!, _rightPlacentalScarsMeta));
    }
    if (data.containsKey('mammaeCondition')) {
      context.handle(
          _mammaeConditionMeta,
          mammaeCondition.isAcceptableOrUnknown(
              data['mammaeCondition']!, _mammaeConditionMeta));
    }
    if (data.containsKey('mammaeInguinalCount')) {
      context.handle(
          _mammaeInguinalCountMeta,
          mammaeInguinalCount.isAcceptableOrUnknown(
              data['mammaeInguinalCount']!, _mammaeInguinalCountMeta));
    }
    if (data.containsKey('mammaeAxillaryCount')) {
      context.handle(
          _mammaeAxillaryCountMeta,
          mammaeAxillaryCount.isAcceptableOrUnknown(
              data['mammaeAxillaryCount']!, _mammaeAxillaryCountMeta));
    }
    if (data.containsKey('mammaeAbdominalCount')) {
      context.handle(
          _mammaeAbdominalCountMeta,
          mammaeAbdominalCount.isAcceptableOrUnknown(
              data['mammaeAbdominalCount']!, _mammaeAbdominalCountMeta));
    }
    if (data.containsKey('vaginaOpening')) {
      context.handle(
          _vaginaOpeningMeta,
          vaginaOpening.isAcceptableOrUnknown(
              data['vaginaOpening']!, _vaginaOpeningMeta));
    }
    if (data.containsKey('pubicSymphysis')) {
      context.handle(
          _pubicSymphysisMeta,
          pubicSymphysis.isAcceptableOrUnknown(
              data['pubicSymphysis']!, _pubicSymphysisMeta));
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
    if (data.containsKey('embryoCR')) {
      context.handle(_embryoCRMeta,
          embryoCR.isAcceptableOrUnknown(data['embryoCR']!, _embryoCRMeta));
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MammalMeasurementData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MammalMeasurementData(
      specimenUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specimenUuid'])!,
      totalLength: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}totalLength']),
      tailLength: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tailLength']),
      hindFootLength: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hindFootLength']),
      earLength: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}earLength']),
      forearm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}forearm']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      accuracy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}accuracy']),
      accuracySpecify: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}accuracySpecify']),
      sex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sex']),
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age']),
      testisPosition: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}testisPosition']),
      testisLength: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}testisLength']),
      testisWidth: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}testisWidth']),
      epididymisAppearance: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}epididymisAppearance']),
      reproductiveStage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reproductiveStage']),
      leftPlacentalScars: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}leftPlacentalScars']),
      rightPlacentalScars: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}rightPlacentalScars']),
      mammaeCondition: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mammaeCondition']),
      mammaeInguinalCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}mammaeInguinalCount']),
      mammaeAxillaryCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}mammaeAxillaryCount']),
      mammaeAbdominalCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}mammaeAbdominalCount']),
      vaginaOpening: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vaginaOpening']),
      pubicSymphysis: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pubicSymphysis']),
      embryoLeftCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}embryoLeftCount']),
      embryoRightCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}embryoRightCount']),
      embryoCR: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}embryoCR']),
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
    );
  }

  @override
  MammalMeasurement createAlias(String alias) {
    return MammalMeasurement(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(specimenUuid)REFERENCES specimen(uuid)'];
  @override
  bool get dontWriteConstraints => true;
}

class MammalMeasurementData extends DataClass
    implements Insertable<MammalMeasurementData> {
  final String specimenUuid;
  final double? totalLength;
  final double? tailLength;
  final double? hindFootLength;
  final double? earLength;
  final double? forearm;
  final double? weight;
  final String? accuracy;
  final String? accuracySpecify;
  final int? sex;
  final int? age;
  final int? testisPosition;

  /// encode using enum
  final double? testisLength;
  final double? testisWidth;
  final int? epididymisAppearance;
  final int? reproductiveStage;
  final int? leftPlacentalScars;
  final int? rightPlacentalScars;
  final int? mammaeCondition;
  final int? mammaeInguinalCount;
  final int? mammaeAxillaryCount;
  final int? mammaeAbdominalCount;
  final int? vaginaOpening;
  final int? pubicSymphysis;
  final int? embryoLeftCount;
  final int? embryoRightCount;
  final int? embryoCR;
  final String? remark;
  const MammalMeasurementData(
      {required this.specimenUuid,
      this.totalLength,
      this.tailLength,
      this.hindFootLength,
      this.earLength,
      this.forearm,
      this.weight,
      this.accuracy,
      this.accuracySpecify,
      this.sex,
      this.age,
      this.testisPosition,
      this.testisLength,
      this.testisWidth,
      this.epididymisAppearance,
      this.reproductiveStage,
      this.leftPlacentalScars,
      this.rightPlacentalScars,
      this.mammaeCondition,
      this.mammaeInguinalCount,
      this.mammaeAxillaryCount,
      this.mammaeAbdominalCount,
      this.vaginaOpening,
      this.pubicSymphysis,
      this.embryoLeftCount,
      this.embryoRightCount,
      this.embryoCR,
      this.remark});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['specimenUuid'] = Variable<String>(specimenUuid);
    if (!nullToAbsent || totalLength != null) {
      map['totalLength'] = Variable<double>(totalLength);
    }
    if (!nullToAbsent || tailLength != null) {
      map['tailLength'] = Variable<double>(tailLength);
    }
    if (!nullToAbsent || hindFootLength != null) {
      map['hindFootLength'] = Variable<double>(hindFootLength);
    }
    if (!nullToAbsent || earLength != null) {
      map['earLength'] = Variable<double>(earLength);
    }
    if (!nullToAbsent || forearm != null) {
      map['forearm'] = Variable<double>(forearm);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<String>(accuracy);
    }
    if (!nullToAbsent || accuracySpecify != null) {
      map['accuracySpecify'] = Variable<String>(accuracySpecify);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<int>(sex);
    }
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || testisPosition != null) {
      map['testisPosition'] = Variable<int>(testisPosition);
    }
    if (!nullToAbsent || testisLength != null) {
      map['testisLength'] = Variable<double>(testisLength);
    }
    if (!nullToAbsent || testisWidth != null) {
      map['testisWidth'] = Variable<double>(testisWidth);
    }
    if (!nullToAbsent || epididymisAppearance != null) {
      map['epididymisAppearance'] = Variable<int>(epididymisAppearance);
    }
    if (!nullToAbsent || reproductiveStage != null) {
      map['reproductiveStage'] = Variable<int>(reproductiveStage);
    }
    if (!nullToAbsent || leftPlacentalScars != null) {
      map['leftPlacentalScars'] = Variable<int>(leftPlacentalScars);
    }
    if (!nullToAbsent || rightPlacentalScars != null) {
      map['rightPlacentalScars'] = Variable<int>(rightPlacentalScars);
    }
    if (!nullToAbsent || mammaeCondition != null) {
      map['mammaeCondition'] = Variable<int>(mammaeCondition);
    }
    if (!nullToAbsent || mammaeInguinalCount != null) {
      map['mammaeInguinalCount'] = Variable<int>(mammaeInguinalCount);
    }
    if (!nullToAbsent || mammaeAxillaryCount != null) {
      map['mammaeAxillaryCount'] = Variable<int>(mammaeAxillaryCount);
    }
    if (!nullToAbsent || mammaeAbdominalCount != null) {
      map['mammaeAbdominalCount'] = Variable<int>(mammaeAbdominalCount);
    }
    if (!nullToAbsent || vaginaOpening != null) {
      map['vaginaOpening'] = Variable<int>(vaginaOpening);
    }
    if (!nullToAbsent || pubicSymphysis != null) {
      map['pubicSymphysis'] = Variable<int>(pubicSymphysis);
    }
    if (!nullToAbsent || embryoLeftCount != null) {
      map['embryoLeftCount'] = Variable<int>(embryoLeftCount);
    }
    if (!nullToAbsent || embryoRightCount != null) {
      map['embryoRightCount'] = Variable<int>(embryoRightCount);
    }
    if (!nullToAbsent || embryoCR != null) {
      map['embryoCR'] = Variable<int>(embryoCR);
    }
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    return map;
  }

  MammalMeasurementCompanion toCompanion(bool nullToAbsent) {
    return MammalMeasurementCompanion(
      specimenUuid: Value(specimenUuid),
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
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      accuracySpecify: accuracySpecify == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracySpecify),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      testisPosition: testisPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(testisPosition),
      testisLength: testisLength == null && nullToAbsent
          ? const Value.absent()
          : Value(testisLength),
      testisWidth: testisWidth == null && nullToAbsent
          ? const Value.absent()
          : Value(testisWidth),
      epididymisAppearance: epididymisAppearance == null && nullToAbsent
          ? const Value.absent()
          : Value(epididymisAppearance),
      reproductiveStage: reproductiveStage == null && nullToAbsent
          ? const Value.absent()
          : Value(reproductiveStage),
      leftPlacentalScars: leftPlacentalScars == null && nullToAbsent
          ? const Value.absent()
          : Value(leftPlacentalScars),
      rightPlacentalScars: rightPlacentalScars == null && nullToAbsent
          ? const Value.absent()
          : Value(rightPlacentalScars),
      mammaeCondition: mammaeCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(mammaeCondition),
      mammaeInguinalCount: mammaeInguinalCount == null && nullToAbsent
          ? const Value.absent()
          : Value(mammaeInguinalCount),
      mammaeAxillaryCount: mammaeAxillaryCount == null && nullToAbsent
          ? const Value.absent()
          : Value(mammaeAxillaryCount),
      mammaeAbdominalCount: mammaeAbdominalCount == null && nullToAbsent
          ? const Value.absent()
          : Value(mammaeAbdominalCount),
      vaginaOpening: vaginaOpening == null && nullToAbsent
          ? const Value.absent()
          : Value(vaginaOpening),
      pubicSymphysis: pubicSymphysis == null && nullToAbsent
          ? const Value.absent()
          : Value(pubicSymphysis),
      embryoLeftCount: embryoLeftCount == null && nullToAbsent
          ? const Value.absent()
          : Value(embryoLeftCount),
      embryoRightCount: embryoRightCount == null && nullToAbsent
          ? const Value.absent()
          : Value(embryoRightCount),
      embryoCR: embryoCR == null && nullToAbsent
          ? const Value.absent()
          : Value(embryoCR),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
    );
  }

  factory MammalMeasurementData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MammalMeasurementData(
      specimenUuid: serializer.fromJson<String>(json['specimenUuid']),
      totalLength: serializer.fromJson<double?>(json['totalLength']),
      tailLength: serializer.fromJson<double?>(json['tailLength']),
      hindFootLength: serializer.fromJson<double?>(json['hindFootLength']),
      earLength: serializer.fromJson<double?>(json['earLength']),
      forearm: serializer.fromJson<double?>(json['forearm']),
      weight: serializer.fromJson<double?>(json['weight']),
      accuracy: serializer.fromJson<String?>(json['accuracy']),
      accuracySpecify: serializer.fromJson<String?>(json['accuracySpecify']),
      sex: serializer.fromJson<int?>(json['sex']),
      age: serializer.fromJson<int?>(json['age']),
      testisPosition: serializer.fromJson<int?>(json['testisPosition']),
      testisLength: serializer.fromJson<double?>(json['testisLength']),
      testisWidth: serializer.fromJson<double?>(json['testisWidth']),
      epididymisAppearance:
          serializer.fromJson<int?>(json['epididymisAppearance']),
      reproductiveStage: serializer.fromJson<int?>(json['reproductiveStage']),
      leftPlacentalScars: serializer.fromJson<int?>(json['leftPlacentalScars']),
      rightPlacentalScars:
          serializer.fromJson<int?>(json['rightPlacentalScars']),
      mammaeCondition: serializer.fromJson<int?>(json['mammaeCondition']),
      mammaeInguinalCount:
          serializer.fromJson<int?>(json['mammaeInguinalCount']),
      mammaeAxillaryCount:
          serializer.fromJson<int?>(json['mammaeAxillaryCount']),
      mammaeAbdominalCount:
          serializer.fromJson<int?>(json['mammaeAbdominalCount']),
      vaginaOpening: serializer.fromJson<int?>(json['vaginaOpening']),
      pubicSymphysis: serializer.fromJson<int?>(json['pubicSymphysis']),
      embryoLeftCount: serializer.fromJson<int?>(json['embryoLeftCount']),
      embryoRightCount: serializer.fromJson<int?>(json['embryoRightCount']),
      embryoCR: serializer.fromJson<int?>(json['embryoCR']),
      remark: serializer.fromJson<String?>(json['remark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'specimenUuid': serializer.toJson<String>(specimenUuid),
      'totalLength': serializer.toJson<double?>(totalLength),
      'tailLength': serializer.toJson<double?>(tailLength),
      'hindFootLength': serializer.toJson<double?>(hindFootLength),
      'earLength': serializer.toJson<double?>(earLength),
      'forearm': serializer.toJson<double?>(forearm),
      'weight': serializer.toJson<double?>(weight),
      'accuracy': serializer.toJson<String?>(accuracy),
      'accuracySpecify': serializer.toJson<String?>(accuracySpecify),
      'sex': serializer.toJson<int?>(sex),
      'age': serializer.toJson<int?>(age),
      'testisPosition': serializer.toJson<int?>(testisPosition),
      'testisLength': serializer.toJson<double?>(testisLength),
      'testisWidth': serializer.toJson<double?>(testisWidth),
      'epididymisAppearance': serializer.toJson<int?>(epididymisAppearance),
      'reproductiveStage': serializer.toJson<int?>(reproductiveStage),
      'leftPlacentalScars': serializer.toJson<int?>(leftPlacentalScars),
      'rightPlacentalScars': serializer.toJson<int?>(rightPlacentalScars),
      'mammaeCondition': serializer.toJson<int?>(mammaeCondition),
      'mammaeInguinalCount': serializer.toJson<int?>(mammaeInguinalCount),
      'mammaeAxillaryCount': serializer.toJson<int?>(mammaeAxillaryCount),
      'mammaeAbdominalCount': serializer.toJson<int?>(mammaeAbdominalCount),
      'vaginaOpening': serializer.toJson<int?>(vaginaOpening),
      'pubicSymphysis': serializer.toJson<int?>(pubicSymphysis),
      'embryoLeftCount': serializer.toJson<int?>(embryoLeftCount),
      'embryoRightCount': serializer.toJson<int?>(embryoRightCount),
      'embryoCR': serializer.toJson<int?>(embryoCR),
      'remark': serializer.toJson<String?>(remark),
    };
  }

  MammalMeasurementData copyWith(
          {String? specimenUuid,
          Value<double?> totalLength = const Value.absent(),
          Value<double?> tailLength = const Value.absent(),
          Value<double?> hindFootLength = const Value.absent(),
          Value<double?> earLength = const Value.absent(),
          Value<double?> forearm = const Value.absent(),
          Value<double?> weight = const Value.absent(),
          Value<String?> accuracy = const Value.absent(),
          Value<String?> accuracySpecify = const Value.absent(),
          Value<int?> sex = const Value.absent(),
          Value<int?> age = const Value.absent(),
          Value<int?> testisPosition = const Value.absent(),
          Value<double?> testisLength = const Value.absent(),
          Value<double?> testisWidth = const Value.absent(),
          Value<int?> epididymisAppearance = const Value.absent(),
          Value<int?> reproductiveStage = const Value.absent(),
          Value<int?> leftPlacentalScars = const Value.absent(),
          Value<int?> rightPlacentalScars = const Value.absent(),
          Value<int?> mammaeCondition = const Value.absent(),
          Value<int?> mammaeInguinalCount = const Value.absent(),
          Value<int?> mammaeAxillaryCount = const Value.absent(),
          Value<int?> mammaeAbdominalCount = const Value.absent(),
          Value<int?> vaginaOpening = const Value.absent(),
          Value<int?> pubicSymphysis = const Value.absent(),
          Value<int?> embryoLeftCount = const Value.absent(),
          Value<int?> embryoRightCount = const Value.absent(),
          Value<int?> embryoCR = const Value.absent(),
          Value<String?> remark = const Value.absent()}) =>
      MammalMeasurementData(
        specimenUuid: specimenUuid ?? this.specimenUuid,
        totalLength: totalLength.present ? totalLength.value : this.totalLength,
        tailLength: tailLength.present ? tailLength.value : this.tailLength,
        hindFootLength:
            hindFootLength.present ? hindFootLength.value : this.hindFootLength,
        earLength: earLength.present ? earLength.value : this.earLength,
        forearm: forearm.present ? forearm.value : this.forearm,
        weight: weight.present ? weight.value : this.weight,
        accuracy: accuracy.present ? accuracy.value : this.accuracy,
        accuracySpecify: accuracySpecify.present
            ? accuracySpecify.value
            : this.accuracySpecify,
        sex: sex.present ? sex.value : this.sex,
        age: age.present ? age.value : this.age,
        testisPosition:
            testisPosition.present ? testisPosition.value : this.testisPosition,
        testisLength:
            testisLength.present ? testisLength.value : this.testisLength,
        testisWidth: testisWidth.present ? testisWidth.value : this.testisWidth,
        epididymisAppearance: epididymisAppearance.present
            ? epididymisAppearance.value
            : this.epididymisAppearance,
        reproductiveStage: reproductiveStage.present
            ? reproductiveStage.value
            : this.reproductiveStage,
        leftPlacentalScars: leftPlacentalScars.present
            ? leftPlacentalScars.value
            : this.leftPlacentalScars,
        rightPlacentalScars: rightPlacentalScars.present
            ? rightPlacentalScars.value
            : this.rightPlacentalScars,
        mammaeCondition: mammaeCondition.present
            ? mammaeCondition.value
            : this.mammaeCondition,
        mammaeInguinalCount: mammaeInguinalCount.present
            ? mammaeInguinalCount.value
            : this.mammaeInguinalCount,
        mammaeAxillaryCount: mammaeAxillaryCount.present
            ? mammaeAxillaryCount.value
            : this.mammaeAxillaryCount,
        mammaeAbdominalCount: mammaeAbdominalCount.present
            ? mammaeAbdominalCount.value
            : this.mammaeAbdominalCount,
        vaginaOpening:
            vaginaOpening.present ? vaginaOpening.value : this.vaginaOpening,
        pubicSymphysis:
            pubicSymphysis.present ? pubicSymphysis.value : this.pubicSymphysis,
        embryoLeftCount: embryoLeftCount.present
            ? embryoLeftCount.value
            : this.embryoLeftCount,
        embryoRightCount: embryoRightCount.present
            ? embryoRightCount.value
            : this.embryoRightCount,
        embryoCR: embryoCR.present ? embryoCR.value : this.embryoCR,
        remark: remark.present ? remark.value : this.remark,
      );
  @override
  String toString() {
    return (StringBuffer('MammalMeasurementData(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('totalLength: $totalLength, ')
          ..write('tailLength: $tailLength, ')
          ..write('hindFootLength: $hindFootLength, ')
          ..write('earLength: $earLength, ')
          ..write('forearm: $forearm, ')
          ..write('weight: $weight, ')
          ..write('accuracy: $accuracy, ')
          ..write('accuracySpecify: $accuracySpecify, ')
          ..write('sex: $sex, ')
          ..write('age: $age, ')
          ..write('testisPosition: $testisPosition, ')
          ..write('testisLength: $testisLength, ')
          ..write('testisWidth: $testisWidth, ')
          ..write('epididymisAppearance: $epididymisAppearance, ')
          ..write('reproductiveStage: $reproductiveStage, ')
          ..write('leftPlacentalScars: $leftPlacentalScars, ')
          ..write('rightPlacentalScars: $rightPlacentalScars, ')
          ..write('mammaeCondition: $mammaeCondition, ')
          ..write('mammaeInguinalCount: $mammaeInguinalCount, ')
          ..write('mammaeAxillaryCount: $mammaeAxillaryCount, ')
          ..write('mammaeAbdominalCount: $mammaeAbdominalCount, ')
          ..write('vaginaOpening: $vaginaOpening, ')
          ..write('pubicSymphysis: $pubicSymphysis, ')
          ..write('embryoLeftCount: $embryoLeftCount, ')
          ..write('embryoRightCount: $embryoRightCount, ')
          ..write('embryoCR: $embryoCR, ')
          ..write('remark: $remark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        specimenUuid,
        totalLength,
        tailLength,
        hindFootLength,
        earLength,
        forearm,
        weight,
        accuracy,
        accuracySpecify,
        sex,
        age,
        testisPosition,
        testisLength,
        testisWidth,
        epididymisAppearance,
        reproductiveStage,
        leftPlacentalScars,
        rightPlacentalScars,
        mammaeCondition,
        mammaeInguinalCount,
        mammaeAxillaryCount,
        mammaeAbdominalCount,
        vaginaOpening,
        pubicSymphysis,
        embryoLeftCount,
        embryoRightCount,
        embryoCR,
        remark
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MammalMeasurementData &&
          other.specimenUuid == this.specimenUuid &&
          other.totalLength == this.totalLength &&
          other.tailLength == this.tailLength &&
          other.hindFootLength == this.hindFootLength &&
          other.earLength == this.earLength &&
          other.forearm == this.forearm &&
          other.weight == this.weight &&
          other.accuracy == this.accuracy &&
          other.accuracySpecify == this.accuracySpecify &&
          other.sex == this.sex &&
          other.age == this.age &&
          other.testisPosition == this.testisPosition &&
          other.testisLength == this.testisLength &&
          other.testisWidth == this.testisWidth &&
          other.epididymisAppearance == this.epididymisAppearance &&
          other.reproductiveStage == this.reproductiveStage &&
          other.leftPlacentalScars == this.leftPlacentalScars &&
          other.rightPlacentalScars == this.rightPlacentalScars &&
          other.mammaeCondition == this.mammaeCondition &&
          other.mammaeInguinalCount == this.mammaeInguinalCount &&
          other.mammaeAxillaryCount == this.mammaeAxillaryCount &&
          other.mammaeAbdominalCount == this.mammaeAbdominalCount &&
          other.vaginaOpening == this.vaginaOpening &&
          other.pubicSymphysis == this.pubicSymphysis &&
          other.embryoLeftCount == this.embryoLeftCount &&
          other.embryoRightCount == this.embryoRightCount &&
          other.embryoCR == this.embryoCR &&
          other.remark == this.remark);
}

class MammalMeasurementCompanion
    extends UpdateCompanion<MammalMeasurementData> {
  final Value<String> specimenUuid;
  final Value<double?> totalLength;
  final Value<double?> tailLength;
  final Value<double?> hindFootLength;
  final Value<double?> earLength;
  final Value<double?> forearm;
  final Value<double?> weight;
  final Value<String?> accuracy;
  final Value<String?> accuracySpecify;
  final Value<int?> sex;
  final Value<int?> age;
  final Value<int?> testisPosition;
  final Value<double?> testisLength;
  final Value<double?> testisWidth;
  final Value<int?> epididymisAppearance;
  final Value<int?> reproductiveStage;
  final Value<int?> leftPlacentalScars;
  final Value<int?> rightPlacentalScars;
  final Value<int?> mammaeCondition;
  final Value<int?> mammaeInguinalCount;
  final Value<int?> mammaeAxillaryCount;
  final Value<int?> mammaeAbdominalCount;
  final Value<int?> vaginaOpening;
  final Value<int?> pubicSymphysis;
  final Value<int?> embryoLeftCount;
  final Value<int?> embryoRightCount;
  final Value<int?> embryoCR;
  final Value<String?> remark;
  final Value<int> rowid;
  const MammalMeasurementCompanion({
    this.specimenUuid = const Value.absent(),
    this.totalLength = const Value.absent(),
    this.tailLength = const Value.absent(),
    this.hindFootLength = const Value.absent(),
    this.earLength = const Value.absent(),
    this.forearm = const Value.absent(),
    this.weight = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.accuracySpecify = const Value.absent(),
    this.sex = const Value.absent(),
    this.age = const Value.absent(),
    this.testisPosition = const Value.absent(),
    this.testisLength = const Value.absent(),
    this.testisWidth = const Value.absent(),
    this.epididymisAppearance = const Value.absent(),
    this.reproductiveStage = const Value.absent(),
    this.leftPlacentalScars = const Value.absent(),
    this.rightPlacentalScars = const Value.absent(),
    this.mammaeCondition = const Value.absent(),
    this.mammaeInguinalCount = const Value.absent(),
    this.mammaeAxillaryCount = const Value.absent(),
    this.mammaeAbdominalCount = const Value.absent(),
    this.vaginaOpening = const Value.absent(),
    this.pubicSymphysis = const Value.absent(),
    this.embryoLeftCount = const Value.absent(),
    this.embryoRightCount = const Value.absent(),
    this.embryoCR = const Value.absent(),
    this.remark = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MammalMeasurementCompanion.insert({
    required String specimenUuid,
    this.totalLength = const Value.absent(),
    this.tailLength = const Value.absent(),
    this.hindFootLength = const Value.absent(),
    this.earLength = const Value.absent(),
    this.forearm = const Value.absent(),
    this.weight = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.accuracySpecify = const Value.absent(),
    this.sex = const Value.absent(),
    this.age = const Value.absent(),
    this.testisPosition = const Value.absent(),
    this.testisLength = const Value.absent(),
    this.testisWidth = const Value.absent(),
    this.epididymisAppearance = const Value.absent(),
    this.reproductiveStage = const Value.absent(),
    this.leftPlacentalScars = const Value.absent(),
    this.rightPlacentalScars = const Value.absent(),
    this.mammaeCondition = const Value.absent(),
    this.mammaeInguinalCount = const Value.absent(),
    this.mammaeAxillaryCount = const Value.absent(),
    this.mammaeAbdominalCount = const Value.absent(),
    this.vaginaOpening = const Value.absent(),
    this.pubicSymphysis = const Value.absent(),
    this.embryoLeftCount = const Value.absent(),
    this.embryoRightCount = const Value.absent(),
    this.embryoCR = const Value.absent(),
    this.remark = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : specimenUuid = Value(specimenUuid);
  static Insertable<MammalMeasurementData> custom({
    Expression<String>? specimenUuid,
    Expression<double>? totalLength,
    Expression<double>? tailLength,
    Expression<double>? hindFootLength,
    Expression<double>? earLength,
    Expression<double>? forearm,
    Expression<double>? weight,
    Expression<String>? accuracy,
    Expression<String>? accuracySpecify,
    Expression<int>? sex,
    Expression<int>? age,
    Expression<int>? testisPosition,
    Expression<double>? testisLength,
    Expression<double>? testisWidth,
    Expression<int>? epididymisAppearance,
    Expression<int>? reproductiveStage,
    Expression<int>? leftPlacentalScars,
    Expression<int>? rightPlacentalScars,
    Expression<int>? mammaeCondition,
    Expression<int>? mammaeInguinalCount,
    Expression<int>? mammaeAxillaryCount,
    Expression<int>? mammaeAbdominalCount,
    Expression<int>? vaginaOpening,
    Expression<int>? pubicSymphysis,
    Expression<int>? embryoLeftCount,
    Expression<int>? embryoRightCount,
    Expression<int>? embryoCR,
    Expression<String>? remark,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (specimenUuid != null) 'specimenUuid': specimenUuid,
      if (totalLength != null) 'totalLength': totalLength,
      if (tailLength != null) 'tailLength': tailLength,
      if (hindFootLength != null) 'hindFootLength': hindFootLength,
      if (earLength != null) 'earLength': earLength,
      if (forearm != null) 'forearm': forearm,
      if (weight != null) 'weight': weight,
      if (accuracy != null) 'accuracy': accuracy,
      if (accuracySpecify != null) 'accuracySpecify': accuracySpecify,
      if (sex != null) 'sex': sex,
      if (age != null) 'age': age,
      if (testisPosition != null) 'testisPosition': testisPosition,
      if (testisLength != null) 'testisLength': testisLength,
      if (testisWidth != null) 'testisWidth': testisWidth,
      if (epididymisAppearance != null)
        'epididymisAppearance': epididymisAppearance,
      if (reproductiveStage != null) 'reproductiveStage': reproductiveStage,
      if (leftPlacentalScars != null) 'leftPlacentalScars': leftPlacentalScars,
      if (rightPlacentalScars != null)
        'rightPlacentalScars': rightPlacentalScars,
      if (mammaeCondition != null) 'mammaeCondition': mammaeCondition,
      if (mammaeInguinalCount != null)
        'mammaeInguinalCount': mammaeInguinalCount,
      if (mammaeAxillaryCount != null)
        'mammaeAxillaryCount': mammaeAxillaryCount,
      if (mammaeAbdominalCount != null)
        'mammaeAbdominalCount': mammaeAbdominalCount,
      if (vaginaOpening != null) 'vaginaOpening': vaginaOpening,
      if (pubicSymphysis != null) 'pubicSymphysis': pubicSymphysis,
      if (embryoLeftCount != null) 'embryoLeftCount': embryoLeftCount,
      if (embryoRightCount != null) 'embryoRightCount': embryoRightCount,
      if (embryoCR != null) 'embryoCR': embryoCR,
      if (remark != null) 'remark': remark,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MammalMeasurementCompanion copyWith(
      {Value<String>? specimenUuid,
      Value<double?>? totalLength,
      Value<double?>? tailLength,
      Value<double?>? hindFootLength,
      Value<double?>? earLength,
      Value<double?>? forearm,
      Value<double?>? weight,
      Value<String?>? accuracy,
      Value<String?>? accuracySpecify,
      Value<int?>? sex,
      Value<int?>? age,
      Value<int?>? testisPosition,
      Value<double?>? testisLength,
      Value<double?>? testisWidth,
      Value<int?>? epididymisAppearance,
      Value<int?>? reproductiveStage,
      Value<int?>? leftPlacentalScars,
      Value<int?>? rightPlacentalScars,
      Value<int?>? mammaeCondition,
      Value<int?>? mammaeInguinalCount,
      Value<int?>? mammaeAxillaryCount,
      Value<int?>? mammaeAbdominalCount,
      Value<int?>? vaginaOpening,
      Value<int?>? pubicSymphysis,
      Value<int?>? embryoLeftCount,
      Value<int?>? embryoRightCount,
      Value<int?>? embryoCR,
      Value<String?>? remark,
      Value<int>? rowid}) {
    return MammalMeasurementCompanion(
      specimenUuid: specimenUuid ?? this.specimenUuid,
      totalLength: totalLength ?? this.totalLength,
      tailLength: tailLength ?? this.tailLength,
      hindFootLength: hindFootLength ?? this.hindFootLength,
      earLength: earLength ?? this.earLength,
      forearm: forearm ?? this.forearm,
      weight: weight ?? this.weight,
      accuracy: accuracy ?? this.accuracy,
      accuracySpecify: accuracySpecify ?? this.accuracySpecify,
      sex: sex ?? this.sex,
      age: age ?? this.age,
      testisPosition: testisPosition ?? this.testisPosition,
      testisLength: testisLength ?? this.testisLength,
      testisWidth: testisWidth ?? this.testisWidth,
      epididymisAppearance: epididymisAppearance ?? this.epididymisAppearance,
      reproductiveStage: reproductiveStage ?? this.reproductiveStage,
      leftPlacentalScars: leftPlacentalScars ?? this.leftPlacentalScars,
      rightPlacentalScars: rightPlacentalScars ?? this.rightPlacentalScars,
      mammaeCondition: mammaeCondition ?? this.mammaeCondition,
      mammaeInguinalCount: mammaeInguinalCount ?? this.mammaeInguinalCount,
      mammaeAxillaryCount: mammaeAxillaryCount ?? this.mammaeAxillaryCount,
      mammaeAbdominalCount: mammaeAbdominalCount ?? this.mammaeAbdominalCount,
      vaginaOpening: vaginaOpening ?? this.vaginaOpening,
      pubicSymphysis: pubicSymphysis ?? this.pubicSymphysis,
      embryoLeftCount: embryoLeftCount ?? this.embryoLeftCount,
      embryoRightCount: embryoRightCount ?? this.embryoRightCount,
      embryoCR: embryoCR ?? this.embryoCR,
      remark: remark ?? this.remark,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (specimenUuid.present) {
      map['specimenUuid'] = Variable<String>(specimenUuid.value);
    }
    if (totalLength.present) {
      map['totalLength'] = Variable<double>(totalLength.value);
    }
    if (tailLength.present) {
      map['tailLength'] = Variable<double>(tailLength.value);
    }
    if (hindFootLength.present) {
      map['hindFootLength'] = Variable<double>(hindFootLength.value);
    }
    if (earLength.present) {
      map['earLength'] = Variable<double>(earLength.value);
    }
    if (forearm.present) {
      map['forearm'] = Variable<double>(forearm.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<String>(accuracy.value);
    }
    if (accuracySpecify.present) {
      map['accuracySpecify'] = Variable<String>(accuracySpecify.value);
    }
    if (sex.present) {
      map['sex'] = Variable<int>(sex.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (testisPosition.present) {
      map['testisPosition'] = Variable<int>(testisPosition.value);
    }
    if (testisLength.present) {
      map['testisLength'] = Variable<double>(testisLength.value);
    }
    if (testisWidth.present) {
      map['testisWidth'] = Variable<double>(testisWidth.value);
    }
    if (epididymisAppearance.present) {
      map['epididymisAppearance'] = Variable<int>(epididymisAppearance.value);
    }
    if (reproductiveStage.present) {
      map['reproductiveStage'] = Variable<int>(reproductiveStage.value);
    }
    if (leftPlacentalScars.present) {
      map['leftPlacentalScars'] = Variable<int>(leftPlacentalScars.value);
    }
    if (rightPlacentalScars.present) {
      map['rightPlacentalScars'] = Variable<int>(rightPlacentalScars.value);
    }
    if (mammaeCondition.present) {
      map['mammaeCondition'] = Variable<int>(mammaeCondition.value);
    }
    if (mammaeInguinalCount.present) {
      map['mammaeInguinalCount'] = Variable<int>(mammaeInguinalCount.value);
    }
    if (mammaeAxillaryCount.present) {
      map['mammaeAxillaryCount'] = Variable<int>(mammaeAxillaryCount.value);
    }
    if (mammaeAbdominalCount.present) {
      map['mammaeAbdominalCount'] = Variable<int>(mammaeAbdominalCount.value);
    }
    if (vaginaOpening.present) {
      map['vaginaOpening'] = Variable<int>(vaginaOpening.value);
    }
    if (pubicSymphysis.present) {
      map['pubicSymphysis'] = Variable<int>(pubicSymphysis.value);
    }
    if (embryoLeftCount.present) {
      map['embryoLeftCount'] = Variable<int>(embryoLeftCount.value);
    }
    if (embryoRightCount.present) {
      map['embryoRightCount'] = Variable<int>(embryoRightCount.value);
    }
    if (embryoCR.present) {
      map['embryoCR'] = Variable<int>(embryoCR.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MammalMeasurementCompanion(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('totalLength: $totalLength, ')
          ..write('tailLength: $tailLength, ')
          ..write('hindFootLength: $hindFootLength, ')
          ..write('earLength: $earLength, ')
          ..write('forearm: $forearm, ')
          ..write('weight: $weight, ')
          ..write('accuracy: $accuracy, ')
          ..write('accuracySpecify: $accuracySpecify, ')
          ..write('sex: $sex, ')
          ..write('age: $age, ')
          ..write('testisPosition: $testisPosition, ')
          ..write('testisLength: $testisLength, ')
          ..write('testisWidth: $testisWidth, ')
          ..write('epididymisAppearance: $epididymisAppearance, ')
          ..write('reproductiveStage: $reproductiveStage, ')
          ..write('leftPlacentalScars: $leftPlacentalScars, ')
          ..write('rightPlacentalScars: $rightPlacentalScars, ')
          ..write('mammaeCondition: $mammaeCondition, ')
          ..write('mammaeInguinalCount: $mammaeInguinalCount, ')
          ..write('mammaeAxillaryCount: $mammaeAxillaryCount, ')
          ..write('mammaeAbdominalCount: $mammaeAbdominalCount, ')
          ..write('vaginaOpening: $vaginaOpening, ')
          ..write('pubicSymphysis: $pubicSymphysis, ')
          ..write('embryoLeftCount: $embryoLeftCount, ')
          ..write('embryoRightCount: $embryoRightCount, ')
          ..write('embryoCR: $embryoCR, ')
          ..write('remark: $remark, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class AvianMeasurement extends Table
    with TableInfo<AvianMeasurement, AvianMeasurementData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AvianMeasurement(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String> specimenUuid = GeneratedColumn<String>(
      'specimenUuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _wingspanMeta =
      const VerificationMeta('wingspan');
  late final GeneratedColumn<double> wingspan = GeneratedColumn<double>(
      'wingspan', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _irisColorMeta =
      const VerificationMeta('irisColor');
  late final GeneratedColumn<String> irisColor = GeneratedColumn<String>(
      'irisColor', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _irisHexMeta =
      const VerificationMeta('irisHex');
  late final GeneratedColumn<String> irisHex = GeneratedColumn<String>(
      'irisHex', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _billColorMeta =
      const VerificationMeta('billColor');
  late final GeneratedColumn<String> billColor = GeneratedColumn<String>(
      'billColor', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _billHexMeta =
      const VerificationMeta('billHex');
  late final GeneratedColumn<String> billHex = GeneratedColumn<String>(
      'billHex', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _footColorMeta =
      const VerificationMeta('footColor');
  late final GeneratedColumn<String> footColor = GeneratedColumn<String>(
      'footColor', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _footHexMeta =
      const VerificationMeta('footHex');
  late final GeneratedColumn<String> footHex = GeneratedColumn<String>(
      'footHex', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tarsusColorMeta =
      const VerificationMeta('tarsusColor');
  late final GeneratedColumn<String> tarsusColor = GeneratedColumn<String>(
      'tarsusColor', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tarsusHexMeta =
      const VerificationMeta('tarsusHex');
  late final GeneratedColumn<String> tarsusHex = GeneratedColumn<String>(
      'tarsusHex', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumn<int> sex = GeneratedColumn<int>(
      'sex', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _broodPatchMeta =
      const VerificationMeta('broodPatch');
  late final GeneratedColumn<int> broodPatch = GeneratedColumn<int>(
      'broodPatch', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _skullOssificationMeta =
      const VerificationMeta('skullOssification');
  late final GeneratedColumn<int> skullOssification = GeneratedColumn<int>(
      'skullOssification', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _hasBursaMeta =
      const VerificationMeta('hasBursa');
  late final GeneratedColumn<int> hasBursa = GeneratedColumn<int>(
      'hasBursa', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _bursaWidthMeta =
      const VerificationMeta('bursaWidth');
  late final GeneratedColumn<double> bursaWidth = GeneratedColumn<double>(
      'bursaWidth', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _bursaLengthMeta =
      const VerificationMeta('bursaLength');
  late final GeneratedColumn<double> bursaLength = GeneratedColumn<double>(
      'bursaLength', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  late final GeneratedColumn<int> fat = GeneratedColumn<int>(
      'fat', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _stomachContentMeta =
      const VerificationMeta('stomachContent');
  late final GeneratedColumn<String> stomachContent = GeneratedColumn<String>(
      'stomachContent', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _testisLengthMeta =
      const VerificationMeta('testisLength');
  late final GeneratedColumn<double> testisLength = GeneratedColumn<double>(
      'testisLength', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _testisWidthMeta =
      const VerificationMeta('testisWidth');
  late final GeneratedColumn<double> testisWidth = GeneratedColumn<double>(
      'testisWidth', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _testisRemarkMeta =
      const VerificationMeta('testisRemark');
  late final GeneratedColumn<String> testisRemark = GeneratedColumn<String>(
      'testisRemark', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _ovaryLengthMeta =
      const VerificationMeta('ovaryLength');
  late final GeneratedColumn<double> ovaryLength = GeneratedColumn<double>(
      'ovaryLength', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _ovaryWidthMeta =
      const VerificationMeta('ovaryWidth');
  late final GeneratedColumn<double> ovaryWidth = GeneratedColumn<double>(
      'ovaryWidth', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _oviductWidthMeta =
      const VerificationMeta('oviductWidth');
  late final GeneratedColumn<double> oviductWidth = GeneratedColumn<double>(
      'oviductWidth', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _ovaryAppearanceMeta =
      const VerificationMeta('ovaryAppearance');
  late final GeneratedColumn<int> ovaryAppearance = GeneratedColumn<int>(
      'ovaryAppearance', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _firstOvaSizeMeta =
      const VerificationMeta('firstOvaSize');
  late final GeneratedColumn<double> firstOvaSize = GeneratedColumn<double>(
      'firstOvaSize', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _secondOvaSizeMeta =
      const VerificationMeta('secondOvaSize');
  late final GeneratedColumn<double> secondOvaSize = GeneratedColumn<double>(
      'secondOvaSize', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _thirdOvaSizeMeta =
      const VerificationMeta('thirdOvaSize');
  late final GeneratedColumn<double> thirdOvaSize = GeneratedColumn<double>(
      'thirdOvaSize', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _oviductAppearanceMeta =
      const VerificationMeta('oviductAppearance');
  late final GeneratedColumn<int> oviductAppearance = GeneratedColumn<int>(
      'oviductAppearance', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _ovaryRemarkMeta =
      const VerificationMeta('ovaryRemark');
  late final GeneratedColumn<String> ovaryRemark = GeneratedColumn<String>(
      'ovaryRemark', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _wingIsMoltMeta =
      const VerificationMeta('wingIsMolt');
  late final GeneratedColumn<int> wingIsMolt = GeneratedColumn<int>(
      'wingIsMolt', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _wingMoltMeta =
      const VerificationMeta('wingMolt');
  late final GeneratedColumn<String> wingMolt = GeneratedColumn<String>(
      'wingMolt', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tailIsMoltMeta =
      const VerificationMeta('tailIsMolt');
  late final GeneratedColumn<int> tailIsMolt = GeneratedColumn<int>(
      'tailIsMolt', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tailMoltMeta =
      const VerificationMeta('tailMolt');
  late final GeneratedColumn<String> tailMolt = GeneratedColumn<String>(
      'tailMolt', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _bodyMoltMeta =
      const VerificationMeta('bodyMolt');
  late final GeneratedColumn<int> bodyMolt = GeneratedColumn<int>(
      'bodyMolt', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _moltRemarkMeta =
      const VerificationMeta('moltRemark');
  late final GeneratedColumn<String> moltRemark = GeneratedColumn<String>(
      'moltRemark', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _specimenRemarkMeta =
      const VerificationMeta('specimenRemark');
  late final GeneratedColumn<String> specimenRemark = GeneratedColumn<String>(
      'specimenRemark', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _habitatRemarkMeta =
      const VerificationMeta('habitatRemark');
  late final GeneratedColumn<String> habitatRemark = GeneratedColumn<String>(
      'habitatRemark', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        specimenUuid,
        weight,
        wingspan,
        irisColor,
        irisHex,
        billColor,
        billHex,
        footColor,
        footHex,
        tarsusColor,
        tarsusHex,
        sex,
        broodPatch,
        skullOssification,
        hasBursa,
        bursaWidth,
        bursaLength,
        fat,
        stomachContent,
        testisLength,
        testisWidth,
        testisRemark,
        ovaryLength,
        ovaryWidth,
        oviductWidth,
        ovaryAppearance,
        firstOvaSize,
        secondOvaSize,
        thirdOvaSize,
        oviductAppearance,
        ovaryRemark,
        wingIsMolt,
        wingMolt,
        tailIsMolt,
        tailMolt,
        bodyMolt,
        moltRemark,
        specimenRemark,
        habitatRemark
      ];
  @override
  String get aliasedName => _alias ?? 'avianMeasurement';
  @override
  String get actualTableName => 'avianMeasurement';
  @override
  VerificationContext validateIntegrity(
      Insertable<AvianMeasurementData> instance,
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
    if (data.containsKey('irisHex')) {
      context.handle(_irisHexMeta,
          irisHex.isAcceptableOrUnknown(data['irisHex']!, _irisHexMeta));
    }
    if (data.containsKey('billColor')) {
      context.handle(_billColorMeta,
          billColor.isAcceptableOrUnknown(data['billColor']!, _billColorMeta));
    }
    if (data.containsKey('billHex')) {
      context.handle(_billHexMeta,
          billHex.isAcceptableOrUnknown(data['billHex']!, _billHexMeta));
    }
    if (data.containsKey('footColor')) {
      context.handle(_footColorMeta,
          footColor.isAcceptableOrUnknown(data['footColor']!, _footColorMeta));
    }
    if (data.containsKey('footHex')) {
      context.handle(_footHexMeta,
          footHex.isAcceptableOrUnknown(data['footHex']!, _footHexMeta));
    }
    if (data.containsKey('tarsusColor')) {
      context.handle(
          _tarsusColorMeta,
          tarsusColor.isAcceptableOrUnknown(
              data['tarsusColor']!, _tarsusColorMeta));
    }
    if (data.containsKey('tarsusHex')) {
      context.handle(_tarsusHexMeta,
          tarsusHex.isAcceptableOrUnknown(data['tarsusHex']!, _tarsusHexMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
          _sexMeta, sex.isAcceptableOrUnknown(data['sex']!, _sexMeta));
    }
    if (data.containsKey('broodPatch')) {
      context.handle(
          _broodPatchMeta,
          broodPatch.isAcceptableOrUnknown(
              data['broodPatch']!, _broodPatchMeta));
    }
    if (data.containsKey('skullOssification')) {
      context.handle(
          _skullOssificationMeta,
          skullOssification.isAcceptableOrUnknown(
              data['skullOssification']!, _skullOssificationMeta));
    }
    if (data.containsKey('hasBursa')) {
      context.handle(_hasBursaMeta,
          hasBursa.isAcceptableOrUnknown(data['hasBursa']!, _hasBursaMeta));
    }
    if (data.containsKey('bursaWidth')) {
      context.handle(
          _bursaWidthMeta,
          bursaWidth.isAcceptableOrUnknown(
              data['bursaWidth']!, _bursaWidthMeta));
    }
    if (data.containsKey('bursaLength')) {
      context.handle(
          _bursaLengthMeta,
          bursaLength.isAcceptableOrUnknown(
              data['bursaLength']!, _bursaLengthMeta));
    }
    if (data.containsKey('fat')) {
      context.handle(
          _fatMeta, fat.isAcceptableOrUnknown(data['fat']!, _fatMeta));
    }
    if (data.containsKey('stomachContent')) {
      context.handle(
          _stomachContentMeta,
          stomachContent.isAcceptableOrUnknown(
              data['stomachContent']!, _stomachContentMeta));
    }
    if (data.containsKey('testisLength')) {
      context.handle(
          _testisLengthMeta,
          testisLength.isAcceptableOrUnknown(
              data['testisLength']!, _testisLengthMeta));
    }
    if (data.containsKey('testisWidth')) {
      context.handle(
          _testisWidthMeta,
          testisWidth.isAcceptableOrUnknown(
              data['testisWidth']!, _testisWidthMeta));
    }
    if (data.containsKey('testisRemark')) {
      context.handle(
          _testisRemarkMeta,
          testisRemark.isAcceptableOrUnknown(
              data['testisRemark']!, _testisRemarkMeta));
    }
    if (data.containsKey('ovaryLength')) {
      context.handle(
          _ovaryLengthMeta,
          ovaryLength.isAcceptableOrUnknown(
              data['ovaryLength']!, _ovaryLengthMeta));
    }
    if (data.containsKey('ovaryWidth')) {
      context.handle(
          _ovaryWidthMeta,
          ovaryWidth.isAcceptableOrUnknown(
              data['ovaryWidth']!, _ovaryWidthMeta));
    }
    if (data.containsKey('oviductWidth')) {
      context.handle(
          _oviductWidthMeta,
          oviductWidth.isAcceptableOrUnknown(
              data['oviductWidth']!, _oviductWidthMeta));
    }
    if (data.containsKey('ovaryAppearance')) {
      context.handle(
          _ovaryAppearanceMeta,
          ovaryAppearance.isAcceptableOrUnknown(
              data['ovaryAppearance']!, _ovaryAppearanceMeta));
    }
    if (data.containsKey('firstOvaSize')) {
      context.handle(
          _firstOvaSizeMeta,
          firstOvaSize.isAcceptableOrUnknown(
              data['firstOvaSize']!, _firstOvaSizeMeta));
    }
    if (data.containsKey('secondOvaSize')) {
      context.handle(
          _secondOvaSizeMeta,
          secondOvaSize.isAcceptableOrUnknown(
              data['secondOvaSize']!, _secondOvaSizeMeta));
    }
    if (data.containsKey('thirdOvaSize')) {
      context.handle(
          _thirdOvaSizeMeta,
          thirdOvaSize.isAcceptableOrUnknown(
              data['thirdOvaSize']!, _thirdOvaSizeMeta));
    }
    if (data.containsKey('oviductAppearance')) {
      context.handle(
          _oviductAppearanceMeta,
          oviductAppearance.isAcceptableOrUnknown(
              data['oviductAppearance']!, _oviductAppearanceMeta));
    }
    if (data.containsKey('ovaryRemark')) {
      context.handle(
          _ovaryRemarkMeta,
          ovaryRemark.isAcceptableOrUnknown(
              data['ovaryRemark']!, _ovaryRemarkMeta));
    }
    if (data.containsKey('wingIsMolt')) {
      context.handle(
          _wingIsMoltMeta,
          wingIsMolt.isAcceptableOrUnknown(
              data['wingIsMolt']!, _wingIsMoltMeta));
    }
    if (data.containsKey('wingMolt')) {
      context.handle(_wingMoltMeta,
          wingMolt.isAcceptableOrUnknown(data['wingMolt']!, _wingMoltMeta));
    }
    if (data.containsKey('tailIsMolt')) {
      context.handle(
          _tailIsMoltMeta,
          tailIsMolt.isAcceptableOrUnknown(
              data['tailIsMolt']!, _tailIsMoltMeta));
    }
    if (data.containsKey('tailMolt')) {
      context.handle(_tailMoltMeta,
          tailMolt.isAcceptableOrUnknown(data['tailMolt']!, _tailMoltMeta));
    }
    if (data.containsKey('bodyMolt')) {
      context.handle(_bodyMoltMeta,
          bodyMolt.isAcceptableOrUnknown(data['bodyMolt']!, _bodyMoltMeta));
    }
    if (data.containsKey('moltRemark')) {
      context.handle(
          _moltRemarkMeta,
          moltRemark.isAcceptableOrUnknown(
              data['moltRemark']!, _moltRemarkMeta));
    }
    if (data.containsKey('specimenRemark')) {
      context.handle(
          _specimenRemarkMeta,
          specimenRemark.isAcceptableOrUnknown(
              data['specimenRemark']!, _specimenRemarkMeta));
    }
    if (data.containsKey('habitatRemark')) {
      context.handle(
          _habitatRemarkMeta,
          habitatRemark.isAcceptableOrUnknown(
              data['habitatRemark']!, _habitatRemarkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AvianMeasurementData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AvianMeasurementData(
      specimenUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specimenUuid'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      wingspan: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}wingspan']),
      irisColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}irisColor']),
      irisHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}irisHex']),
      billColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}billColor']),
      billHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}billHex']),
      footColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}footColor']),
      footHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}footHex']),
      tarsusColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarsusColor']),
      tarsusHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarsusHex']),
      sex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sex']),
      broodPatch: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}broodPatch']),
      skullOssification: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}skullOssification']),
      hasBursa: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hasBursa']),
      bursaWidth: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bursaWidth']),
      bursaLength: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bursaLength']),
      fat: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fat']),
      stomachContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stomachContent']),
      testisLength: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}testisLength']),
      testisWidth: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}testisWidth']),
      testisRemark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}testisRemark']),
      ovaryLength: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ovaryLength']),
      ovaryWidth: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ovaryWidth']),
      oviductWidth: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}oviductWidth']),
      ovaryAppearance: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ovaryAppearance']),
      firstOvaSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}firstOvaSize']),
      secondOvaSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}secondOvaSize']),
      thirdOvaSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}thirdOvaSize']),
      oviductAppearance: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}oviductAppearance']),
      ovaryRemark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ovaryRemark']),
      wingIsMolt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wingIsMolt']),
      wingMolt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wingMolt']),
      tailIsMolt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tailIsMolt']),
      tailMolt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tailMolt']),
      bodyMolt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bodyMolt']),
      moltRemark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}moltRemark']),
      specimenRemark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specimenRemark']),
      habitatRemark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habitatRemark']),
    );
  }

  @override
  AvianMeasurement createAlias(String alias) {
    return AvianMeasurement(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(specimenUuid)REFERENCES specimen(uuid)'];
  @override
  bool get dontWriteConstraints => true;
}

class AvianMeasurementData extends DataClass
    implements Insertable<AvianMeasurementData> {
  final String specimenUuid;
  final double? weight;
  final double? wingspan;
  final String? irisColor;
  final String? irisHex;

  /// Hex number for iris color
  final String? billColor;
  final String? billHex;
  final String? footColor;
  final String? footHex;
  final String? tarsusColor;
  final String? tarsusHex;
  final int? sex;
  final int? broodPatch;
  final int? skullOssification;
  final int? hasBursa;
  final double? bursaWidth;
  final double? bursaLength;
  final int? fat;
  final String? stomachContent;
  final double? testisLength;
  final double? testisWidth;
  final String? testisRemark;
  final double? ovaryLength;
  final double? ovaryWidth;
  final double? oviductWidth;
  final int? ovaryAppearance;
  final double? firstOvaSize;
  final double? secondOvaSize;
  final double? thirdOvaSize;
  final int? oviductAppearance;

  /// encode to int to save space
  final String? ovaryRemark;
  final int? wingIsMolt;

  /// encode text
  final String? wingMolt;
  final int? tailIsMolt;
  final String? tailMolt;
  final int? bodyMolt;

  /// encode text
  final String? moltRemark;
  final String? specimenRemark;
  final String? habitatRemark;
  const AvianMeasurementData(
      {required this.specimenUuid,
      this.weight,
      this.wingspan,
      this.irisColor,
      this.irisHex,
      this.billColor,
      this.billHex,
      this.footColor,
      this.footHex,
      this.tarsusColor,
      this.tarsusHex,
      this.sex,
      this.broodPatch,
      this.skullOssification,
      this.hasBursa,
      this.bursaWidth,
      this.bursaLength,
      this.fat,
      this.stomachContent,
      this.testisLength,
      this.testisWidth,
      this.testisRemark,
      this.ovaryLength,
      this.ovaryWidth,
      this.oviductWidth,
      this.ovaryAppearance,
      this.firstOvaSize,
      this.secondOvaSize,
      this.thirdOvaSize,
      this.oviductAppearance,
      this.ovaryRemark,
      this.wingIsMolt,
      this.wingMolt,
      this.tailIsMolt,
      this.tailMolt,
      this.bodyMolt,
      this.moltRemark,
      this.specimenRemark,
      this.habitatRemark});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['specimenUuid'] = Variable<String>(specimenUuid);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || wingspan != null) {
      map['wingspan'] = Variable<double>(wingspan);
    }
    if (!nullToAbsent || irisColor != null) {
      map['irisColor'] = Variable<String>(irisColor);
    }
    if (!nullToAbsent || irisHex != null) {
      map['irisHex'] = Variable<String>(irisHex);
    }
    if (!nullToAbsent || billColor != null) {
      map['billColor'] = Variable<String>(billColor);
    }
    if (!nullToAbsent || billHex != null) {
      map['billHex'] = Variable<String>(billHex);
    }
    if (!nullToAbsent || footColor != null) {
      map['footColor'] = Variable<String>(footColor);
    }
    if (!nullToAbsent || footHex != null) {
      map['footHex'] = Variable<String>(footHex);
    }
    if (!nullToAbsent || tarsusColor != null) {
      map['tarsusColor'] = Variable<String>(tarsusColor);
    }
    if (!nullToAbsent || tarsusHex != null) {
      map['tarsusHex'] = Variable<String>(tarsusHex);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<int>(sex);
    }
    if (!nullToAbsent || broodPatch != null) {
      map['broodPatch'] = Variable<int>(broodPatch);
    }
    if (!nullToAbsent || skullOssification != null) {
      map['skullOssification'] = Variable<int>(skullOssification);
    }
    if (!nullToAbsent || hasBursa != null) {
      map['hasBursa'] = Variable<int>(hasBursa);
    }
    if (!nullToAbsent || bursaWidth != null) {
      map['bursaWidth'] = Variable<double>(bursaWidth);
    }
    if (!nullToAbsent || bursaLength != null) {
      map['bursaLength'] = Variable<double>(bursaLength);
    }
    if (!nullToAbsent || fat != null) {
      map['fat'] = Variable<int>(fat);
    }
    if (!nullToAbsent || stomachContent != null) {
      map['stomachContent'] = Variable<String>(stomachContent);
    }
    if (!nullToAbsent || testisLength != null) {
      map['testisLength'] = Variable<double>(testisLength);
    }
    if (!nullToAbsent || testisWidth != null) {
      map['testisWidth'] = Variable<double>(testisWidth);
    }
    if (!nullToAbsent || testisRemark != null) {
      map['testisRemark'] = Variable<String>(testisRemark);
    }
    if (!nullToAbsent || ovaryLength != null) {
      map['ovaryLength'] = Variable<double>(ovaryLength);
    }
    if (!nullToAbsent || ovaryWidth != null) {
      map['ovaryWidth'] = Variable<double>(ovaryWidth);
    }
    if (!nullToAbsent || oviductWidth != null) {
      map['oviductWidth'] = Variable<double>(oviductWidth);
    }
    if (!nullToAbsent || ovaryAppearance != null) {
      map['ovaryAppearance'] = Variable<int>(ovaryAppearance);
    }
    if (!nullToAbsent || firstOvaSize != null) {
      map['firstOvaSize'] = Variable<double>(firstOvaSize);
    }
    if (!nullToAbsent || secondOvaSize != null) {
      map['secondOvaSize'] = Variable<double>(secondOvaSize);
    }
    if (!nullToAbsent || thirdOvaSize != null) {
      map['thirdOvaSize'] = Variable<double>(thirdOvaSize);
    }
    if (!nullToAbsent || oviductAppearance != null) {
      map['oviductAppearance'] = Variable<int>(oviductAppearance);
    }
    if (!nullToAbsent || ovaryRemark != null) {
      map['ovaryRemark'] = Variable<String>(ovaryRemark);
    }
    if (!nullToAbsent || wingIsMolt != null) {
      map['wingIsMolt'] = Variable<int>(wingIsMolt);
    }
    if (!nullToAbsent || wingMolt != null) {
      map['wingMolt'] = Variable<String>(wingMolt);
    }
    if (!nullToAbsent || tailIsMolt != null) {
      map['tailIsMolt'] = Variable<int>(tailIsMolt);
    }
    if (!nullToAbsent || tailMolt != null) {
      map['tailMolt'] = Variable<String>(tailMolt);
    }
    if (!nullToAbsent || bodyMolt != null) {
      map['bodyMolt'] = Variable<int>(bodyMolt);
    }
    if (!nullToAbsent || moltRemark != null) {
      map['moltRemark'] = Variable<String>(moltRemark);
    }
    if (!nullToAbsent || specimenRemark != null) {
      map['specimenRemark'] = Variable<String>(specimenRemark);
    }
    if (!nullToAbsent || habitatRemark != null) {
      map['habitatRemark'] = Variable<String>(habitatRemark);
    }
    return map;
  }

  AvianMeasurementCompanion toCompanion(bool nullToAbsent) {
    return AvianMeasurementCompanion(
      specimenUuid: Value(specimenUuid),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      wingspan: wingspan == null && nullToAbsent
          ? const Value.absent()
          : Value(wingspan),
      irisColor: irisColor == null && nullToAbsent
          ? const Value.absent()
          : Value(irisColor),
      irisHex: irisHex == null && nullToAbsent
          ? const Value.absent()
          : Value(irisHex),
      billColor: billColor == null && nullToAbsent
          ? const Value.absent()
          : Value(billColor),
      billHex: billHex == null && nullToAbsent
          ? const Value.absent()
          : Value(billHex),
      footColor: footColor == null && nullToAbsent
          ? const Value.absent()
          : Value(footColor),
      footHex: footHex == null && nullToAbsent
          ? const Value.absent()
          : Value(footHex),
      tarsusColor: tarsusColor == null && nullToAbsent
          ? const Value.absent()
          : Value(tarsusColor),
      tarsusHex: tarsusHex == null && nullToAbsent
          ? const Value.absent()
          : Value(tarsusHex),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      broodPatch: broodPatch == null && nullToAbsent
          ? const Value.absent()
          : Value(broodPatch),
      skullOssification: skullOssification == null && nullToAbsent
          ? const Value.absent()
          : Value(skullOssification),
      hasBursa: hasBursa == null && nullToAbsent
          ? const Value.absent()
          : Value(hasBursa),
      bursaWidth: bursaWidth == null && nullToAbsent
          ? const Value.absent()
          : Value(bursaWidth),
      bursaLength: bursaLength == null && nullToAbsent
          ? const Value.absent()
          : Value(bursaLength),
      fat: fat == null && nullToAbsent ? const Value.absent() : Value(fat),
      stomachContent: stomachContent == null && nullToAbsent
          ? const Value.absent()
          : Value(stomachContent),
      testisLength: testisLength == null && nullToAbsent
          ? const Value.absent()
          : Value(testisLength),
      testisWidth: testisWidth == null && nullToAbsent
          ? const Value.absent()
          : Value(testisWidth),
      testisRemark: testisRemark == null && nullToAbsent
          ? const Value.absent()
          : Value(testisRemark),
      ovaryLength: ovaryLength == null && nullToAbsent
          ? const Value.absent()
          : Value(ovaryLength),
      ovaryWidth: ovaryWidth == null && nullToAbsent
          ? const Value.absent()
          : Value(ovaryWidth),
      oviductWidth: oviductWidth == null && nullToAbsent
          ? const Value.absent()
          : Value(oviductWidth),
      ovaryAppearance: ovaryAppearance == null && nullToAbsent
          ? const Value.absent()
          : Value(ovaryAppearance),
      firstOvaSize: firstOvaSize == null && nullToAbsent
          ? const Value.absent()
          : Value(firstOvaSize),
      secondOvaSize: secondOvaSize == null && nullToAbsent
          ? const Value.absent()
          : Value(secondOvaSize),
      thirdOvaSize: thirdOvaSize == null && nullToAbsent
          ? const Value.absent()
          : Value(thirdOvaSize),
      oviductAppearance: oviductAppearance == null && nullToAbsent
          ? const Value.absent()
          : Value(oviductAppearance),
      ovaryRemark: ovaryRemark == null && nullToAbsent
          ? const Value.absent()
          : Value(ovaryRemark),
      wingIsMolt: wingIsMolt == null && nullToAbsent
          ? const Value.absent()
          : Value(wingIsMolt),
      wingMolt: wingMolt == null && nullToAbsent
          ? const Value.absent()
          : Value(wingMolt),
      tailIsMolt: tailIsMolt == null && nullToAbsent
          ? const Value.absent()
          : Value(tailIsMolt),
      tailMolt: tailMolt == null && nullToAbsent
          ? const Value.absent()
          : Value(tailMolt),
      bodyMolt: bodyMolt == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyMolt),
      moltRemark: moltRemark == null && nullToAbsent
          ? const Value.absent()
          : Value(moltRemark),
      specimenRemark: specimenRemark == null && nullToAbsent
          ? const Value.absent()
          : Value(specimenRemark),
      habitatRemark: habitatRemark == null && nullToAbsent
          ? const Value.absent()
          : Value(habitatRemark),
    );
  }

  factory AvianMeasurementData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AvianMeasurementData(
      specimenUuid: serializer.fromJson<String>(json['specimenUuid']),
      weight: serializer.fromJson<double?>(json['weight']),
      wingspan: serializer.fromJson<double?>(json['wingspan']),
      irisColor: serializer.fromJson<String?>(json['irisColor']),
      irisHex: serializer.fromJson<String?>(json['irisHex']),
      billColor: serializer.fromJson<String?>(json['billColor']),
      billHex: serializer.fromJson<String?>(json['billHex']),
      footColor: serializer.fromJson<String?>(json['footColor']),
      footHex: serializer.fromJson<String?>(json['footHex']),
      tarsusColor: serializer.fromJson<String?>(json['tarsusColor']),
      tarsusHex: serializer.fromJson<String?>(json['tarsusHex']),
      sex: serializer.fromJson<int?>(json['sex']),
      broodPatch: serializer.fromJson<int?>(json['broodPatch']),
      skullOssification: serializer.fromJson<int?>(json['skullOssification']),
      hasBursa: serializer.fromJson<int?>(json['hasBursa']),
      bursaWidth: serializer.fromJson<double?>(json['bursaWidth']),
      bursaLength: serializer.fromJson<double?>(json['bursaLength']),
      fat: serializer.fromJson<int?>(json['fat']),
      stomachContent: serializer.fromJson<String?>(json['stomachContent']),
      testisLength: serializer.fromJson<double?>(json['testisLength']),
      testisWidth: serializer.fromJson<double?>(json['testisWidth']),
      testisRemark: serializer.fromJson<String?>(json['testisRemark']),
      ovaryLength: serializer.fromJson<double?>(json['ovaryLength']),
      ovaryWidth: serializer.fromJson<double?>(json['ovaryWidth']),
      oviductWidth: serializer.fromJson<double?>(json['oviductWidth']),
      ovaryAppearance: serializer.fromJson<int?>(json['ovaryAppearance']),
      firstOvaSize: serializer.fromJson<double?>(json['firstOvaSize']),
      secondOvaSize: serializer.fromJson<double?>(json['secondOvaSize']),
      thirdOvaSize: serializer.fromJson<double?>(json['thirdOvaSize']),
      oviductAppearance: serializer.fromJson<int?>(json['oviductAppearance']),
      ovaryRemark: serializer.fromJson<String?>(json['ovaryRemark']),
      wingIsMolt: serializer.fromJson<int?>(json['wingIsMolt']),
      wingMolt: serializer.fromJson<String?>(json['wingMolt']),
      tailIsMolt: serializer.fromJson<int?>(json['tailIsMolt']),
      tailMolt: serializer.fromJson<String?>(json['tailMolt']),
      bodyMolt: serializer.fromJson<int?>(json['bodyMolt']),
      moltRemark: serializer.fromJson<String?>(json['moltRemark']),
      specimenRemark: serializer.fromJson<String?>(json['specimenRemark']),
      habitatRemark: serializer.fromJson<String?>(json['habitatRemark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'specimenUuid': serializer.toJson<String>(specimenUuid),
      'weight': serializer.toJson<double?>(weight),
      'wingspan': serializer.toJson<double?>(wingspan),
      'irisColor': serializer.toJson<String?>(irisColor),
      'irisHex': serializer.toJson<String?>(irisHex),
      'billColor': serializer.toJson<String?>(billColor),
      'billHex': serializer.toJson<String?>(billHex),
      'footColor': serializer.toJson<String?>(footColor),
      'footHex': serializer.toJson<String?>(footHex),
      'tarsusColor': serializer.toJson<String?>(tarsusColor),
      'tarsusHex': serializer.toJson<String?>(tarsusHex),
      'sex': serializer.toJson<int?>(sex),
      'broodPatch': serializer.toJson<int?>(broodPatch),
      'skullOssification': serializer.toJson<int?>(skullOssification),
      'hasBursa': serializer.toJson<int?>(hasBursa),
      'bursaWidth': serializer.toJson<double?>(bursaWidth),
      'bursaLength': serializer.toJson<double?>(bursaLength),
      'fat': serializer.toJson<int?>(fat),
      'stomachContent': serializer.toJson<String?>(stomachContent),
      'testisLength': serializer.toJson<double?>(testisLength),
      'testisWidth': serializer.toJson<double?>(testisWidth),
      'testisRemark': serializer.toJson<String?>(testisRemark),
      'ovaryLength': serializer.toJson<double?>(ovaryLength),
      'ovaryWidth': serializer.toJson<double?>(ovaryWidth),
      'oviductWidth': serializer.toJson<double?>(oviductWidth),
      'ovaryAppearance': serializer.toJson<int?>(ovaryAppearance),
      'firstOvaSize': serializer.toJson<double?>(firstOvaSize),
      'secondOvaSize': serializer.toJson<double?>(secondOvaSize),
      'thirdOvaSize': serializer.toJson<double?>(thirdOvaSize),
      'oviductAppearance': serializer.toJson<int?>(oviductAppearance),
      'ovaryRemark': serializer.toJson<String?>(ovaryRemark),
      'wingIsMolt': serializer.toJson<int?>(wingIsMolt),
      'wingMolt': serializer.toJson<String?>(wingMolt),
      'tailIsMolt': serializer.toJson<int?>(tailIsMolt),
      'tailMolt': serializer.toJson<String?>(tailMolt),
      'bodyMolt': serializer.toJson<int?>(bodyMolt),
      'moltRemark': serializer.toJson<String?>(moltRemark),
      'specimenRemark': serializer.toJson<String?>(specimenRemark),
      'habitatRemark': serializer.toJson<String?>(habitatRemark),
    };
  }

  AvianMeasurementData copyWith(
          {String? specimenUuid,
          Value<double?> weight = const Value.absent(),
          Value<double?> wingspan = const Value.absent(),
          Value<String?> irisColor = const Value.absent(),
          Value<String?> irisHex = const Value.absent(),
          Value<String?> billColor = const Value.absent(),
          Value<String?> billHex = const Value.absent(),
          Value<String?> footColor = const Value.absent(),
          Value<String?> footHex = const Value.absent(),
          Value<String?> tarsusColor = const Value.absent(),
          Value<String?> tarsusHex = const Value.absent(),
          Value<int?> sex = const Value.absent(),
          Value<int?> broodPatch = const Value.absent(),
          Value<int?> skullOssification = const Value.absent(),
          Value<int?> hasBursa = const Value.absent(),
          Value<double?> bursaWidth = const Value.absent(),
          Value<double?> bursaLength = const Value.absent(),
          Value<int?> fat = const Value.absent(),
          Value<String?> stomachContent = const Value.absent(),
          Value<double?> testisLength = const Value.absent(),
          Value<double?> testisWidth = const Value.absent(),
          Value<String?> testisRemark = const Value.absent(),
          Value<double?> ovaryLength = const Value.absent(),
          Value<double?> ovaryWidth = const Value.absent(),
          Value<double?> oviductWidth = const Value.absent(),
          Value<int?> ovaryAppearance = const Value.absent(),
          Value<double?> firstOvaSize = const Value.absent(),
          Value<double?> secondOvaSize = const Value.absent(),
          Value<double?> thirdOvaSize = const Value.absent(),
          Value<int?> oviductAppearance = const Value.absent(),
          Value<String?> ovaryRemark = const Value.absent(),
          Value<int?> wingIsMolt = const Value.absent(),
          Value<String?> wingMolt = const Value.absent(),
          Value<int?> tailIsMolt = const Value.absent(),
          Value<String?> tailMolt = const Value.absent(),
          Value<int?> bodyMolt = const Value.absent(),
          Value<String?> moltRemark = const Value.absent(),
          Value<String?> specimenRemark = const Value.absent(),
          Value<String?> habitatRemark = const Value.absent()}) =>
      AvianMeasurementData(
        specimenUuid: specimenUuid ?? this.specimenUuid,
        weight: weight.present ? weight.value : this.weight,
        wingspan: wingspan.present ? wingspan.value : this.wingspan,
        irisColor: irisColor.present ? irisColor.value : this.irisColor,
        irisHex: irisHex.present ? irisHex.value : this.irisHex,
        billColor: billColor.present ? billColor.value : this.billColor,
        billHex: billHex.present ? billHex.value : this.billHex,
        footColor: footColor.present ? footColor.value : this.footColor,
        footHex: footHex.present ? footHex.value : this.footHex,
        tarsusColor: tarsusColor.present ? tarsusColor.value : this.tarsusColor,
        tarsusHex: tarsusHex.present ? tarsusHex.value : this.tarsusHex,
        sex: sex.present ? sex.value : this.sex,
        broodPatch: broodPatch.present ? broodPatch.value : this.broodPatch,
        skullOssification: skullOssification.present
            ? skullOssification.value
            : this.skullOssification,
        hasBursa: hasBursa.present ? hasBursa.value : this.hasBursa,
        bursaWidth: bursaWidth.present ? bursaWidth.value : this.bursaWidth,
        bursaLength: bursaLength.present ? bursaLength.value : this.bursaLength,
        fat: fat.present ? fat.value : this.fat,
        stomachContent:
            stomachContent.present ? stomachContent.value : this.stomachContent,
        testisLength:
            testisLength.present ? testisLength.value : this.testisLength,
        testisWidth: testisWidth.present ? testisWidth.value : this.testisWidth,
        testisRemark:
            testisRemark.present ? testisRemark.value : this.testisRemark,
        ovaryLength: ovaryLength.present ? ovaryLength.value : this.ovaryLength,
        ovaryWidth: ovaryWidth.present ? ovaryWidth.value : this.ovaryWidth,
        oviductWidth:
            oviductWidth.present ? oviductWidth.value : this.oviductWidth,
        ovaryAppearance: ovaryAppearance.present
            ? ovaryAppearance.value
            : this.ovaryAppearance,
        firstOvaSize:
            firstOvaSize.present ? firstOvaSize.value : this.firstOvaSize,
        secondOvaSize:
            secondOvaSize.present ? secondOvaSize.value : this.secondOvaSize,
        thirdOvaSize:
            thirdOvaSize.present ? thirdOvaSize.value : this.thirdOvaSize,
        oviductAppearance: oviductAppearance.present
            ? oviductAppearance.value
            : this.oviductAppearance,
        ovaryRemark: ovaryRemark.present ? ovaryRemark.value : this.ovaryRemark,
        wingIsMolt: wingIsMolt.present ? wingIsMolt.value : this.wingIsMolt,
        wingMolt: wingMolt.present ? wingMolt.value : this.wingMolt,
        tailIsMolt: tailIsMolt.present ? tailIsMolt.value : this.tailIsMolt,
        tailMolt: tailMolt.present ? tailMolt.value : this.tailMolt,
        bodyMolt: bodyMolt.present ? bodyMolt.value : this.bodyMolt,
        moltRemark: moltRemark.present ? moltRemark.value : this.moltRemark,
        specimenRemark:
            specimenRemark.present ? specimenRemark.value : this.specimenRemark,
        habitatRemark:
            habitatRemark.present ? habitatRemark.value : this.habitatRemark,
      );
  @override
  String toString() {
    return (StringBuffer('AvianMeasurementData(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('weight: $weight, ')
          ..write('wingspan: $wingspan, ')
          ..write('irisColor: $irisColor, ')
          ..write('irisHex: $irisHex, ')
          ..write('billColor: $billColor, ')
          ..write('billHex: $billHex, ')
          ..write('footColor: $footColor, ')
          ..write('footHex: $footHex, ')
          ..write('tarsusColor: $tarsusColor, ')
          ..write('tarsusHex: $tarsusHex, ')
          ..write('sex: $sex, ')
          ..write('broodPatch: $broodPatch, ')
          ..write('skullOssification: $skullOssification, ')
          ..write('hasBursa: $hasBursa, ')
          ..write('bursaWidth: $bursaWidth, ')
          ..write('bursaLength: $bursaLength, ')
          ..write('fat: $fat, ')
          ..write('stomachContent: $stomachContent, ')
          ..write('testisLength: $testisLength, ')
          ..write('testisWidth: $testisWidth, ')
          ..write('testisRemark: $testisRemark, ')
          ..write('ovaryLength: $ovaryLength, ')
          ..write('ovaryWidth: $ovaryWidth, ')
          ..write('oviductWidth: $oviductWidth, ')
          ..write('ovaryAppearance: $ovaryAppearance, ')
          ..write('firstOvaSize: $firstOvaSize, ')
          ..write('secondOvaSize: $secondOvaSize, ')
          ..write('thirdOvaSize: $thirdOvaSize, ')
          ..write('oviductAppearance: $oviductAppearance, ')
          ..write('ovaryRemark: $ovaryRemark, ')
          ..write('wingIsMolt: $wingIsMolt, ')
          ..write('wingMolt: $wingMolt, ')
          ..write('tailIsMolt: $tailIsMolt, ')
          ..write('tailMolt: $tailMolt, ')
          ..write('bodyMolt: $bodyMolt, ')
          ..write('moltRemark: $moltRemark, ')
          ..write('specimenRemark: $specimenRemark, ')
          ..write('habitatRemark: $habitatRemark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        specimenUuid,
        weight,
        wingspan,
        irisColor,
        irisHex,
        billColor,
        billHex,
        footColor,
        footHex,
        tarsusColor,
        tarsusHex,
        sex,
        broodPatch,
        skullOssification,
        hasBursa,
        bursaWidth,
        bursaLength,
        fat,
        stomachContent,
        testisLength,
        testisWidth,
        testisRemark,
        ovaryLength,
        ovaryWidth,
        oviductWidth,
        ovaryAppearance,
        firstOvaSize,
        secondOvaSize,
        thirdOvaSize,
        oviductAppearance,
        ovaryRemark,
        wingIsMolt,
        wingMolt,
        tailIsMolt,
        tailMolt,
        bodyMolt,
        moltRemark,
        specimenRemark,
        habitatRemark
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AvianMeasurementData &&
          other.specimenUuid == this.specimenUuid &&
          other.weight == this.weight &&
          other.wingspan == this.wingspan &&
          other.irisColor == this.irisColor &&
          other.irisHex == this.irisHex &&
          other.billColor == this.billColor &&
          other.billHex == this.billHex &&
          other.footColor == this.footColor &&
          other.footHex == this.footHex &&
          other.tarsusColor == this.tarsusColor &&
          other.tarsusHex == this.tarsusHex &&
          other.sex == this.sex &&
          other.broodPatch == this.broodPatch &&
          other.skullOssification == this.skullOssification &&
          other.hasBursa == this.hasBursa &&
          other.bursaWidth == this.bursaWidth &&
          other.bursaLength == this.bursaLength &&
          other.fat == this.fat &&
          other.stomachContent == this.stomachContent &&
          other.testisLength == this.testisLength &&
          other.testisWidth == this.testisWidth &&
          other.testisRemark == this.testisRemark &&
          other.ovaryLength == this.ovaryLength &&
          other.ovaryWidth == this.ovaryWidth &&
          other.oviductWidth == this.oviductWidth &&
          other.ovaryAppearance == this.ovaryAppearance &&
          other.firstOvaSize == this.firstOvaSize &&
          other.secondOvaSize == this.secondOvaSize &&
          other.thirdOvaSize == this.thirdOvaSize &&
          other.oviductAppearance == this.oviductAppearance &&
          other.ovaryRemark == this.ovaryRemark &&
          other.wingIsMolt == this.wingIsMolt &&
          other.wingMolt == this.wingMolt &&
          other.tailIsMolt == this.tailIsMolt &&
          other.tailMolt == this.tailMolt &&
          other.bodyMolt == this.bodyMolt &&
          other.moltRemark == this.moltRemark &&
          other.specimenRemark == this.specimenRemark &&
          other.habitatRemark == this.habitatRemark);
}

class AvianMeasurementCompanion extends UpdateCompanion<AvianMeasurementData> {
  final Value<String> specimenUuid;
  final Value<double?> weight;
  final Value<double?> wingspan;
  final Value<String?> irisColor;
  final Value<String?> irisHex;
  final Value<String?> billColor;
  final Value<String?> billHex;
  final Value<String?> footColor;
  final Value<String?> footHex;
  final Value<String?> tarsusColor;
  final Value<String?> tarsusHex;
  final Value<int?> sex;
  final Value<int?> broodPatch;
  final Value<int?> skullOssification;
  final Value<int?> hasBursa;
  final Value<double?> bursaWidth;
  final Value<double?> bursaLength;
  final Value<int?> fat;
  final Value<String?> stomachContent;
  final Value<double?> testisLength;
  final Value<double?> testisWidth;
  final Value<String?> testisRemark;
  final Value<double?> ovaryLength;
  final Value<double?> ovaryWidth;
  final Value<double?> oviductWidth;
  final Value<int?> ovaryAppearance;
  final Value<double?> firstOvaSize;
  final Value<double?> secondOvaSize;
  final Value<double?> thirdOvaSize;
  final Value<int?> oviductAppearance;
  final Value<String?> ovaryRemark;
  final Value<int?> wingIsMolt;
  final Value<String?> wingMolt;
  final Value<int?> tailIsMolt;
  final Value<String?> tailMolt;
  final Value<int?> bodyMolt;
  final Value<String?> moltRemark;
  final Value<String?> specimenRemark;
  final Value<String?> habitatRemark;
  final Value<int> rowid;
  const AvianMeasurementCompanion({
    this.specimenUuid = const Value.absent(),
    this.weight = const Value.absent(),
    this.wingspan = const Value.absent(),
    this.irisColor = const Value.absent(),
    this.irisHex = const Value.absent(),
    this.billColor = const Value.absent(),
    this.billHex = const Value.absent(),
    this.footColor = const Value.absent(),
    this.footHex = const Value.absent(),
    this.tarsusColor = const Value.absent(),
    this.tarsusHex = const Value.absent(),
    this.sex = const Value.absent(),
    this.broodPatch = const Value.absent(),
    this.skullOssification = const Value.absent(),
    this.hasBursa = const Value.absent(),
    this.bursaWidth = const Value.absent(),
    this.bursaLength = const Value.absent(),
    this.fat = const Value.absent(),
    this.stomachContent = const Value.absent(),
    this.testisLength = const Value.absent(),
    this.testisWidth = const Value.absent(),
    this.testisRemark = const Value.absent(),
    this.ovaryLength = const Value.absent(),
    this.ovaryWidth = const Value.absent(),
    this.oviductWidth = const Value.absent(),
    this.ovaryAppearance = const Value.absent(),
    this.firstOvaSize = const Value.absent(),
    this.secondOvaSize = const Value.absent(),
    this.thirdOvaSize = const Value.absent(),
    this.oviductAppearance = const Value.absent(),
    this.ovaryRemark = const Value.absent(),
    this.wingIsMolt = const Value.absent(),
    this.wingMolt = const Value.absent(),
    this.tailIsMolt = const Value.absent(),
    this.tailMolt = const Value.absent(),
    this.bodyMolt = const Value.absent(),
    this.moltRemark = const Value.absent(),
    this.specimenRemark = const Value.absent(),
    this.habitatRemark = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AvianMeasurementCompanion.insert({
    required String specimenUuid,
    this.weight = const Value.absent(),
    this.wingspan = const Value.absent(),
    this.irisColor = const Value.absent(),
    this.irisHex = const Value.absent(),
    this.billColor = const Value.absent(),
    this.billHex = const Value.absent(),
    this.footColor = const Value.absent(),
    this.footHex = const Value.absent(),
    this.tarsusColor = const Value.absent(),
    this.tarsusHex = const Value.absent(),
    this.sex = const Value.absent(),
    this.broodPatch = const Value.absent(),
    this.skullOssification = const Value.absent(),
    this.hasBursa = const Value.absent(),
    this.bursaWidth = const Value.absent(),
    this.bursaLength = const Value.absent(),
    this.fat = const Value.absent(),
    this.stomachContent = const Value.absent(),
    this.testisLength = const Value.absent(),
    this.testisWidth = const Value.absent(),
    this.testisRemark = const Value.absent(),
    this.ovaryLength = const Value.absent(),
    this.ovaryWidth = const Value.absent(),
    this.oviductWidth = const Value.absent(),
    this.ovaryAppearance = const Value.absent(),
    this.firstOvaSize = const Value.absent(),
    this.secondOvaSize = const Value.absent(),
    this.thirdOvaSize = const Value.absent(),
    this.oviductAppearance = const Value.absent(),
    this.ovaryRemark = const Value.absent(),
    this.wingIsMolt = const Value.absent(),
    this.wingMolt = const Value.absent(),
    this.tailIsMolt = const Value.absent(),
    this.tailMolt = const Value.absent(),
    this.bodyMolt = const Value.absent(),
    this.moltRemark = const Value.absent(),
    this.specimenRemark = const Value.absent(),
    this.habitatRemark = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : specimenUuid = Value(specimenUuid);
  static Insertable<AvianMeasurementData> custom({
    Expression<String>? specimenUuid,
    Expression<double>? weight,
    Expression<double>? wingspan,
    Expression<String>? irisColor,
    Expression<String>? irisHex,
    Expression<String>? billColor,
    Expression<String>? billHex,
    Expression<String>? footColor,
    Expression<String>? footHex,
    Expression<String>? tarsusColor,
    Expression<String>? tarsusHex,
    Expression<int>? sex,
    Expression<int>? broodPatch,
    Expression<int>? skullOssification,
    Expression<int>? hasBursa,
    Expression<double>? bursaWidth,
    Expression<double>? bursaLength,
    Expression<int>? fat,
    Expression<String>? stomachContent,
    Expression<double>? testisLength,
    Expression<double>? testisWidth,
    Expression<String>? testisRemark,
    Expression<double>? ovaryLength,
    Expression<double>? ovaryWidth,
    Expression<double>? oviductWidth,
    Expression<int>? ovaryAppearance,
    Expression<double>? firstOvaSize,
    Expression<double>? secondOvaSize,
    Expression<double>? thirdOvaSize,
    Expression<int>? oviductAppearance,
    Expression<String>? ovaryRemark,
    Expression<int>? wingIsMolt,
    Expression<String>? wingMolt,
    Expression<int>? tailIsMolt,
    Expression<String>? tailMolt,
    Expression<int>? bodyMolt,
    Expression<String>? moltRemark,
    Expression<String>? specimenRemark,
    Expression<String>? habitatRemark,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (specimenUuid != null) 'specimenUuid': specimenUuid,
      if (weight != null) 'weight': weight,
      if (wingspan != null) 'wingspan': wingspan,
      if (irisColor != null) 'irisColor': irisColor,
      if (irisHex != null) 'irisHex': irisHex,
      if (billColor != null) 'billColor': billColor,
      if (billHex != null) 'billHex': billHex,
      if (footColor != null) 'footColor': footColor,
      if (footHex != null) 'footHex': footHex,
      if (tarsusColor != null) 'tarsusColor': tarsusColor,
      if (tarsusHex != null) 'tarsusHex': tarsusHex,
      if (sex != null) 'sex': sex,
      if (broodPatch != null) 'broodPatch': broodPatch,
      if (skullOssification != null) 'skullOssification': skullOssification,
      if (hasBursa != null) 'hasBursa': hasBursa,
      if (bursaWidth != null) 'bursaWidth': bursaWidth,
      if (bursaLength != null) 'bursaLength': bursaLength,
      if (fat != null) 'fat': fat,
      if (stomachContent != null) 'stomachContent': stomachContent,
      if (testisLength != null) 'testisLength': testisLength,
      if (testisWidth != null) 'testisWidth': testisWidth,
      if (testisRemark != null) 'testisRemark': testisRemark,
      if (ovaryLength != null) 'ovaryLength': ovaryLength,
      if (ovaryWidth != null) 'ovaryWidth': ovaryWidth,
      if (oviductWidth != null) 'oviductWidth': oviductWidth,
      if (ovaryAppearance != null) 'ovaryAppearance': ovaryAppearance,
      if (firstOvaSize != null) 'firstOvaSize': firstOvaSize,
      if (secondOvaSize != null) 'secondOvaSize': secondOvaSize,
      if (thirdOvaSize != null) 'thirdOvaSize': thirdOvaSize,
      if (oviductAppearance != null) 'oviductAppearance': oviductAppearance,
      if (ovaryRemark != null) 'ovaryRemark': ovaryRemark,
      if (wingIsMolt != null) 'wingIsMolt': wingIsMolt,
      if (wingMolt != null) 'wingMolt': wingMolt,
      if (tailIsMolt != null) 'tailIsMolt': tailIsMolt,
      if (tailMolt != null) 'tailMolt': tailMolt,
      if (bodyMolt != null) 'bodyMolt': bodyMolt,
      if (moltRemark != null) 'moltRemark': moltRemark,
      if (specimenRemark != null) 'specimenRemark': specimenRemark,
      if (habitatRemark != null) 'habitatRemark': habitatRemark,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AvianMeasurementCompanion copyWith(
      {Value<String>? specimenUuid,
      Value<double?>? weight,
      Value<double?>? wingspan,
      Value<String?>? irisColor,
      Value<String?>? irisHex,
      Value<String?>? billColor,
      Value<String?>? billHex,
      Value<String?>? footColor,
      Value<String?>? footHex,
      Value<String?>? tarsusColor,
      Value<String?>? tarsusHex,
      Value<int?>? sex,
      Value<int?>? broodPatch,
      Value<int?>? skullOssification,
      Value<int?>? hasBursa,
      Value<double?>? bursaWidth,
      Value<double?>? bursaLength,
      Value<int?>? fat,
      Value<String?>? stomachContent,
      Value<double?>? testisLength,
      Value<double?>? testisWidth,
      Value<String?>? testisRemark,
      Value<double?>? ovaryLength,
      Value<double?>? ovaryWidth,
      Value<double?>? oviductWidth,
      Value<int?>? ovaryAppearance,
      Value<double?>? firstOvaSize,
      Value<double?>? secondOvaSize,
      Value<double?>? thirdOvaSize,
      Value<int?>? oviductAppearance,
      Value<String?>? ovaryRemark,
      Value<int?>? wingIsMolt,
      Value<String?>? wingMolt,
      Value<int?>? tailIsMolt,
      Value<String?>? tailMolt,
      Value<int?>? bodyMolt,
      Value<String?>? moltRemark,
      Value<String?>? specimenRemark,
      Value<String?>? habitatRemark,
      Value<int>? rowid}) {
    return AvianMeasurementCompanion(
      specimenUuid: specimenUuid ?? this.specimenUuid,
      weight: weight ?? this.weight,
      wingspan: wingspan ?? this.wingspan,
      irisColor: irisColor ?? this.irisColor,
      irisHex: irisHex ?? this.irisHex,
      billColor: billColor ?? this.billColor,
      billHex: billHex ?? this.billHex,
      footColor: footColor ?? this.footColor,
      footHex: footHex ?? this.footHex,
      tarsusColor: tarsusColor ?? this.tarsusColor,
      tarsusHex: tarsusHex ?? this.tarsusHex,
      sex: sex ?? this.sex,
      broodPatch: broodPatch ?? this.broodPatch,
      skullOssification: skullOssification ?? this.skullOssification,
      hasBursa: hasBursa ?? this.hasBursa,
      bursaWidth: bursaWidth ?? this.bursaWidth,
      bursaLength: bursaLength ?? this.bursaLength,
      fat: fat ?? this.fat,
      stomachContent: stomachContent ?? this.stomachContent,
      testisLength: testisLength ?? this.testisLength,
      testisWidth: testisWidth ?? this.testisWidth,
      testisRemark: testisRemark ?? this.testisRemark,
      ovaryLength: ovaryLength ?? this.ovaryLength,
      ovaryWidth: ovaryWidth ?? this.ovaryWidth,
      oviductWidth: oviductWidth ?? this.oviductWidth,
      ovaryAppearance: ovaryAppearance ?? this.ovaryAppearance,
      firstOvaSize: firstOvaSize ?? this.firstOvaSize,
      secondOvaSize: secondOvaSize ?? this.secondOvaSize,
      thirdOvaSize: thirdOvaSize ?? this.thirdOvaSize,
      oviductAppearance: oviductAppearance ?? this.oviductAppearance,
      ovaryRemark: ovaryRemark ?? this.ovaryRemark,
      wingIsMolt: wingIsMolt ?? this.wingIsMolt,
      wingMolt: wingMolt ?? this.wingMolt,
      tailIsMolt: tailIsMolt ?? this.tailIsMolt,
      tailMolt: tailMolt ?? this.tailMolt,
      bodyMolt: bodyMolt ?? this.bodyMolt,
      moltRemark: moltRemark ?? this.moltRemark,
      specimenRemark: specimenRemark ?? this.specimenRemark,
      habitatRemark: habitatRemark ?? this.habitatRemark,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (specimenUuid.present) {
      map['specimenUuid'] = Variable<String>(specimenUuid.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (wingspan.present) {
      map['wingspan'] = Variable<double>(wingspan.value);
    }
    if (irisColor.present) {
      map['irisColor'] = Variable<String>(irisColor.value);
    }
    if (irisHex.present) {
      map['irisHex'] = Variable<String>(irisHex.value);
    }
    if (billColor.present) {
      map['billColor'] = Variable<String>(billColor.value);
    }
    if (billHex.present) {
      map['billHex'] = Variable<String>(billHex.value);
    }
    if (footColor.present) {
      map['footColor'] = Variable<String>(footColor.value);
    }
    if (footHex.present) {
      map['footHex'] = Variable<String>(footHex.value);
    }
    if (tarsusColor.present) {
      map['tarsusColor'] = Variable<String>(tarsusColor.value);
    }
    if (tarsusHex.present) {
      map['tarsusHex'] = Variable<String>(tarsusHex.value);
    }
    if (sex.present) {
      map['sex'] = Variable<int>(sex.value);
    }
    if (broodPatch.present) {
      map['broodPatch'] = Variable<int>(broodPatch.value);
    }
    if (skullOssification.present) {
      map['skullOssification'] = Variable<int>(skullOssification.value);
    }
    if (hasBursa.present) {
      map['hasBursa'] = Variable<int>(hasBursa.value);
    }
    if (bursaWidth.present) {
      map['bursaWidth'] = Variable<double>(bursaWidth.value);
    }
    if (bursaLength.present) {
      map['bursaLength'] = Variable<double>(bursaLength.value);
    }
    if (fat.present) {
      map['fat'] = Variable<int>(fat.value);
    }
    if (stomachContent.present) {
      map['stomachContent'] = Variable<String>(stomachContent.value);
    }
    if (testisLength.present) {
      map['testisLength'] = Variable<double>(testisLength.value);
    }
    if (testisWidth.present) {
      map['testisWidth'] = Variable<double>(testisWidth.value);
    }
    if (testisRemark.present) {
      map['testisRemark'] = Variable<String>(testisRemark.value);
    }
    if (ovaryLength.present) {
      map['ovaryLength'] = Variable<double>(ovaryLength.value);
    }
    if (ovaryWidth.present) {
      map['ovaryWidth'] = Variable<double>(ovaryWidth.value);
    }
    if (oviductWidth.present) {
      map['oviductWidth'] = Variable<double>(oviductWidth.value);
    }
    if (ovaryAppearance.present) {
      map['ovaryAppearance'] = Variable<int>(ovaryAppearance.value);
    }
    if (firstOvaSize.present) {
      map['firstOvaSize'] = Variable<double>(firstOvaSize.value);
    }
    if (secondOvaSize.present) {
      map['secondOvaSize'] = Variable<double>(secondOvaSize.value);
    }
    if (thirdOvaSize.present) {
      map['thirdOvaSize'] = Variable<double>(thirdOvaSize.value);
    }
    if (oviductAppearance.present) {
      map['oviductAppearance'] = Variable<int>(oviductAppearance.value);
    }
    if (ovaryRemark.present) {
      map['ovaryRemark'] = Variable<String>(ovaryRemark.value);
    }
    if (wingIsMolt.present) {
      map['wingIsMolt'] = Variable<int>(wingIsMolt.value);
    }
    if (wingMolt.present) {
      map['wingMolt'] = Variable<String>(wingMolt.value);
    }
    if (tailIsMolt.present) {
      map['tailIsMolt'] = Variable<int>(tailIsMolt.value);
    }
    if (tailMolt.present) {
      map['tailMolt'] = Variable<String>(tailMolt.value);
    }
    if (bodyMolt.present) {
      map['bodyMolt'] = Variable<int>(bodyMolt.value);
    }
    if (moltRemark.present) {
      map['moltRemark'] = Variable<String>(moltRemark.value);
    }
    if (specimenRemark.present) {
      map['specimenRemark'] = Variable<String>(specimenRemark.value);
    }
    if (habitatRemark.present) {
      map['habitatRemark'] = Variable<String>(habitatRemark.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AvianMeasurementCompanion(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('weight: $weight, ')
          ..write('wingspan: $wingspan, ')
          ..write('irisColor: $irisColor, ')
          ..write('irisHex: $irisHex, ')
          ..write('billColor: $billColor, ')
          ..write('billHex: $billHex, ')
          ..write('footColor: $footColor, ')
          ..write('footHex: $footHex, ')
          ..write('tarsusColor: $tarsusColor, ')
          ..write('tarsusHex: $tarsusHex, ')
          ..write('sex: $sex, ')
          ..write('broodPatch: $broodPatch, ')
          ..write('skullOssification: $skullOssification, ')
          ..write('hasBursa: $hasBursa, ')
          ..write('bursaWidth: $bursaWidth, ')
          ..write('bursaLength: $bursaLength, ')
          ..write('fat: $fat, ')
          ..write('stomachContent: $stomachContent, ')
          ..write('testisLength: $testisLength, ')
          ..write('testisWidth: $testisWidth, ')
          ..write('testisRemark: $testisRemark, ')
          ..write('ovaryLength: $ovaryLength, ')
          ..write('ovaryWidth: $ovaryWidth, ')
          ..write('oviductWidth: $oviductWidth, ')
          ..write('ovaryAppearance: $ovaryAppearance, ')
          ..write('firstOvaSize: $firstOvaSize, ')
          ..write('secondOvaSize: $secondOvaSize, ')
          ..write('thirdOvaSize: $thirdOvaSize, ')
          ..write('oviductAppearance: $oviductAppearance, ')
          ..write('ovaryRemark: $ovaryRemark, ')
          ..write('wingIsMolt: $wingIsMolt, ')
          ..write('wingMolt: $wingMolt, ')
          ..write('tailIsMolt: $tailIsMolt, ')
          ..write('tailMolt: $tailMolt, ')
          ..write('bodyMolt: $bodyMolt, ')
          ..write('moltRemark: $moltRemark, ')
          ..write('specimenRemark: $specimenRemark, ')
          ..write('habitatRemark: $habitatRemark, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class SpecimenPart extends Table
    with TableInfo<SpecimenPart, SpecimenPartData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SpecimenPart(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String> specimenUuid = GeneratedColumn<String>(
      'specimenUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tissueIDMeta =
      const VerificationMeta('tissueID');
  late final GeneratedColumn<String> tissueID = GeneratedColumn<String>(
      'tissueID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _barcodeIDMeta =
      const VerificationMeta('barcodeID');
  late final GeneratedColumn<String> barcodeID = GeneratedColumn<String>(
      'barcodeID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  late final GeneratedColumn<String> count = GeneratedColumn<String>(
      'count', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _treatmentMeta =
      const VerificationMeta('treatment');
  late final GeneratedColumn<String> treatment = GeneratedColumn<String>(
      'treatment', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _additionalTreatmentMeta =
      const VerificationMeta('additionalTreatment');
  late final GeneratedColumn<String> additionalTreatment =
      GeneratedColumn<String>('additionalTreatment', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _dateTakenMeta =
      const VerificationMeta('dateTaken');
  late final GeneratedColumn<String> dateTaken = GeneratedColumn<String>(
      'dateTaken', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _timeTakenMeta =
      const VerificationMeta('timeTaken');
  late final GeneratedColumn<String> timeTaken = GeneratedColumn<String>(
      'timeTaken', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _museumPermanentMeta =
      const VerificationMeta('museumPermanent');
  late final GeneratedColumn<String> museumPermanent = GeneratedColumn<String>(
      'museumPermanent', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _museumLoanMeta =
      const VerificationMeta('museumLoan');
  late final GeneratedColumn<String> museumLoan = GeneratedColumn<String>(
      'museumLoan', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        specimenUuid,
        tissueID,
        barcodeID,
        type,
        count,
        treatment,
        additionalTreatment,
        dateTaken,
        timeTaken,
        museumPermanent,
        museumLoan,
        remark
      ];
  @override
  String get aliasedName => _alias ?? 'specimenPart';
  @override
  String get actualTableName => 'specimenPart';
  @override
  VerificationContext validateIntegrity(Insertable<SpecimenPartData> instance,
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
    if (data.containsKey('tissueID')) {
      context.handle(_tissueIDMeta,
          tissueID.isAcceptableOrUnknown(data['tissueID']!, _tissueIDMeta));
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
    if (data.containsKey('dateTaken')) {
      context.handle(_dateTakenMeta,
          dateTaken.isAcceptableOrUnknown(data['dateTaken']!, _dateTakenMeta));
    }
    if (data.containsKey('timeTaken')) {
      context.handle(_timeTakenMeta,
          timeTaken.isAcceptableOrUnknown(data['timeTaken']!, _timeTakenMeta));
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
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpecimenPartData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpecimenPartData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      specimenUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specimenUuid']),
      tissueID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tissueID']),
      barcodeID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcodeID']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}count']),
      treatment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}treatment']),
      additionalTreatment: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}additionalTreatment']),
      dateTaken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dateTaken']),
      timeTaken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timeTaken']),
      museumPermanent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}museumPermanent']),
      museumLoan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}museumLoan']),
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
    );
  }

  @override
  SpecimenPart createAlias(String alias) {
    return SpecimenPart(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(specimenUuid)REFERENCES specimen(uuid)'];
  @override
  bool get dontWriteConstraints => true;
}

class SpecimenPartData extends DataClass
    implements Insertable<SpecimenPartData> {
  final int? id;

  /// internal id
  final String? specimenUuid;
  final String? tissueID;
  final String? barcodeID;
  final String? type;
  final String? count;
  final String? treatment;
  final String? additionalTreatment;
  final String? dateTaken;
  final String? timeTaken;
  final String? museumPermanent;
  final String? museumLoan;
  final String? remark;
  const SpecimenPartData(
      {this.id,
      this.specimenUuid,
      this.tissueID,
      this.barcodeID,
      this.type,
      this.count,
      this.treatment,
      this.additionalTreatment,
      this.dateTaken,
      this.timeTaken,
      this.museumPermanent,
      this.museumLoan,
      this.remark});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || specimenUuid != null) {
      map['specimenUuid'] = Variable<String>(specimenUuid);
    }
    if (!nullToAbsent || tissueID != null) {
      map['tissueID'] = Variable<String>(tissueID);
    }
    if (!nullToAbsent || barcodeID != null) {
      map['barcodeID'] = Variable<String>(barcodeID);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<String>(count);
    }
    if (!nullToAbsent || treatment != null) {
      map['treatment'] = Variable<String>(treatment);
    }
    if (!nullToAbsent || additionalTreatment != null) {
      map['additionalTreatment'] = Variable<String>(additionalTreatment);
    }
    if (!nullToAbsent || dateTaken != null) {
      map['dateTaken'] = Variable<String>(dateTaken);
    }
    if (!nullToAbsent || timeTaken != null) {
      map['timeTaken'] = Variable<String>(timeTaken);
    }
    if (!nullToAbsent || museumPermanent != null) {
      map['museumPermanent'] = Variable<String>(museumPermanent);
    }
    if (!nullToAbsent || museumLoan != null) {
      map['museumLoan'] = Variable<String>(museumLoan);
    }
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    return map;
  }

  SpecimenPartCompanion toCompanion(bool nullToAbsent) {
    return SpecimenPartCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      specimenUuid: specimenUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(specimenUuid),
      tissueID: tissueID == null && nullToAbsent
          ? const Value.absent()
          : Value(tissueID),
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
      dateTaken: dateTaken == null && nullToAbsent
          ? const Value.absent()
          : Value(dateTaken),
      timeTaken: timeTaken == null && nullToAbsent
          ? const Value.absent()
          : Value(timeTaken),
      museumPermanent: museumPermanent == null && nullToAbsent
          ? const Value.absent()
          : Value(museumPermanent),
      museumLoan: museumLoan == null && nullToAbsent
          ? const Value.absent()
          : Value(museumLoan),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
    );
  }

  factory SpecimenPartData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpecimenPartData(
      id: serializer.fromJson<int?>(json['id']),
      specimenUuid: serializer.fromJson<String?>(json['specimenUuid']),
      tissueID: serializer.fromJson<String?>(json['tissueID']),
      barcodeID: serializer.fromJson<String?>(json['barcodeID']),
      type: serializer.fromJson<String?>(json['type']),
      count: serializer.fromJson<String?>(json['count']),
      treatment: serializer.fromJson<String?>(json['treatment']),
      additionalTreatment:
          serializer.fromJson<String?>(json['additionalTreatment']),
      dateTaken: serializer.fromJson<String?>(json['dateTaken']),
      timeTaken: serializer.fromJson<String?>(json['timeTaken']),
      museumPermanent: serializer.fromJson<String?>(json['museumPermanent']),
      museumLoan: serializer.fromJson<String?>(json['museumLoan']),
      remark: serializer.fromJson<String?>(json['remark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'specimenUuid': serializer.toJson<String?>(specimenUuid),
      'tissueID': serializer.toJson<String?>(tissueID),
      'barcodeID': serializer.toJson<String?>(barcodeID),
      'type': serializer.toJson<String?>(type),
      'count': serializer.toJson<String?>(count),
      'treatment': serializer.toJson<String?>(treatment),
      'additionalTreatment': serializer.toJson<String?>(additionalTreatment),
      'dateTaken': serializer.toJson<String?>(dateTaken),
      'timeTaken': serializer.toJson<String?>(timeTaken),
      'museumPermanent': serializer.toJson<String?>(museumPermanent),
      'museumLoan': serializer.toJson<String?>(museumLoan),
      'remark': serializer.toJson<String?>(remark),
    };
  }

  SpecimenPartData copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> specimenUuid = const Value.absent(),
          Value<String?> tissueID = const Value.absent(),
          Value<String?> barcodeID = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<String?> count = const Value.absent(),
          Value<String?> treatment = const Value.absent(),
          Value<String?> additionalTreatment = const Value.absent(),
          Value<String?> dateTaken = const Value.absent(),
          Value<String?> timeTaken = const Value.absent(),
          Value<String?> museumPermanent = const Value.absent(),
          Value<String?> museumLoan = const Value.absent(),
          Value<String?> remark = const Value.absent()}) =>
      SpecimenPartData(
        id: id.present ? id.value : this.id,
        specimenUuid:
            specimenUuid.present ? specimenUuid.value : this.specimenUuid,
        tissueID: tissueID.present ? tissueID.value : this.tissueID,
        barcodeID: barcodeID.present ? barcodeID.value : this.barcodeID,
        type: type.present ? type.value : this.type,
        count: count.present ? count.value : this.count,
        treatment: treatment.present ? treatment.value : this.treatment,
        additionalTreatment: additionalTreatment.present
            ? additionalTreatment.value
            : this.additionalTreatment,
        dateTaken: dateTaken.present ? dateTaken.value : this.dateTaken,
        timeTaken: timeTaken.present ? timeTaken.value : this.timeTaken,
        museumPermanent: museumPermanent.present
            ? museumPermanent.value
            : this.museumPermanent,
        museumLoan: museumLoan.present ? museumLoan.value : this.museumLoan,
        remark: remark.present ? remark.value : this.remark,
      );
  @override
  String toString() {
    return (StringBuffer('SpecimenPartData(')
          ..write('id: $id, ')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('tissueID: $tissueID, ')
          ..write('barcodeID: $barcodeID, ')
          ..write('type: $type, ')
          ..write('count: $count, ')
          ..write('treatment: $treatment, ')
          ..write('additionalTreatment: $additionalTreatment, ')
          ..write('dateTaken: $dateTaken, ')
          ..write('timeTaken: $timeTaken, ')
          ..write('museumPermanent: $museumPermanent, ')
          ..write('museumLoan: $museumLoan, ')
          ..write('remark: $remark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      specimenUuid,
      tissueID,
      barcodeID,
      type,
      count,
      treatment,
      additionalTreatment,
      dateTaken,
      timeTaken,
      museumPermanent,
      museumLoan,
      remark);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecimenPartData &&
          other.id == this.id &&
          other.specimenUuid == this.specimenUuid &&
          other.tissueID == this.tissueID &&
          other.barcodeID == this.barcodeID &&
          other.type == this.type &&
          other.count == this.count &&
          other.treatment == this.treatment &&
          other.additionalTreatment == this.additionalTreatment &&
          other.dateTaken == this.dateTaken &&
          other.timeTaken == this.timeTaken &&
          other.museumPermanent == this.museumPermanent &&
          other.museumLoan == this.museumLoan &&
          other.remark == this.remark);
}

class SpecimenPartCompanion extends UpdateCompanion<SpecimenPartData> {
  final Value<int?> id;
  final Value<String?> specimenUuid;
  final Value<String?> tissueID;
  final Value<String?> barcodeID;
  final Value<String?> type;
  final Value<String?> count;
  final Value<String?> treatment;
  final Value<String?> additionalTreatment;
  final Value<String?> dateTaken;
  final Value<String?> timeTaken;
  final Value<String?> museumPermanent;
  final Value<String?> museumLoan;
  final Value<String?> remark;
  const SpecimenPartCompanion({
    this.id = const Value.absent(),
    this.specimenUuid = const Value.absent(),
    this.tissueID = const Value.absent(),
    this.barcodeID = const Value.absent(),
    this.type = const Value.absent(),
    this.count = const Value.absent(),
    this.treatment = const Value.absent(),
    this.additionalTreatment = const Value.absent(),
    this.dateTaken = const Value.absent(),
    this.timeTaken = const Value.absent(),
    this.museumPermanent = const Value.absent(),
    this.museumLoan = const Value.absent(),
    this.remark = const Value.absent(),
  });
  SpecimenPartCompanion.insert({
    this.id = const Value.absent(),
    this.specimenUuid = const Value.absent(),
    this.tissueID = const Value.absent(),
    this.barcodeID = const Value.absent(),
    this.type = const Value.absent(),
    this.count = const Value.absent(),
    this.treatment = const Value.absent(),
    this.additionalTreatment = const Value.absent(),
    this.dateTaken = const Value.absent(),
    this.timeTaken = const Value.absent(),
    this.museumPermanent = const Value.absent(),
    this.museumLoan = const Value.absent(),
    this.remark = const Value.absent(),
  });
  static Insertable<SpecimenPartData> custom({
    Expression<int>? id,
    Expression<String>? specimenUuid,
    Expression<String>? tissueID,
    Expression<String>? barcodeID,
    Expression<String>? type,
    Expression<String>? count,
    Expression<String>? treatment,
    Expression<String>? additionalTreatment,
    Expression<String>? dateTaken,
    Expression<String>? timeTaken,
    Expression<String>? museumPermanent,
    Expression<String>? museumLoan,
    Expression<String>? remark,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (specimenUuid != null) 'specimenUuid': specimenUuid,
      if (tissueID != null) 'tissueID': tissueID,
      if (barcodeID != null) 'barcodeID': barcodeID,
      if (type != null) 'type': type,
      if (count != null) 'count': count,
      if (treatment != null) 'treatment': treatment,
      if (additionalTreatment != null)
        'additionalTreatment': additionalTreatment,
      if (dateTaken != null) 'dateTaken': dateTaken,
      if (timeTaken != null) 'timeTaken': timeTaken,
      if (museumPermanent != null) 'museumPermanent': museumPermanent,
      if (museumLoan != null) 'museumLoan': museumLoan,
      if (remark != null) 'remark': remark,
    });
  }

  SpecimenPartCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? specimenUuid,
      Value<String?>? tissueID,
      Value<String?>? barcodeID,
      Value<String?>? type,
      Value<String?>? count,
      Value<String?>? treatment,
      Value<String?>? additionalTreatment,
      Value<String?>? dateTaken,
      Value<String?>? timeTaken,
      Value<String?>? museumPermanent,
      Value<String?>? museumLoan,
      Value<String?>? remark}) {
    return SpecimenPartCompanion(
      id: id ?? this.id,
      specimenUuid: specimenUuid ?? this.specimenUuid,
      tissueID: tissueID ?? this.tissueID,
      barcodeID: barcodeID ?? this.barcodeID,
      type: type ?? this.type,
      count: count ?? this.count,
      treatment: treatment ?? this.treatment,
      additionalTreatment: additionalTreatment ?? this.additionalTreatment,
      dateTaken: dateTaken ?? this.dateTaken,
      timeTaken: timeTaken ?? this.timeTaken,
      museumPermanent: museumPermanent ?? this.museumPermanent,
      museumLoan: museumLoan ?? this.museumLoan,
      remark: remark ?? this.remark,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (specimenUuid.present) {
      map['specimenUuid'] = Variable<String>(specimenUuid.value);
    }
    if (tissueID.present) {
      map['tissueID'] = Variable<String>(tissueID.value);
    }
    if (barcodeID.present) {
      map['barcodeID'] = Variable<String>(barcodeID.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (count.present) {
      map['count'] = Variable<String>(count.value);
    }
    if (treatment.present) {
      map['treatment'] = Variable<String>(treatment.value);
    }
    if (additionalTreatment.present) {
      map['additionalTreatment'] = Variable<String>(additionalTreatment.value);
    }
    if (dateTaken.present) {
      map['dateTaken'] = Variable<String>(dateTaken.value);
    }
    if (timeTaken.present) {
      map['timeTaken'] = Variable<String>(timeTaken.value);
    }
    if (museumPermanent.present) {
      map['museumPermanent'] = Variable<String>(museumPermanent.value);
    }
    if (museumLoan.present) {
      map['museumLoan'] = Variable<String>(museumLoan.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecimenPartCompanion(')
          ..write('id: $id, ')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('tissueID: $tissueID, ')
          ..write('barcodeID: $barcodeID, ')
          ..write('type: $type, ')
          ..write('count: $count, ')
          ..write('treatment: $treatment, ')
          ..write('additionalTreatment: $additionalTreatment, ')
          ..write('dateTaken: $dateTaken, ')
          ..write('timeTaken: $timeTaken, ')
          ..write('museumPermanent: $museumPermanent, ')
          ..write('museumLoan: $museumLoan, ')
          ..write('remark: $remark')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final Project project = Project(this);
  late final Personnel personnel = Personnel(this);
  late final Media media = Media(this);
  late final Site site = Site(this);
  late final Coordinate coordinate = Coordinate(this);
  late final CollEvent collEvent = CollEvent(this);
  late final Weather weather = Weather(this);
  late final CollPersonnel collPersonnel = CollPersonnel(this);
  late final CollEffort collEffort = CollEffort(this);
  late final Narrative narrative = Narrative(this);
  late final NarrativeMedia narrativeMedia = NarrativeMedia(this);
  late final SiteMedia siteMedia = SiteMedia(this);
  late final Taxonomy taxonomy = Taxonomy(this);
  late final Specimen specimen = Specimen(this);
  late final SpecimenMedia specimenMedia = SpecimenMedia(this);
  late final AssociatedData associatedData = AssociatedData(this);
  late final PersonnelList personnelList = PersonnelList(this);
  late final ProjectPersonnel projectPersonnel = ProjectPersonnel(this);
  late final MammalMeasurement mammalMeasurement = MammalMeasurement(this);
  late final AvianMeasurement avianMeasurement = AvianMeasurement(this);
  late final SpecimenPart specimenPart = SpecimenPart(this);
  Selectable<ListProjectResult> listProject() {
    return customSelect('SELECT uuid, name, created, lastAccessed FROM project',
        variables: [],
        readsFrom: {
          project,
        }).map((QueryRow row) {
      return ListProjectResult(
        uuid: row.read<String>('uuid'),
        name: row.read<String>('name'),
        created: row.readNullable<String>('created'),
        lastAccessed: row.readNullable<String>('lastAccessed'),
      );
    });
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        project,
        personnel,
        media,
        site,
        coordinate,
        collEvent,
        weather,
        collPersonnel,
        collEffort,
        narrative,
        narrativeMedia,
        siteMedia,
        taxonomy,
        specimen,
        specimenMedia,
        associatedData,
        personnelList,
        projectPersonnel,
        mammalMeasurement,
        avianMeasurement,
        specimenPart
      ];
}

class ListProjectResult {
  final String uuid;
  final String name;
  final String? created;
  final String? lastAccessed;
  ListProjectResult({
    required this.uuid,
    required this.name,
    this.created,
    this.lastAccessed,
  });
}
