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
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  late final GeneratedColumn<String> created = GeneratedColumn<String>(
      'created', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  late final GeneratedColumn<String> lastModified = GeneratedColumn<String>(
      'lastModified', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, name, description, principalInvestigator, created, lastModified];
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
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('lastModified')) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableOrUnknown(
              data['lastModified']!, _lastModifiedMeta));
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
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created']),
      lastModified: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lastModified']),
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
  final String? created;
  final String? lastModified;
  const ProjectData(
      {required this.uuid,
      required this.name,
      this.description,
      this.principalInvestigator,
      this.created,
      this.lastModified});
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
    if (!nullToAbsent || created != null) {
      map['created'] = Variable<String>(created);
    }
    if (!nullToAbsent || lastModified != null) {
      map['lastModified'] = Variable<String>(lastModified);
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
      created: created == null && nullToAbsent
          ? const Value.absent()
          : Value(created),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
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
      created: serializer.fromJson<String?>(json['created']),
      lastModified: serializer.fromJson<String?>(json['lastModified']),
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
      'created': serializer.toJson<String?>(created),
      'lastModified': serializer.toJson<String?>(lastModified),
    };
  }

  ProjectData copyWith(
          {String? uuid,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> principalInvestigator = const Value.absent(),
          Value<String?> created = const Value.absent(),
          Value<String?> lastModified = const Value.absent()}) =>
      ProjectData(
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        principalInvestigator: principalInvestigator.present
            ? principalInvestigator.value
            : this.principalInvestigator,
        created: created.present ? created.value : this.created,
        lastModified:
            lastModified.present ? lastModified.value : this.lastModified,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectData(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('principalInvestigator: $principalInvestigator, ')
          ..write('created: $created, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uuid, name, description, principalInvestigator, created, lastModified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectData &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.description == this.description &&
          other.principalInvestigator == this.principalInvestigator &&
          other.created == this.created &&
          other.lastModified == this.lastModified);
}

class ProjectCompanion extends UpdateCompanion<ProjectData> {
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> principalInvestigator;
  final Value<String?> created;
  final Value<String?> lastModified;
  const ProjectCompanion({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.principalInvestigator = const Value.absent(),
    this.created = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  ProjectCompanion.insert({
    required String uuid,
    required String name,
    this.description = const Value.absent(),
    this.principalInvestigator = const Value.absent(),
    this.created = const Value.absent(),
    this.lastModified = const Value.absent(),
  })  : uuid = Value(uuid),
        name = Value(name);
  static Insertable<ProjectData> custom({
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? principalInvestigator,
    Expression<String>? created,
    Expression<String>? lastModified,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (principalInvestigator != null)
        'principalInvestigator': principalInvestigator,
      if (created != null) 'created': created,
      if (lastModified != null) 'lastModified': lastModified,
    });
  }

  ProjectCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? principalInvestigator,
      Value<String?>? created,
      Value<String?>? lastModified}) {
    return ProjectCompanion(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      principalInvestigator:
          principalInvestigator ?? this.principalInvestigator,
      created: created ?? this.created,
      lastModified: lastModified ?? this.lastModified,
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
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (lastModified.present) {
      map['lastModified'] = Variable<String>(lastModified.value);
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
          ..write('created: $created, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }
}

class FileMetadata extends Table
    with TableInfo<FileMetadata, FileMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  FileMetadata(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _filenameMeta =
      const VerificationMeta('filename');
  late final GeneratedColumn<String> filename = GeneratedColumn<String>(
      'filename', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sizeKbMeta = const VerificationMeta('sizeKb');
  late final GeneratedColumn<double> sizeKb = GeneratedColumn<double>(
      'sizeKb', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _relativePathMeta =
      const VerificationMeta('relativePath');
  late final GeneratedColumn<Uint8List> relativePath =
      GeneratedColumn<Uint8List>('relativePath', aliasedName, true,
          type: DriftSqlType.blob,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  late final GeneratedColumn<String> created = GeneratedColumn<String>(
      'created', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, filename, sizeKb, relativePath, created];
  @override
  String get aliasedName => _alias ?? 'fileMetadata';
  @override
  String get actualTableName => 'fileMetadata';
  @override
  VerificationContext validateIntegrity(Insertable<FileMetadataData> instance,
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
    if (data.containsKey('sizeKb')) {
      context.handle(_sizeKbMeta,
          sizeKb.isAcceptableOrUnknown(data['sizeKb']!, _sizeKbMeta));
    }
    if (data.containsKey('relativePath')) {
      context.handle(
          _relativePathMeta,
          relativePath.isAcceptableOrUnknown(
              data['relativePath']!, _relativePathMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileMetadataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      filename: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filename']),
      sizeKb: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sizeKb']),
      relativePath: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}relativePath']),
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created']),
    );
  }

  @override
  FileMetadata createAlias(String alias) {
    return FileMetadata(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class FileMetadataData extends DataClass
    implements Insertable<FileMetadataData> {
  final int? id;
  final String? filename;
  final double? sizeKb;
  final Uint8List? relativePath;
  final String? created;
  const FileMetadataData(
      {this.id, this.filename, this.sizeKb, this.relativePath, this.created});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || filename != null) {
      map['filename'] = Variable<String>(filename);
    }
    if (!nullToAbsent || sizeKb != null) {
      map['sizeKb'] = Variable<double>(sizeKb);
    }
    if (!nullToAbsent || relativePath != null) {
      map['relativePath'] = Variable<Uint8List>(relativePath);
    }
    if (!nullToAbsent || created != null) {
      map['created'] = Variable<String>(created);
    }
    return map;
  }

  FileMetadataCompanion toCompanion(bool nullToAbsent) {
    return FileMetadataCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      filename: filename == null && nullToAbsent
          ? const Value.absent()
          : Value(filename),
      sizeKb:
          sizeKb == null && nullToAbsent ? const Value.absent() : Value(sizeKb),
      relativePath: relativePath == null && nullToAbsent
          ? const Value.absent()
          : Value(relativePath),
      created: created == null && nullToAbsent
          ? const Value.absent()
          : Value(created),
    );
  }

  factory FileMetadataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileMetadataData(
      id: serializer.fromJson<int?>(json['id']),
      filename: serializer.fromJson<String?>(json['filename']),
      sizeKb: serializer.fromJson<double?>(json['sizeKb']),
      relativePath: serializer.fromJson<Uint8List?>(json['relativePath']),
      created: serializer.fromJson<String?>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'filename': serializer.toJson<String?>(filename),
      'sizeKb': serializer.toJson<double?>(sizeKb),
      'relativePath': serializer.toJson<Uint8List?>(relativePath),
      'created': serializer.toJson<String?>(created),
    };
  }

  FileMetadataData copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> filename = const Value.absent(),
          Value<double?> sizeKb = const Value.absent(),
          Value<Uint8List?> relativePath = const Value.absent(),
          Value<String?> created = const Value.absent()}) =>
      FileMetadataData(
        id: id.present ? id.value : this.id,
        filename: filename.present ? filename.value : this.filename,
        sizeKb: sizeKb.present ? sizeKb.value : this.sizeKb,
        relativePath:
            relativePath.present ? relativePath.value : this.relativePath,
        created: created.present ? created.value : this.created,
      );
  @override
  String toString() {
    return (StringBuffer('FileMetadataData(')
          ..write('id: $id, ')
          ..write('filename: $filename, ')
          ..write('sizeKb: $sizeKb, ')
          ..write('relativePath: $relativePath, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, filename, sizeKb, $driftBlobEquality.hash(relativePath), created);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileMetadataData &&
          other.id == this.id &&
          other.filename == this.filename &&
          other.sizeKb == this.sizeKb &&
          $driftBlobEquality.equals(other.relativePath, this.relativePath) &&
          other.created == this.created);
}

class FileMetadataCompanion extends UpdateCompanion<FileMetadataData> {
  final Value<int?> id;
  final Value<String?> filename;
  final Value<double?> sizeKb;
  final Value<Uint8List?> relativePath;
  final Value<String?> created;
  const FileMetadataCompanion({
    this.id = const Value.absent(),
    this.filename = const Value.absent(),
    this.sizeKb = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.created = const Value.absent(),
  });
  FileMetadataCompanion.insert({
    this.id = const Value.absent(),
    this.filename = const Value.absent(),
    this.sizeKb = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.created = const Value.absent(),
  });
  static Insertable<FileMetadataData> custom({
    Expression<int>? id,
    Expression<String>? filename,
    Expression<double>? sizeKb,
    Expression<Uint8List>? relativePath,
    Expression<String>? created,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (filename != null) 'filename': filename,
      if (sizeKb != null) 'sizeKb': sizeKb,
      if (relativePath != null) 'relativePath': relativePath,
      if (created != null) 'created': created,
    });
  }

  FileMetadataCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? filename,
      Value<double?>? sizeKb,
      Value<Uint8List?>? relativePath,
      Value<String?>? created}) {
    return FileMetadataCompanion(
      id: id ?? this.id,
      filename: filename ?? this.filename,
      sizeKb: sizeKb ?? this.sizeKb,
      relativePath: relativePath ?? this.relativePath,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (sizeKb.present) {
      map['sizeKb'] = Variable<double>(sizeKb.value);
    }
    if (relativePath.present) {
      map['relativePath'] = Variable<Uint8List>(relativePath.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileMetadataCompanion(')
          ..write('id: $id, ')
          ..write('filename: $filename, ')
          ..write('sizeKb: $sizeKb, ')
          ..write('relativePath: $relativePath, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

class PersonnelPhoto extends Table
    with TableInfo<PersonnelPhoto, PersonnelPhotoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PersonnelPhoto(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
      'fileId', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, fileId];
  @override
  String get aliasedName => _alias ?? 'personnelPhoto';
  @override
  String get actualTableName => 'personnelPhoto';
  @override
  VerificationContext validateIntegrity(Insertable<PersonnelPhotoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fileId')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['fileId']!, _fileIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonnelPhotoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonnelPhotoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fileId']),
    );
  }

  @override
  PersonnelPhoto createAlias(String alias) {
    return PersonnelPhoto(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(fileId)REFERENCES fileMetadata(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class PersonnelPhotoData extends DataClass
    implements Insertable<PersonnelPhotoData> {
  final int? id;
  final int? fileId;
  const PersonnelPhotoData({this.id, this.fileId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || fileId != null) {
      map['fileId'] = Variable<int>(fileId);
    }
    return map;
  }

  PersonnelPhotoCompanion toCompanion(bool nullToAbsent) {
    return PersonnelPhotoCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      fileId:
          fileId == null && nullToAbsent ? const Value.absent() : Value(fileId),
    );
  }

  factory PersonnelPhotoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonnelPhotoData(
      id: serializer.fromJson<int?>(json['id']),
      fileId: serializer.fromJson<int?>(json['fileId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'fileId': serializer.toJson<int?>(fileId),
    };
  }

  PersonnelPhotoData copyWith(
          {Value<int?> id = const Value.absent(),
          Value<int?> fileId = const Value.absent()}) =>
      PersonnelPhotoData(
        id: id.present ? id.value : this.id,
        fileId: fileId.present ? fileId.value : this.fileId,
      );
  @override
  String toString() {
    return (StringBuffer('PersonnelPhotoData(')
          ..write('id: $id, ')
          ..write('fileId: $fileId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fileId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonnelPhotoData &&
          other.id == this.id &&
          other.fileId == this.fileId);
}

class PersonnelPhotoCompanion extends UpdateCompanion<PersonnelPhotoData> {
  final Value<int?> id;
  final Value<int?> fileId;
  const PersonnelPhotoCompanion({
    this.id = const Value.absent(),
    this.fileId = const Value.absent(),
  });
  PersonnelPhotoCompanion.insert({
    this.id = const Value.absent(),
    this.fileId = const Value.absent(),
  });
  static Insertable<PersonnelPhotoData> custom({
    Expression<int>? id,
    Expression<int>? fileId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileId != null) 'fileId': fileId,
    });
  }

  PersonnelPhotoCompanion copyWith({Value<int?>? id, Value<int?>? fileId}) {
    return PersonnelPhotoCompanion(
      id: id ?? this.id,
      fileId: fileId ?? this.fileId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileId.present) {
      map['fileId'] = Variable<int>(fileId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonnelPhotoCompanion(')
          ..write('id: $id, ')
          ..write('fileId: $fileId')
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
  static const VerificationMeta _nextCollectorNumberMeta =
      const VerificationMeta('nextCollectorNumber');
  late final GeneratedColumn<int> nextCollectorNumber = GeneratedColumn<int>(
      'nextCollectorNumber', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _personnelPhotoMeta =
      const VerificationMeta('personnelPhoto');
  late final GeneratedColumn<int> personnelPhoto = GeneratedColumn<int>(
      'personnelPhoto', aliasedName, true,
      type: DriftSqlType.int,
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
        nextCollectorNumber,
        personnelPhoto
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
    if (data.containsKey('nextCollectorNumber')) {
      context.handle(
          _nextCollectorNumberMeta,
          nextCollectorNumber.isAcceptableOrUnknown(
              data['nextCollectorNumber']!, _nextCollectorNumberMeta));
    }
    if (data.containsKey('personnelPhoto')) {
      context.handle(
          _personnelPhotoMeta,
          personnelPhoto.isAcceptableOrUnknown(
              data['personnelPhoto']!, _personnelPhotoMeta));
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
      nextCollectorNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}nextCollectorNumber']),
      personnelPhoto: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}personnelPhoto']),
    );
  }

  @override
  Personnel createAlias(String alias) {
    return Personnel(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(personnelPhoto)REFERENCES personnelPhoto(id)'];
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
  final int? nextCollectorNumber;
  final int? personnelPhoto;
  const PersonnelData(
      {required this.uuid,
      this.name,
      this.initial,
      this.email,
      this.phone,
      this.affiliation,
      this.role,
      this.nextCollectorNumber,
      this.personnelPhoto});
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
    if (!nullToAbsent || nextCollectorNumber != null) {
      map['nextCollectorNumber'] = Variable<int>(nextCollectorNumber);
    }
    if (!nullToAbsent || personnelPhoto != null) {
      map['personnelPhoto'] = Variable<int>(personnelPhoto);
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
      nextCollectorNumber: nextCollectorNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(nextCollectorNumber),
      personnelPhoto: personnelPhoto == null && nullToAbsent
          ? const Value.absent()
          : Value(personnelPhoto),
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
      nextCollectorNumber:
          serializer.fromJson<int?>(json['nextCollectorNumber']),
      personnelPhoto: serializer.fromJson<int?>(json['personnelPhoto']),
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
      'nextCollectorNumber': serializer.toJson<int?>(nextCollectorNumber),
      'personnelPhoto': serializer.toJson<int?>(personnelPhoto),
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
          Value<int?> nextCollectorNumber = const Value.absent(),
          Value<int?> personnelPhoto = const Value.absent()}) =>
      PersonnelData(
        uuid: uuid ?? this.uuid,
        name: name.present ? name.value : this.name,
        initial: initial.present ? initial.value : this.initial,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        affiliation: affiliation.present ? affiliation.value : this.affiliation,
        role: role.present ? role.value : this.role,
        nextCollectorNumber: nextCollectorNumber.present
            ? nextCollectorNumber.value
            : this.nextCollectorNumber,
        personnelPhoto:
            personnelPhoto.present ? personnelPhoto.value : this.personnelPhoto,
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
          ..write('nextCollectorNumber: $nextCollectorNumber, ')
          ..write('personnelPhoto: $personnelPhoto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, name, initial, email, phone,
      affiliation, role, nextCollectorNumber, personnelPhoto);
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
          other.nextCollectorNumber == this.nextCollectorNumber &&
          other.personnelPhoto == this.personnelPhoto);
}

class PersonnelCompanion extends UpdateCompanion<PersonnelData> {
  final Value<String> uuid;
  final Value<String?> name;
  final Value<String?> initial;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> affiliation;
  final Value<String?> role;
  final Value<int?> nextCollectorNumber;
  final Value<int?> personnelPhoto;
  const PersonnelCompanion({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.initial = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.affiliation = const Value.absent(),
    this.role = const Value.absent(),
    this.nextCollectorNumber = const Value.absent(),
    this.personnelPhoto = const Value.absent(),
  });
  PersonnelCompanion.insert({
    required String uuid,
    this.name = const Value.absent(),
    this.initial = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.affiliation = const Value.absent(),
    this.role = const Value.absent(),
    this.nextCollectorNumber = const Value.absent(),
    this.personnelPhoto = const Value.absent(),
  }) : uuid = Value(uuid);
  static Insertable<PersonnelData> custom({
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? initial,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? affiliation,
    Expression<String>? role,
    Expression<int>? nextCollectorNumber,
    Expression<int>? personnelPhoto,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (initial != null) 'initial': initial,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (affiliation != null) 'affiliation': affiliation,
      if (role != null) 'role': role,
      if (nextCollectorNumber != null)
        'nextCollectorNumber': nextCollectorNumber,
      if (personnelPhoto != null) 'personnelPhoto': personnelPhoto,
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
      Value<int?>? nextCollectorNumber,
      Value<int?>? personnelPhoto}) {
    return PersonnelCompanion(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      initial: initial ?? this.initial,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      affiliation: affiliation ?? this.affiliation,
      role: role ?? this.role,
      nextCollectorNumber: nextCollectorNumber ?? this.nextCollectorNumber,
      personnelPhoto: personnelPhoto ?? this.personnelPhoto,
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
    if (nextCollectorNumber.present) {
      map['nextCollectorNumber'] = Variable<int>(nextCollectorNumber.value);
    }
    if (personnelPhoto.present) {
      map['personnelPhoto'] = Variable<int>(personnelPhoto.value);
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
          ..write('nextCollectorNumber: $nextCollectorNumber, ')
          ..write('personnelPhoto: $personnelPhoto')
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
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
      'fileId', aliasedName, true,
      type: DriftSqlType.int,
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
  static const VerificationMeta _personnelIdMeta =
      const VerificationMeta('personnelId');
  late final GeneratedColumn<String> personnelId = GeneratedColumn<String>(
      'personnelId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        primaryId,
        secondaryId,
        secondaryIdRef,
        fileId,
        taken,
        camera,
        lenses,
        personnelId
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
    if (data.containsKey('fileId')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['fileId']!, _fileIdMeta));
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
    if (data.containsKey('personnelId')) {
      context.handle(
          _personnelIdMeta,
          personnelId.isAcceptableOrUnknown(
              data['personnelId']!, _personnelIdMeta));
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
      secondaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}secondaryId']),
      secondaryIdRef: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}secondaryIdRef']),
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fileId']),
      taken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}taken']),
      camera: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}camera']),
      lenses: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lenses']),
      personnelId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}personnelId']),
    );
  }

  @override
  Media createAlias(String alias) {
    return Media(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(personnelId)REFERENCES personnel(uuid)',
        'FOREIGN KEY(fileId)REFERENCES fileMetadata(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class MediaData extends DataClass implements Insertable<MediaData> {
  final int? primaryId;
  final String? secondaryId;
  final String? secondaryIdRef;
  final int? fileId;
  final String? taken;
  final String? camera;
  final String? lenses;
  final String? personnelId;
  const MediaData(
      {this.primaryId,
      this.secondaryId,
      this.secondaryIdRef,
      this.fileId,
      this.taken,
      this.camera,
      this.lenses,
      this.personnelId});
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
    if (!nullToAbsent || fileId != null) {
      map['fileId'] = Variable<int>(fileId);
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
    if (!nullToAbsent || personnelId != null) {
      map['personnelId'] = Variable<String>(personnelId);
    }
    return map;
  }

  MediaCompanion toCompanion(bool nullToAbsent) {
    return MediaCompanion(
      primaryId: primaryId == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryId),
      secondaryId: secondaryId == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryId),
      secondaryIdRef: secondaryIdRef == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryIdRef),
      fileId:
          fileId == null && nullToAbsent ? const Value.absent() : Value(fileId),
      taken:
          taken == null && nullToAbsent ? const Value.absent() : Value(taken),
      camera:
          camera == null && nullToAbsent ? const Value.absent() : Value(camera),
      lenses:
          lenses == null && nullToAbsent ? const Value.absent() : Value(lenses),
      personnelId: personnelId == null && nullToAbsent
          ? const Value.absent()
          : Value(personnelId),
    );
  }

  factory MediaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaData(
      primaryId: serializer.fromJson<int?>(json['primaryId']),
      secondaryId: serializer.fromJson<String?>(json['secondaryId']),
      secondaryIdRef: serializer.fromJson<String?>(json['secondaryIdRef']),
      fileId: serializer.fromJson<int?>(json['fileId']),
      taken: serializer.fromJson<String?>(json['taken']),
      camera: serializer.fromJson<String?>(json['camera']),
      lenses: serializer.fromJson<String?>(json['lenses']),
      personnelId: serializer.fromJson<String?>(json['personnelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'primaryId': serializer.toJson<int?>(primaryId),
      'secondaryId': serializer.toJson<String?>(secondaryId),
      'secondaryIdRef': serializer.toJson<String?>(secondaryIdRef),
      'fileId': serializer.toJson<int?>(fileId),
      'taken': serializer.toJson<String?>(taken),
      'camera': serializer.toJson<String?>(camera),
      'lenses': serializer.toJson<String?>(lenses),
      'personnelId': serializer.toJson<String?>(personnelId),
    };
  }

  MediaData copyWith(
          {Value<int?> primaryId = const Value.absent(),
          Value<String?> secondaryId = const Value.absent(),
          Value<String?> secondaryIdRef = const Value.absent(),
          Value<int?> fileId = const Value.absent(),
          Value<String?> taken = const Value.absent(),
          Value<String?> camera = const Value.absent(),
          Value<String?> lenses = const Value.absent(),
          Value<String?> personnelId = const Value.absent()}) =>
      MediaData(
        primaryId: primaryId.present ? primaryId.value : this.primaryId,
        secondaryId: secondaryId.present ? secondaryId.value : this.secondaryId,
        secondaryIdRef:
            secondaryIdRef.present ? secondaryIdRef.value : this.secondaryIdRef,
        fileId: fileId.present ? fileId.value : this.fileId,
        taken: taken.present ? taken.value : this.taken,
        camera: camera.present ? camera.value : this.camera,
        lenses: lenses.present ? lenses.value : this.lenses,
        personnelId: personnelId.present ? personnelId.value : this.personnelId,
      );
  @override
  String toString() {
    return (StringBuffer('MediaData(')
          ..write('primaryId: $primaryId, ')
          ..write('secondaryId: $secondaryId, ')
          ..write('secondaryIdRef: $secondaryIdRef, ')
          ..write('fileId: $fileId, ')
          ..write('taken: $taken, ')
          ..write('camera: $camera, ')
          ..write('lenses: $lenses, ')
          ..write('personnelId: $personnelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(primaryId, secondaryId, secondaryIdRef,
      fileId, taken, camera, lenses, personnelId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaData &&
          other.primaryId == this.primaryId &&
          other.secondaryId == this.secondaryId &&
          other.secondaryIdRef == this.secondaryIdRef &&
          other.fileId == this.fileId &&
          other.taken == this.taken &&
          other.camera == this.camera &&
          other.lenses == this.lenses &&
          other.personnelId == this.personnelId);
}

class MediaCompanion extends UpdateCompanion<MediaData> {
  final Value<int?> primaryId;
  final Value<String?> secondaryId;
  final Value<String?> secondaryIdRef;
  final Value<int?> fileId;
  final Value<String?> taken;
  final Value<String?> camera;
  final Value<String?> lenses;
  final Value<String?> personnelId;
  const MediaCompanion({
    this.primaryId = const Value.absent(),
    this.secondaryId = const Value.absent(),
    this.secondaryIdRef = const Value.absent(),
    this.fileId = const Value.absent(),
    this.taken = const Value.absent(),
    this.camera = const Value.absent(),
    this.lenses = const Value.absent(),
    this.personnelId = const Value.absent(),
  });
  MediaCompanion.insert({
    this.primaryId = const Value.absent(),
    this.secondaryId = const Value.absent(),
    this.secondaryIdRef = const Value.absent(),
    this.fileId = const Value.absent(),
    this.taken = const Value.absent(),
    this.camera = const Value.absent(),
    this.lenses = const Value.absent(),
    this.personnelId = const Value.absent(),
  });
  static Insertable<MediaData> custom({
    Expression<int>? primaryId,
    Expression<String>? secondaryId,
    Expression<String>? secondaryIdRef,
    Expression<int>? fileId,
    Expression<String>? taken,
    Expression<String>? camera,
    Expression<String>? lenses,
    Expression<String>? personnelId,
  }) {
    return RawValuesInsertable({
      if (primaryId != null) 'primaryId': primaryId,
      if (secondaryId != null) 'secondaryId': secondaryId,
      if (secondaryIdRef != null) 'secondaryIdRef': secondaryIdRef,
      if (fileId != null) 'fileId': fileId,
      if (taken != null) 'taken': taken,
      if (camera != null) 'camera': camera,
      if (lenses != null) 'lenses': lenses,
      if (personnelId != null) 'personnelId': personnelId,
    });
  }

  MediaCompanion copyWith(
      {Value<int?>? primaryId,
      Value<String?>? secondaryId,
      Value<String?>? secondaryIdRef,
      Value<int?>? fileId,
      Value<String?>? taken,
      Value<String?>? camera,
      Value<String?>? lenses,
      Value<String?>? personnelId}) {
    return MediaCompanion(
      primaryId: primaryId ?? this.primaryId,
      secondaryId: secondaryId ?? this.secondaryId,
      secondaryIdRef: secondaryIdRef ?? this.secondaryIdRef,
      fileId: fileId ?? this.fileId,
      taken: taken ?? this.taken,
      camera: camera ?? this.camera,
      lenses: lenses ?? this.lenses,
      personnelId: personnelId ?? this.personnelId,
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
    if (fileId.present) {
      map['fileId'] = Variable<int>(fileId.value);
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
    if (personnelId.present) {
      map['personnelId'] = Variable<String>(personnelId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaCompanion(')
          ..write('primaryId: $primaryId, ')
          ..write('secondaryId: $secondaryId, ')
          ..write('secondaryIdRef: $secondaryIdRef, ')
          ..write('fileId: $fileId, ')
          ..write('taken: $taken, ')
          ..write('camera: $camera, ')
          ..write('lenses: $lenses, ')
          ..write('personnelId: $personnelId')
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
  final String? nameId;
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

class WeatherData extends Table with TableInfo<WeatherData, WeatherDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  WeatherData(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _lowestDayTempMeta =
      const VerificationMeta('lowestDayTemp');
  late final GeneratedColumn<String> lowestDayTemp = GeneratedColumn<String>(
      'lowestDayTemp', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _highestDayTempMeta =
      const VerificationMeta('highestDayTemp');
  late final GeneratedColumn<String> highestDayTemp = GeneratedColumn<String>(
      'highestDayTemp', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _lowestNightTempMeta =
      const VerificationMeta('lowestNightTemp');
  late final GeneratedColumn<String> lowestNightTemp = GeneratedColumn<String>(
      'lowestNightTemp', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _highestNightTempMeta =
      const VerificationMeta('highestNightTemp');
  late final GeneratedColumn<String> highestNightTemp = GeneratedColumn<String>(
      'highestNightTemp', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sunriseMeta =
      const VerificationMeta('sunrise');
  late final GeneratedColumn<String> sunrise = GeneratedColumn<String>(
      'sunrise', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sunsetMeta = const VerificationMeta('sunset');
  late final GeneratedColumn<String> sunset = GeneratedColumn<String>(
      'sunset', aliasedName, true,
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lowestDayTemp,
        highestDayTemp,
        lowestNightTemp,
        highestNightTemp,
        sunrise,
        sunset,
        moonPhase
      ];
  @override
  String get aliasedName => _alias ?? 'weatherData';
  @override
  String get actualTableName => 'weatherData';
  @override
  VerificationContext validateIntegrity(Insertable<WeatherDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lowestDayTemp')) {
      context.handle(
          _lowestDayTempMeta,
          lowestDayTemp.isAcceptableOrUnknown(
              data['lowestDayTemp']!, _lowestDayTempMeta));
    }
    if (data.containsKey('highestDayTemp')) {
      context.handle(
          _highestDayTempMeta,
          highestDayTemp.isAcceptableOrUnknown(
              data['highestDayTemp']!, _highestDayTempMeta));
    }
    if (data.containsKey('lowestNightTemp')) {
      context.handle(
          _lowestNightTempMeta,
          lowestNightTemp.isAcceptableOrUnknown(
              data['lowestNightTemp']!, _lowestNightTempMeta));
    }
    if (data.containsKey('highestNightTemp')) {
      context.handle(
          _highestNightTempMeta,
          highestNightTemp.isAcceptableOrUnknown(
              data['highestNightTemp']!, _highestNightTempMeta));
    }
    if (data.containsKey('sunrise')) {
      context.handle(_sunriseMeta,
          sunrise.isAcceptableOrUnknown(data['sunrise']!, _sunriseMeta));
    }
    if (data.containsKey('sunset')) {
      context.handle(_sunsetMeta,
          sunset.isAcceptableOrUnknown(data['sunset']!, _sunsetMeta));
    }
    if (data.containsKey('moonPhase')) {
      context.handle(_moonPhaseMeta,
          moonPhase.isAcceptableOrUnknown(data['moonPhase']!, _moonPhaseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeatherDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherDataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lowestDayTemp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lowestDayTemp']),
      highestDayTemp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}highestDayTemp']),
      lowestNightTemp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lowestNightTemp']),
      highestNightTemp: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}highestNightTemp']),
      sunrise: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sunrise']),
      sunset: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sunset']),
      moonPhase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}moonPhase']),
    );
  }

  @override
  WeatherData createAlias(String alias) {
    return WeatherData(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class WeatherDataData extends DataClass implements Insertable<WeatherDataData> {
  final int id;
  final String? lowestDayTemp;
  final String? highestDayTemp;
  final String? lowestNightTemp;
  final String? highestNightTemp;
  final String? sunrise;
  final String? sunset;
  final String? moonPhase;
  const WeatherDataData(
      {required this.id,
      this.lowestDayTemp,
      this.highestDayTemp,
      this.lowestNightTemp,
      this.highestNightTemp,
      this.sunrise,
      this.sunset,
      this.moonPhase});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lowestDayTemp != null) {
      map['lowestDayTemp'] = Variable<String>(lowestDayTemp);
    }
    if (!nullToAbsent || highestDayTemp != null) {
      map['highestDayTemp'] = Variable<String>(highestDayTemp);
    }
    if (!nullToAbsent || lowestNightTemp != null) {
      map['lowestNightTemp'] = Variable<String>(lowestNightTemp);
    }
    if (!nullToAbsent || highestNightTemp != null) {
      map['highestNightTemp'] = Variable<String>(highestNightTemp);
    }
    if (!nullToAbsent || sunrise != null) {
      map['sunrise'] = Variable<String>(sunrise);
    }
    if (!nullToAbsent || sunset != null) {
      map['sunset'] = Variable<String>(sunset);
    }
    if (!nullToAbsent || moonPhase != null) {
      map['moonPhase'] = Variable<String>(moonPhase);
    }
    return map;
  }

  WeatherDataCompanion toCompanion(bool nullToAbsent) {
    return WeatherDataCompanion(
      id: Value(id),
      lowestDayTemp: lowestDayTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(lowestDayTemp),
      highestDayTemp: highestDayTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(highestDayTemp),
      lowestNightTemp: lowestNightTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(lowestNightTemp),
      highestNightTemp: highestNightTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(highestNightTemp),
      sunrise: sunrise == null && nullToAbsent
          ? const Value.absent()
          : Value(sunrise),
      sunset:
          sunset == null && nullToAbsent ? const Value.absent() : Value(sunset),
      moonPhase: moonPhase == null && nullToAbsent
          ? const Value.absent()
          : Value(moonPhase),
    );
  }

  factory WeatherDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherDataData(
      id: serializer.fromJson<int>(json['id']),
      lowestDayTemp: serializer.fromJson<String?>(json['lowestDayTemp']),
      highestDayTemp: serializer.fromJson<String?>(json['highestDayTemp']),
      lowestNightTemp: serializer.fromJson<String?>(json['lowestNightTemp']),
      highestNightTemp: serializer.fromJson<String?>(json['highestNightTemp']),
      sunrise: serializer.fromJson<String?>(json['sunrise']),
      sunset: serializer.fromJson<String?>(json['sunset']),
      moonPhase: serializer.fromJson<String?>(json['moonPhase']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lowestDayTemp': serializer.toJson<String?>(lowestDayTemp),
      'highestDayTemp': serializer.toJson<String?>(highestDayTemp),
      'lowestNightTemp': serializer.toJson<String?>(lowestNightTemp),
      'highestNightTemp': serializer.toJson<String?>(highestNightTemp),
      'sunrise': serializer.toJson<String?>(sunrise),
      'sunset': serializer.toJson<String?>(sunset),
      'moonPhase': serializer.toJson<String?>(moonPhase),
    };
  }

  WeatherDataData copyWith(
          {int? id,
          Value<String?> lowestDayTemp = const Value.absent(),
          Value<String?> highestDayTemp = const Value.absent(),
          Value<String?> lowestNightTemp = const Value.absent(),
          Value<String?> highestNightTemp = const Value.absent(),
          Value<String?> sunrise = const Value.absent(),
          Value<String?> sunset = const Value.absent(),
          Value<String?> moonPhase = const Value.absent()}) =>
      WeatherDataData(
        id: id ?? this.id,
        lowestDayTemp:
            lowestDayTemp.present ? lowestDayTemp.value : this.lowestDayTemp,
        highestDayTemp:
            highestDayTemp.present ? highestDayTemp.value : this.highestDayTemp,
        lowestNightTemp: lowestNightTemp.present
            ? lowestNightTemp.value
            : this.lowestNightTemp,
        highestNightTemp: highestNightTemp.present
            ? highestNightTemp.value
            : this.highestNightTemp,
        sunrise: sunrise.present ? sunrise.value : this.sunrise,
        sunset: sunset.present ? sunset.value : this.sunset,
        moonPhase: moonPhase.present ? moonPhase.value : this.moonPhase,
      );
  @override
  String toString() {
    return (StringBuffer('WeatherDataData(')
          ..write('id: $id, ')
          ..write('lowestDayTemp: $lowestDayTemp, ')
          ..write('highestDayTemp: $highestDayTemp, ')
          ..write('lowestNightTemp: $lowestNightTemp, ')
          ..write('highestNightTemp: $highestNightTemp, ')
          ..write('sunrise: $sunrise, ')
          ..write('sunset: $sunset, ')
          ..write('moonPhase: $moonPhase')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lowestDayTemp, highestDayTemp,
      lowestNightTemp, highestNightTemp, sunrise, sunset, moonPhase);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherDataData &&
          other.id == this.id &&
          other.lowestDayTemp == this.lowestDayTemp &&
          other.highestDayTemp == this.highestDayTemp &&
          other.lowestNightTemp == this.lowestNightTemp &&
          other.highestNightTemp == this.highestNightTemp &&
          other.sunrise == this.sunrise &&
          other.sunset == this.sunset &&
          other.moonPhase == this.moonPhase);
}

class WeatherDataCompanion extends UpdateCompanion<WeatherDataData> {
  final Value<int> id;
  final Value<String?> lowestDayTemp;
  final Value<String?> highestDayTemp;
  final Value<String?> lowestNightTemp;
  final Value<String?> highestNightTemp;
  final Value<String?> sunrise;
  final Value<String?> sunset;
  final Value<String?> moonPhase;
  const WeatherDataCompanion({
    this.id = const Value.absent(),
    this.lowestDayTemp = const Value.absent(),
    this.highestDayTemp = const Value.absent(),
    this.lowestNightTemp = const Value.absent(),
    this.highestNightTemp = const Value.absent(),
    this.sunrise = const Value.absent(),
    this.sunset = const Value.absent(),
    this.moonPhase = const Value.absent(),
  });
  WeatherDataCompanion.insert({
    this.id = const Value.absent(),
    this.lowestDayTemp = const Value.absent(),
    this.highestDayTemp = const Value.absent(),
    this.lowestNightTemp = const Value.absent(),
    this.highestNightTemp = const Value.absent(),
    this.sunrise = const Value.absent(),
    this.sunset = const Value.absent(),
    this.moonPhase = const Value.absent(),
  });
  static Insertable<WeatherDataData> custom({
    Expression<int>? id,
    Expression<String>? lowestDayTemp,
    Expression<String>? highestDayTemp,
    Expression<String>? lowestNightTemp,
    Expression<String>? highestNightTemp,
    Expression<String>? sunrise,
    Expression<String>? sunset,
    Expression<String>? moonPhase,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lowestDayTemp != null) 'lowestDayTemp': lowestDayTemp,
      if (highestDayTemp != null) 'highestDayTemp': highestDayTemp,
      if (lowestNightTemp != null) 'lowestNightTemp': lowestNightTemp,
      if (highestNightTemp != null) 'highestNightTemp': highestNightTemp,
      if (sunrise != null) 'sunrise': sunrise,
      if (sunset != null) 'sunset': sunset,
      if (moonPhase != null) 'moonPhase': moonPhase,
    });
  }

  WeatherDataCompanion copyWith(
      {Value<int>? id,
      Value<String?>? lowestDayTemp,
      Value<String?>? highestDayTemp,
      Value<String?>? lowestNightTemp,
      Value<String?>? highestNightTemp,
      Value<String?>? sunrise,
      Value<String?>? sunset,
      Value<String?>? moonPhase}) {
    return WeatherDataCompanion(
      id: id ?? this.id,
      lowestDayTemp: lowestDayTemp ?? this.lowestDayTemp,
      highestDayTemp: highestDayTemp ?? this.highestDayTemp,
      lowestNightTemp: lowestNightTemp ?? this.lowestNightTemp,
      highestNightTemp: highestNightTemp ?? this.highestNightTemp,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      moonPhase: moonPhase ?? this.moonPhase,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lowestDayTemp.present) {
      map['lowestDayTemp'] = Variable<String>(lowestDayTemp.value);
    }
    if (highestDayTemp.present) {
      map['highestDayTemp'] = Variable<String>(highestDayTemp.value);
    }
    if (lowestNightTemp.present) {
      map['lowestNightTemp'] = Variable<String>(lowestNightTemp.value);
    }
    if (highestNightTemp.present) {
      map['highestNightTemp'] = Variable<String>(highestNightTemp.value);
    }
    if (sunrise.present) {
      map['sunrise'] = Variable<String>(sunrise.value);
    }
    if (sunset.present) {
      map['sunset'] = Variable<String>(sunset.value);
    }
    if (moonPhase.present) {
      map['moonPhase'] = Variable<String>(moonPhase.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherDataCompanion(')
          ..write('id: $id, ')
          ..write('lowestDayTemp: $lowestDayTemp, ')
          ..write('highestDayTemp: $highestDayTemp, ')
          ..write('lowestNightTemp: $lowestNightTemp, ')
          ..write('highestNightTemp: $highestNightTemp, ')
          ..write('sunrise: $sunrise, ')
          ..write('sunset: $sunset, ')
          ..write('moonPhase: $moonPhase')
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
  static const VerificationMeta _eventIDMeta =
      const VerificationMeta('eventID');
  late final GeneratedColumn<String> eventID = GeneratedColumn<String>(
      'eventID', aliasedName, true,
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
  static const VerificationMeta _weatherIDMeta =
      const VerificationMeta('weatherID');
  late final GeneratedColumn<int> weatherID = GeneratedColumn<int>(
      'weatherID', aliasedName, true,
      type: DriftSqlType.int,
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
        eventID,
        projectUuid,
        startDate,
        startTime,
        endDate,
        endTime,
        primaryCollMethod,
        collMethodNotes,
        weatherID,
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
    if (data.containsKey('eventID')) {
      context.handle(_eventIDMeta,
          eventID.isAcceptableOrUnknown(data['eventID']!, _eventIDMeta));
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
    if (data.containsKey('weatherID')) {
      context.handle(_weatherIDMeta,
          weatherID.isAcceptableOrUnknown(data['weatherID']!, _weatherIDMeta));
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
      eventID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}eventID']),
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
      weatherID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weatherID']),
      siteID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}siteID']),
    );
  }

  @override
  CollEvent createAlias(String alias) {
    return CollEvent(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(projectUuid)REFERENCES project(uuid)',
        'FOREIGN KEY(weatherID)REFERENCES weatherData(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class CollEventData extends DataClass implements Insertable<CollEventData> {
  final int id;
  final String? eventID;
  final String? projectUuid;
  final String? startDate;
  final String? startTime;
  final String? endDate;
  final String? endTime;
  final String? primaryCollMethod;
  final String? collMethodNotes;
  final int? weatherID;
  final int? siteID;
  const CollEventData(
      {required this.id,
      this.eventID,
      this.projectUuid,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.primaryCollMethod,
      this.collMethodNotes,
      this.weatherID,
      this.siteID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || eventID != null) {
      map['eventID'] = Variable<String>(eventID);
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
    if (!nullToAbsent || weatherID != null) {
      map['weatherID'] = Variable<int>(weatherID);
    }
    if (!nullToAbsent || siteID != null) {
      map['siteID'] = Variable<int>(siteID);
    }
    return map;
  }

  CollEventCompanion toCompanion(bool nullToAbsent) {
    return CollEventCompanion(
      id: Value(id),
      eventID: eventID == null && nullToAbsent
          ? const Value.absent()
          : Value(eventID),
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
      weatherID: weatherID == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherID),
      siteID:
          siteID == null && nullToAbsent ? const Value.absent() : Value(siteID),
    );
  }

  factory CollEventData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollEventData(
      id: serializer.fromJson<int>(json['id']),
      eventID: serializer.fromJson<String?>(json['eventID']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
      startDate: serializer.fromJson<String?>(json['startDate']),
      startTime: serializer.fromJson<String?>(json['startTime']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      endTime: serializer.fromJson<String?>(json['endTime']),
      primaryCollMethod:
          serializer.fromJson<String?>(json['primaryCollMethod']),
      collMethodNotes: serializer.fromJson<String?>(json['collMethodNotes']),
      weatherID: serializer.fromJson<int?>(json['weatherID']),
      siteID: serializer.fromJson<int?>(json['siteID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventID': serializer.toJson<String?>(eventID),
      'projectUuid': serializer.toJson<String?>(projectUuid),
      'startDate': serializer.toJson<String?>(startDate),
      'startTime': serializer.toJson<String?>(startTime),
      'endDate': serializer.toJson<String?>(endDate),
      'endTime': serializer.toJson<String?>(endTime),
      'primaryCollMethod': serializer.toJson<String?>(primaryCollMethod),
      'collMethodNotes': serializer.toJson<String?>(collMethodNotes),
      'weatherID': serializer.toJson<int?>(weatherID),
      'siteID': serializer.toJson<int?>(siteID),
    };
  }

  CollEventData copyWith(
          {int? id,
          Value<String?> eventID = const Value.absent(),
          Value<String?> projectUuid = const Value.absent(),
          Value<String?> startDate = const Value.absent(),
          Value<String?> startTime = const Value.absent(),
          Value<String?> endDate = const Value.absent(),
          Value<String?> endTime = const Value.absent(),
          Value<String?> primaryCollMethod = const Value.absent(),
          Value<String?> collMethodNotes = const Value.absent(),
          Value<int?> weatherID = const Value.absent(),
          Value<int?> siteID = const Value.absent()}) =>
      CollEventData(
        id: id ?? this.id,
        eventID: eventID.present ? eventID.value : this.eventID,
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
        weatherID: weatherID.present ? weatherID.value : this.weatherID,
        siteID: siteID.present ? siteID.value : this.siteID,
      );
  @override
  String toString() {
    return (StringBuffer('CollEventData(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('startDate: $startDate, ')
          ..write('startTime: $startTime, ')
          ..write('endDate: $endDate, ')
          ..write('endTime: $endTime, ')
          ..write('primaryCollMethod: $primaryCollMethod, ')
          ..write('collMethodNotes: $collMethodNotes, ')
          ..write('weatherID: $weatherID, ')
          ..write('siteID: $siteID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      eventID,
      projectUuid,
      startDate,
      startTime,
      endDate,
      endTime,
      primaryCollMethod,
      collMethodNotes,
      weatherID,
      siteID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollEventData &&
          other.id == this.id &&
          other.eventID == this.eventID &&
          other.projectUuid == this.projectUuid &&
          other.startDate == this.startDate &&
          other.startTime == this.startTime &&
          other.endDate == this.endDate &&
          other.endTime == this.endTime &&
          other.primaryCollMethod == this.primaryCollMethod &&
          other.collMethodNotes == this.collMethodNotes &&
          other.weatherID == this.weatherID &&
          other.siteID == this.siteID);
}

class CollEventCompanion extends UpdateCompanion<CollEventData> {
  final Value<int> id;
  final Value<String?> eventID;
  final Value<String?> projectUuid;
  final Value<String?> startDate;
  final Value<String?> startTime;
  final Value<String?> endDate;
  final Value<String?> endTime;
  final Value<String?> primaryCollMethod;
  final Value<String?> collMethodNotes;
  final Value<int?> weatherID;
  final Value<int?> siteID;
  const CollEventCompanion({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.startDate = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endDate = const Value.absent(),
    this.endTime = const Value.absent(),
    this.primaryCollMethod = const Value.absent(),
    this.collMethodNotes = const Value.absent(),
    this.weatherID = const Value.absent(),
    this.siteID = const Value.absent(),
  });
  CollEventCompanion.insert({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.projectUuid = const Value.absent(),
    this.startDate = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endDate = const Value.absent(),
    this.endTime = const Value.absent(),
    this.primaryCollMethod = const Value.absent(),
    this.collMethodNotes = const Value.absent(),
    this.weatherID = const Value.absent(),
    this.siteID = const Value.absent(),
  });
  static Insertable<CollEventData> custom({
    Expression<int>? id,
    Expression<String>? eventID,
    Expression<String>? projectUuid,
    Expression<String>? startDate,
    Expression<String>? startTime,
    Expression<String>? endDate,
    Expression<String>? endTime,
    Expression<String>? primaryCollMethod,
    Expression<String>? collMethodNotes,
    Expression<int>? weatherID,
    Expression<int>? siteID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventID != null) 'eventID': eventID,
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (startDate != null) 'startDate': startDate,
      if (startTime != null) 'startTime': startTime,
      if (endDate != null) 'endDate': endDate,
      if (endTime != null) 'endTime': endTime,
      if (primaryCollMethod != null) 'primaryCollMethod': primaryCollMethod,
      if (collMethodNotes != null) 'collMethodNotes': collMethodNotes,
      if (weatherID != null) 'weatherID': weatherID,
      if (siteID != null) 'siteID': siteID,
    });
  }

  CollEventCompanion copyWith(
      {Value<int>? id,
      Value<String?>? eventID,
      Value<String?>? projectUuid,
      Value<String?>? startDate,
      Value<String?>? startTime,
      Value<String?>? endDate,
      Value<String?>? endTime,
      Value<String?>? primaryCollMethod,
      Value<String?>? collMethodNotes,
      Value<int?>? weatherID,
      Value<int?>? siteID}) {
    return CollEventCompanion(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      projectUuid: projectUuid ?? this.projectUuid,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
      primaryCollMethod: primaryCollMethod ?? this.primaryCollMethod,
      collMethodNotes: collMethodNotes ?? this.collMethodNotes,
      weatherID: weatherID ?? this.weatherID,
      siteID: siteID ?? this.siteID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventID.present) {
      map['eventID'] = Variable<String>(eventID.value);
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
    if (weatherID.present) {
      map['weatherID'] = Variable<int>(weatherID.value);
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
          ..write('eventID: $eventID, ')
          ..write('projectUuid: $projectUuid, ')
          ..write('startDate: $startDate, ')
          ..write('startTime: $startTime, ')
          ..write('endDate: $endDate, ')
          ..write('endTime: $endTime, ')
          ..write('primaryCollMethod: $primaryCollMethod, ')
          ..write('collMethodNotes: $collMethodNotes, ')
          ..write('weatherID: $weatherID, ')
          ..write('siteID: $siteID')
          ..write(')'))
        .toString();
  }
}

class CollectingPersonnel extends Table
    with TableInfo<CollectingPersonnel, CollectingPersonnelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CollectingPersonnel(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, eventID, personnelId, role];
  @override
  String get aliasedName => _alias ?? 'collectingPersonnel';
  @override
  String get actualTableName => 'collectingPersonnel';
  @override
  VerificationContext validateIntegrity(
      Insertable<CollectingPersonnelData> instance,
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
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectingPersonnelData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectingPersonnelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      eventID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}eventID']),
      personnelId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}personnelId']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role']),
    );
  }

  @override
  CollectingPersonnel createAlias(String alias) {
    return CollectingPersonnel(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(eventID)REFERENCES collEvent(id)',
        'FOREIGN KEY(personnelId)REFERENCES personnel(uuid)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class CollectingPersonnelData extends DataClass
    implements Insertable<CollectingPersonnelData> {
  final int id;
  final int? eventID;
  final String? personnelId;
  final String? role;
  const CollectingPersonnelData(
      {required this.id, this.eventID, this.personnelId, this.role});
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
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    return map;
  }

  CollectingPersonnelCompanion toCompanion(bool nullToAbsent) {
    return CollectingPersonnelCompanion(
      id: Value(id),
      eventID: eventID == null && nullToAbsent
          ? const Value.absent()
          : Value(eventID),
      personnelId: personnelId == null && nullToAbsent
          ? const Value.absent()
          : Value(personnelId),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
    );
  }

  factory CollectingPersonnelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectingPersonnelData(
      id: serializer.fromJson<int>(json['id']),
      eventID: serializer.fromJson<int?>(json['eventID']),
      personnelId: serializer.fromJson<String?>(json['personnelId']),
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
      'role': serializer.toJson<String?>(role),
    };
  }

  CollectingPersonnelData copyWith(
          {int? id,
          Value<int?> eventID = const Value.absent(),
          Value<String?> personnelId = const Value.absent(),
          Value<String?> role = const Value.absent()}) =>
      CollectingPersonnelData(
        id: id ?? this.id,
        eventID: eventID.present ? eventID.value : this.eventID,
        personnelId: personnelId.present ? personnelId.value : this.personnelId,
        role: role.present ? role.value : this.role,
      );
  @override
  String toString() {
    return (StringBuffer('CollectingPersonnelData(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('personnelId: $personnelId, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventID, personnelId, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectingPersonnelData &&
          other.id == this.id &&
          other.eventID == this.eventID &&
          other.personnelId == this.personnelId &&
          other.role == this.role);
}

class CollectingPersonnelCompanion
    extends UpdateCompanion<CollectingPersonnelData> {
  final Value<int> id;
  final Value<int?> eventID;
  final Value<String?> personnelId;
  final Value<String?> role;
  const CollectingPersonnelCompanion({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.personnelId = const Value.absent(),
    this.role = const Value.absent(),
  });
  CollectingPersonnelCompanion.insert({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.personnelId = const Value.absent(),
    this.role = const Value.absent(),
  });
  static Insertable<CollectingPersonnelData> custom({
    Expression<int>? id,
    Expression<int>? eventID,
    Expression<String>? personnelId,
    Expression<String>? role,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventID != null) 'eventID': eventID,
      if (personnelId != null) 'personnelId': personnelId,
      if (role != null) 'role': role,
    });
  }

  CollectingPersonnelCompanion copyWith(
      {Value<int>? id,
      Value<int?>? eventID,
      Value<String?>? personnelId,
      Value<String?>? role}) {
    return CollectingPersonnelCompanion(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      personnelId: personnelId ?? this.personnelId,
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
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectingPersonnelCompanion(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('personnelId: $personnelId, ')
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
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
      [id, eventID, type, brand, count, size, notes];
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
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
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
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
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
  final String? type;
  final String? brand;
  final int? count;
  final String? size;
  final String? notes;
  const CollEffortData(
      {required this.id,
      this.eventID,
      this.type,
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
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
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
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
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
      type: serializer.fromJson<String?>(json['type']),
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
      'type': serializer.toJson<String?>(type),
      'brand': serializer.toJson<String?>(brand),
      'count': serializer.toJson<int?>(count),
      'size': serializer.toJson<String?>(size),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  CollEffortData copyWith(
          {int? id,
          Value<int?> eventID = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<String?> brand = const Value.absent(),
          Value<int?> count = const Value.absent(),
          Value<String?> size = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      CollEffortData(
        id: id ?? this.id,
        eventID: eventID.present ? eventID.value : this.eventID,
        type: type.present ? type.value : this.type,
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
          ..write('type: $type, ')
          ..write('brand: $brand, ')
          ..write('count: $count, ')
          ..write('size: $size, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventID, type, brand, count, size, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollEffortData &&
          other.id == this.id &&
          other.eventID == this.eventID &&
          other.type == this.type &&
          other.brand == this.brand &&
          other.count == this.count &&
          other.size == this.size &&
          other.notes == this.notes);
}

class CollEffortCompanion extends UpdateCompanion<CollEffortData> {
  final Value<int> id;
  final Value<int?> eventID;
  final Value<String?> type;
  final Value<String?> brand;
  final Value<int?> count;
  final Value<String?> size;
  final Value<String?> notes;
  const CollEffortCompanion({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.type = const Value.absent(),
    this.brand = const Value.absent(),
    this.count = const Value.absent(),
    this.size = const Value.absent(),
    this.notes = const Value.absent(),
  });
  CollEffortCompanion.insert({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.type = const Value.absent(),
    this.brand = const Value.absent(),
    this.count = const Value.absent(),
    this.size = const Value.absent(),
    this.notes = const Value.absent(),
  });
  static Insertable<CollEffortData> custom({
    Expression<int>? id,
    Expression<int>? eventID,
    Expression<String>? type,
    Expression<String>? brand,
    Expression<int>? count,
    Expression<String>? size,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventID != null) 'eventID': eventID,
      if (type != null) 'type': type,
      if (brand != null) 'brand': brand,
      if (count != null) 'count': count,
      if (size != null) 'size': size,
      if (notes != null) 'notes': notes,
    });
  }

  CollEffortCompanion copyWith(
      {Value<int>? id,
      Value<int?>? eventID,
      Value<String?>? type,
      Value<String?>? brand,
      Value<int?>? count,
      Value<String?>? size,
      Value<String?>? notes}) {
    return CollEffortCompanion(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      type: type ?? this.type,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
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
          ..write('type: $type, ')
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
  late final GeneratedColumn<Uint8List> secondaryIdRef =
      GeneratedColumn<Uint8List>('secondaryIdRef', aliasedName, true,
          type: DriftSqlType.blob,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<Uint8List> type = GeneratedColumn<Uint8List>(
      'type', aliasedName, true,
      type: DriftSqlType.blob,
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
          .read(DriftSqlType.blob, data['${effectivePrefix}secondaryIdRef']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}type']),
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
  final Uint8List? secondaryIdRef;
  final Uint8List? type;
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
      map['secondaryIdRef'] = Variable<Uint8List>(secondaryIdRef);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<Uint8List>(type);
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
      secondaryIdRef: serializer.fromJson<Uint8List?>(json['secondaryIdRef']),
      type: serializer.fromJson<Uint8List?>(json['type']),
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
      'secondaryIdRef': serializer.toJson<Uint8List?>(secondaryIdRef),
      'type': serializer.toJson<Uint8List?>(type),
      'description': serializer.toJson<String?>(description),
      'fileId': serializer.toJson<String?>(fileId),
    };
  }

  AssociatedDataData copyWith(
          {Value<int?> primaryId = const Value.absent(),
          Value<String?> secondaryId = const Value.absent(),
          Value<Uint8List?> secondaryIdRef = const Value.absent(),
          Value<Uint8List?> type = const Value.absent(),
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
      primaryId,
      secondaryId,
      $driftBlobEquality.hash(secondaryIdRef),
      $driftBlobEquality.hash(type),
      description,
      fileId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssociatedDataData &&
          other.primaryId == this.primaryId &&
          other.secondaryId == this.secondaryId &&
          $driftBlobEquality.equals(
              other.secondaryIdRef, this.secondaryIdRef) &&
          $driftBlobEquality.equals(other.type, this.type) &&
          other.description == this.description &&
          other.fileId == this.fileId);
}

class AssociatedDataCompanion extends UpdateCompanion<AssociatedDataData> {
  final Value<int?> primaryId;
  final Value<String?> secondaryId;
  final Value<Uint8List?> secondaryIdRef;
  final Value<Uint8List?> type;
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
    Expression<Uint8List>? secondaryIdRef,
    Expression<Uint8List>? type,
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
      Value<Uint8List?>? secondaryIdRef,
      Value<Uint8List?>? type,
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
      map['secondaryIdRef'] = Variable<Uint8List>(secondaryIdRef.value);
    }
    if (type.present) {
      map['type'] = Variable<Uint8List>(type.value);
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
  const PersonnelListCompanion({
    this.projectUuid = const Value.absent(),
    this.personnelUuid = const Value.absent(),
  });
  PersonnelListCompanion.insert({
    this.projectUuid = const Value.absent(),
    this.personnelUuid = const Value.absent(),
  });
  static Insertable<PersonnelListData> custom({
    Expression<String>? projectUuid,
    Expression<String>? personnelUuid,
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
      map['projectUuid'] = Variable<String>(projectUuid.value);
    }
    if (personnelUuid.present) {
      map['personnelUuid'] = Variable<String>(personnelUuid.value);
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
  const ProjectPersonnelCompanion({
    this.projectUuid = const Value.absent(),
    this.personnelId = const Value.absent(),
  });
  ProjectPersonnelCompanion.insert({
    this.projectUuid = const Value.absent(),
    this.personnelId = const Value.absent(),
  });
  static Insertable<ProjectPersonnelData> custom({
    Expression<String>? projectUuid,
    Expression<String>? personnelId,
  }) {
    return RawValuesInsertable({
      if (projectUuid != null) 'projectUuid': projectUuid,
      if (personnelId != null) 'personnelId': personnelId,
    });
  }

  ProjectPersonnelCompanion copyWith(
      {Value<String?>? projectUuid, Value<String?>? personnelId}) {
    return ProjectPersonnelCompanion(
      projectUuid: projectUuid ?? this.projectUuid,
      personnelId: personnelId ?? this.personnelId,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectPersonnelCompanion(')
          ..write('projectUuid: $projectUuid, ')
          ..write('personnelId: $personnelId')
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
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
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
        note,
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
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
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
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
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
  final String? note;
  final int? mediaId;
  const TaxonomyData(
      {required this.id,
      this.taxonClass,
      this.taxonOrder,
      this.taxonFamily,
      this.genus,
      this.specificEpithet,
      this.commonName,
      this.note,
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
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
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
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
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
      note: serializer.fromJson<String?>(json['note']),
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
      'note': serializer.toJson<String?>(note),
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
          Value<String?> note = const Value.absent(),
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
        note: note.present ? note.value : this.note,
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
          ..write('note: $note, ')
          ..write('mediaId: $mediaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taxonClass, taxonOrder, taxonFamily,
      genus, specificEpithet, commonName, note, mediaId);
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
          other.note == this.note &&
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
  final Value<String?> note;
  final Value<int?> mediaId;
  const TaxonomyCompanion({
    this.id = const Value.absent(),
    this.taxonClass = const Value.absent(),
    this.taxonOrder = const Value.absent(),
    this.taxonFamily = const Value.absent(),
    this.genus = const Value.absent(),
    this.specificEpithet = const Value.absent(),
    this.commonName = const Value.absent(),
    this.note = const Value.absent(),
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
    this.note = const Value.absent(),
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
    Expression<String>? note,
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
      if (note != null) 'note': note,
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
      Value<String?>? note,
      Value<int?>? mediaId}) {
    return TaxonomyCompanion(
      id: id ?? this.id,
      taxonClass: taxonClass ?? this.taxonClass,
      taxonOrder: taxonOrder ?? this.taxonOrder,
      taxonFamily: taxonFamily ?? this.taxonFamily,
      genus: genus ?? this.genus,
      specificEpithet: specificEpithet ?? this.specificEpithet,
      commonName: commonName ?? this.commonName,
      note: note ?? this.note,
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
    if (note.present) {
      map['note'] = Variable<String>(note.value);
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
          ..write('note: $note, ')
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
  static const VerificationMeta _captureDateMeta =
      const VerificationMeta('captureDate');
  late final GeneratedColumn<String> captureDate = GeneratedColumn<String>(
      'captureDate', aliasedName, true,
      type: DriftSqlType.string,
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
  static const VerificationMeta _collectorIDMeta =
      const VerificationMeta('collectorID');
  late final GeneratedColumn<String> collectorID = GeneratedColumn<String>(
      'collectorID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _collectorNumberMeta =
      const VerificationMeta('collectorNumber');
  late final GeneratedColumn<int> collectorNumber = GeneratedColumn<int>(
      'collectorNumber', aliasedName, true,
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
        captureDate,
        captureTime,
        trapType,
        collectorID,
        collectorNumber,
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
    if (data.containsKey('collectorNumber')) {
      context.handle(
          _collectorNumberMeta,
          collectorNumber.isAcceptableOrUnknown(
              data['collectorNumber']!, _collectorNumberMeta));
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
      captureDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}captureDate']),
      captureTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}captureTime']),
      trapType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}trapType']),
      collectorID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collectorID']),
      collectorNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}collectorNumber']),
      collEventID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}collEventID']),
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
        'FOREIGN KEY(collectorID)REFERENCES personnel(uuid)',
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
  final String? condition;
  final String? prepDate;
  final String? prepTime;
  final String? captureDate;
  final String? captureTime;
  final String? trapType;
  final String? collectorID;
  final int? collectorNumber;
  final int? collEventID;
  final String? preparatorID;
  const SpecimenData(
      {required this.uuid,
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
      this.collectorNumber,
      this.collEventID,
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
    if (!nullToAbsent || captureDate != null) {
      map['captureDate'] = Variable<String>(captureDate);
    }
    if (!nullToAbsent || captureTime != null) {
      map['captureTime'] = Variable<String>(captureTime);
    }
    if (!nullToAbsent || trapType != null) {
      map['trapType'] = Variable<String>(trapType);
    }
    if (!nullToAbsent || collectorID != null) {
      map['collectorID'] = Variable<String>(collectorID);
    }
    if (!nullToAbsent || collectorNumber != null) {
      map['collectorNumber'] = Variable<int>(collectorNumber);
    }
    if (!nullToAbsent || collEventID != null) {
      map['collEventID'] = Variable<int>(collEventID);
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
      collectorNumber: collectorNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(collectorNumber),
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
      uuid: serializer.fromJson<String>(json['uuid']),
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
      collectorNumber: serializer.fromJson<int?>(json['collectorNumber']),
      collEventID: serializer.fromJson<int?>(json['collEventID']),
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
      'captureDate': serializer.toJson<String?>(captureDate),
      'captureTime': serializer.toJson<String?>(captureTime),
      'trapType': serializer.toJson<String?>(trapType),
      'collectorID': serializer.toJson<String?>(collectorID),
      'collectorNumber': serializer.toJson<int?>(collectorNumber),
      'collEventID': serializer.toJson<int?>(collEventID),
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
          Value<String?> captureDate = const Value.absent(),
          Value<String?> captureTime = const Value.absent(),
          Value<String?> trapType = const Value.absent(),
          Value<String?> collectorID = const Value.absent(),
          Value<int?> collectorNumber = const Value.absent(),
          Value<int?> collEventID = const Value.absent(),
          Value<String?> preparatorID = const Value.absent()}) =>
      SpecimenData(
        uuid: uuid ?? this.uuid,
        projectUuid: projectUuid.present ? projectUuid.value : this.projectUuid,
        speciesID: speciesID.present ? speciesID.value : this.speciesID,
        taxonGroup: taxonGroup.present ? taxonGroup.value : this.taxonGroup,
        condition: condition.present ? condition.value : this.condition,
        prepDate: prepDate.present ? prepDate.value : this.prepDate,
        prepTime: prepTime.present ? prepTime.value : this.prepTime,
        captureDate: captureDate.present ? captureDate.value : this.captureDate,
        captureTime: captureTime.present ? captureTime.value : this.captureTime,
        trapType: trapType.present ? trapType.value : this.trapType,
        collectorID: collectorID.present ? collectorID.value : this.collectorID,
        collectorNumber: collectorNumber.present
            ? collectorNumber.value
            : this.collectorNumber,
        collEventID: collEventID.present ? collEventID.value : this.collEventID,
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
          ..write('captureDate: $captureDate, ')
          ..write('captureTime: $captureTime, ')
          ..write('trapType: $trapType, ')
          ..write('collectorID: $collectorID, ')
          ..write('collectorNumber: $collectorNumber, ')
          ..write('collEventID: $collEventID, ')
          ..write('preparatorID: $preparatorID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uuid,
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
      collectorNumber,
      collEventID,
      preparatorID);
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
          other.captureDate == this.captureDate &&
          other.captureTime == this.captureTime &&
          other.trapType == this.trapType &&
          other.collectorID == this.collectorID &&
          other.collectorNumber == this.collectorNumber &&
          other.collEventID == this.collEventID &&
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
  final Value<String?> captureDate;
  final Value<String?> captureTime;
  final Value<String?> trapType;
  final Value<String?> collectorID;
  final Value<int?> collectorNumber;
  final Value<int?> collEventID;
  final Value<String?> preparatorID;
  const SpecimenCompanion({
    this.uuid = const Value.absent(),
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
    this.collectorNumber = const Value.absent(),
    this.collEventID = const Value.absent(),
    this.preparatorID = const Value.absent(),
  });
  SpecimenCompanion.insert({
    required String uuid,
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
    this.collectorNumber = const Value.absent(),
    this.collEventID = const Value.absent(),
    this.preparatorID = const Value.absent(),
  }) : uuid = Value(uuid);
  static Insertable<SpecimenData> custom({
    Expression<String>? uuid,
    Expression<String>? projectUuid,
    Expression<int>? speciesID,
    Expression<String>? taxonGroup,
    Expression<String>? condition,
    Expression<String>? prepDate,
    Expression<String>? prepTime,
    Expression<String>? captureDate,
    Expression<String>? captureTime,
    Expression<String>? trapType,
    Expression<String>? collectorID,
    Expression<int>? collectorNumber,
    Expression<int>? collEventID,
    Expression<String>? preparatorID,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
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
      if (collectorNumber != null) 'collectorNumber': collectorNumber,
      if (collEventID != null) 'collEventID': collEventID,
      if (preparatorID != null) 'preparatorID': preparatorID,
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
      Value<String?>? captureDate,
      Value<String?>? captureTime,
      Value<String?>? trapType,
      Value<String?>? collectorID,
      Value<int?>? collectorNumber,
      Value<int?>? collEventID,
      Value<String?>? preparatorID}) {
    return SpecimenCompanion(
      uuid: uuid ?? this.uuid,
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
      collectorNumber: collectorNumber ?? this.collectorNumber,
      collEventID: collEventID ?? this.collEventID,
      preparatorID: preparatorID ?? this.preparatorID,
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
    if (captureDate.present) {
      map['captureDate'] = Variable<String>(captureDate.value);
    }
    if (captureTime.present) {
      map['captureTime'] = Variable<String>(captureTime.value);
    }
    if (trapType.present) {
      map['trapType'] = Variable<String>(trapType.value);
    }
    if (collectorID.present) {
      map['collectorID'] = Variable<String>(collectorID.value);
    }
    if (collectorNumber.present) {
      map['collectorNumber'] = Variable<int>(collectorNumber.value);
    }
    if (collEventID.present) {
      map['collEventID'] = Variable<int>(collEventID.value);
    }
    if (preparatorID.present) {
      map['preparatorID'] = Variable<String>(preparatorID.value);
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
          ..write('captureDate: $captureDate, ')
          ..write('captureTime: $captureTime, ')
          ..write('trapType: $trapType, ')
          ..write('collectorID: $collectorID, ')
          ..write('collectorNumber: $collectorNumber, ')
          ..write('collEventID: $collEventID, ')
          ..write('preparatorID: $preparatorID')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String> specimenUuid = GeneratedColumn<String>(
      'specimenUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _totalLengthMeta =
      const VerificationMeta('totalLength');
  late final GeneratedColumn<int> totalLength = GeneratedColumn<int>(
      'totalLength', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tailLengthMeta =
      const VerificationMeta('tailLength');
  late final GeneratedColumn<int> tailLength = GeneratedColumn<int>(
      'tailLength', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _hindFootLengthMeta =
      const VerificationMeta('hindFootLength');
  late final GeneratedColumn<int> hindFootLength = GeneratedColumn<int>(
      'hindFootLength', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _earLengthMeta =
      const VerificationMeta('earLength');
  late final GeneratedColumn<int> earLength = GeneratedColumn<int>(
      'earLength', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _forearmMeta =
      const VerificationMeta('forearm');
  late final GeneratedColumn<int> forearm = GeneratedColumn<int>(
      'forearm', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _inaccurateMeta =
      const VerificationMeta('inaccurate');
  late final GeneratedColumn<String> inaccurate = GeneratedColumn<String>(
      'inaccurate', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _inaccurateReasonMeta =
      const VerificationMeta('inaccurateReason');
  late final GeneratedColumn<String> inaccurateReason = GeneratedColumn<String>(
      'inaccurateReason', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
      'sex', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _lifeStageMeta =
      const VerificationMeta('lifeStage');
  late final GeneratedColumn<String> lifeStage = GeneratedColumn<String>(
      'lifeStage', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _testesPositionMeta =
      const VerificationMeta('testesPosition');
  late final GeneratedColumn<String> testesPosition = GeneratedColumn<String>(
      'testesPosition', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _testesLengthMeta =
      const VerificationMeta('testesLength');
  late final GeneratedColumn<int> testesLength = GeneratedColumn<int>(
      'testesLength', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _testesWidthMeta =
      const VerificationMeta('testesWidth');
  late final GeneratedColumn<int> testesWidth = GeneratedColumn<int>(
      'testesWidth', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _reproductiveStageMeta =
      const VerificationMeta('reproductiveStage');
  late final GeneratedColumn<String> reproductiveStage =
      GeneratedColumn<String>('reproductiveStage', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _placentalScarsMeta =
      const VerificationMeta('placentalScars');
  late final GeneratedColumn<String> placentalScars = GeneratedColumn<String>(
      'placentalScars', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _mammaeInguinalCountMeta =
      const VerificationMeta('mammaeInguinalCount');
  late final GeneratedColumn<int> mammaeInguinalCount = GeneratedColumn<int>(
      'mammaeInguinalCount', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _mammaeAxilaryCountMeta =
      const VerificationMeta('mammaeAxilaryCount');
  late final GeneratedColumn<int> mammaeAxilaryCount = GeneratedColumn<int>(
      'mammaeAxilaryCount', aliasedName, true,
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
  static const VerificationMeta _embryoCRLeftMeta =
      const VerificationMeta('embryoCRLeft');
  late final GeneratedColumn<int> embryoCRLeft = GeneratedColumn<int>(
      'embryoCRLeft', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _embryoCRRightMeta =
      const VerificationMeta('embryoCRRight');
  late final GeneratedColumn<int> embryoCRRight = GeneratedColumn<int>(
      'embryoCRRight', aliasedName, true,
      type: DriftSqlType.int,
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MammalMeasurementData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      specimenUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specimenUuid']),
      totalLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}totalLength']),
      tailLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tailLength']),
      hindFootLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hindFootLength']),
      earLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}earLength']),
      forearm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}forearm']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight']),
      inaccurate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}inaccurate']),
      inaccurateReason: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}inaccurateReason']),
      sex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sex']),
      lifeStage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lifeStage']),
      testesPosition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}testesPosition']),
      testesLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}testesLength']),
      testesWidth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}testesWidth']),
      reproductiveStage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reproductiveStage']),
      placentalScars: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}placentalScars']),
      mammaeInguinalCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}mammaeInguinalCount']),
      mammaeAxilaryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mammaeAxilaryCount']),
      mammaeAbdominalCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}mammaeAbdominalCount']),
      embryoLeftCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}embryoLeftCount']),
      embryoRightCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}embryoRightCount']),
      embryoCRLeft: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}embryoCRLeft']),
      embryoCRRight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}embryoCRRight']),
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
  const MammalMeasurementData(
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || specimenUuid != null) {
      map['specimenUuid'] = Variable<String>(specimenUuid);
    }
    if (!nullToAbsent || totalLength != null) {
      map['totalLength'] = Variable<int>(totalLength);
    }
    if (!nullToAbsent || tailLength != null) {
      map['tailLength'] = Variable<int>(tailLength);
    }
    if (!nullToAbsent || hindFootLength != null) {
      map['hindFootLength'] = Variable<int>(hindFootLength);
    }
    if (!nullToAbsent || earLength != null) {
      map['earLength'] = Variable<int>(earLength);
    }
    if (!nullToAbsent || forearm != null) {
      map['forearm'] = Variable<int>(forearm);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || inaccurate != null) {
      map['inaccurate'] = Variable<String>(inaccurate);
    }
    if (!nullToAbsent || inaccurateReason != null) {
      map['inaccurateReason'] = Variable<String>(inaccurateReason);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<String>(sex);
    }
    if (!nullToAbsent || lifeStage != null) {
      map['lifeStage'] = Variable<String>(lifeStage);
    }
    if (!nullToAbsent || testesPosition != null) {
      map['testesPosition'] = Variable<String>(testesPosition);
    }
    if (!nullToAbsent || testesLength != null) {
      map['testesLength'] = Variable<int>(testesLength);
    }
    if (!nullToAbsent || testesWidth != null) {
      map['testesWidth'] = Variable<int>(testesWidth);
    }
    if (!nullToAbsent || reproductiveStage != null) {
      map['reproductiveStage'] = Variable<String>(reproductiveStage);
    }
    if (!nullToAbsent || placentalScars != null) {
      map['placentalScars'] = Variable<String>(placentalScars);
    }
    if (!nullToAbsent || mammaeInguinalCount != null) {
      map['mammaeInguinalCount'] = Variable<int>(mammaeInguinalCount);
    }
    if (!nullToAbsent || mammaeAxilaryCount != null) {
      map['mammaeAxilaryCount'] = Variable<int>(mammaeAxilaryCount);
    }
    if (!nullToAbsent || mammaeAbdominalCount != null) {
      map['mammaeAbdominalCount'] = Variable<int>(mammaeAbdominalCount);
    }
    if (!nullToAbsent || embryoLeftCount != null) {
      map['embryoLeftCount'] = Variable<int>(embryoLeftCount);
    }
    if (!nullToAbsent || embryoRightCount != null) {
      map['embryoRightCount'] = Variable<int>(embryoRightCount);
    }
    if (!nullToAbsent || embryoCRLeft != null) {
      map['embryoCRLeft'] = Variable<int>(embryoCRLeft);
    }
    if (!nullToAbsent || embryoCRRight != null) {
      map['embryoCRRight'] = Variable<int>(embryoCRRight);
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
          Value<String?> specimenUuid = const Value.absent(),
          Value<int?> totalLength = const Value.absent(),
          Value<int?> tailLength = const Value.absent(),
          Value<int?> hindFootLength = const Value.absent(),
          Value<int?> earLength = const Value.absent(),
          Value<int?> forearm = const Value.absent(),
          Value<int?> weight = const Value.absent(),
          Value<String?> inaccurate = const Value.absent(),
          Value<String?> inaccurateReason = const Value.absent(),
          Value<String?> sex = const Value.absent(),
          Value<String?> lifeStage = const Value.absent(),
          Value<String?> testesPosition = const Value.absent(),
          Value<int?> testesLength = const Value.absent(),
          Value<int?> testesWidth = const Value.absent(),
          Value<String?> reproductiveStage = const Value.absent(),
          Value<String?> placentalScars = const Value.absent(),
          Value<int?> mammaeInguinalCount = const Value.absent(),
          Value<int?> mammaeAxilaryCount = const Value.absent(),
          Value<int?> mammaeAbdominalCount = const Value.absent(),
          Value<int?> embryoLeftCount = const Value.absent(),
          Value<int?> embryoRightCount = const Value.absent(),
          Value<int?> embryoCRLeft = const Value.absent(),
          Value<int?> embryoCRRight = const Value.absent()}) =>
      MammalMeasurementData(
        id: id ?? this.id,
        specimenUuid:
            specimenUuid.present ? specimenUuid.value : this.specimenUuid,
        totalLength: totalLength.present ? totalLength.value : this.totalLength,
        tailLength: tailLength.present ? tailLength.value : this.tailLength,
        hindFootLength:
            hindFootLength.present ? hindFootLength.value : this.hindFootLength,
        earLength: earLength.present ? earLength.value : this.earLength,
        forearm: forearm.present ? forearm.value : this.forearm,
        weight: weight.present ? weight.value : this.weight,
        inaccurate: inaccurate.present ? inaccurate.value : this.inaccurate,
        inaccurateReason: inaccurateReason.present
            ? inaccurateReason.value
            : this.inaccurateReason,
        sex: sex.present ? sex.value : this.sex,
        lifeStage: lifeStage.present ? lifeStage.value : this.lifeStage,
        testesPosition:
            testesPosition.present ? testesPosition.value : this.testesPosition,
        testesLength:
            testesLength.present ? testesLength.value : this.testesLength,
        testesWidth: testesWidth.present ? testesWidth.value : this.testesWidth,
        reproductiveStage: reproductiveStage.present
            ? reproductiveStage.value
            : this.reproductiveStage,
        placentalScars:
            placentalScars.present ? placentalScars.value : this.placentalScars,
        mammaeInguinalCount: mammaeInguinalCount.present
            ? mammaeInguinalCount.value
            : this.mammaeInguinalCount,
        mammaeAxilaryCount: mammaeAxilaryCount.present
            ? mammaeAxilaryCount.value
            : this.mammaeAxilaryCount,
        mammaeAbdominalCount: mammaeAbdominalCount.present
            ? mammaeAbdominalCount.value
            : this.mammaeAbdominalCount,
        embryoLeftCount: embryoLeftCount.present
            ? embryoLeftCount.value
            : this.embryoLeftCount,
        embryoRightCount: embryoRightCount.present
            ? embryoRightCount.value
            : this.embryoRightCount,
        embryoCRLeft:
            embryoCRLeft.present ? embryoCRLeft.value : this.embryoCRLeft,
        embryoCRRight:
            embryoCRRight.present ? embryoCRRight.value : this.embryoCRRight,
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
    Expression<String>? specimenUuid,
    Expression<int>? totalLength,
    Expression<int>? tailLength,
    Expression<int>? hindFootLength,
    Expression<int>? earLength,
    Expression<int>? forearm,
    Expression<int>? weight,
    Expression<String>? inaccurate,
    Expression<String>? inaccurateReason,
    Expression<String>? sex,
    Expression<String>? lifeStage,
    Expression<String>? testesPosition,
    Expression<int>? testesLength,
    Expression<int>? testesWidth,
    Expression<String>? reproductiveStage,
    Expression<String>? placentalScars,
    Expression<int>? mammaeInguinalCount,
    Expression<int>? mammaeAxilaryCount,
    Expression<int>? mammaeAbdominalCount,
    Expression<int>? embryoLeftCount,
    Expression<int>? embryoRightCount,
    Expression<int>? embryoCRLeft,
    Expression<int>? embryoCRRight,
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
      map['specimenUuid'] = Variable<String>(specimenUuid.value);
    }
    if (totalLength.present) {
      map['totalLength'] = Variable<int>(totalLength.value);
    }
    if (tailLength.present) {
      map['tailLength'] = Variable<int>(tailLength.value);
    }
    if (hindFootLength.present) {
      map['hindFootLength'] = Variable<int>(hindFootLength.value);
    }
    if (earLength.present) {
      map['earLength'] = Variable<int>(earLength.value);
    }
    if (forearm.present) {
      map['forearm'] = Variable<int>(forearm.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (inaccurate.present) {
      map['inaccurate'] = Variable<String>(inaccurate.value);
    }
    if (inaccurateReason.present) {
      map['inaccurateReason'] = Variable<String>(inaccurateReason.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (lifeStage.present) {
      map['lifeStage'] = Variable<String>(lifeStage.value);
    }
    if (testesPosition.present) {
      map['testesPosition'] = Variable<String>(testesPosition.value);
    }
    if (testesLength.present) {
      map['testesLength'] = Variable<int>(testesLength.value);
    }
    if (testesWidth.present) {
      map['testesWidth'] = Variable<int>(testesWidth.value);
    }
    if (reproductiveStage.present) {
      map['reproductiveStage'] = Variable<String>(reproductiveStage.value);
    }
    if (placentalScars.present) {
      map['placentalScars'] = Variable<String>(placentalScars.value);
    }
    if (mammaeInguinalCount.present) {
      map['mammaeInguinalCount'] = Variable<int>(mammaeInguinalCount.value);
    }
    if (mammaeAxilaryCount.present) {
      map['mammaeAxilaryCount'] = Variable<int>(mammaeAxilaryCount.value);
    }
    if (mammaeAbdominalCount.present) {
      map['mammaeAbdominalCount'] = Variable<int>(mammaeAbdominalCount.value);
    }
    if (embryoLeftCount.present) {
      map['embryoLeftCount'] = Variable<int>(embryoLeftCount.value);
    }
    if (embryoRightCount.present) {
      map['embryoRightCount'] = Variable<int>(embryoRightCount.value);
    }
    if (embryoCRLeft.present) {
      map['embryoCRLeft'] = Variable<int>(embryoCRLeft.value);
    }
    if (embryoCRRight.present) {
      map['embryoCRRight'] = Variable<int>(embryoCRRight.value);
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

class BirdMeasurement extends Table
    with TableInfo<BirdMeasurement, BirdMeasurementData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  BirdMeasurement(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String> specimenUuid = GeneratedColumn<String>(
      'specimenUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _wingspanMeta =
      const VerificationMeta('wingspan');
  late final GeneratedColumn<int> wingspan = GeneratedColumn<int>(
      'wingspan', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _irisColorMeta =
      const VerificationMeta('irisColor');
  late final GeneratedColumn<String> irisColor = GeneratedColumn<String>(
      'irisColor', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _feetColorMeta =
      const VerificationMeta('feetColor');
  late final GeneratedColumn<String> feetColor = GeneratedColumn<String>(
      'feetColor', aliasedName, true,
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
  static const VerificationMeta _moltingWingMeta =
      const VerificationMeta('moltingWing');
  late final GeneratedColumn<String> moltingWing = GeneratedColumn<String>(
      'moltingWing', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _moltingTailMeta =
      const VerificationMeta('moltingTail');
  late final GeneratedColumn<String> moltingTail = GeneratedColumn<String>(
      'moltingTail', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _bodyFatMeta =
      const VerificationMeta('bodyFat');
  late final GeneratedColumn<String> bodyFat = GeneratedColumn<String>(
      'bodyFat', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _bursaLengthMeta =
      const VerificationMeta('bursaLength');
  late final GeneratedColumn<int> bursaLength = GeneratedColumn<int>(
      'bursaLength', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _bursaWidthMeta =
      const VerificationMeta('bursaWidth');
  late final GeneratedColumn<int> bursaWidth = GeneratedColumn<int>(
      'bursaWidth', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _skullOssilationMeta =
      const VerificationMeta('skullOssilation');
  late final GeneratedColumn<String> skullOssilation = GeneratedColumn<String>(
      'skullOssilation', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  late final GeneratedColumn<String> fat = GeneratedColumn<String>(
      'fat', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
      'sex', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _gonadMeta = const VerificationMeta('gonad');
  late final GeneratedColumn<String> gonad = GeneratedColumn<String>(
      'gonad', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _stomachMeta =
      const VerificationMeta('stomach');
  late final GeneratedColumn<String> stomach = GeneratedColumn<String>(
      'stomach', aliasedName, true,
      type: DriftSqlType.string,
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BirdMeasurementData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      specimenUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specimenUuid']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight']),
      wingspan: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wingspan']),
      irisColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}irisColor']),
      feetColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feetColor']),
      tarsusColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tarsusColor']),
      moltingWing: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}moltingWing']),
      moltingTail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}moltingTail']),
      bodyFat: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bodyFat']),
      bursaLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bursaLength']),
      bursaWidth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bursaWidth']),
      skullOssilation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}skullOssilation']),
      fat: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fat']),
      sex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sex']),
      gonad: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gonad']),
      stomach: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stomach']),
    );
  }

  @override
  BirdMeasurement createAlias(String alias) {
    return BirdMeasurement(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(specimenUuid)REFERENCES specimen(uuid)'];
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
  const BirdMeasurementData(
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || specimenUuid != null) {
      map['specimenUuid'] = Variable<String>(specimenUuid);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || wingspan != null) {
      map['wingspan'] = Variable<int>(wingspan);
    }
    if (!nullToAbsent || irisColor != null) {
      map['irisColor'] = Variable<String>(irisColor);
    }
    if (!nullToAbsent || feetColor != null) {
      map['feetColor'] = Variable<String>(feetColor);
    }
    if (!nullToAbsent || tarsusColor != null) {
      map['tarsusColor'] = Variable<String>(tarsusColor);
    }
    if (!nullToAbsent || moltingWing != null) {
      map['moltingWing'] = Variable<String>(moltingWing);
    }
    if (!nullToAbsent || moltingTail != null) {
      map['moltingTail'] = Variable<String>(moltingTail);
    }
    if (!nullToAbsent || bodyFat != null) {
      map['bodyFat'] = Variable<String>(bodyFat);
    }
    if (!nullToAbsent || bursaLength != null) {
      map['bursaLength'] = Variable<int>(bursaLength);
    }
    if (!nullToAbsent || bursaWidth != null) {
      map['bursaWidth'] = Variable<int>(bursaWidth);
    }
    if (!nullToAbsent || skullOssilation != null) {
      map['skullOssilation'] = Variable<String>(skullOssilation);
    }
    if (!nullToAbsent || fat != null) {
      map['fat'] = Variable<String>(fat);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<String>(sex);
    }
    if (!nullToAbsent || gonad != null) {
      map['gonad'] = Variable<String>(gonad);
    }
    if (!nullToAbsent || stomach != null) {
      map['stomach'] = Variable<String>(stomach);
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
          Value<String?> specimenUuid = const Value.absent(),
          Value<int?> weight = const Value.absent(),
          Value<int?> wingspan = const Value.absent(),
          Value<String?> irisColor = const Value.absent(),
          Value<String?> feetColor = const Value.absent(),
          Value<String?> tarsusColor = const Value.absent(),
          Value<String?> moltingWing = const Value.absent(),
          Value<String?> moltingTail = const Value.absent(),
          Value<String?> bodyFat = const Value.absent(),
          Value<int?> bursaLength = const Value.absent(),
          Value<int?> bursaWidth = const Value.absent(),
          Value<String?> skullOssilation = const Value.absent(),
          Value<String?> fat = const Value.absent(),
          Value<String?> sex = const Value.absent(),
          Value<String?> gonad = const Value.absent(),
          Value<String?> stomach = const Value.absent()}) =>
      BirdMeasurementData(
        id: id ?? this.id,
        specimenUuid:
            specimenUuid.present ? specimenUuid.value : this.specimenUuid,
        weight: weight.present ? weight.value : this.weight,
        wingspan: wingspan.present ? wingspan.value : this.wingspan,
        irisColor: irisColor.present ? irisColor.value : this.irisColor,
        feetColor: feetColor.present ? feetColor.value : this.feetColor,
        tarsusColor: tarsusColor.present ? tarsusColor.value : this.tarsusColor,
        moltingWing: moltingWing.present ? moltingWing.value : this.moltingWing,
        moltingTail: moltingTail.present ? moltingTail.value : this.moltingTail,
        bodyFat: bodyFat.present ? bodyFat.value : this.bodyFat,
        bursaLength: bursaLength.present ? bursaLength.value : this.bursaLength,
        bursaWidth: bursaWidth.present ? bursaWidth.value : this.bursaWidth,
        skullOssilation: skullOssilation.present
            ? skullOssilation.value
            : this.skullOssilation,
        fat: fat.present ? fat.value : this.fat,
        sex: sex.present ? sex.value : this.sex,
        gonad: gonad.present ? gonad.value : this.gonad,
        stomach: stomach.present ? stomach.value : this.stomach,
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
    Expression<String>? specimenUuid,
    Expression<int>? weight,
    Expression<int>? wingspan,
    Expression<String>? irisColor,
    Expression<String>? feetColor,
    Expression<String>? tarsusColor,
    Expression<String>? moltingWing,
    Expression<String>? moltingTail,
    Expression<String>? bodyFat,
    Expression<int>? bursaLength,
    Expression<int>? bursaWidth,
    Expression<String>? skullOssilation,
    Expression<String>? fat,
    Expression<String>? sex,
    Expression<String>? gonad,
    Expression<String>? stomach,
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
      map['specimenUuid'] = Variable<String>(specimenUuid.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (wingspan.present) {
      map['wingspan'] = Variable<int>(wingspan.value);
    }
    if (irisColor.present) {
      map['irisColor'] = Variable<String>(irisColor.value);
    }
    if (feetColor.present) {
      map['feetColor'] = Variable<String>(feetColor.value);
    }
    if (tarsusColor.present) {
      map['tarsusColor'] = Variable<String>(tarsusColor.value);
    }
    if (moltingWing.present) {
      map['moltingWing'] = Variable<String>(moltingWing.value);
    }
    if (moltingTail.present) {
      map['moltingTail'] = Variable<String>(moltingTail.value);
    }
    if (bodyFat.present) {
      map['bodyFat'] = Variable<String>(bodyFat.value);
    }
    if (bursaLength.present) {
      map['bursaLength'] = Variable<int>(bursaLength.value);
    }
    if (bursaWidth.present) {
      map['bursaWidth'] = Variable<int>(bursaWidth.value);
    }
    if (skullOssilation.present) {
      map['skullOssilation'] = Variable<String>(skullOssilation.value);
    }
    if (fat.present) {
      map['fat'] = Variable<String>(fat.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (gonad.present) {
      map['gonad'] = Variable<String>(gonad.value);
    }
    if (stomach.present) {
      map['stomach'] = Variable<String>(stomach.value);
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

class Part extends Table with TableInfo<Part, PartData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Part(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _specimenUuidMeta =
      const VerificationMeta('specimenUuid');
  late final GeneratedColumn<String> specimenUuid = GeneratedColumn<String>(
      'specimenUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _secondaryIDMeta =
      const VerificationMeta('secondaryID');
  late final GeneratedColumn<String> secondaryID = GeneratedColumn<String>(
      'secondaryID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tertiaryIDMeta =
      const VerificationMeta('tertiaryID');
  late final GeneratedColumn<String> tertiaryID = GeneratedColumn<String>(
      'tertiaryID', aliasedName, true,
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
  @override
  List<GeneratedColumn> get $columns => [
        specimenUuid,
        secondaryID,
        tertiaryID,
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
    if (data.containsKey('secondaryID')) {
      context.handle(
          _secondaryIDMeta,
          secondaryID.isAcceptableOrUnknown(
              data['secondaryID']!, _secondaryIDMeta));
    }
    if (data.containsKey('tertiaryID')) {
      context.handle(
          _tertiaryIDMeta,
          tertiaryID.isAcceptableOrUnknown(
              data['tertiaryID']!, _tertiaryIDMeta));
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PartData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartData(
      specimenUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specimenUuid']),
      secondaryID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}secondaryID']),
      tertiaryID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tertiaryID']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}count']),
      treatment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}treatment']),
      additionalTreatment: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}additionalTreatment']),
      museumPermanent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}museumPermanent']),
      museumLoan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}museumLoan']),
    );
  }

  @override
  Part createAlias(String alias) {
    return Part(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class PartData extends DataClass implements Insertable<PartData> {
  final String? specimenUuid;
  final String? secondaryID;
  final String? tertiaryID;
  final String? type;
  final String? count;
  final String? treatment;
  final String? additionalTreatment;
  final String? museumPermanent;
  final String? museumLoan;
  const PartData(
      {this.specimenUuid,
      this.secondaryID,
      this.tertiaryID,
      this.type,
      this.count,
      this.treatment,
      this.additionalTreatment,
      this.museumPermanent,
      this.museumLoan});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || specimenUuid != null) {
      map['specimenUuid'] = Variable<String>(specimenUuid);
    }
    if (!nullToAbsent || secondaryID != null) {
      map['secondaryID'] = Variable<String>(secondaryID);
    }
    if (!nullToAbsent || tertiaryID != null) {
      map['tertiaryID'] = Variable<String>(tertiaryID);
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
    if (!nullToAbsent || museumPermanent != null) {
      map['museumPermanent'] = Variable<String>(museumPermanent);
    }
    if (!nullToAbsent || museumLoan != null) {
      map['museumLoan'] = Variable<String>(museumLoan);
    }
    return map;
  }

  PartCompanion toCompanion(bool nullToAbsent) {
    return PartCompanion(
      specimenUuid: specimenUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(specimenUuid),
      secondaryID: secondaryID == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryID),
      tertiaryID: tertiaryID == null && nullToAbsent
          ? const Value.absent()
          : Value(tertiaryID),
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
      secondaryID: serializer.fromJson<String?>(json['secondaryID']),
      tertiaryID: serializer.fromJson<String?>(json['tertiaryID']),
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
      'secondaryID': serializer.toJson<String?>(secondaryID),
      'tertiaryID': serializer.toJson<String?>(tertiaryID),
      'type': serializer.toJson<String?>(type),
      'count': serializer.toJson<String?>(count),
      'treatment': serializer.toJson<String?>(treatment),
      'additionalTreatment': serializer.toJson<String?>(additionalTreatment),
      'museumPermanent': serializer.toJson<String?>(museumPermanent),
      'museumLoan': serializer.toJson<String?>(museumLoan),
    };
  }

  PartData copyWith(
          {Value<String?> specimenUuid = const Value.absent(),
          Value<String?> secondaryID = const Value.absent(),
          Value<String?> tertiaryID = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<String?> count = const Value.absent(),
          Value<String?> treatment = const Value.absent(),
          Value<String?> additionalTreatment = const Value.absent(),
          Value<String?> museumPermanent = const Value.absent(),
          Value<String?> museumLoan = const Value.absent()}) =>
      PartData(
        specimenUuid:
            specimenUuid.present ? specimenUuid.value : this.specimenUuid,
        secondaryID: secondaryID.present ? secondaryID.value : this.secondaryID,
        tertiaryID: tertiaryID.present ? tertiaryID.value : this.tertiaryID,
        type: type.present ? type.value : this.type,
        count: count.present ? count.value : this.count,
        treatment: treatment.present ? treatment.value : this.treatment,
        additionalTreatment: additionalTreatment.present
            ? additionalTreatment.value
            : this.additionalTreatment,
        museumPermanent: museumPermanent.present
            ? museumPermanent.value
            : this.museumPermanent,
        museumLoan: museumLoan.present ? museumLoan.value : this.museumLoan,
      );
  @override
  String toString() {
    return (StringBuffer('PartData(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('secondaryID: $secondaryID, ')
          ..write('tertiaryID: $tertiaryID, ')
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
  int get hashCode => Object.hash(specimenUuid, secondaryID, tertiaryID, type,
      count, treatment, additionalTreatment, museumPermanent, museumLoan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartData &&
          other.specimenUuid == this.specimenUuid &&
          other.secondaryID == this.secondaryID &&
          other.tertiaryID == this.tertiaryID &&
          other.type == this.type &&
          other.count == this.count &&
          other.treatment == this.treatment &&
          other.additionalTreatment == this.additionalTreatment &&
          other.museumPermanent == this.museumPermanent &&
          other.museumLoan == this.museumLoan);
}

class PartCompanion extends UpdateCompanion<PartData> {
  final Value<String?> specimenUuid;
  final Value<String?> secondaryID;
  final Value<String?> tertiaryID;
  final Value<String?> type;
  final Value<String?> count;
  final Value<String?> treatment;
  final Value<String?> additionalTreatment;
  final Value<String?> museumPermanent;
  final Value<String?> museumLoan;
  const PartCompanion({
    this.specimenUuid = const Value.absent(),
    this.secondaryID = const Value.absent(),
    this.tertiaryID = const Value.absent(),
    this.type = const Value.absent(),
    this.count = const Value.absent(),
    this.treatment = const Value.absent(),
    this.additionalTreatment = const Value.absent(),
    this.museumPermanent = const Value.absent(),
    this.museumLoan = const Value.absent(),
  });
  PartCompanion.insert({
    this.specimenUuid = const Value.absent(),
    this.secondaryID = const Value.absent(),
    this.tertiaryID = const Value.absent(),
    this.type = const Value.absent(),
    this.count = const Value.absent(),
    this.treatment = const Value.absent(),
    this.additionalTreatment = const Value.absent(),
    this.museumPermanent = const Value.absent(),
    this.museumLoan = const Value.absent(),
  });
  static Insertable<PartData> custom({
    Expression<String>? specimenUuid,
    Expression<String>? secondaryID,
    Expression<String>? tertiaryID,
    Expression<String>? type,
    Expression<String>? count,
    Expression<String>? treatment,
    Expression<String>? additionalTreatment,
    Expression<String>? museumPermanent,
    Expression<String>? museumLoan,
  }) {
    return RawValuesInsertable({
      if (specimenUuid != null) 'specimenUuid': specimenUuid,
      if (secondaryID != null) 'secondaryID': secondaryID,
      if (tertiaryID != null) 'tertiaryID': tertiaryID,
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
      Value<String?>? secondaryID,
      Value<String?>? tertiaryID,
      Value<String?>? type,
      Value<String?>? count,
      Value<String?>? treatment,
      Value<String?>? additionalTreatment,
      Value<String?>? museumPermanent,
      Value<String?>? museumLoan}) {
    return PartCompanion(
      specimenUuid: specimenUuid ?? this.specimenUuid,
      secondaryID: secondaryID ?? this.secondaryID,
      tertiaryID: tertiaryID ?? this.tertiaryID,
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
      map['specimenUuid'] = Variable<String>(specimenUuid.value);
    }
    if (secondaryID.present) {
      map['secondaryID'] = Variable<String>(secondaryID.value);
    }
    if (tertiaryID.present) {
      map['tertiaryID'] = Variable<String>(tertiaryID.value);
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
    if (museumPermanent.present) {
      map['museumPermanent'] = Variable<String>(museumPermanent.value);
    }
    if (museumLoan.present) {
      map['museumLoan'] = Variable<String>(museumLoan.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartCompanion(')
          ..write('specimenUuid: $specimenUuid, ')
          ..write('secondaryID: $secondaryID, ')
          ..write('tertiaryID: $tertiaryID, ')
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

class Expense extends Table with TableInfo<Expense, ExpenseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Expense(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  late final GeneratedColumn<String> item = GeneratedColumn<String>(
      'item', aliasedName, true,
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
  static const VerificationMeta _budgetMeta = const VerificationMeta('budget');
  late final GeneratedColumn<double> budget = GeneratedColumn<double>(
      'budget', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _actualMeta = const VerificationMeta('actual');
  late final GeneratedColumn<double> actual = GeneratedColumn<double>(
      'actual', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _projectUuidMeta =
      const VerificationMeta('projectUuid');
  late final GeneratedColumn<String> projectUuid = GeneratedColumn<String>(
      'projectUuid', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, category, item, description, budget, actual, projectUuid];
  @override
  String get aliasedName => _alias ?? 'expense';
  @override
  String get actualTableName => 'expense';
  @override
  VerificationContext validateIntegrity(Insertable<ExpenseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item']!, _itemMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('budget')) {
      context.handle(_budgetMeta,
          budget.isAcceptableOrUnknown(data['budget']!, _budgetMeta));
    }
    if (data.containsKey('actual')) {
      context.handle(_actualMeta,
          actual.isAcceptableOrUnknown(data['actual']!, _actualMeta));
    }
    if (data.containsKey('projectUuid')) {
      context.handle(
          _projectUuidMeta,
          projectUuid.isAcceptableOrUnknown(
              data['projectUuid']!, _projectUuidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      item: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      budget: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}budget']),
      actual: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual']),
      projectUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}projectUuid']),
    );
  }

  @override
  Expense createAlias(String alias) {
    return Expense(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(projectUuid)REFERENCES project(uuid)'];
  @override
  bool get dontWriteConstraints => true;
}

class ExpenseData extends DataClass implements Insertable<ExpenseData> {
  final int? id;
  final String? category;
  final String? item;
  final String? description;
  final double? budget;
  final double? actual;
  final String? projectUuid;
  const ExpenseData(
      {this.id,
      this.category,
      this.item,
      this.description,
      this.budget,
      this.actual,
      this.projectUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || item != null) {
      map['item'] = Variable<String>(item);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || budget != null) {
      map['budget'] = Variable<double>(budget);
    }
    if (!nullToAbsent || actual != null) {
      map['actual'] = Variable<double>(actual);
    }
    if (!nullToAbsent || projectUuid != null) {
      map['projectUuid'] = Variable<String>(projectUuid);
    }
    return map;
  }

  ExpenseCompanion toCompanion(bool nullToAbsent) {
    return ExpenseCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      item: item == null && nullToAbsent ? const Value.absent() : Value(item),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      budget:
          budget == null && nullToAbsent ? const Value.absent() : Value(budget),
      actual:
          actual == null && nullToAbsent ? const Value.absent() : Value(actual),
      projectUuid: projectUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(projectUuid),
    );
  }

  factory ExpenseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseData(
      id: serializer.fromJson<int?>(json['id']),
      category: serializer.fromJson<String?>(json['category']),
      item: serializer.fromJson<String?>(json['item']),
      description: serializer.fromJson<String?>(json['description']),
      budget: serializer.fromJson<double?>(json['budget']),
      actual: serializer.fromJson<double?>(json['actual']),
      projectUuid: serializer.fromJson<String?>(json['projectUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'category': serializer.toJson<String?>(category),
      'item': serializer.toJson<String?>(item),
      'description': serializer.toJson<String?>(description),
      'budget': serializer.toJson<double?>(budget),
      'actual': serializer.toJson<double?>(actual),
      'projectUuid': serializer.toJson<String?>(projectUuid),
    };
  }

  ExpenseData copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> category = const Value.absent(),
          Value<String?> item = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<double?> budget = const Value.absent(),
          Value<double?> actual = const Value.absent(),
          Value<String?> projectUuid = const Value.absent()}) =>
      ExpenseData(
        id: id.present ? id.value : this.id,
        category: category.present ? category.value : this.category,
        item: item.present ? item.value : this.item,
        description: description.present ? description.value : this.description,
        budget: budget.present ? budget.value : this.budget,
        actual: actual.present ? actual.value : this.actual,
        projectUuid: projectUuid.present ? projectUuid.value : this.projectUuid,
      );
  @override
  String toString() {
    return (StringBuffer('ExpenseData(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('item: $item, ')
          ..write('description: $description, ')
          ..write('budget: $budget, ')
          ..write('actual: $actual, ')
          ..write('projectUuid: $projectUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, category, item, description, budget, actual, projectUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseData &&
          other.id == this.id &&
          other.category == this.category &&
          other.item == this.item &&
          other.description == this.description &&
          other.budget == this.budget &&
          other.actual == this.actual &&
          other.projectUuid == this.projectUuid);
}

class ExpenseCompanion extends UpdateCompanion<ExpenseData> {
  final Value<int?> id;
  final Value<String?> category;
  final Value<String?> item;
  final Value<String?> description;
  final Value<double?> budget;
  final Value<double?> actual;
  final Value<String?> projectUuid;
  const ExpenseCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.item = const Value.absent(),
    this.description = const Value.absent(),
    this.budget = const Value.absent(),
    this.actual = const Value.absent(),
    this.projectUuid = const Value.absent(),
  });
  ExpenseCompanion.insert({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.item = const Value.absent(),
    this.description = const Value.absent(),
    this.budget = const Value.absent(),
    this.actual = const Value.absent(),
    this.projectUuid = const Value.absent(),
  });
  static Insertable<ExpenseData> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? item,
    Expression<String>? description,
    Expression<double>? budget,
    Expression<double>? actual,
    Expression<String>? projectUuid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (item != null) 'item': item,
      if (description != null) 'description': description,
      if (budget != null) 'budget': budget,
      if (actual != null) 'actual': actual,
      if (projectUuid != null) 'projectUuid': projectUuid,
    });
  }

  ExpenseCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? category,
      Value<String?>? item,
      Value<String?>? description,
      Value<double?>? budget,
      Value<double?>? actual,
      Value<String?>? projectUuid}) {
    return ExpenseCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      item: item ?? this.item,
      description: description ?? this.description,
      budget: budget ?? this.budget,
      actual: actual ?? this.actual,
      projectUuid: projectUuid ?? this.projectUuid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (item.present) {
      map['item'] = Variable<String>(item.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (budget.present) {
      map['budget'] = Variable<double>(budget.value);
    }
    if (actual.present) {
      map['actual'] = Variable<double>(actual.value);
    }
    if (projectUuid.present) {
      map['projectUuid'] = Variable<String>(projectUuid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('item: $item, ')
          ..write('description: $description, ')
          ..write('budget: $budget, ')
          ..write('actual: $actual, ')
          ..write('projectUuid: $projectUuid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final Project project = Project(this);
  late final FileMetadata fileMetadata = FileMetadata(this);
  late final PersonnelPhoto personnelPhoto = PersonnelPhoto(this);
  late final Personnel personnel = Personnel(this);
  late final Media media = Media(this);
  late final Site site = Site(this);
  late final Coordinate coordinate = Coordinate(this);
  late final WeatherData weatherData = WeatherData(this);
  late final CollEvent collEvent = CollEvent(this);
  late final CollectingPersonnel collectingPersonnel =
      CollectingPersonnel(this);
  late final CollEffort collEffort = CollEffort(this);
  late final Narrative narrative = Narrative(this);
  late final AssociatedData associatedData = AssociatedData(this);
  late final PersonnelList personnelList = PersonnelList(this);
  late final ProjectPersonnel projectPersonnel = ProjectPersonnel(this);
  late final Taxonomy taxonomy = Taxonomy(this);
  late final Specimen specimen = Specimen(this);
  late final MammalMeasurement mammalMeasurement = MammalMeasurement(this);
  late final BirdMeasurement birdMeasurement = BirdMeasurement(this);
  late final Part part = Part(this);
  late final Expense expense = Expense(this);
  Selectable<ListProjectResult> listProject() {
    return customSelect('SELECT uuid, name, created, lastModified FROM project',
        variables: [],
        readsFrom: {
          project,
        }).map((QueryRow row) {
      return ListProjectResult(
        uuid: row.read<String>('uuid'),
        name: row.read<String>('name'),
        created: row.readNullable<String>('created'),
        lastModified: row.readNullable<String>('lastModified'),
      );
    });
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        project,
        fileMetadata,
        personnelPhoto,
        personnel,
        media,
        site,
        coordinate,
        weatherData,
        collEvent,
        collectingPersonnel,
        collEffort,
        narrative,
        associatedData,
        personnelList,
        projectPersonnel,
        taxonomy,
        specimen,
        mammalMeasurement,
        birdMeasurement,
        part,
        expense
      ];
}

class ListProjectResult {
  final String uuid;
  final String name;
  final String? created;
  final String? lastModified;
  ListProjectResult({
    required this.uuid,
    required this.name,
    this.created,
    this.lastModified,
  });
}
