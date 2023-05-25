import 'package:nahpu/providers/validation.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/project_queries.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:uuid/uuid.dart';
import 'package:nahpu/providers/projects.dart';

get uuid => const Uuid().v4();

get defaultCatalog => 'general-mammals';

class ProjectServices extends DbAccess {
  ProjectServices(super.ref);

  void createProject(ProjectCompanion form) {
    ProjectQuery(dbAccess).createProject(form);
    _updateProjectUuid(form.uuid.value);
    ref.invalidate(projectListProvider);
    ref.invalidate(projectFormValidation);
  }

  void updateProject(String projectUuid, ProjectCompanion form) {
    ProjectQuery(dbAccess).updateProjectEntry(projectUuid, form);
    ref.invalidate(projectFormValidation);
    invalidateProject();
  }

  Future<ProjectData> getProjectByUuid(String uuid) {
    return ProjectQuery(dbAccess).getProjectByUuid(uuid);
  }

  String getProjectUuid() {
    return ref.read(projectUuidProvider);
  }

  Future<void> deleteProject(String uuid) async {
    await ProjectQuery(dbAccess).deleteProject(uuid);
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
