import 'package:nahpu/providers/validation.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:uuid/uuid.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

get uuid => const Uuid().v4();

get defaultCatalog => 'general-mammals';

class ProjectServices {
  ProjectServices(this.ref);

  final WidgetRef ref;

  void createProject(ProjectCompanion form) {
    ref.read(databaseProvider).createProject(form);
    _updateProjectUuid(form.uuid.value);
    ref.invalidate(projectListProvider);
    ref.invalidate(projectFormNotifier);
  }

  void updateProject(String projectUuid, ProjectCompanion form) {
    ref.read(databaseProvider).updateProjectEntry(projectUuid, form);
    invalidateProject();
  }

  Future<ProjectData> getProjectByUuid(String uuid) {
    return ref.read(databaseProvider).getProjectByUuid(uuid);
  }

  String getProjectUuid() {
    return ref.read(projectUuidProvider);
  }

  void deleteProject(String uuid) {
    ref.read(databaseProvider).deleteProject(uuid);
    ref.invalidate(projectListProvider);
  }

  void invalidateProject() {
    ref.invalidate(projectListProvider);
    ref.invalidate(projectInfoProvider);
  }

  void _updateProjectUuid(String projectUuid) {
    ref.read(projectUuidProvider.notifier).state = projectUuid;
  }
}
