import 'package:nahpu/database/database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final databaseProvider = Provider<Database>((ref) {
  return Database();
});

final projectListProvider = FutureProvider<List<ListProjectResult>>((ref) {
  return ref.read(databaseProvider).getProjectList();
});

final projectInfoProvider =
    FutureProvider.family<ProjectData?, String>((ref, uuid) {
  final projectInfo = ref.watch(databaseProvider).getProjectByUuid(uuid);
  return projectInfo;
});




// final projectListNotifier = StreamProvider<List<ListProjectResult>>((ref) => ref
//     .watch(databaseProvider)
//     .getProjectList()
//     .asStream()
//     .map((event) => event.reversed.toList()));

// class ProjectListNotifier extends StateNotifier<List<ListProjectResult>> {

//   List<ListProjectResult> _projectList = [];
//   get projectList => _projectList;

//   final Ref ref;

//   void getProjectList() {
//     ProjectModel(ref).getProjectList().then((value) {
//       _projectList = value.reversed.toList();
//       notifyListeners();
//     });
//   }

//   void deleteProject(String projectUuid) {
//     ProjectModel(ref).deleteProject(projectUuid);
//     notifyListeners();
//   }
// }
