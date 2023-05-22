import 'package:nahpu/services/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database/specimen_queries.dart';

final specimenEntryProvider =
    FutureProvider.autoDispose<List<SpecimenData>>((ref) {
  final projectUuid = ref.watch(projectUuidProvider);
  final specimenEntries =
      SpecimenQuery(ref.read(databaseProvider)).getAllSpecimens(projectUuid);
  return specimenEntries;
});

final partBySpecimenProvider = FutureProvider.family
    .autoDispose<List<SpecimenPartData>, String>((ref, specimenUuid) =>
        SpecimenPartQuery(ref.read(databaseProvider))
            .getSpecimenParts(specimenUuid));
