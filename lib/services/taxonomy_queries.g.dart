// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxonomy_queries.dart';

// ignore_for_file: type=lint
mixin _$TaxonomyQueryMixin on DatabaseAccessor<Database> {
  Project get project => attachedDatabase.project;
  FileMetadata get fileMetadata => attachedDatabase.fileMetadata;
  PersonnelPhoto get personnelPhoto => attachedDatabase.personnelPhoto;
  Personnel get personnel => attachedDatabase.personnel;
  Media get media => attachedDatabase.media;
  Site get site => attachedDatabase.site;
  Coordinate get coordinate => attachedDatabase.coordinate;
  CollEvent get collEvent => attachedDatabase.collEvent;
  Weather get weather => attachedDatabase.weather;
  CollectingPersonnel get collectingPersonnel =>
      attachedDatabase.collectingPersonnel;
  CollEffort get collEffort => attachedDatabase.collEffort;
  Narrative get narrative => attachedDatabase.narrative;
  AssociatedData get associatedData => attachedDatabase.associatedData;
  PersonnelList get personnelList => attachedDatabase.personnelList;
  ProjectPersonnel get projectPersonnel => attachedDatabase.projectPersonnel;
  Taxonomy get taxonomy => attachedDatabase.taxonomy;
  Specimen get specimen => attachedDatabase.specimen;
  MammalMeasurement get mammalMeasurement => attachedDatabase.mammalMeasurement;
  BirdMeasurement get birdMeasurement => attachedDatabase.birdMeasurement;
  Part get part => attachedDatabase.part;
  Expense get expense => attachedDatabase.expense;
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
