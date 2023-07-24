/// Project module providers contain all the providers related to the project,
/// Except for the project form validation provider, which is in the validation.dart file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/database.dart';
import 'package:nahpu/services/database/database.dart' as db;
import 'package:nahpu/services/database/project_queries.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'projects.g.dart';

final projectListProvider =
    FutureProvider.autoDispose<List<ListProjectResult>>((ref) {
  return ProjectQuery(ref.read(databaseProvider)).getProjectList();
});

final projectInfoProvider =
    FutureProvider.family<db.ProjectData?, String>((ref, uuid) async {
  final projectInfo =
      ProjectQuery(ref.read(databaseProvider)).getProjectByUuid(uuid);
  return await projectInfo;
});

// final projectUuidProvider = StateProvider<String>((ref) => '');

@riverpod
class ProjectUuid extends _$ProjectUuid {
  @override
  String build() {
    return '';
  }

  void updateProjectUuid(String uuid) {
    state = uuid;
  }
}

final projectNavbarIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
