import 'package:drift/drift.dart';
import 'package:nahpu/services/database/database.dart';

part 'media_queries.g.dart';

@DriftAccessor(
  include: {'tables.drift'},
)
class MediaDbQuery extends DatabaseAccessor<Database> with _$MediaDbQueryMixin {
  MediaDbQuery(Database db) : super(db);

  Future<int> createMedia(MediaCompanion form) {
    return into(media).insert(form);
  }

  Future<List<MediaData>> getAllMedia() {
    return select(media).get();
  }

  Future<void> updateMedia(int mediaId, MediaCompanion form) {
    return (update(media)..where((t) => t.primaryId.equals(mediaId)))
        .write(form);
  }

  Future<MediaData> getMedia(int id) {
    return (select(media)..where((t) => t.primaryId.equals(id))).getSingle();
  }

  Future<void> deleteMedia(int id) {
    return (delete(media)..where((t) => t.primaryId.equals(id))).go();
  }
}
