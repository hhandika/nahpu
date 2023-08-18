import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  include: {'tables.drift'},
)
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 4; // bump this when you change the schema

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (m) async {
      await m.createAll();
    }, onUpgrade: (Migrator m, int from, int to) async {
      await customStatement('PRAGMA foreign_keys = OFF');
      if (from < 2) {
        await m.addColumn(specimen, specimen.taxonGroup);
      }

      if (from < 3) {
        await _migrateFromVersion2(m);
      }

      if (from == 3) {
        await _migrateV3only(m);
      }

      if (from < 4) {
        await _migrateFromVersion3(m);
      }

      if (from < 5) {
        await _migrateFromVersion4(m);
      }
    }, beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    });
  }

  Future<void> _migrateFromVersion4(Migrator m) async {
    await m.deleteTable('projectPersonnel');

    // Specimen record tables
    await m.addColumn(specimen, specimen.iDConfidence);
    await m.addColumn(specimen, specimen.iDMethod);
    await m.addColumn(specimenPart, specimenPart.personnelId);
    await m.addColumn(specimenPart, specimenPart.pmi);

    // Taxon registry table
    await m.addColumn(taxonomy, taxonomy.citesStatus);
    await m.addColumn(taxonomy, taxonomy.redListCriteria);
    await m.addColumn(taxonomy, taxonomy.countryStatus);
    await m.addColumn(taxonomy, taxonomy.sortingOrder);

    // Site Casting
    await m.alterTable(TableMigration(coordinate));
    await m.alterTable(TableMigration(coordinate, columnTransformer: {
      coordinate.elevationInMeter: coordinate.elevationInMeter.cast<double>(),
    }));
  }

  Future<void> _migrateFromVersion3(Migrator m) async {
    await m.addColumn(personnel, personnel.photoPath);
    await m.addColumn(specimen, specimen.collectionTime);
    await m.addColumn(media, media.projectUuid);
    await m.addColumn(media, media.category);
    await m.addColumn(media, media.caption);
    await m.addColumn(media, media.tag);
    await m.addColumn(media, media.additionalExif);

    await m.create(narrativeMedia);
    await m.create(siteMedia);
    await m.create(specimenMedia);

    await m.renameColumn(collEvent, 'eventID', collEvent.idSuffix);
    await m.renameColumn(collEffort, 'type', collEffort.method);

    await m.deleteTable('fileMetadata');
    await m.deleteTable('personnelPhoto');
    // delete column from media table and personnel tables
    await m.alterTable(TableMigration(personnel));
    await m.alterTable(TableMigration(media));
  }

  Future<void> _migrateV3only(Migrator m) async {
    try {
      await m.renameColumn(media, 'thumbnailPath', media.fileName);
    } catch (e) {
      await m.addColumn(media, media.fileName);
    }
  }

  Future<void> _migrateFromVersion2(Migrator m) async {
    // We remove expense table. NO NEED for the app.
    await m.deleteTable('expense');

    // We add missing columns in the specimen table.
    await m.addColumn(media, media.fileName);
    await m.addColumn(specimen, specimen.coordinateID);
    await m.addColumn(specimen, specimen.methodID);
    await m.addColumn(specimen, specimen.museumID);

    // We switch bird table to revised version
    await m.deleteTable('bird_measurement');
    await m.createTable(avianMeasurement);

    _castMammalType(m);
  }

  Future<void> _castMammalType(Migrator m) async {
    await m.alterTable(TableMigration(mammalMeasurement, columnTransformer: {
      mammalMeasurement.totalLength:
          mammalMeasurement.totalLength.cast<double>(),
      mammalMeasurement.tailLength: mammalMeasurement.tailLength.cast<double>(),
      mammalMeasurement.hindFootLength:
          mammalMeasurement.hindFootLength.cast<double>(),
      mammalMeasurement.earLength: mammalMeasurement.earLength.cast<double>(),
      mammalMeasurement.forearm: mammalMeasurement.forearm.cast<double>(),
      mammalMeasurement.testisLength:
          mammalMeasurement.testisLength.cast<double>(),
      mammalMeasurement.testisWidth:
          mammalMeasurement.testisWidth.cast<double>(),
    }));
  }

  Future<void> addColumnToTable(String tableName, String columnName) async {
    await customStatement('ALTER TABLE $tableName ADD COLUMN $columnName');
  }

  Future<void> exportInto(File file) async {
    await file.parent.create(recursive: true);

    if (file.existsSync()) {
      file.deleteSync();
    }

    await customStatement('VACUUM INTO ?', [file.path]);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = await dBPath;
    if (kDebugMode) {
      print('App database path: ${file.path}');
    }
    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}

Future<File> get dBPath async {
  // We save database to the default document directory locations.
  final dbDir = await nahpuDocumentDir;
  return File(p.join(dbDir.path, 'nahpu.db'));
}
