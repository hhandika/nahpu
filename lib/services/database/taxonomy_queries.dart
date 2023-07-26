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

  Future<String> getSpeciesById(int id) {
    return (select(taxonomy)..where((t) => t.id.equals(id)))
        .map((t) => '${t.genus} ${t.specificEpithet}')
        .getSingle();
  }

  Future<List<TaxonomyData>> searchTaxon(String query) {
    return (select(taxonomy)
          ..where((t) =>
              t.taxonOrder.contains(query) |
              t.taxonFamily.contains(query) |
              t.genus.contains(query) |
              t.specificEpithet.contains(query) |
              t.commonName.contains(query)))
        .get();
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

  Future<List<int>> getAllUniqueTaxonFromSpecimen() async {
    List<int?> specimenTaxonIds =
        await select(specimen).map((s) => s.speciesID).get();
    return specimenTaxonIds
        .toSet()
        .toList()
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
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
