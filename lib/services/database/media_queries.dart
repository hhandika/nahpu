import 'package:drift/drift.dart';
import 'package:nahpu/services/database/database.dart';

part 'media_queries.g.dart';

@DriftAccessor(
  include: {'tables.drift'},
)
class MediaQuery extends DatabaseAccessor<Database> with _$MediaQueryMixin {
  MediaQuery(Database db) : super(db);
}
