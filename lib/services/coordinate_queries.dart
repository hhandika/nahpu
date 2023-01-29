import 'package:drift/drift.dart';
import 'package:nahpu/services/database.dart';

part 'coordinate_queries.g.dart';

@DriftAccessor(
  include: {'tables.drift'},
)
class CoordinateQuery extends DatabaseAccessor<Database>
    with _$CoordinateQueryMixin {
  CoordinateQuery(Database db) : super(db);

  Future<List<CoordinateData>> getAllCoordinates() {
    return select(coordinate).get();
  }

  Future<List<CoordinateData>> getCoordinatesBySiteID(int siteID) {
    return (select(coordinate)..where((t) => t.siteID.equals(siteID))).get();
  }
}
