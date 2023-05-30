import 'package:nahpu/services/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/specimen_queries.dart';
import 'package:nahpu/services/database/taxonomy_queries.dart';
import 'package:nahpu/providers/database.dart';

final taxonRegistryProvider =
    FutureProvider.autoDispose<List<TaxonomyData>>((ref) async {
  final projectTaxon = TaxonomyQuery(ref.read(databaseProvider)).getTaxonList();
  return await projectTaxon;
});

final taxonDataProvider = FutureProvider.family
    .autoDispose<TaxonomyData?, String>((ref, specimenUuid) async {
  int? taxonId = await SpecimenQuery(ref.read(databaseProvider))
      .getSpeciesByUuid(specimenUuid);

  if (taxonId != null) {
    final taxonData =
        TaxonomyQuery(ref.read(databaseProvider)).getTaxonById(taxonId);
    return taxonData;
  } else {
    return null;
  }
});

final taxonProvider = FutureProvider.autoDispose<List<TaxonomyData>>((ref) {
  final taxonList = TaxonomyQuery(ref.read(databaseProvider)).getTaxonList();
  return taxonList;
});
