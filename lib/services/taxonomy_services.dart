import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';

String getSpeciesName(TaxonomyData data) {
  if (data.genus != null && data.specificEpithet != null) {
    return '${data.genus} ${data.specificEpithet}';
  } else {
    return '';
  }
}

class TaxonomyService extends DbAccess {
  TaxonomyService(super.ref);

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

class TaxonFilterServices {
  TaxonFilterServices();

  List<TaxonomyData> filterTaxonList(
      List<TaxonomyData> data, String searchValue) {
    return data
        .where((taxon) => _isTaxonMatch(taxon, searchValue.toLowerCase()))
        .toList();
  }

  bool _isTaxonMatch(TaxonomyData data, String searchValue) {
    return _getSpecies(data).contains(searchValue) ||
        _getFamily(data).contains(searchValue) ||
        _getOrder(data).contains(searchValue);
  }

  String _getSpecies(TaxonomyData taxon) {
    return getSpeciesName(taxon).toLowerCase();
  }

  String _getFamily(TaxonomyData taxon) {
    return (taxon.taxonFamily ?? '').toLowerCase();
  }

  String _getOrder(TaxonomyData taxon) {
    return (taxon.taxonOrder ?? '').toLowerCase();
  }
}
