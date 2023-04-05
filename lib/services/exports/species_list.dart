import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/specimen_queries.dart';

class SpeciesListWriter {
  SpeciesListWriter({required this.ref});

  final WidgetRef ref;

  Future<Map<String, int>> countSpeciesList(String projectUuid) async {
    final db = ref.read(databaseProvider);
    final speciesList = await SpecimenQuery(db).getAllSpecies(projectUuid);
    final speciesListMap = <String, int>{};
    for (final species in speciesList) {
      if (species != null) {
        if (speciesListMap.containsKey(species)) {
          speciesListMap[species.toString()] = speciesListMap[species]! + 1;
        } else {
          speciesListMap[species.toString()] = 1;
        }
      }
    }
    return speciesListMap;
  }
}
