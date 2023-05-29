import 'package:drift/drift.dart';
import 'package:nahpu/services/database/database.dart';

part 'project_queries.g.dart';

@DriftAccessor(
  include: {'tables_v3.drift'},
)
class ProjectQuery extends DatabaseAccessor<Database> with _$ProjectQueryMixin {
  ProjectQuery(Database db) : super(db);

  Future<void> createProject(ProjectCompanion form) =>
      into(project).insert(form);

  Future<List<ProjectData>> getAllProjects() => select(project).get();

  Future<List<String>> getAllProjectNames() =>
      select(project).map((e) => e.name).get();

  Future<ProjectData> getProjectByUuid(String uuid) async {
    return await (select(project)..where((t) => t.uuid.equals(uuid)))
        .getSingle();
  }

  Future<ProjectData?> getProjectByName(String name) async {
    try {
      return await (select(project)..where((t) => t.name.equals(name)))
          .getSingle();
    } catch (e) {
      return null;
    }
  }

  Future<void> updateProjectEntry(String uuid, ProjectCompanion entry) {
    return (update(project)..where((t) => t.uuid.equals(uuid))).write(entry);
  }

  Future<List<ListProjectResult>> getProjectList() => listProject().get();

  Future<int> deleteProject(String id) async {
    return await (delete(project)..where((t) => t.uuid.equals(id))).go();
  }

  Future<void> deleteAllProjects() {
    return (delete(project)).go();
  }
}
