import 'package:uuid/uuid.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

get uuid => const Uuid().v4();

get defaultCatalog => 'general-mammals';

class ProjectServices {
  ProjectServices(this.ref);

  final WidgetRef ref;

  void deleteProject(String uuid) {
    ref.read(databaseProvider).deleteProject(uuid);
    ref.invalidate(projectListProvider);
  }

  void invalidateProject() {
    ref.invalidate(projectListProvider);
    ref.invalidate(projectInfoProvider);
  }
}
