import 'package:nahpu/providers/validation.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:uuid/uuid.dart';
import 'package:nahpu/providers/projects.dart';

get uuid => const Uuid().v4();

get defaultCatalog => 'general-mammals';

class ProjectServices extends DbAccess {
  ProjectServices(super.ref);

  Database get db => ref.read(databaseProvider);

  void createProject(ProjectCompanion form) {
    db.createProject(form);
    _updateProjectUuid(form.uuid.value);
    ref.invalidate(projectListProvider);
    ref.invalidate(projectFormValidation);
  }

  void updateProject(String projectUuid, ProjectCompanion form) {
    db.updateProjectEntry(projectUuid, form);
    ref.invalidate(projectFormValidation);
    invalidateProject();
  }

  Future<ProjectData> getProjectByUuid(String uuid) {
    return db.getProjectByUuid(uuid);
  }

  String getProjectUuid() {
    return ref.read(projectUuidProvider);
  }

  void deleteProject(String uuid) {
    db.deleteProject(uuid);
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
