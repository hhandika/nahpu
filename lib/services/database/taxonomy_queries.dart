import 'package:drift/drift.dart';
import 'package:nahpu/services/database/database.dart';

part 'taxonomy_queries.g.dart';

@DriftAccessor(
  include: {'tables.drift'},
)
class TaxonomyQuery extends DatabaseAccessor<Database>
    with _$TaxonomyQueryMixin {
  TaxonomyQuery(Database db) : super(db);

  Future<TaxonomyData> getTaxonById(int id) {
    return (select(taxonomy)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<TaxonomyData?> getTaxonIdByGenusEpithet(String genus, String epithet) {
    return (select(taxonomy)
          ..where((t) => t.genus.equals(genus))
          ..where((t) => t.specificEpithet.equals(epithet)))
        .getSingleOrNull();
  }

  Future<List<TaxonomyData>> getTaxonList() {
    return select(taxonomy).get();
  }

  Future<void> createTaxon(TaxonomyCompanion form) {
    return into(taxonomy).insert(form);
  }

  Future<void> updateTaxonEntry(int id, TaxonomyCompanion entry) {
    return (update(taxonomy)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<void> deleteTaxon(int id) {
    return (delete(taxonomy)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllTaxon() {
    return delete(taxonomy).go();
  }
}
