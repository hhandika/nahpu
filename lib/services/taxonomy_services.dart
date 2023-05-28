import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';
import 'package:nahpu/services/io_services.dart';

String getSpeciesName(TaxonomyData data) {
  if (data.genus != null && data.specificEpithet != null) {
    return '${data.genus} ${data.specificEpithet}';
  } else {
    return '';
  }
}

String getTaxonFirstThreeLetters(String value) {
  try {
    List<String> splitAtSpace = value.split(' ');
    if (splitAtSpace.length > 1) {
      String genus = splitAtSpace[0].substring(0, 1);
      String species = splitAtSpace[1].substring(0, 3);
      return '$genus. $species';
    } else {
      return value.substring(0, 5);
    }
  } catch (e) {
    return value.substring(0, 5);
  }
}

class TaxonomyService extends DbAccess {
  TaxonomyService(super.ref);

  Future<TaxonomyData> getTaxonById(int id) async {
    return await TaxonomyQuery(dbAccess).getTaxonById(id);
  }

  Future<TaxonomyData?> getTaxonBySpecies(String genus, String epithet) async {
    return await TaxonomyQuery(dbAccess)
        .getTaxonIdByGenusEpithet(genus, epithet);
  }

  Future<List<TaxonomyData>> getTaxonList() {
    return TaxonomyQuery(dbAccess).getTaxonList();
  }

  Future<void> createTaxon(TaxonomyCompanion form) {
    return TaxonomyQuery(dbAccess).createTaxon(form);
  }

  Future<void> updateTaxonEntry(int id, TaxonomyCompanion entry) {
    return TaxonomyQuery(dbAccess).updateTaxonEntry(id, entry);
  }

  Future<void> deleteTaxon(int id) {
    return TaxonomyQuery(dbAccess).deleteTaxon(id);
  }

  Future<void> deleteAllTaxon() {
    return TaxonomyQuery(dbAccess).deleteAllTaxon();
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
