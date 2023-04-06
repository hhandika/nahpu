import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';

class TaxonService extends DbAccess {
  TaxonService(super.ref);

  Database get db => ref.read(databaseProvider);

  Future<TaxonomyData> getTaxonById(int id) async {
    return await TaxonomyQuery(db).getTaxonById(id);
  }

  Future<List<TaxonomyData>> getTaxonList() {
    return TaxonomyQuery(db).getTaxonList();
  }

  Future<void> createTaxon(TaxonomyCompanion form) {
    return TaxonomyQuery(db).createTaxon(form);
  }

  Future<void> updateTaxonEntry(int id, TaxonomyCompanion entry) {
    return TaxonomyQuery(db).updateTaxonEntry(id, entry);
  }

  Future<void> deleteTaxon(int id) {
    return TaxonomyQuery(db).deleteTaxon(id);
  }

  Future<void> deleteAllTaxon() {
    return TaxonomyQuery(db).deleteAllTaxon();
  }
}
