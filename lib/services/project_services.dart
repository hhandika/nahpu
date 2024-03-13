import 'package:nahpu/services/providers/projects.dart';
import 'package:nahpu/services/providers/validation.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/project_queries.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:uuid/uuid.dart';

get uuid => const Uuid().v4();

get defaultCatalog => 'general-mammals';

class ProjectServices extends AppServices {
  const ProjectServices({required super.ref});

  void createProject(ProjectCompanion form) {
    ProjectQuery(dbAccess).createProject(form);
    invalidateProject();
    updateProjectUuid(form.uuid.value);
  }

  void updateProjectUuid(String projectUuid) {
    ref.read(projectUuidProvider.notifier).updateProjectUuid(projectUuid);
  }

  void updateProject(String projectUuid, ProjectCompanion form) {
    ProjectQuery(dbAccess).updateProjectEntry(projectUuid, form);
    ref.invalidate(projectFormValidatorProvider);
    ref.invalidate(projectInfoProvider);
  }

  Future<ProjectData> getProjectByUuid(String uuid) async {
    return await ProjectQuery(dbAccess).getProjectByUuid(uuid);
  }

  Future<List<String>> getAllProjectNames() async {
    return await ProjectQuery(dbAccess).getAllProjectNames();
  }

  Future<String> getProjectName(String uuid) async {
    ProjectData data = await getProjectByUuid(uuid);
    return data.name;
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
    ref.invalidate(projectUuidProvider);
  }
}

extension StringValidator on String {
  bool get isValidCollNum {
    final catNumRegex = RegExp(r'^[0-9]+$');
    return catNumRegex.hasMatch(this);
  }

  bool get isValidProjectName {
    final projectNameRegex =
        RegExp(r'^[\d\p{L}\p{Mn}\s\-\\_]+$', unicode: true);
    return projectNameRegex.hasMatch(this);
  }

  bool get isValidName {
    // Match name with unicode characters
    final nameRegex = RegExp(r'^[\p{L}\p{Mn}\p{Pd}\s\.\-]+$', unicode: true);
    return nameRegex.hasMatch(this);
  }

  bool get isValidInitial {
    final initialRegex = RegExp(r'^[a-zA-Z0-9\-\_]+$');
    return initialRegex.hasMatch(this);
  }

  bool get isValidEmail {
    final emailRegex =
        RegExp(r'(^[a-zA-Z0-9_.]+[@]{1}[a-z0-9]+[\.][a-z](.)+$)');
    return emailRegex.hasMatch(this);
  }
}
