import 'package:drift/drift.dart';
import 'package:nahpu/services/database/database.dart';

part 'media_queries.g.dart';

@DriftAccessor(
  include: {'tables.drift'},
)
class MediaQuery extends DatabaseAccessor<Database> with _$MediaQueryMixin {
  MediaQuery(Database db) : super(db);

  Future<int> createMedia(MediaCompanion form) {
    return into(media).insert(form);
  }

  Future<List<MediaData>> getAllMedia() {
    return select(media).get();
  }

  Future<void> deleteMedia(int id) {
    return (delete(media)..where((t) => t.primaryId.equals(id))).go();
  }
}
